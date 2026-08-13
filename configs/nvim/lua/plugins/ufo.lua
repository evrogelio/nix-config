return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "BufReadPost",
  -- CRITICAL: These settings must be set for UFO to take control
  init = function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  keys = {
    { "zR", function() require("ufo").openAllFolds() end,               desc = "Open all folds" },
    { "zM", function() require("ufo").closeAllFolds() end,              desc = "Close all folds" },
    { "zr", function() require("ufo").openFoldsExceptKinds() end,       desc = "Fold less" },
    { "zm", function() require("ufo").closeFoldsWith() end,             desc = "Fold more" },
    { "zp", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" },
  },
  opts = {
    provider_selector = function()
      -- Changed 'indent' to 'treesitter' to fix your "fold everything" issue
      return { "lsp", "indent" }
    end,
  },
}
