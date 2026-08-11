return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    filters = {
      dotfiles = false,
    },
    disable_netrw = true,
    hijack_netrw = true,
    view = {
      width = 30,
      relativenumber = true,
    },
    renderer = {
      group_empty = true,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
  },
}
