"" General TeX document settings
set sw=2
set iskeyword+=:
set grepprg=grep\ -nH\ $*

" I think these mappings will be covered by VimTex
" onoremap <silent> i$ :<c-u>normal! T$vt$<cr>
" vnoremap i$ T$ot$

" Trying without YCM for a bit
" let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme

" " Don't try to complete identifiers in LaTeX
" let g:ycm_min_num_of_chars_for_completion=99

"" ChangeAndCompile
" Use this for making a notes version of a slides document, or a solutions
" version of an exam document
"
function! ChangeAndCompile(pattern, replace, jobname)
    set lazyredraw

    let current_bufnr = bufnr()
    let new_bufname = bufname()."-".a:jobname
    let new_bufnr = bufadd(new_bufname)
    call bufload(new_bufnr)
    let bufend = line('$')
    call appendbufline(new_bufnr, 0, getline(1, bufend))

    execute 'hide buffer' new_bufnr
    execute 's/'.a:pattern.'/'.a:replace
    execute 'silent write! ' a:jobname.'.tex'
    execute '!latexmk -pdf' a:jobname 
    execute 'buffer' current_bufnr
    execute 'bd!' new_bufnr

    set lazyredraw
endfunction

let g:solutions_header = '\\documentclass[answers, 12pt, letterpaper]{exam}'
let g:notes_header = '\\documentclass[12pt, letterpaper]{article} \\usepackage[hyperref, envcountsect]{beamerarticle}'

nnoremap <localleader>lS :call ChangeAndCompile('\\documentclass.*{exam}', g:solutions_header, "solutions")<CR>
nnoremap <localleader>lN :call ChangeAndCompile('\\documentclass.*{beamer}', g:notes_header, "notes")<CR>

"" Vimtex settings

let g:vimtex_view_method='zathura'

""" Logging
let g:vimtex_quickfix_autoclose_after_keystrokes=5
let g:vimtex_quickfix_latexlog = {
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \ 'font' : 0,
      \ 'packages' : {
      \   'default' : 0,
      \ },
      \}

""" Folding
let g:vimtex_fold_enabled=1
let g:vimtex_fold_manual=1
let g:vimtex_fold_types = {
      \ 'comments' : {'enabled' : 1},
      \ 'preamble' : {'enabled' : 1},
      \ 'envs' : {
      \   'blacklist' : [],
      \   'whitelist' : ['coverpages', 'solution', 'frame'],
      \ },
      \ 'sections' : {
      \   'parse_levels' : 0,
      \   'sections' : [
      \    'section',
      \	   'question',
      \	   'part',
      \  ],
      \ },
      \}

""" Indentation
let g:vimtex_indent_conditionals = {
      \ 'open': '\v%(\\newif)@<!\\if%(lastpage|field|name|numequal|thenelse)@!',
      \ 'else': '\\else\>',
      \ 'close': '\\fi\>',
      \}

let g:vimtex_indent_ignored_envs = ['document', 'questions']

let g:vimtex_indent_lists = [
      \ 'itemize',
      \ 'description',
      \ 'enumerate',
      \ 'thebibliography',
      \]

""" Delimiters
let g:vimtex_delim_toggle_mod_list = [
      \ ['\left', '\right'],
      \ ['\bigl', '\bigr'],
      \ ['\Bigl', '\Bigr'],
      \ ['\biggl', '\biggr'],
      \ ['\Biggl', '\Biggr'],
      \]

""" Alternative latexmk settings
let latexmk_notes = {
        \ 'backend' : 'jobs',
        \ 'background' : 1,
        \ 'build_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
	\   '-jobname=notes'
        \ ],
        \}



"" MODELINE
" vim:fdm=expr
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'"*')-1)\:'='
"
