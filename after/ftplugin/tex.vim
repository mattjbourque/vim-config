" Vim plugin to add bibiliography file to the list of included files for
" autocomplete
"

" Tell Vim how to recognize LaTeX \biliograhy{foo}:
let &l:include .= '\|\\bibliography{'
" On some file systems, "{" and "}" are inluded in 'isfname'.  In case the
" TeX file has \include{fname} (LaTeX only), strip everything except "fname".
let &l:includeexpr = "substitute(v:fname, '^.\\{-}{\\|}.*', '', 'g')"
setlocal suffixesadd+=.bib
