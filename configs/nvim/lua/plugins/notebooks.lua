return {
  {
    "GCBallesteros/jupytext.nvim",
    config = true,
    opts = {
      style = "hyptext",
      output_format = "py:percent",
      force_ft = "python",
    },
  },

  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_auto_open_output = false
      vim.g.molten_output_virt_lines = true
      vim.g.molten_wrap_output = true
    end,
    keys = {
      { "<leader>mi",  ":MoltenInit<CR>",             desc = "Initialize Molten Kernel" },
      { "<leader>me",  ":MoltenEvaluateOperator<CR>", desc = "Evaluate Operator" },
      { "<leader>mE",  ":MoltenEvaluateLine<CR>",     desc = "Evaluate Line" },
      { "<leader>mr",  ":MoltenReevaluateCell<CR>",   desc = "Re-evaluate Cell" },
      { "<leader>mc",  ":MoltenEvaluateCell<CR>",     desc = "Evaluate Cell" },
      { "<leader>mvh", ":MoltenHideOutput<CR>",       desc = "Hide Output" },
      { "<leader>mso", ":MoltenShowOutput<CR>",       desc = "Show Output" },
    },
  },
}
