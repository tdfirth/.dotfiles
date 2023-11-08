vim.g["conjure#mapping#doc_word"] = false
vim.g["conjure#log#hud#border"] = "rounded"
vim.g["conjure#eval#inline_results"] = false

-- Disable LSP diagnostics in the HUD.
vim.api.nvim_create_autocmd("BufNewFile", {
  group = vim.api.nvim_create_augroup("conjure_log_disable_lsp", { clear = true }),
  pattern = { "conjure-log-*" },
  callback = function()
    vim.diagnostic.disable(0)
  end,
  desc = "Conjure Log disable LSP diagnostics",
})

-- Override the standard test kebindings.
vim.keymap.set("n", "<leader>tf", function()
  vim.cmd("ConjureEvalBuf")
  vim.cmd("ConjureCljRunCurrentNsTests")
end, { silent = true })

vim.keymap.set("n", "<leader>ta", function()
  vim.cmd("ConjureEvalBuf")
  vim.cmd("ConjureCljRunAlternateNsTests")
end, { silent = true })

local function single_test()
  vim.cmd("ConjureEvalRootForm")
  vim.cmd("ConjureCljRunCurrentTest")
end

vim.keymap.set("n", "<leader>tl", function()
  single_test()
end, { silent = true })
vim.keymap.set("n", "<leader>tn", function()
  single_test()
end, { silent = true })
