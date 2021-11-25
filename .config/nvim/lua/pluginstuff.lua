local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.api.nvim_set_keymap( 'n', ':', '<cmd>lua require("fine-cmdline").open()<CR>', {noremap = true})
vim.api.nvim_set_keymap( 'n', '/', '<cmd>lua require("searchbox").incsearch()<CR>', {noremap = true})

return require('packer').startup(function(use)
  -- Plugins go here:
  use 'wbthomason/packer.nvim'          -- This plugin
  use 'mattn/emmet-vim'                 -- Magic HTML IDE thingy
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

  if packer_bootstrap then
    require('packer').sync()
  end
end)
