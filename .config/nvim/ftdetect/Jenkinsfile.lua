local setFiletype = function() vim.opt.filetype="groovy" end

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.Jenkinsfile", "*.jenkinsfile"},
    callback = setFiletype,
  })
