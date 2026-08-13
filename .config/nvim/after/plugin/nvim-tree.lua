-- Essential settings that must be set before any file operations
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- Set up lazy loading key mapping for nvim-tree
vim.keymap.set("n", "<C-n>", function()
  -- Load the plugin manually
  vim.cmd('packadd nvim-tree.lua')
  vim.cmd('packadd nvim-web-devicons')
  
  -- Setup nvim-tree
  require("nvim-tree").setup()
  
  -- Replace this mapping with the actual toggle function
  vim.keymap.set("n", "<C-n>", function()
    require("nvim-tree.api").tree.toggle()
  end, { desc = 'Toggle nvim-tree' })
  
  -- Call toggle for the first time
  require("nvim-tree.api").tree.toggle()
end, { desc = 'Load and toggle nvim-tree' })

