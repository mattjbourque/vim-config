set sw=2
set iskeyword+=:
set grepprg=grep\ -nH\ $*

onoremap <silent> i$ :<c-u>normal! T$vt$<cr>
vnoremap i$ T$ot$

" Trying without YCM for a bit
" let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme

" " Don't try to complete identifiers in LaTeX
" let g:ycm_min_num_of_chars_for_completion=99

