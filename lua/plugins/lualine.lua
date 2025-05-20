return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = ' '
    else
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- Optional: only require if lazyvim loaded or fallback gracefully
    local icons = (rawget(_G, 'LazyVim') and LazyVim.config.icons)
      or {
        diagnostics = { Error = 'E', Warn = 'W', Info = 'I', Hint = 'H' },
        git = { added = '+', modified = '~', removed = '-' },
      }

    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        theme = 'auto',
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          LazyVim.lualine.root_dir(),
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
          (rawget(_G, 'Snacks') and Snacks.profiler.status()) or '',
          {
            function()
              return package.loaded['noice'] and require('noice').api.status.command.get() or ''
            end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.command.has()
            end,
            color = function()
              return (rawget(_G, 'Snacks') and Snacks.util.color 'Statement') and { fg = Snacks.util.color 'Statement' } or {}
            end,
          },
          {
            function()
              return package.loaded['noice'] and require('noice').api.status.mode.get() or ''
            end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.mode.has()
            end,
            color = function()
              return (rawget(_G, 'Snacks') and Snacks.util.color 'Constant') and { fg = Snacks.util.color 'Constant' } or {}
            end,
          },
          {
            function()
              return package.loaded['dap'] and ('  ' .. require('dap').status()) or ''
            end,
            cond = function()
              return package.loaded['dap'] and require('dap').status() ~= ''
            end,
            color = function()
              return (rawget(_G, 'Snacks') and Snacks.util.color 'Debug') and { fg = Snacks.util.color 'Debug' } or {}
            end,
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = function()
              return (rawget(_G, 'Snacks') and Snacks.util.color 'Special') and { fg = Snacks.util.color 'Special' } or {}
            end,
          },
          {
            'diff',
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
          { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return ' ' .. os.date '%R'
          end,
        },
      },
      extensions = { 'neo-tree', 'lazy', 'fzf' },
    }

    if vim.g.trouble_lualine and LazyVim.has 'trouble.nvim' then
      local trouble = require 'trouble'
      local symbols = trouble.statusline {
        mode = 'symbols',
        groups = {},
        title = false,
        filter = { range = true },
        format = '{kind_icon}{symbol.name:Normal}',
        hl_group = 'lualine_c_normal',
      }
      if symbols and symbols.get then
        table.insert(opts.sections.lualine_c, {
          symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end
    end

    return opts
  end,
}
