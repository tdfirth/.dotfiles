vim.opt_local.makeprg = "ruff check --output-format=concise ; ty check --output-format concise"
vim.opt_local.errorformat = "%f:%l:%c: %m"

vim.api.nvim_buf_create_user_command(0, "Fmt", "!ruff format %", {})

vim.api.nvim_buf_create_user_command(0, "Check", function()
  vim.cmd("lexpr system('ruff check --output-format=concise ' .. expand('%') .. ' ; ty check --output-format concise ' .. expand('%'))")
  vim.cmd("lopen")
end, {})

