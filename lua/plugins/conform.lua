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
      lua = { 'stylua' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      yaml = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      markdown = { 'prettier' },
      markdown_inline = { 'prettier' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      zsh = { 'shfmt' },
      fish = { 'fish_indent' },
      python = { 'black' },
      go = { 'gofmt' },
      rust = { 'rustfmt' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      java = { 'google-java-format' },
      php = { 'php-cs-fixer' },
      ruby = { 'rubocop' },
      toml = { 'taplo' },
      sql = { 'sqlfluff' },
      xml = { 'xmlformat' },
      dockerfile = { 'dockfmt' },
      vue = { 'prettier' },
      svelte = { 'prettier' },
      tex = { 'latexindent' },
    },
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
  },
}

