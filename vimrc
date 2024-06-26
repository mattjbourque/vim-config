"" INITAL SETTINGS
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


"" PLUGINS
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

""" VUNDLE: PLUGINS
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-scriptease'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-repeat'

" Wiki and outlining
Plugin 'vimwiki/vimwiki'
Plugin 'mattn/calendar-vim'

" Airline status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes' 
"Plugin 'mattjbourque/airline-latex'
Plugin 'jalvesaq/Nvim-R'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'altercation/vim-colors-solarized'
Plugin 'moll/vim-bbye'

" I had a repo for this, I think. Where is it?
Plugin 'freitass/todo.txt-vim'

Plugin 'lervag/vimtex'

Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

Plugin 'ervandew/supertab'

" Plugin 'CoderCookE/vim-chatgpt'

" Testing a local plugin - make symbolic link in ~/.vim/bundle
"Plugin 'vim-latex', {'pinned': 1}

""" VUNDLE: EXAMPLE
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" All of your Plugins must be added before the following line
call vundle#end()            " required


"" SETTINGS

set belloff=all

" Settings for mouse in windows terminal
set mouse=a
set ttymouse=sgr

let g:tex_flavor = "latex"

runtime ftplugin/man.vim

" Don't show the gap
" https://wiki.archlinux.org/index.php/Vim#Empty_space_at_the_bottom_of_gVim_windows
set guiheadroom=0

set hidden "Set buffers to hidden when abandoning them
if exists('+modelineexpr')
set modelineexpr " Allow expression options in modelines
endif

" Set the shell for commands within Vim
set shell=/usr/bin/fish

" Search in same directory as current file for tags, then work up the tree
set tags=./tags;/

" Case sensitivity in searching. Note you can use \C anywhere in the search
" string to force case sensitive search.
 set ignorecase
 set smartcase

" Make file completion behave like Bash: http://www.fuzz.dk/software/vim/filename_completion
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.log
	    \,*.aux
	    \,*.pdf
	    \,*.toc
	    \,*.nav
	    \,*.snm
	    \,*.out
	    \,*-concordance.tex
	    \,*.fls
	    \,*.fdb_latexmk
	    \,*.synctex.gz
	    \,*-tikzDictionary

augroup NoWildignoreInsert
  au!
  au InsertEnter *
        \ if !exists('b:old_wildignore') |
        \   let b:old_wildignore=&wildignore |
        \   set wildignore& |
        \ endif
  au InsertLeave *
        \ if exists('b:old_wildignore') |
        \   let &wildignore=b:old_wildignore |
        \   unlet b:old_wildignore |
        \ endif
augroup END

" add my bibtex directory for searching for include files
set path+=/home/matt/texmf/tex/latex/bibtex/bib
set suffixesadd=.tex,.bib

" set directory for vim backup files, add directory for uniqueness
set backupdir=~/.vimbackup,/tmp
let &backupext=substitute(expand('%:p:h'),'[\,/]','%','g')

" set default indent style
set autoindent
set softtabstop=4
set shiftwidth=4

" by default, list mode is off
" set listchars to display eol and tabs when :set list is used
set nolist
set listchars=eol:¬,tab:▸·,space:·

set fillchars=fold:\ 

set splitright

" always show statusline
set laststatus=2

"use line numbers
set number
set relativenumber

" Use smart wrapping
set breakindent
set showbreak=↳\ 
set cpoptions+=n
set breakindentopt+=sbr

set fillchars=fold:\ 

" system clipboard
"set clipboard=unnamedplus

"Improve visibility of autocomplete popup menu
"from http://vim.wikia.com/wiki/Omni_completion_popup_menu
"highlight Pmenu guibg=brown gui=bold

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" formatoptions
set formatoptions=jcrql

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
    set backup		" keep a backup file
endif

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
	autocmd!
	autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

