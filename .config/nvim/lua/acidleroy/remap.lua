vim.g.mapleader = ","

-- Insert date with F5
vim.keymap.set("n", "<F5>", '"=strftime("%c")<CR>P')
vim.keymap.set("t", '<ESC>', '<C-\\><C-n>')

vim.keymap.set("n", "<C-n>", ':Lex<CR>')

