"" General TeX document settings
set sw=2
set iskeyword+=:
set grepprg=grep\ -nH\ $*

set conceallevel=0

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

if !exists('*ChangeAndCompile')
  function! ChangeAndCompile(pattern, replace, jobname)

    set lazyredraw

    cd %:h
    let current_bufnr = bufnr()
    let new_bufnr = bufadd(a:jobname.'.tex')
    call bufload(new_bufnr)
    let bufend = line('$')
    call appendbufline(new_bufnr, 0, getline(1, bufend))

    execute 'hide buffer' new_bufnr
    execute '%s/'.a:pattern.'/'.a:replace
    echom "writing" expand("%")  "in" getcwd()
    silent write!
    echom "doing latexmk in" getcwd()
    execute 'silent !latexmk -pdf -shell-escape' a:jobname 
    execute 'buffer' current_bufnr
    execute 'bd!' new_bufnr
    cd -

    set nolazyredraw
    redraw!
  endfunction
endif

let g:solutions_header = '\\documentclass[answers, 12pt, letterpaper]{exam}'
let g:notes_header = '\\documentclass[12pt, letterpaper]{article} \\usepackage[hyperref, envcountsect]{beamerarticle}'

nnoremap <localleader>lS :call ChangeAndCompile('\\documentclass.*{exam}', g:solutions_header, "solutions")<CR>
nnoremap <localleader>lN :call ChangeAndCompile('\\documentclass.*{beamer}', g:notes_header, "notes")<CR>

"" Publish PDF
" Depends on CopyOutput, defined in vimrc
" Intended for publishing PDF slides and classwork to Sakai
command -nargs=? PublishPDF call CopyOutput('~/Dropbox/Teaching', '~/ExpanDrive', '.pdf')

"" vimTex settings

""" For WSL

" if has('win32') || (has('unix') && exists('$WSLENV'))
"  if executable('mupdf.exe')
"    let g:vimtex_view_general_viewer = 'mupdf.exe'
"  elseif executable('/mnt/c/Users/mbourque/AppData/Local/SumatraPDF/SumatraPDF.exe')
"    let g:vimtex_view_general_viewer = '/mnt/c/Users/mbourque/AppData/Local/SumatraPDF/SumatraPDF.exe'
"  endif
" endif

""" Viewer
let g:vimtex_view_method='zathura'

""" Logging
let g:vimtex_quickfix_autoclose_after_keystrokes=5

" TODO: I usually don't care much about overfull/underfull boxes, but I might
" want to easily change this if I were working on something where it mattered.
let g:vimtex_quickfix_ignore_filters = [
      \ 'LaTeX Font Warning',
      \ 'Overfull \\hbox',
      \ 'Overfull \\vbox',
      \ 'Underfull \\hbox',
      \ 'Underfull \\vbox',
      \]

""" Folding
let g:vimtex_fold_enabled=1
let g:vimtex_fold_manual=1
let g:vimtex_fold_types = {
      \ 'comments' : {'enabled' : 1},
      \ 'preamble' : {'enabled' : 1},
      \ 'envs' : {
      \   'blacklist' : [],
      \   'whitelist' : ['coverpages', 'frame', 'questions', 'tikzpicture',],
      \ },
      \ 'sections' : {
      \   'parse_levels' : 0,
      \   'sections' : [
      \    'section',
      \	   'question',
      \	   'part',
      \  ],
      \ },
      \ 'env_options' : {
      \   'blacklist' : [],
      \   'whitelist' : ['axis'],
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
      \ 'questions'
      \]

""" Delimiters
let g:vimtex_delim_toggle_mod_list = [
      \ ['\left', '\right'],
      \ ['\bigl', '\bigr'],
      \ ['\Bigl', '\Bigr'],
      \ ['\biggl', '\biggr'],
      \ ['\Biggl', '\Biggr'],
      \]

let g:vimtex_env_toggle_math_map = {
      \ '$': '\[',
      \ '\[': 'align*',
      \ '$$': '\[',
      \ '\(': '$',
      \}

let g:vimtex_compiler_latexmk = {
      \ 'options' : [
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \   '-shell-escape',
      \],
      \}

""" Alternative latexmk settings
" let latexmk_notes = {
"       \ 'backend' : 'jobs',
"       \ 'background' : 1,
"       \ 'build_dir' : '',
"       \ 'callback' : 1,
"       \ 'continuous' : 1,
"       \ 'executable' : 'latexmk',
"       \ 'hooks' : [],
"       \ 'options' : [
"       \   '-verbose',
"       \   '-file-line-error',
"       \   '-synctex=1',
"       \   '-interaction=nonstopmode',
"       \   '-jobname=notes'
"       \ ],
"       \}

"" SuperTab settings

let g:SuperTabNoCompleteAfter+=['}']

"" MODELINE
" vim:fdm=expr
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'"*')-1)\:'='
"
