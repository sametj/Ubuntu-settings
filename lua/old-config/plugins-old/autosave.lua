return {
  'Pocco81/auto-save.nvim',
  event = { 'InsertLeave', 'TextChanged' },
  config = function()
    require('auto-save').setup {
      enabled = true,
      execution_message = {
        message = function()
          return 'Autosaved at ' .. vim.fn.strftime '%H:%M:%S'
        end,
        dim = 0.18,
      },
      debounce_delay = 135,
    }
  end,
}
