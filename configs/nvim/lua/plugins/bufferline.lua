return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
    { "<Tab>",      "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<S-Tab>",    "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<leader>bp", "<cmd>BufferLinePick<cr>",      desc = "Pick Buffer" },
    { "<leader>bd", "<cmd>bdelete<cr>",             desc = "Close Current Buffer" },
  },
  opts = {
    options = {
      mode = "buffers",
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      offsets = {
        {
          filetype = "NvimTree",
          text = function()
            local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return "󰉋 " .. dir_name
          end,
          text_align = "left",
          highlight = "Directory",
          separator = true,
        },
      },
    },
  },
}
