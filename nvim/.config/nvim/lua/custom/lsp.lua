require 'custom.templ'

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(event)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    --  To jump back, press <C-T>.
    map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    map('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

local capabilities = nil
if pcall(require, 'cmp_nvim_lsp') then
  capabilities = require('cmp_nvim_lsp').default_capabilities()
end

local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

local exlixir_ls_path = vim.fn.exepath 'elixir-ls'
local lexical_path = vim.fn.exepath 'lexical'

local lspconfig = require 'lspconfig'
local servers = {
  bashls = true,
  gopls = true,
  nil_ls = true,
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        workspace = {
          checkThirdParty = false,
          -- Tells lua_ls where to find all the Lua files that you have loaded
          -- for your neovim configuration.
          library = {
            '${3rd}/luv/library',
            unpack(vim.api.nvim_get_runtime_file('', true)),
          },
          -- If lua_ls is really slow on your computer, you can try this instead:
          -- library = { vim.env.VIMRUNTIME },
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        diagnostics = {
          globals = { 'vim' },
          -- disable = { 'missing-fields' },
        },
      },
    },
  },
  lexical = {
    cmd = { lexical_path },
    filetypes = { 'elixir', 'eelixir', 'heex' },
    settings = {},
    root_dir = require('lspconfig.util').root_pattern { 'mix.exs' },
  },
  elixirls = {
    cmd = { exlixir_ls_path },
    filetypes = { 'elixir', 'eelixir', 'heex' },
    -- need to figure out how to do this
    -- server_capabilities = {
    --   completion = false,
    --   documentFormattingProvider = false,
    -- },
    -- cmd = { '/var/home/jh/.local/share/nvim/mason/packages/elixir-ls/language_server.sh' },
  },
  rust_analyzer = true,
  -- svelte = true,
  -- templ = true,
  -- cssls = true,

  html = {
    filetypes = { 'html' },
  },
  -- Probably want to disable formatting for this lang server
  tsserver = true,
  marksman = {
    filetypes = { 'markdown' },
  },

  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },

  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = '',
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  },

  -- ocamllsp = {
  --   manual_install = true,
  --   settings = {
  --     codelens = { enable = true },
  --   },
  --
  --   filetypes = {
  --     'ocaml',
  --     'ocaml.interface',
  --     'ocaml.menhir',
  --     'ocaml.cram',
  --   },

  -- TODO: Check if i still need the filtypes stuff i had before
  -- },
}

local servers_to_install = vim.tbl_filter(function(key)
  local t = servers[key]
  if type(t) == 'table' then
    return not t.manual_install
  else
    return t
  end
end, vim.tbl_keys(servers))

-- local servers = {
--   bashls = true,
--   gopls = true,
--   rust_analyzer = true,
--   cssls = true,
--   jsonls = {
--     settings = {
--       json = {
--         schemas = require('schemastore').json.schemas(),
--         validate = { enable = true },
--       },
--     },
--   },
--   yamlls = {
--     settings = {
--       yaml = {
--         schemaStore = {
--           enable = false,
--           url = '',
--         },
--         schemas = require('schemastore').yaml.schemas(),
--       },
--     },
--   },
--   -- Some languages (like typescript) have entire language plugins that can be useful:
--   --    https://github.com/pmizio/typescript-tools.nvim
--   --
--   -- But for many setups, the LSP (`tsserver`) will work just fine
--   -- tsserver = {},
--   --
--   templ = {
--     filetypes = { 'templ' },
--   },
--
--   html = {
--     filetypes = { 'html' },
--   },
-- }
-- Register the language
vim.filetype.add {
  extension = {
    templ = 'templ',
  },
}

-- Make sure we have a tree-sitter grammar for the language
local treesitter_parser_config = require('nvim-treesitter.parsers').get_parser_configs()
treesitter_parser_config.templ = treesitter_parser_config.templ
  or {
    install_info = {
      url = 'https://github.com/vrischmann/tree-sitter-templ.git',
      files = { 'src/parser.c', 'src/scanner.c' },
      branch = 'master',
    },
  }

vim.treesitter.language.register('templ', 'templ')

-- Register the LSP as a config
local configs = require 'lspconfig.configs'
if not configs.templ then
  configs.templ = {
    default_config = {
      cmd = { 'templ', 'lsp' },
      filetypes = { 'templ' },
      root_dir = require('lspconfig.util').root_pattern('go.mod', '.git'),
      settings = {},
    },
  }
end
-- Ensure the servers and tools above are installed
--  To check the current status of installed tools and/or manually install
--  other tools, you can run
--    :Mason
--
--  You can press `g?` for help in this menu
require('mason').setup()
local ensure_installed = {
  'stylua',
  'lua_ls',
  'delve',
  'gopls',
  'goimports',
  'markdownlint-cli2',
  'markdown-toc',
  -- "tailwind-language-server",
}

vim.list_extend(ensure_installed, servers_to_install)

-- You can add other tools here that you want Mason to install
-- for you, so that they are available from within Neovim.
-- local ensure_installed = vim.tbl_keys(servers or {})
-- vim.list_extend(ensure_installed, {
--   'stylua', -- Used to format lua code
--   'gopls',
--   'goimports',
--   'htmx-lsp',
--   'templ',
-- })
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config = vim.tbl_deep_extend('force', {}, {
    capabilities = capabilities,
  }, config)

  lspconfig[name].setup(config)
end
-- require('mason-lspconfig').setup {
--   handlers = {
--     function(server_name)
--       local server = servers[server_name] or {}
--       require('lspconfig')[server_name].setup {
--         cmd = server.cmd,
--         settings = server.settings,
--         filetypes = server.filetypes,
--         -- This handles overriding only values explicitly passed
--         -- by the server configuration above. Useful when disabling
--         -- certain features of an LSP (for example, turning off formatting for tsserver)
--         capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {}),
--       }
--     end,
--   },
-- }
