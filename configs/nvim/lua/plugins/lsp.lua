return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(event)
        local opts = { buffer = event.buf }
        local keymap = vim.keymap.set

        keymap("n", "gD", vim.lsp.buf.declaration, opts)
        keymap("n", "gd", vim.lsp.buf.definition, opts)
        keymap("n", "K", vim.lsp.buf.hover, opts)
        keymap("n", "gi", vim.lsp.buf.implementation, opts)
        keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        keymap("n", "gr", vim.lsp.buf.references, opts)

        keymap("v", "<leader>re", function()
          vim.lsp.buf.code_action({
            filter = function(a) return a.title:lower():match("extract") or a.title:lower():match("function") end,
            apply = true,
          })
        end, vim.tbl_extend("force", opts, { desc = "Extract Function (LSP)" }))

        keymap("v", "<leader>rv", function()
          vim.lsp.buf.code_action({
            filter = function(a)
              return a.title:lower():match("extract") or a.title:lower():match("variable") or
                  a.title:lower():match("constant")
            end,
            apply = true,
          })
        end, vim.tbl_extend("force", opts, { desc = "Extract Variable (LSP)" }))

        keymap("v", "<leader>rf", function()
          vim.lsp.buf.code_action({
            filter = function(a) return a.title:lower():match("move") or a.title:lower():match("file") end,
            apply = true,
          })
        end, vim.tbl_extend("force", opts, { desc = "Move to File (LSP)" }))

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = event.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
            end,
          })
        end
      end,
    })

    local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = true,
      },
    })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
      end,
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local servers = {
      html = {
        filetypes = { "html", "eruby" },
        init_options = { provideFormatter = true },
      },
      ts_ls = {},
      svelte = {
        settings = {
          svelte = {
            plugin = {
              svelte = {
                compilerWarnings = { ["missing-declaration"] = "ignore" },
                format = { enable = true },
              },
            },
          },
        },
      },
      tailwindcss = {
        filetypes = { "html", "svelte", "javascript", "typescript", "react", "css" },
        init_options = { userLanguages = { svelte = "html" } },
      },
      ruby_lsp = {
        filetypes = { "ruby" },
      },
      emmet_ls = {
        filetypes = { "html", "css", "sass", "scss", "javascriptreact", "typescriptreact", "svelte", "eruby" },
      },
      cssls = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      },
    }

    for server_name, config in pairs(servers) do
      config.capabilities = capabilities

      vim.lsp.config(server_name, config)

      vim.lsp.enable(server_name)
    end
  end,
}
