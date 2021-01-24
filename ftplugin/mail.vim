setlocal textwidth=72
setlocal nojs
setlocal nosmartindent

setlocal formatoptions+=t formatoptions+=w

" mail/pposting.vim contains functions and mappings for automatic setup and
" easy manipulation of mail messages.
" Configuration values for posting.vim
let g:DeleteQuotedSignature=1
let g:DeleteOldSubject=1
let g:CleanSubject=1

let g:UseMailMappings=1

let g:SignOff=1
let b:Signoff="Best,"
let b:Name="Matt"
