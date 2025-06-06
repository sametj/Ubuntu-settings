return {
  'mason-org/mason.nvim',
  cmd = 'Mason',
  keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
  build = ':MasonUpdate',
  opts_extend = { 'ensure_installed' },
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed
      or {
        'stylua',
        'shfmt',

        -- Docker tooling
        'dockerfile-language-server',

        -- Web tooling (common)
        'eslint_d',
        'prettierd',

        -- Python tooling
        'pyright',
        'black',
        'isort',
        'pylint',

        -- Add your js-debug adapter too
        'js-debug-adapter',
      }
    return opts
  end,
  config = function(_, opts)
    require('mason').setup(opts)
    local mr = require 'mason-registry'
    mr:on('package:install:success', function()
      vim.defer_fn(function()
        require('lazy.core.handler.event').trigger {
          event = 'FileType',
          buf = vim.api.nvim_get_current_buf(),
        }
      end, 100)
    end)

    mr.refresh(function()
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)
  end,
}
