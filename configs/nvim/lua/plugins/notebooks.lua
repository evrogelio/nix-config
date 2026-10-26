return {
  {
    "GCBallesteros/jupytext.nvim",
    config = true,
    opts = {
      style = "percent",
      output_format = "py:percent",
      force_ft = "python",
    },
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.python3_host_prog = vim.fn.exepath("python3")

      vim.g.molten_auto_open_output = true
      vim.g.molten_split_direction = "right"
      vim.g.molten_split_size = 40
      vim.g.molten_use_floating_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = false
    end,
    keys = {
      { "<leader>mi",  ":MoltenInit<CR>",             desc = "Initialize Molten Kernel" },
      { "<leader>me",  ":MoltenEvaluateOperator<CR>", desc = "Evaluate Operator" },
      { "<leader>mE",  ":MoltenEvaluateLine<CR>",     desc = "Evaluate Line" },
      { "<leader>mr",  ":MoltenReevaluateCell<CR>",   desc = "Re-evaluate Cell" },
      { "<leader>mvh", ":MoltenHideOutput<CR>",       desc = "Hide Output Split" },
      { "<leader>mso", ":MoltenShowOutput<CR>",       desc = "Show Output Split" },
    },
  },
  {
    "GCBallesteros/NotebookNavigator.nvim",
    dependencies = {
      "benlubas/molten-nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    opts = {
      cell_markers = {
        python = "# %%",
      },
    },
    config = function(_, opts)
      local nn = require("notebook-navigator")
      nn.setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(event)
          local opts_buf = { buffer = event.buf, remap = false }

          -- Override cell navigation
          vim.keymap.set("n", "]]", function() nn.move_cell("d") end,
            vim.tbl_extend("force", opts_buf, { desc = "Next Notebook Cell" }))
          vim.keymap.set("n", "[[", function() nn.move_cell("u") end,
            vim.tbl_extend("force", opts_buf, { desc = "Prev Notebook Cell" }))
          vim.keymap.set("n", "<leader>mc", function() nn.run_cell() end,
            vim.tbl_extend("force", opts_buf, { desc = "Run Notebook Cell" }))

          -- Clean up Which-Key descriptions for single bracket presses
          vim.keymap.set("n", "]", "<Nop>", vim.tbl_extend("force", opts_buf, { desc = "Next..." }))
          vim.keymap.set("n", "[", "<Nop>", vim.tbl_extend("force", opts_buf, { desc = "Prev..." }))
        end,
      })
    end,
  }
}
