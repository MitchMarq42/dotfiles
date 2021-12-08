local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system(
        {'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}
    )
end

vim.api.nvim_set_keymap(
    'n', ':',
    '<cmd>lua require("fine-cmdline").open()<CR>',
    {noremap = true}
)
vim.api.nvim_set_keymap(
    'n', '/',
    '<cmd>lua require("searchbox").incsearch()<CR>',
    {noremap = true}
)

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'          -- This plugin
  use 'equalsraf/neovim-gui-shim'       -- Boilerplate for nvim-qt
  use 'mattn/emmet-vim'                 -- Magic HTML IDE thingy
  use 'tpope/vim-commentary'            -- comment with gcc
  use 'tpope/vim-surround'              -- add surroundings with cs
  use 'tpope/vim-repeat'                -- boring re-repeat repeater .
  use 'Xuyuanp/scrollbar.nvim'          -- Actually good scrollbar
  use 'vim-airline/vim-airline'         -- sorta epic statusline
  use 'vim-airline/vim-airline-themes'  -- themes for above
  use 'pprovost/vim-ps1'                -- PowerShell highlighting etc
  use 'hrsh7th/cmp-nvim-lsp'               -- These four
  use 'hrsh7th/cmp-buffer'                 -- probably do
  use 'hrsh7th/nvim-cmp'                   -- something, but I'm
  use 'nvim-lua/completion-nvim'           -- not sure what
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
  use { 'VonHeikemen/fine-cmdline.nvim', requires = { {'MunifTanjim/nui.nvim'} } }
  use { 'VonHeikemen/searchbox.nvim', requires = { {'MunifTanjim/nui.nvim'} } }
  use { 'rrethy/vim-hexokinase', run = 'make hexokinase' }

require('fine-cmdline').setup({
  cmdline = {
    enable_keymaps = true,
    smart_history = true
  },
  popup = {
    position = {
      row = '12%',
      col = '50%', },
    size = { width = '30%' },
    border = {
      style = 'rounded',
      highlight = 'FloatBorder', },
  },
})
require'nvim-treesitter.configs'.setup {
   ensure_installed = {
       "bash",
       "css",
       "html",
       "javascript",
       "jsonc",
       "lua",
       "python",
       "regex",
       "vim"
   },
   sync_install = true,
   highlight = {
       enable = true,
       additional_vim_regex_highlighting = false,
       },
   indent = { enable = true }
}
   vim.cmd [[:silent! TSEnableAll regex]]
  local cmp = require('cmp')
  cmp.setup { sources = { { name = 'nvim_lsp' }, } }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