""" Gvim settings

" Make external commands work through a pipe instead of a pseudo-tty
set noguipty

" Font choice: move to local file
" set guifont=Inconsolata\ 14
source $HOME/.vim/localVimrc

" Hide the menubar and toolbar
set guioptions -=m
set guioptions -=T
set guioptions -=r
set guioptions -=L

"" COLORS and SYNTAX HIGHLIGHTING
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    "  set hlsearch
endif

set t_Co=16
set background=dark
colorscheme solarized

command! LightScheme  set background=light
	    \| let g:airline_solarized_bg='light'
	    \| AirlineRefresh

command! DarkScheme  set background=dark
	    \| let g:airline_solarized_bg='dark'
	    \| AirlineRefresh

" Set up terminal colors for solarized dark theme.
" TODO: How to set this up more flexibly for changing color on the fly from
" light to dark?
let g:terminal_ansi_colors = [
	    \ "#073642", "#dc322f", "#859900", "#b58900", 
	    \ "#268bd2", "#d33682", "#2aa198", "#eee8d5", 
	    \ "#cb4b16", "#002b36", "#586e75", "#657b83", 
	    \ "#839496", "#6c71c4", "#93a1a1", "#fdf6e3"
	    \]

"" FILETYPE AUTOCOMMANDS
" TODO: move these to individual ftplugin files
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
filetype plugin indent on    " required
" Setting filetypes
augroup vimrcSpecialFiletypes
    au!

    autocmd BufNewFile,BufRead dmenuExtended_preferences.txt set filetype=json

augroup END


" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
    au!


    " Set 'textwidth' and tabs and such for various kinds of files
    autocmd FileType text setlocal textwidth=79

    autocmd FileType tex  setlocal textwidth=0
    autocmd FileType tex  setlocal wrap
    autocmd FileType tex  setlocal breakindent
    autocmd FileType tex  setlocal breakindentopt=shift:5,sbr
    "autocmd FileType tex  setlocal showbreak=---------->
    autocmd FileType tex  setlocal lbr
    autocmd FileType tex  setlocal autoindent
    autocmd FileType tex  setlocal softtabstop=2
    autocmd FileType tex  setlocal shiftwidth=2

    autocmd FileType r    setlocal textwidth=79
    autocmd FileType r    setlocal softtabstop=2
    autocmd FileType r    setlocal autoindent
    autocmd FileType html setlocal textwidth=79
    autocmd filetype html setlocal autoindent
    autocmd filetype html setlocal softtabstop=2
    autocmd filetype html setlocal shiftwidth=2
    autocmd FileType css  setlocal textwidth=79
    autocmd filetype css  setlocal autoindent
    autocmd filetype css  setlocal softtabstop=2
    autocmd filetype css  setlocal shiftwidth=2
    autocmd filetype php  setlocal autoindent
    autocmd filetype php  setlocal softtabstop=2
    autocmd filetype php  setlocal shiftwidth=2
    autocmd FileType python setlocal textwidth=79
    autocmd filetype python setlocal autoindent
    autocmd filetype python setlocal softtabstop=4
    autocmd filetype python setlocal shiftwidth=4
    autocmd filetype python setlocal expandtab

augroup END


" "" TEMPLATE AUTOCOMMANDS
" " TODO: figure out path specification. Currently vim only seems to match paths
" " from home directory, not from, say ~/Teaching/103stat_S20/Classwork
" " Here is a hint: help says for :p filename modifier "For a filename that does
" " not exist and does not have an absolute path the result is unpredictable."
" augroup Templates
"     au!

"     autocmd BufNewFile */118math_*/Quizzes/*quiz/questions.tex 
" 		\ 0r ~/.vim/templates/quiz_worksheet_preamble.tex 
" 		\| $r ~/.vim/templates/quiz_header.tex
" 		\| $r ~/.vim/templates/questions_wrapper.tex
" 		\| set ft=tex
" 		\| exe "normal gg"

"     autocmd BufNewFile */118math_*/Quizzes/*practice/questions.tex 
" 		\ exe "!mkdir -p %:h"
" 		\| 0r ~/.vim/templates/exam_class_preamble.tex 
" 		\| $r ~/.vim/templates/practice_quiz_header.tex
" 		\| $r ~/.vim/templates/questions_wrapper.tex
" 		\| set ft=tex
" 		\| exe "normal gg"

"     autocmd BufNewFile */103stat_*/Quizzes/*quiz/questions.Rnw
" 		\ 0r ~/.vim/templates/quiz_worksheet_preamble.tex 
" 		\| $r ~/.vim/templates/knitr_setup.Rnw
" 		\| $r ~/.vim/templates/quiz_header.tex
" 		\| $r ~/.vim/templates/questions_wrapper.tex
" 		\| set ft=rnoweb
" 		\| exe "normal gg"

"     autocmd BufNewFile */118math_*/Exams/*exam/questions.tex
" 		\ 0r ~/.vim/templates/exam_preamble.tex 
" 		\| $r ~/.vim/templates/exam_coverpages.tex
" 		\| $r ~/.vim/templates/questions_wrapper.tex
" 		\| set ft=tex
" 		\| exe "normal gg"

"     autocmd BufNewFile */103stat_*/Exams/*exam/questions.Rnw
" 		\ 0r ~/.vim/templates/exam_preamble.tex 
" 		\| $r ~/.vim/templates/knitr_setup.Rnw
" 		\| $r ~/.vim/templates/exam_coverpages.tex
" 		\| $r ~/.vim/templates/questions_wrapper.tex
" 		\| set ft=rnoweb
" 		\| exe "normal gg"

"     autocmd BufNewFile */118math_*/Quizzes/*practice/questions.tex 
" 		\ 0r ~/.vim/templates/quiz_worksheet_preamble.tex 
" 		\| $r ~/.vim/templates/practice_header.tex
" 		\| $r ~/.vim/templates/questions_wrapper.tex
" 		\| set ft=tex
" 		\| exe "normal gg"

"     autocmd BufNewFile */103stat_*/Quizzes/*practice/questions.Rnw
" 		\ 0r ~/.vim/templates/quiz_worksheet_preamble.tex 
" 		\| $r ~/.vim/templates/knitr_setup.Rnw
" 		\| $r ~/.vim/templates/practice_header.tex
" 		\| $r ~/.vim/templates/questions_wrapper.tex
" 		\| set ft=rnoweb
" 		\| exe "normal gg"

"     autocmd BufNewFile */103stat*/Classwork/*/questions.Rnw
" 		\ 0r ~/.vim/templates/quiz_worksheet_preamble.tex 
" 		\| $r ~/.vim/templates/knitr_setup.Rnw
" 		\| $r ~/.vim/templates/classwork_header.tex
" 		\| $r ~/.vim/templates/questions_wrapper.tex
" 		\| set ft=rnoweb
" 		\| exe "normal gg"

"     autocmd BufNewFile */103stat*/Slides/*/slides.Rnw
" 		\ 0r ~/.vim/templates/beamer_class_preamble.tex 
" 		\| $r ~/.vim/templates/knitr_setup.Rnw
" 		\| $r ~/.vim/templates/slides_body.tex
" 		\| set ft=rnoweb
" 		\| exe "normal gg"

"     autocmd BufNewFile */103stat_*/Quizzes/*practice/questions.Rnw 
" 		\ 0r ~/.vim/templates/exam_class_preamble.tex 
" 		\| $r ~/.vim/templates/knitr_setup.Rnw
" 		\| $r ~/.vim/templates/practice_quiz_header.tex
" 		\| $r ~/.vim/templates/questions_wrapper.tex
" 		\| set ft=rnoweb
" 		\| exe "normal gg"


" augroup END
"" MY MAPPINGS

" From https://vim.fandom.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

command! Mkdir !mkdir -p %:h

" Basis for a mapping to use sk to upload current file
" !sk -c %:p:h:h:t -f %:p:h:t -t % %
" but trouble: doesn't wait for password input

" <leader>cs copies filename <leader>cl copies path to X clipboard
nnoremap <leader>cs :let @*=expand("%")<CR>
nnoremap <leader>cl :let @*=expand("%:p")<CR>

" <leader>bc passes the current line to bc and joins the result with the previous line.
nnoremap <leader>bc Iscale=4; <Esc>:.!bc -l ~/.config/bc/bc_init<CR>kJA
inoremap <leader>bc <Esc>Iscale=4; <Esc>:.!bc -l ~/.config/bc/bc_init<CR>kJA

" Easy opening of standard files
function! OpenNewIfBufferNotEmpty(filename)
    if expand('%:p') == ''
	exec ':edit' a:filename
    else
	exec ':new' a:filename
    endif
endfunction

" TODO: don't open a new window if the current one is empty
nnoremap <leader>ev :call OpenNewIfBufferNotEmpty($MYVIMRC)<CR>
nnoremap <leader>et :call OpenNewIfBufferNotEmpty('~/Dropbox/MyWiki/todo/todo.txt')<CR>
nnoremap <leader>eQ :call OpenNewIfBufferNotEmpty('~/Dropbox/MyWiki/QuickNote.md')<CR>
nnoremap <leader>em :call OpenNewIfBufferNotEmpty('~/Dropbox/todo/meetingnotes.txt')<CR>
nnoremap <leader>exm :call OpenNewIfBufferNotEmpty('~/.xmonad/xmonad.hs')<CR>
nnoremap <leader>eft :execute "new ~/.vim/ftplugin/".split(&filetype, '\.')[0].".vim"<CR>
nnoremap <leader>eu :UltiSnipsEdit<cr>
nnoremap <leader>eU :vsplit ~/Dropbox/Config/UltiSnips/


nnoremap <leader>R :terminal ++close R --vanilla --quiet<CR>

" I would like to have a command for this.
map <F6> :let $VIM_DIR=expand('%:p:h')<CR>:terminal<CR> cd $VIM_DIR; clear<CR>

"" Function definitions

function! CopyOutput(base_directory, destination_directory, extension)
  let current_dir = getcwd()
  exec 'cd' a:base_directory
  echom 'Current directory: ' . getcwd()
  echom 'running ' . 'mkdir -p ' . a:destination_directory . '/' . expand('%:h')
  call system('mkdir -p ' . a:destination_directory . '/' . expand('%:h'))
  echom 'running' . 'cp --parents ' . expand('%:r') . '.' . a:extension . ' ' .  a:destination_directory
  call system('cp --parents ' . expand('%:r') .  a:extension . ' ' .  a:destination_directory)
  exec 'cd' current_dir
endfunction

"" AIRLINE SETTINGS
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts=0

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#airlatex#enabled=0

let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

let g:airline#extensions#branch#enabled=1

"" LATEX-SUITE SETTINGS
" also some stuff in .vim/ftplugin/tex.vim. I am not sure whether it would be
" better here. Let's figure that out someday.
"
" <+place-holder+> jump mappings
" nmap <C-Space> <Plug>IMAP_JumpForward
" imap <C-Space> <Plug>IMAP_JumpForward
" smap <C-Space> <Plug>IMAP_JumpForward
" This needs attention

" Easily toggle using Makefile
nnoremap <leader>m :call TexMakefileToggle()<CR>

function! TexMakefileToggle()
    if g:Tex_UseMakefile
	let g:Tex_UseMakefile = 0
	echo "Calling pdflatex directly"
    else
	let g:Tex_UseMakefile = 1
	echo "Using Makefile"
    endif
endfunction



""" ENVIRONMENT EXPANSIONS

