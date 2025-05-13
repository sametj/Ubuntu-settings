require 'core.options'
require 'core.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  --require 'plugins.neotree',
  require 'plugins.gitsigns',
  require 'plugins.telescope',
  require 'plugins.indent-blankline',
  require 'plugins.autocompletion',
  require 'plugins.lsp',
  require 'plugins.bufferline',
  require 'plugins.colortheme',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.none-ls',
  require 'plugins.snacks',
  require 'plugins.misc',
  require 'plugins.vim-tmux-navigator',
  require 'plugins.noice',
  --require 'plugins.autosave',
}
