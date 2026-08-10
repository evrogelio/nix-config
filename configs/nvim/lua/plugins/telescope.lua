return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find String (Grep)" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Open Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help Tags" },
  },
}
