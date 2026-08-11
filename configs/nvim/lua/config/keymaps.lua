local keymap = vim.keymap.set

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")
keymap("n", "<C-s>", "<cmd>:w<CR>")

keymap("n", ";", ":", { desc = "CMD enter command mode" })

keymap("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap("n", "<leader>gg", "<cmd> LazyGit <CR>", { desc = "Open LazyGit" })
