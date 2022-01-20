let vimwiki_header_type = '='
setlocal foldlevel=0
setlocal foldenable
" setlocal foldmethod=syntax
setlocal foldexpr=pandoc#folding#MarkdownLevelBasic()
setlocal foldtext=pandoc#folding#MarkdownFoldText()

