" credit to Joe Ferris of thoughtbot (github.com/joeferris)
function! MergeTabs()
if tabpagenr() == 1
   return
 endif
 let bufferName = bufname("%")
 if tabpagenr("$") == tabpagenr()
   close!
 else
   close!
   tabprev
 endif
 split
 execute "buffer " . bufferName
endfunction

" the below will merge tabs with vsplit
nnoremap <C-W>m :call MergeTabs()<CR><C-W>t <C-W>H
" the below will merge tabs with hsplit
nnoremap <C-W>M :call MergeTabs()<CR>
