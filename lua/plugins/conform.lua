return {
  'stevearc/conform.nvim',
  dependencies = { 'mason.nvim' },
  lazy = true,
  cmd = 'ConformInfo',
  keys = {
    {
      '<leader>cF',
      function()
        require('conform').format { formatters = { 'injected' }, timeout_ms = 3000 }
      end,
      mode = { 'n', 'v' },
      desc = 'Format Injected Langs',
    },
  },
  init = function()
    LazyVim.on_very_lazy(function()
      LazyVim.format.register {
        name = 'conform.nvim',
        priority = 100,
        primary = true,
        format = function(buf)
          require('conform').format { bufnr = buf }
        end,
        sources = function(buf)
          local ret = require('conform').list_formatters(buf)
          return vim.tbl_map(function(v)
            return v.name
          end, ret)
        end,
      }
    end)
  end,
  opts = {
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      cs = { 'csharpier' },
      lua = { 'stylua' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      markdown = { 'prettier' },
      sh = { 'shfmt' },
      python = { 'black' },
      go = { 'gofmt' },
      rust = { 'rustfmt' },
      toml = { 'taplo' },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
  },
}
