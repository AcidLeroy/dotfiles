vim.g.mapleader = ","

-- Insert date with F5
vim.keymap.set("n", "<F5>", '"=strftime("%c")<CR>P')
vim.keymap.set("t", '<ESC>', '<C-\\><C-n>')

vim.keymap.set("n", "<leader>w", ':ZenMode<CR>')

-- Make copy and paste work (only for mac osx) 
if vim.fn.has('macunix') then
  vim.keymap.set("v", "<C-c>", ":w !pbcopy<CR><;workCR>")
  --vim.keymap.set("n", "<C-v>", ":r !pbpaste<CR><CR>")
end


-- Close file but preserve layout
vim.keymap.set("n", "<leader>q", ":bp<bar>sp<bar>bn<bar>bd<CR>")