let g:Tex_Env_frame="\\begin{frame}\<CR> \\frametitle{<++>}\<CR>\<CR><++>\<CR>\<CR>\\end{frame}<++>"
let g:Tex_Env_fframe="\\begin{frame}[fragile]\<CR> \\frametitle{<++>}\<CR>\<CR><++>\<CR>\<CR>\\end{frame}<++>"
let g:Tex_Env_framesplit="\\end{frame}\<CR>\<CR>\\begin{frame}\<CR>\\frametitle{<++>}\<CR>\<CR>"
let g:Tex_Env_example="\\begin{example}\<CR><++>\<CR>\\end{example}<++>"
let g:Tex_Env_solution="\\begin{solution}<++>\<CR><+solution+>\<CR>\\end{solution}<++>"
let g:Tex_Env_solutionorlines="\\begin{solutionorlines}<++>\<CR><+solution+>\<CR>\\end{solutionorlines}<++>"
let g:Tex_Env_solutionorgrid="\\begin{solutionorgrid}<++>\<CR><+solution+>\<CR>\\end{solutionorgrid}<++>"
let g:Tex_Env_block="\\begin{block}{<++>}\<CR><++>\<CR>\\end{block}<++>"
let g:Tex_Env_enumerate="\\begin{enumerate}<++>\<CR>\<CR>\\item<++>\<CR>\<CR>\\end{enumerate}<++>"
let g:Tex_Env_parts="\\begin{parts}\<CR>\<CR>\\part<++>\<CR>\<CR>\\end{parts}<++>"
let g:Tex_Env_aligned="$\\begin{aligned}[<+baseline+>]\<CR><+content+>\<CR>\\end{aligned}$<++>"

