return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true,
    })

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp_ok, cmp = pcall(require, "cmp")
    if cmp_ok then
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}
