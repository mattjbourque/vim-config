" Settings for Rnoweb (knitr) files

if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_min_num_of_chars_for_completion = 99
let g:ycm_semantic_triggers.rnoweb=g:vimtex#re#youcompleteme

