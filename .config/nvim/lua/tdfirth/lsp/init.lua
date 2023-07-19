local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "tdfirth.lsp.configs"
require("tdfirth.lsp.handlers").setup()
require "tdfirth.lsp.null-ls"
