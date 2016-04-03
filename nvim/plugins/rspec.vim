Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }

" RSpec.vim mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
nnoremap <Leader>a :call RunAllSpecs()<CR>

" borrowed from tpope's rails.vim
function! RailsDetect(...) abort
  if exists('b:rails_root')
    return 1
  endif
  let fn = fnamemodify(a:0 ? a:1 : expand('%'), ':p')
  if fn =~# ':[\/]\{2\}'
    return 0
  endif
  if !isdirectory(fn)
    let fn = fnamemodify(fn, ':h')
  endif
  let file = findfile('config/environment.rb', escape(fn, ', ').';')
  if !empty(file) && isdirectory(fnamemodify(file, ':p:h:h') . '/app')
    let b:rails_root = fnamemodify(file, ':p:h:h')
    return 1
  endif
endfunction

" vim rspec settings
if RailsDetect()
  let g:rspec_command = "call VtrSendCommand('bundle exec rspec {spec}')"
else
  let g:rspec_command = "call VtrSendCommand('rspec {spec}')"
endif
