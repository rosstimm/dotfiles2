return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          bacon_ls = {
            enabled = diagnostics == "bacon-ls",
          },
          rust_analyzer = { enabled = true },
        },
      },
    },
    { -- optional cmp completion source for require statements and module annotations
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = "lazydev",
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    }
  },
  enable = true,
  config = function()
    require("lspconfig").lua_ls.setup {}

    vim.diagnostic.config({ virtual_text = true })
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if not client then return end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if client:supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
            end,
          })
        end
      end,
    })
  end
}
