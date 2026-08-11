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
      number = false,
      relativenumber = false,
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
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    -- Auto-open nvim-tree when launching Neovim in a directory
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function(data)
        local is_directory = vim.fn.isdirectory(data.file) == 1

        if is_directory then
          vim.cmd.cd(data.file)
          require("nvim-tree.api").tree.open()
        end
      end,
    })
  end,
}
