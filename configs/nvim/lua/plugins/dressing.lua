return {
  "stevearc/dressing.nvim",
  lazy = false,
  opts = {
    input = {
      enabled = true,
      border = "rounded",
    },
    select = {
      enabled = true,
      backend = { "telescope", "builtin" },
      builtin = {
        border = "rounded",
      },
    },
  },
}
