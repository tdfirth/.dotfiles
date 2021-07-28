local M = {}

vim.g.vsnip_snippet_dir = O.vnsip_dir

M.config = function()
  local opt = {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
      path = { kind = "   (Path)" },
      buffer = { kind = "   (Buffer)" },
      calc = { kind = "   (Calc)" },
      vsnip = { kind = "   (Snippet)" },
      nvim_lsp = { kind = "   (LSP)" },
      -- nvim_lua = {kind = "  "},
      nvim_lua = false,
      spell = { kind = "   (Spell)" },
      tags = false,
      -- vim_dadbod_completion = true,
      -- snippets_nvim = {kind = "  "},
      -- ultisnips = {kind = "  "},
      -- treesitter = {kind = "  "},
      emoji = { kind = " ﲃ  (Emoji)", filetypes = { "markdown", "text" } },
    },
  }
  local status_ok, compe = pcall(require, "compe")
  if not status_ok then
    return
  end

  compe.setup(opt)
end

return M
