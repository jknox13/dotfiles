vim.api.nvim_create_autocmd("User", {
  pattern = "GoyoEnter",
  command = "Limelight",
})

vim.api.nvim_create_autocmd("User", {
  pattern = "GoyoLeave",
  command = "Limelight!",
})
