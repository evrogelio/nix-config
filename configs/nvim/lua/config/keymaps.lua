local keymap = vim.keymap.set

-- Clear search highlights on ESC
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")
keymap("n", "<C>s", "<cmd>:w<CR>")
