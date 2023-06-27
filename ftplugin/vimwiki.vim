let vimwiki_header_type = '='
setlocal foldlevel=2
setlocal foldenable
" setlocal foldmethod=syntax
setlocal foldexpr=pandoc#folding#MarkdownLevelBasic()
setlocal foldtext=pandoc#folding#MarkdownFoldText()
setlocal nowrap


setlocal shiftwidth=4 smarttab
setlocal expandtab
setlocal tabstop=8 softtabstop=8
