" line numbers
set number

" disable arrow keys --{{{
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>
" }}}

" tab settings
set expandtab
set shiftwidth=2
set softtabstop=2

syntax enable

" search highlighting --{{{
set hlsearch
highlight Search cterm=NONE ctermfg=black ctermbg=blue
" }}}

" vim-plug --{{{
call plug#begin('~/.vim/plugged')
" sensible defaults we can all agree on
Plug 'tpope/vim-sensible'

" Git wrapper
Plug 'tpope/vim-fugitive'

" status bar
" Plug 'bling/vim-airline'
Plug 'itchyny/lightline.vim'

" auto-close parentheses
Plug 'vim-scripts/AutoClose'

" base16 colors
Plug 'chriskempson/base16-vim'

" Gist
Plug 'vim-scripts/Gist.vim'

" allows relative numbering in normal, absolute in insert 
Plug 'myusuf3/numbers.vim'

" comments
Plug 'tpope/vim-commentary'

" file tree browser
Plug 'scrooloose/nerdtree'
call plug#end()
" }}}

"" Show the 80th column
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif


" eof character
set list
set listchars=eol:¬,extends:…,precedes:…,tab:\ \


" minimal number of screen lines to keep below and above the cursor
set scrolloff=3
" set cursorline

" creates undofile, allows undo even after closing
set undofile

set background=dark
" colorscheme base16-ocean
" let base16colorspace=256

" Vimscript file settings --------------------{{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
" base16-ocean color settings (with a few tweaks) --{{{
" GUI color definitions
let s:gui00 = "2b303b"
let s:gui01 = "343d46"
let s:gui02 = "4f5b66"
let s:gui03 = "65737e"
let s:gui04 = "a7adba"
let s:gui05 = "c0c5ce"
let s:gui06 = "dfe1e8"
let s:gui07 = "eff1f5"
let s:gui08 = "bf616a"
let s:gui09 = "d08770"
let s:gui0A = "ebcb8b"
let s:gui0B = "a3be8c"
let s:gui0C = "96b5b4"
let s:gui0D = "8fa1b3"
let s:gui0E = "b48ead"
let s:gui0F = "ab7967"
" terminal color definitions
let s:cterm00 = "00"
let s:cterm03 = "08"
let s:cterm05 = "07"
let s:cterm07 = "15"
let s:cterm08 = "01"
let s:cterm0A = "03"
let s:cterm0B = "02"
let s:cterm0C = "06"
let s:cterm0D = "04"
let s:cterm0E = "05"

if exists('base16colorspace') && base16colorspace == "256"
  let s:cterm01 = "18"
  let s:cterm02 = "19"
  let s:cterm04 = "20"
  let s:cterm06 = "21"
  let s:cterm09 = "16"
  let s:cterm0F = "17"
else
  let s:cterm01 = "10"
  let s:cterm02 = "11"
  let s:cterm04 = "12"
  let s:cterm06 = "13"
  let s:cterm09 = "09"
  let s:cterm0F = "14"
endif

" Theme setup
hi clear
syntax reset
let g:colors_name = "base16-ocean"

" Highlighting function
fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=#" . s:gui(a:guifg)
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=#" . s:gui(a:guibg)
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . s:cterm(a:ctermfg)
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . s:cterm(a:ctermbg)
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun

" Return GUI color for light/dark variants
fun s:gui(color)
  if &background == "dark"
    return a:color
  endif

  if a:color == s:gui00
    return s:gui07
  elseif a:color == s:gui01
    return s:gui06
  elseif a:color == s:gui02
    return s:gui05
  elseif a:color == s:gui03
    return s:gui04
  elseif a:color == s:gui04
    return s:gui03
  elseif a:color == s:gui05
    return s:gui02
  elseif a:color == s:gui06
    return s:gui01
  elseif a:color == s:gui07
    return s:gui00
  endif

  return a:color
endfun

" Return terminal color for light/dark variants
fun s:cterm(color)
  if &background == "dark"
    return a:color
  endif

  if a:color == s:cterm00
    return s:cterm07
  elseif a:color == s:cterm01
    return s:cterm06
  elseif a:color == s:cterm02
    return s:cterm05
  elseif a:color == s:cterm03
    return s:cterm04
  elseif a:color == s:cterm04
    return s:cterm03
  elseif a:color == s:cterm05
    return s:cterm02
  elseif a:color == s:cterm06
    return s:cterm01
  elseif a:color == s:cterm07
    return s:cterm00
  endif

  return a:color
endfun

