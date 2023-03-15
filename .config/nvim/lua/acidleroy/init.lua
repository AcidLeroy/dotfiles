print("This is AcidLeroy directory")
require("acidleroy.set")
require("acidleroy.remap")
require("acidleroy.packer")

local augroup = vim.api.nvim_create_augroup
local AcidLeroyGroup = augroup('AcidLeroy',{})

local autocmd = vim.api.nvim_create_autocmd

local fmt = function() vim.lsp.buf.format({ async = false }) end

-- Automatically format go files on save
 autocmd({"BufWritePre"}, {
   group = AcidLeroyGroup,
   pattern = {"*.go"},
   callback = fmt
 })

