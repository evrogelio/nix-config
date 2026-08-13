return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    preset = "classic",
    win = {
      border = "rounded",
    },
    spec = {
      { "<leader>c", group = "code" },
      { "<leader>f", group = "file/find" },
      { "<leader>r", group = "refactor/rename" },
      { "<leader>p", group = "print/debug" },
    },
  },
}
