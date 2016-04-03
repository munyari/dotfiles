"Fuzzy file finding
Plug 'ctrlpvim/ctrlp.vim'

" The Silver Searcher
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" order results top to bottom
let g:ctrlp_match_window = 'bottom,order:ttb'
" open files in a new buffer
let g:ctrlp_switch_buffer = 0
" CTRLP will respect working directory changes
let g:ctrlp_working_path_mode = 0
