return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Install parsers for common languages you use
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "nix",
        "json",
        "markdown",
        "python",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
