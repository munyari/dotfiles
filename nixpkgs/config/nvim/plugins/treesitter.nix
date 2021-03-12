''
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained', -- ensure all maintained parsers are installed
  highlight = {enable = true}
}
EOF
''
# vim:ft=lua
