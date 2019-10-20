" Don't load twice
if exists("g:loaded_MyMailPlugin")
    finish
endif
let g:loaded_MyMailPlugin=1
echo 'MyMail plugin loaded'


setlocal textwidth=72
setlocal nojs
setlocal nosmartindent

setlocal formatoptions+=n formatoptions+=t formatoptions+=w

call search("^$")

" Huh?
augroup MyMail
    au!
    autocmd BufReadPost * exe :normal /^$'
    autocmd BufReadPost * :echom "MyMail group"
augroup END

