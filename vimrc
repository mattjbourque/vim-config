"" INITAL SETTINGS
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


"" VUNDLE SETUP
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
Plugin 'vimoutliner/vimoutliner'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes' 
"Plugin 'mattjbourque/airline-latex'
Plugin 'jalvesaq/Nvim-R'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'moll/vim-bbye'
Plugin 'freitass/todo.txt-vim'
Plugin 'lervag/vimtex'
Plugin 'ycm-core/YouCompleteMe'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

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

runtime ftplugin/man.vim

set hidden "Set buffers to hidden when abandoning them
if exists('+modelineexpr')
set modelineexpr " Allow expression options in modelines
endif

" Set the shell for commands within Vim
set shell=/bin/bash\ --rcfile\ ~/.bashvimrc

" Search in same directory as current file for tags, then work up the tree
set tags=./tags;/

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
set listchars=eol:¬,tab:▸·

" put new splits below and to the right of current one
"set splitbelow

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

"" COLORS and SYNTAX HIGHLIGHTING
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    "  set hlsearch
endif

set background=dark
colorscheme solarized

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

    autocmd FileType markdown setlocal textwidth=79

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

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif

augroup END

"" TEMPLATE AUTOCOMMANDS
" TODO: figure out path specification. Currently vim only seems to match paths
" from home directory, not from, say ~/Teaching/103stat_S20/Classwork
" Here is a hint: help says for :p filename modifier "For a filename that does
" not exist and does not have an absolute path the result is unpredictable."
augroup Templates
    au!

    autocmd BufNewFile */118math_*/Quizzes/*quiz/questions.tex 
		\ 0r ~/.vim/templates/quiz_worksheet_preamble.tex 
		\| $r ~/.vim/templates/quiz_header.tex
		\| $r ~/.vim/templates/questions_wrapper.tex
		\| set ft=tex
		\| exe "normal gg"

    autocmd BufNewFile */118math_*/Quizzes/*practice/questions.tex 
		\ exe "!mkdir -p %:h"
		\| 0r ~/.vim/templates/exam_class_preamble.tex 
		\| $r ~/.vim/templates/practice_quiz_header.tex
		\| $r ~/.vim/templates/questions_wrapper.tex
		\| set ft=tex
		\| exe "normal gg"

    autocmd BufNewFile */103stat_*/Quizzes/*quiz/questions.Rnw
		\ 0r ~/.vim/templates/quiz_worksheet_preamble.tex 
		\| $r ~/.vim/templates/knitr_setup.Rnw
		\| $r ~/.vim/templates/quiz_header.tex
		\| $r ~/.vim/templates/questions_wrapper.tex
		\| set ft=rnoweb
		\| exe "normal gg"

    autocmd BufNewFile */118math_*/Exams/*exam/questions.tex
		\ 0r ~/.vim/templates/exam_preamble.tex 
		\| $r ~/.vim/templates/exam_coverpages.tex
		\| $r ~/.vim/templates/questions_wrapper.tex
		\| set ft=tex
		\| exe "normal gg"

    autocmd BufNewFile */103stat_*/Exams/*exam/questions.Rnw
		\ 0r ~/.vim/templates/exam_preamble.tex 
		\| $r ~/.vim/templates/knitr_setup.Rnw
		\| $r ~/.vim/templates/exam_coverpages.tex
		\| $r ~/.vim/templates/questions_wrapper.tex
		\| set ft=rnoweb
		\| exe "normal gg"

    autocmd BufNewFile */118math_*/Quizzes/*practice/questions.tex 
		\ 0r ~/.vim/templates/quiz_worksheet_preamble.tex 
		\| $r ~/.vim/templates/practice_header.tex
		\| $r ~/.vim/templates/questions_wrapper.tex
		\| set ft=tex
		\| exe "normal gg"

    autocmd BufNewFile */103stat_*/Quizzes/*practice/questions.Rnw
		\ 0r ~/.vim/templates/quiz_worksheet_preamble.tex 
		\| $r ~/.vim/templates/knitr_setup.Rnw
		\| $r ~/.vim/templates/practice_header.tex
		\| $r ~/.vim/templates/questions_wrapper.tex
		\| set ft=rnoweb
		\| exe "normal gg"

    autocmd BufNewFile */103stat*/Classwork/*/questions.Rnw
		\ 0r ~/.vim/templates/quiz_worksheet_preamble.tex 
		\| $r ~/.vim/templates/knitr_setup.Rnw
		\| $r ~/.vim/templates/classwork_header.tex
		\| $r ~/.vim/templates/questions_wrapper.tex
		\| set ft=rnoweb
		\| exe "normal gg"

    autocmd BufNewFile */103stat*/Slides/*/slides.Rnw
		\ 0r ~/.vim/templates/beamer_class_preamble.tex 
		\| $r ~/.vim/templates/knitr_setup.Rnw
		\| $r ~/.vim/templates/slides_body.tex
		\| set ft=rnoweb
		\| exe "normal gg"

    autocmd BufNewFile */103stat_*/Quizzes/*practice/questions.Rnw 
		\ 0r ~/.vim/templates/exam_class_preamble.tex 
		\| $r ~/.vim/templates/knitr_setup.Rnw
		\| $r ~/.vim/templates/practice_quiz_header.tex
		\| $r ~/.vim/templates/questions_wrapper.tex
		\| set ft=rnoweb
		\| exe "normal gg"


augroup END
"" MY MAPPINGS

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
nnoremap <leader>et :call OpenNewIfBufferNotEmpty('~/Dropbox/todo/todo.txt')<CR>
nnoremap <leader>en :call OpenNewIfBufferNotEmpty('~/Dropbox/todo/lifenotes.txt')<CR>
nnoremap <leader>exm :call OpenNewIfBufferNotEmpty('~/.xmonad/xmonad.hs')<CR>
nnoremap <leader>eft :execute "new ~/.vim/ftplugin/".&filetype.".vim"<CR>

nnoremap <leader>R :terminal ++close R --vanilla --quiet<CR>

command! Wd write|bdelete


"" AIRLINE SETTINGS
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts=0

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#airlatex#enabled=0

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
let maplocalleader = ','
let R_openpdf=1
let R_openhtml = 0 " See NVim-R help about getting browser to reload
let R_applescript = 0
let R_nvimpager = "no"
let R_nvimpager = "vertical"
let R_pdfviewer = "zathura"
 
"" Vimtex settings
let g:vimtex_quickfix_autoclose_after_keystrokes=5


"" UltiSnips settings

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


"" CtrlP settings
let g:ctrlp_brief_prompt=1

let g:ctrlp_working_path_mode = 'rwa'
let g:ctrlp_root_markers = ['.classroot']

"Mappings 
nnoremap <c-h> :CtrlP $HOME<CR>
inoremap <c-h> <C-O>:CtrlP $HOME<CR>

nnoremap <c-c> :CtrlPDir $HOME<CR>
inoremap <c-c> <C-O>:CtrlPDir $HOME<CR>

"" MODELINE
" vim:fdm=expr
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'"*')-1)\:'='
