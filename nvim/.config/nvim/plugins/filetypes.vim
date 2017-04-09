" " C {{{
" Plug 'Rip-Rip/clang_complete', { 'for': 'c' }
" " }}}

" " C++ {{{
" Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
" " }}}

" " coq {{{
" Plug 'jvoorhis/coq.vim'
" Plug 'let-def/vimbufsync', { 'for': 'coq' } | Plug 'the-lambda-church/coquille', { 'for': 'coq' }

" augroup filetype_coq
"   autocmd!
"   " autocmd BufEnter *.v :CoqLaunch<cr>
"   autocmd Filetype coq :CoqLaunch<cr>
"   autocmd FileType coq nnoremap <right> :CoqToCursor<cr>
"   autocmd FileType coq nnoremap U :CoqUndo<cr>
" augroup END
" " }}}

" " elixir {{{
" Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
" " }}}

" " glsl {{{
" Plug 'beyondmarc/glsl.vim', { 'for': 'glsl' }
" " }}}

" " haskell {{{
" Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

" let g:haskell_enable_quantification = 1
" let g:haskell_enable_recursivedo = 1
" let g:haskell_enable_arrowsyntax = 1
" let g:haskell_enable_pattern_synonyms = 1
" let g:haskell_enable_typeroles = 1
" let g:haskell_enable_static_pointers = 1
" let g:haskell_indent_if = 4
" let g:haskell_indent_let = 4
" let g:haskell_indent_where = 4
" let g:haskell_indent_do = 4
" let g:haskell_indent_in = 4
" let g:haskell_indent_guard = 4
" let g:haskell_indent_case = 4
" " }}}

" " latex {{{
" Plug 'lervag/vimtex', { 'for': 'tex' }
" " let g:vimtex_enabled = 0
" let g:vimtex_view_method = 'zathura'

" Plug 'xuhdev/vim-latex-live-preview'
" let g:livepreview_previewer='zathura'
" " make this local to tex
" autocmd BufWritePost *.tex :VimtexCompile
" " }}}

" " markdown {{{
" Plug 'tpope/vim-markdown', { 'for': 'markdown' }



" Plug 'vim-pandoc/vim-pandoc'

" let g:pandoc#formatting#mode = 'haA'
" let g:pandoc#formatting#textwidth = 80
" let g:pandoc#folding#fold_yaml = 1
" let g:pandoc#command#autoexec_command = "Pandoc! pdf"
" let g:pandoc#folding#level = 0
" let g:pandoc#filetypes#handled = ["pandoc", "markdown", "latex"]
" let g:pandoc#folding#fdc = 0

" nnoremap <localleader>p :Pandoc! pdf<cr>
" nnoremap <localleader>w :au BufWritePost *.md :Pandoc pdf<cr>
" Plug 'vim-pandoc/vim-pandoc-syntax'
" let g:pandoc#syntax#conceal#use=0
" set conceallevel=0
" " }}}

" " ruby {{{
" " Rails in vim
" Plug 'tpope/vim-rails', { 'for': 'ruby' }

" nnoremap <Leader>ra :A
" nnoremap <Leader>rc :Econtroller
" nnoremap <Leader>rdm :Emigration
" nnoremap <Leader>rf :Efixtures
" nnoremap <Leader>rj :Ejavascript
" nnoremap <Leader>rn :Rnew
" nnoremap <Leader>rp :Rpreview
" nnoremap <Leader>rtf :Efunctionaltest
" nnoremap <Leader>rti :Eintegrationtest
" nnoremap <Leader>rtu :Eunittest
" nnoremap <Leader>rh :Ehelper
" nnoremap <Leader>rh :Ehelper
" nnoremap <Leader>rm :Emodel
" nnoremap <Leader>rru :Rrunner
" nnoremap <Leader>rs :Estylesheet
" nnoremap <Leader>rv :Eview

" nnoremap <silent><Leader>rds :Emigration 0<CR>
" nnoremap <silent><Leader>rg :Elib<CR>
" nnoremap <silent><Leader>rpp :Rpreview<CR>
" nnoremap <silent><Leader>rre :R<CR>
" nnoremap <silent><Leader>rro :Einitializer<CR>

" Plug 'tpope/vim-rake', { 'for': 'ruby' }
" Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }

" " RSpec.vim mappings
" nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
" nnoremap <Leader>s :call RunNearestSpec()<CR>
" nnoremap <Leader>l :call RunLastSpec()<CR>
" nnoremap <Leader>a :call RunAllSpecs()<CR>

" " borrowed from tpope's rails.vim
" function! RailsDetect(...) abort
"   if exists('b:rails_root')
"     return 1
"   endif
"   let fn = fnamemodify(a:0 ? a:1 : expand('%'), ':p')
"   if fn =~# ':[\/]\{2\}'
"     return 0
"   endif
"   if !isdirectory(fn)
"     let fn = fnamemodify(fn, ':h')
"   endif
"   let file = findfile('config/environment.rb', escape(fn, ', ').';')
"   if !empty(file) && isdirectory(fnamemodify(file, ':p:h:h') . '/app')
"     let b:rails_root = fnamemodify(file, ':p:h:h')
"     return 1
"   endif
" endfunction

" " vim rspec settings
" if RailsDetect()
"   let g:rspec_command = "call VtrSendCommand('bundle exec rspec {spec}')"
" else
"   let g:rspec_command = "call VtrSendCommand('rspec {spec}')"
" endif
" Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

" " automatically configures path and tags to include all libraries referenced
" " in Gemfile
" Plug 'tpope/vim-bundler'

" Plug 'kana/vim-textobj-user' | Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
" " }}}

" " rust {{{
" Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" " }}}

