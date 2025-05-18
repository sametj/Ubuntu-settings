-- In your LazyVim configuration (e.g., `plugins.lua`)

return {
  -- Catppuccin theme plugin
  {
    'catppuccin/nvim',
    name = 'catppuccin', -- Optional: name it for easier referencing
    priority = 1000, -- Optional: set the priority if you want it loaded early
    config = function()
      -- Theme setup configuration
      require('catppuccin').setup {
        flavour = 'mocha', -- Set your preferred flavour here (latte, frappe, macchiato, mocha)
        background = {
          light = 'mocha', -- Light theme background
          dark = 'mocha', -- Dark theme background
        },
        transparent_background = false, -- Set to true for transparent background
        show_end_of_buffer = false, -- Disables showing the '~' characters at the end of buffers
        term_colors = true, -- Enable terminal colors
        dim_inactive = {
          enabled = false, -- Disable dimming of inactive windows
          shade = 'dark',
          percentage = 0.15,
        },
        no_italic = false, -- Allow italic font
        no_bold = true, -- Allow bold font
        no_underline = false, -- Allow underline
        styles = {
          comments = { 'italic' }, -- Customize comment style (italic in this case)
          conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {}, -- Optional: override specific colors
        custom_highlights = {}, -- Optional: define custom highlight groups
        default_integrations = true, -- Enable all default integrations
        integrations = {
          cmp = true, -- Enable nvim-cmp integration
          gitsigns = true, -- Enable gitsigns integration
          nvimtree = true, -- Enable nvim-tree integration
          treesitter = true, -- Enable treesitter integration
          notify = false, -- Disable the notify integration
          mini = { enabled = true }, -- Enable mini.nvim integrations
        },
      }

      -- Set the colorscheme
      vim.cmd 'colorscheme catppuccin'
    end,
  },
}