let g:Tex_Env_axis="\\begin{axis}[\<CR>axis x line = center,\<CR>axis y line = center,\<CR>xmin = <++>, xmax = <++>,\<CR>ymin = <++>, ymax = <++>,\<CR>xtick distance = <++>,\<CR>ytick distance = <++>,\<CR>grid = <+major,both+>,\<CR>xlabel = <++>,\<CR>ylabel = <++>,\<CR>every tick label/.append style={font=\\tiny},\<CR>clip=false<++>\<CR>]\<CR>\<CR><++>\<CR>\<CR>\\end{axis}<++>"

""" COMMAND EXPANSIONS
let g:Tex_Com_question = "\\question%<<<\<CR><++>\<CR>%>>><++>"
let g:Tex_Com_only = "\\only<<++>>{<++>}"
let g:Tex_Com_space = "\\vspace{\\stretch{<++>}}"

"" NVIM-R SETTINGS
let maplocalleader = '\'
let R_openpdf=1
let R_openhtml = 0 " See NVim-R help about getting browser to reload
let R_applescript = 0
let R_nvimpager = "no"
let R_nvimpager = "vertical"
let R_pdfviewer = "zathura"
let R_clear_line = 1
 
"" UltiSnips setting

let g:UltiSnipsSnippetDirectories=[$HOME.'/Dropbox/Config/UltiSnips']

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:snips_author="mattjbourque@gmail.com"

"" todo.txt settings
" don't use date mappings
let g:todo_txt_disable_date_mappings=1

"" SuperTab settings
let g:SuperTabDefaultCompletionType='context'

let wiki_notes = {}
let wiki_notes.name = 'My notes wiki'
let wiki_notes.path = '~/Dropbox/MyWiki'
let wiki_notes.syntax = 'markdown'
let wiki_notes.ext = '.md'
let wiki_notes.nested_syntaxes = {'todo': 'todo'}

"" Vimwiki settings

" let g:twvim_handlers = {
" 	    \ 'Dropbox': {'prefix': 'local:~/Dropbox', 'replacement': 'C:/Users/mbourque/Dropbox'}
" 	    \}

let g:vimwiki_global_ext = 0

let g:vimwiki_list = [
	    \{
	    \ 'name': '118math_S24_docs',
	    \ 'path': '~/Dropbox/Teaching/118math_S24/course_docs',
	    \ 'path_html': '~/Dropbox/Teaching/118math_S24/Sakai/course_docs',
	    \ 'auto_toc':1,
	    \ 'auto_export':1,
	    \ 'syntax': 'markdown',
	    \ 'links_space_char': '_',
	    \ 'ext': 'md',
	    \ 'custom_wiki2html': '~/Dropbox/Teaching/Utilities/coursepages_html.sh',
	    \ 'custom_wiki2html_args': 'https://sakai.luc.edu/dav/MATH_118_003_1092_1242'
	    \},
	    \{
	    \ 'name': '132math_S24_docs',
	    \ 'path': '~/Dropbox/Teaching/132math_S24/course_docs',
	    \ 'path_html': '~/Dropbox/Teaching/132math_S24/Sakai/course_docs',
	    \ 'auto_toc':1,
	    \ 'auto_export':1,
	    \ 'syntax': 'markdown',
	    \ 'links_space_char': '_',
	    \ 'ext': 'md',
	    \ 'custom_wiki2html': '~/Dropbox/Teaching/Utilities/coursepages_html.sh',
	    \ 'custom_wiki2html_args': 'https://sakai.luc.edu/dav/MATH_132_004_1319_1242'
	    \},
	    \wiki_notes,
	    \{
	    \ 'name': 'Teaching notes',
	    \ 'path': '~/Dropbox/Teaching/wiki',
	    \ 'syntax':'markdown', 'ext':'.md'
	    \},
	    \]

let g:vimwiki_key_mappings = {'table_mappings' : 0}

let g:vimwiki_folding = 'custom'

"" Pandoc settings
let g:pandoc#command#latex_engine="pdflatex"

"" ChatGPT plugin settings

let g:chat_gpt_key='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'
let g:chat_gpt_max_tokens=2000
let g:chat_gpt_model='gpt-3.5-turbo'

"" MODELINE
" vim:fdm=expr
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'"*')-1)\:'='
