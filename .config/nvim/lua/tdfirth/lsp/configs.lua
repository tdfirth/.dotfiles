local lsp_installed, lspconfig = pcall(require, "lspconfig")
if not lsp_installed then
	return
end

local mason_installed, mason = pcall(require, "mason")
if not mason_installed then
	return
end

local mason_lspconfig_installed, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_installed then
	return
end

local servers = { "jsonls", "lua_ls", "rust_analyzer", "pyright", "tsserver", "ocamllsp", "zls", "sqlls" }

mason.setup()

mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("tdfirth.lsp.handlers").on_attach,
		capabilities = require("tdfirth.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "tdfirth.lsp.lang." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end
