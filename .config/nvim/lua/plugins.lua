require('Comment').setup()
require'nvim-treesitter.configs'.setup {
   ensure_installed = {"bash", "css", "html", "javascript", "jsonc", "lua", "python", "regex", "vim"},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        },
    indent = {
        enable = true
        }
}
  local cmp = require('cmp')
  cmp.setup {
    sources = {
      { name = 'nvim_lsp' },
      }
}
