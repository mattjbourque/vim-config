set sw=2
set iskeyword+=:
set grepprg=grep\ -nH\ $*

onoremap <silent> i$ :<c-u>normal! T$vt$<cr>
vnoremap i$ T$ot$

