" python.vim
"
" Created by Jeff Elkner 23 January 2006
" Last modified May 20, 2008 Matt Bourque
"
" Turn on syntax highlighting and autoindenting
syntax enable
filetype indent on
" set autoindent width to 4 spaces (see
" http://www.vim.org/tips/tip.php?tip_id=83)
set et
set sw=4
set smarttab
" Bind <f2> key to running the python interpreter on the currently active
" file.  (curtesy of Steve Howell from email dated 1 Feb 2006).
map <f2> :w\|!python %<cr>
