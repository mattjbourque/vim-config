let vimwiki_header_type = '#'
setlocal foldlevel=0
setlocal foldenable
setlocal foldmethod=expr
setlocal foldexpr=pandoc#folding#MarkdownLevelBasic()
setlocal foldtext=pandoc#folding#MarkdownFoldText()

