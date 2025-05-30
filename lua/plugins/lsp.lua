return {
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  opts = {
    servers = {
      sqls = {},
      tsserver = { enabled = false },
      ts_ls = { enabled = false },
      vtsls = {
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              maxInlayHintLength = 30,
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = 'always' },
            suggest = { completeFunctionCalls = true },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = 'literals' },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
        keys = {
          {
            'gD',
            function()
              local params = vim.lsp.util.make_position_params(0, 'utf-32')
              LazyVim.lsp.execute {
                command = 'typescript.goToSourceDefinition',
                arguments = { params.textDocument.uri, params.position },
                open = true,
              }
            end,
            desc = 'Goto Source Definition',
          },
          {
            'gR',
            function()
              LazyVim.lsp.execute {
                command = 'typescript.findAllFileReferences',
                arguments = { vim.uri_from_bufnr(0) },
                open = true,
              }
            end,
            desc = 'File References',
          },
          { '<leader>co', LazyVim.lsp.action['source.organizeImports'], desc = 'Organize Imports' },
          { '<leader>cM', LazyVim.lsp.action['source.addMissingImports.ts'], desc = 'Add missing imports' },
          { '<leader>cu', LazyVim.lsp.action['source.removeUnused.ts'], desc = 'Remove unused imports' },
          { '<leader>cD', LazyVim.lsp.action['source.fixAll.ts'], desc = 'Fix all diagnostics' },
          {
            '<leader>cV',
            function()
              LazyVim.lsp.execute { command = 'typescript.selectTypeScriptVersion' }
            end,
            desc = 'Select TS workspace version',
          },
        },
      },
    },
    setup = {
      tsserver = function()
        return true -- disables tsserver setup
      end,
      ts_ls = function()
        return true -- disables ts_ls setup
      end,
    },
  },
}