" Vim editor colors
call <sid>hi("Bold",          "", "", "", "", "bold")
call <sid>hi("Debug",         s:gui08, "", s:cterm08, "", "")
call <sid>hi("Directory",     s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("ErrorMsg",      s:gui08, s:gui00, s:cterm08, s:cterm00, "")
call <sid>hi("Exception",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("FoldColumn",    "", s:gui01, "", s:cterm01, "")
call <sid>hi("Folded",        s:gui03, s:gui01, s:cterm07, s:cterm03, "")
call <sid>hi("IncSearch",     s:gui01, s:gui09, s:cterm01, s:cterm09, "none")
call <sid>hi("Italic",        "", "", "", "", "none")
call <sid>hi("Macro",         s:gui08, "", s:cterm08, "", "")
call <sid>hi("MatchParen",    s:gui00, s:gui03, s:cterm00, s:cterm03,  "")
call <sid>hi("ModeMsg",       s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("MoreMsg",       s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("Question",      s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("Search",        s:gui03, s:gui0A, s:cterm03, s:cterm0A,  "")
call <sid>hi("SpecialKey",    s:gui03, "", s:cterm03, "", "")
call <sid>hi("TooLong",       s:gui08, "", s:cterm08, "", "")
call <sid>hi("Underlined",    s:gui08, "", s:cterm08, "", "")
call <sid>hi("Visual",        "", s:gui02, "", s:cterm02, "")
call <sid>hi("VisualNOS",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("WarningMsg",    s:gui08, "", s:cterm08, "", "")
call <sid>hi("WildMenu",      s:gui08, "", s:cterm08, "", "")
call <sid>hi("Title",         s:gui0D, "", s:cterm0D, "", "none")
call <sid>hi("Conceal",       s:gui0D, s:gui00, s:cterm0D, s:cterm00, "")
call <sid>hi("Cursor",        s:gui00, s:gui05, s:cterm00, s:cterm05, "")
call <sid>hi("NonText",       s:gui03, "", s:cterm03, "", "")
call <sid>hi("Normal",        s:gui05, s:gui00, s:cterm05, s:cterm00, "")
call <sid>hi("LineNr",        s:gui03, s:gui01, s:cterm07, s:cterm00, "")
call <sid>hi("SignColumn",    s:gui03, s:gui01, s:cterm03, s:cterm01, "")
call <sid>hi("SpecialKey",    s:gui03, "", s:cterm03, "", "")
call <sid>hi("StatusLine",    s:gui04, s:gui02, s:cterm04, s:cterm02, "none")
call <sid>hi("StatusLineNC",  s:gui03, s:gui01, s:cterm03, s:cterm01, "none")
call <sid>hi("VertSplit",     s:gui02, s:gui02, s:cterm02, s:cterm02, "none")
call <sid>hi("ColorColumn",   "", s:gui01, "", s:cterm01, "none")
call <sid>hi("CursorColumn",  "", s:gui01, "", s:cterm01, "none")
call <sid>hi("CursorLine",    "", s:gui01, "", s:cterm01, "none")
call <sid>hi("CursorLineNr",  s:gui03, s:gui01, s:cterm07, s:cterm00, "")
call <sid>hi("PMenu",         s:gui04, s:gui01, s:cterm04, s:cterm01, "none")
call <sid>hi("PMenuSel",      s:gui01, s:gui04, s:cterm01, s:cterm04, "")
call <sid>hi("TabLine",       s:gui03, s:gui01, s:cterm03, s:cterm01, "none")
call <sid>hi("TabLineFill",   s:gui03, s:gui01, s:cterm03, s:cterm01, "none")
call <sid>hi("TabLineSel",    s:gui0B, s:gui01, s:cterm0B, s:cterm01, "none")

" Standard syntax highlighting
call <sid>hi("Boolean",      s:gui09, "", s:cterm09, "", "")
call <sid>hi("Character",    s:gui08, "", s:cterm08, "", "")
call <sid>hi("Comment",      s:gui03, "", s:cterm03, "", "")
call <sid>hi("Conditional",  s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("Constant",     s:gui09, "", s:cterm09, "", "")
call <sid>hi("Define",       s:gui0E, "", s:cterm0E, "", "none")
call <sid>hi("Delimiter",    s:gui0F, "", s:cterm0F, "", "")
call <sid>hi("Float",        s:gui09, "", s:cterm09, "", "")
call <sid>hi("Function",     s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("Identifier",   s:gui08, "", s:cterm08, "", "none")
call <sid>hi("Include",      s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("Keyword",      s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("Label",        s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("Number",       s:gui09, "", s:cterm09, "", "")
call <sid>hi("Operator",     s:gui05, "", s:cterm05, "", "none")
call <sid>hi("PreProc",      s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("Repeat",       s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("Special",      s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("SpecialChar",  s:gui0F, "", s:cterm0F, "", "")
call <sid>hi("Statement",    s:gui08, "", s:cterm08, "", "")
call <sid>hi("StorageClass", s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("String",       s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("Structure",    s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("Tag",          s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("Todo",         s:gui0A, s:gui01, s:cterm0A, s:cterm01, "")
call <sid>hi("Type",         s:gui0A, "", s:cterm0A, "", "none")
call <sid>hi("Typedef",      s:gui0A, "", s:cterm0A, "", "")

" C highlighting
call <sid>hi("cOperator",   s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("cPreCondit",  s:gui0E, "", s:cterm0E, "", "")

" CSS highlighting
call <sid>hi("cssBraces",      s:gui05, "", s:cterm05, "", "")
call <sid>hi("cssClassName",   s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("cssColor",       s:gui0C, "", s:cterm0C, "", "")

" Diff highlighting
call <sid>hi("DiffAdd",      s:gui0B, s:gui01,  s:cterm0B, s:cterm01, "")
call <sid>hi("DiffChange",   s:gui03, s:gui01,  s:cterm03, s:cterm01, "")
call <sid>hi("DiffDelete",   s:gui08, s:gui01,  s:cterm08, s:cterm01, "")
call <sid>hi("DiffText",     s:gui0D, s:gui01,  s:cterm0D, s:cterm01, "")
call <sid>hi("DiffAdded",    s:gui0B, s:gui00,  s:cterm0B, s:cterm00, "")
call <sid>hi("DiffFile",     s:gui08, s:gui00,  s:cterm08, s:cterm00, "")
call <sid>hi("DiffNewFile",  s:gui0B, s:gui00,  s:cterm0B, s:cterm00, "")
call <sid>hi("DiffLine",     s:gui0D, s:gui00,  s:cterm0D, s:cterm00, "")
call <sid>hi("DiffRemoved",  s:gui08, s:gui00,  s:cterm08, s:cterm00, "")

" Git highlighting
call <sid>hi("gitCommitOverflow",  s:gui08, "", s:cterm08, "", "")
call <sid>hi("gitCommitSummary",   s:gui0B, "", s:cterm0B, "", "")
  
" GitGutter highlighting
call <sid>hi("GitGutterAdd",     s:gui0B, s:gui01, s:cterm0B, s:cterm01, "")
call <sid>hi("GitGutterChange",  s:gui0D, s:gui01, s:cterm0D, s:cterm01, "")
call <sid>hi("GitGutterDelete",  s:gui08, s:gui01, s:cterm08, s:cterm01, "")
call <sid>hi("GitGutterChangeDelete",  s:gui0E, s:gui01, s:cterm0E, s:cterm01, "")

" HTML highlighting
call <sid>hi("htmlBold",    s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("htmlItalic",  s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("htmlEndTag",  s:gui05, "", s:cterm05, "", "")
call <sid>hi("htmlTag",     s:gui05, "", s:cterm05, "", "")

" JavaScript highlighting
call <sid>hi("javaScript",        s:gui05, "", s:cterm05, "", "")
call <sid>hi("javaScriptBraces",  s:gui05, "", s:cterm05, "", "")
call <sid>hi("javaScriptNumber",  s:gui09, "", s:cterm09, "", "")

" Markdown highlighting
call <sid>hi("markdownCode",              s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("markdownError",             s:gui05, s:gui00, s:cterm05, s:cterm00, "")
call <sid>hi("markdownCodeBlock",         s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("markdownHeadingDelimiter",  s:gui0D, "", s:cterm0D, "", "")

" NERDTree highlighting
call <sid>hi("NERDTreeDirSlash",  s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("NERDTreeExecFile",  s:gui05, "", s:cterm05, "", "")

" PHP highlighting
call <sid>hi("phpMemberSelector",  s:gui05, "", s:cterm05, "", "")
call <sid>hi("phpComparison",      s:gui05, "", s:cterm05, "", "")
call <sid>hi("phpParent",          s:gui05, "", s:cterm05, "", "")

" Python highlighting
call <sid>hi("pythonOperator",  s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("pythonRepeat",    s:gui0E, "", s:cterm0E, "", "")

" Ruby highlighting
call <sid>hi("rubyAttribute",               s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("rubyConstant",                s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("rubyInterpolation",           s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("rubyInterpolationDelimiter",  s:gui0F, "", s:cterm0F, "", "")
call <sid>hi("rubyRegexp",                  s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("rubySymbol",                  s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("rubyStringDelimiter",         s:gui0B, "", s:cterm0B, "", "")

" SASS highlighting
call <sid>hi("sassidChar",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("sassClassChar",  s:gui09, "", s:cterm09, "", "")
call <sid>hi("sassInclude",    s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("sassMixing",     s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("sassMixinName",  s:gui0D, "", s:cterm0D, "", "")

" Signify highlighting
call <sid>hi("SignifySignAdd",     s:gui0B, s:gui01, s:cterm0B, s:cterm01, "")
call <sid>hi("SignifySignChange",  s:gui0D, s:gui01, s:cterm0D, s:cterm01, "")
call <sid>hi("SignifySignDelete",  s:gui08, s:gui01, s:cterm08, s:cterm01, "")

" Spelling highlighting
call <sid>hi("SpellBad",     "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellLocal",   "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellCap",     "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellRare",    "", s:gui00, "", s:cterm00, "undercurl")

" Remove functions
delf <sid>hi
delf <sid>gui
delf <sid>cterm

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F
" }}}
