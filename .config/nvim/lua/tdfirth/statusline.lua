-- -- STATUSLINE --
local modes = {
  ["n"] = "NORMAL",
  ["no"] = "  OP  ",
  ["nov"] = "  OP  ",
  ["noV"] = "  OP  ",
  ["noCTRL-V"] = "  OP  ",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["nt"] = "NORMAL",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "VISUAL",
  ["Vs"] = "VISUAL",
  ["CTRL-V"] = "VISUAL-BLOCK",
  ["CTRL-Vs"] = "VISUAL-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT",
  ["CTRL-S"] = "SELECT-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rx"] = "REPLACE",
  ["Rv"] = "VIRTUAL-REPLACE",
  ["Rvc"] = "VIRTUAL-REPLACE",
  ["Rvx"] = "VIRTUAL-REPLACE",
  ["c"] = " CLI  ",
  ["cv"] = "  EX  ",
  ["r"] = "HIT-ENTER",
  ["rm"] = " MORE ",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  if current_mode == "n" then
    return "%#StatusLineNormal#"
  elseif current_mode == "i" or current_mode == "ic" then
    return "%#StatusLineInsert#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    return "%#StatusLineVisual#"
  elseif current_mode == "R" then
    return "%#StatusLineReplace#"
  elseif current_mode == "c" then
    return "%#StatusLineCmdLine#"
  elseif current_mode == "t" then
    return "%#StatusLineTerminal#"
  end
  return "%#StatusLineNormal#"
end

local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
    return " "
  end

  return string.format(" %%<%s/", fpath)
end

local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
    return ""
  end
  return fname .. " "
end

local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = string.format(" %%#LspDiagnosticsSignError#e %d", count["errors"])
  end
  if count["warnings"] ~= 0 then
    warnings = string.format(" %%#LspDiagnosticsSignWarning#w %d", count["warnings"])
  end
  if count["hints"] ~= 0 then
    hints = string.format(" %%#LspDiagnosticsSignHint#h %d", count["hints"])
  end
  if count["info"] ~= 0 then
    info = string.format(" %%#LspDiagnosticsSignInformation#i %d", count["info"])
  end

  --local ns = table.concat({errors, warnings, hints, info}, " ")
  --return string.format("%%#LspDiagnosticsSignInformation# %s %%#Normal#", ns)
  return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function filetype()
  return string.format(" %s ", vim.bo.filetype)
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %l:%c "
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    "%#Statusline#",
    -- update_mode_colors(),
    "%#StatusLineNormal#",
    mode(),
    "%#Normal# ",
    filepath(),
    filename(),
    "%#Normal#",
    lsp(),
    "%=%#StatusLineExtra#",
    filetype(),
    "|",
    lineinfo(),
  }
end

function Statusline.inactive()
  return " %F"
end

function Statusline.short()
  return "%#StatusLineNC#   NvimTree"
end

vim.opt.laststatus = 3
-- vim.opt.statusline = "%#CursorColumn# %{lua:long_mode()} | %f %r %#CursorLine#%m %=%#CursorColumn# %y | %l:%c | %p%% "

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)

--
-- -- TABLINE --
-- function tabline()
--     local i = 1
--     local line = ""
--     while i <= vim.fn.tabpagenr("$") do
--         -- Set highlight based on current tab
--         if i == vfn.tabpagenr() then
--           line = line .. "%#TabLineSel#"
--         else
-- 	        line = line .. "%#TabLine#"
--         end
--         -- Add a separator bar
--         if i ~= 1 then
--           line = line .. "|"
--         end
--         -- Set the file name
--         local buflist = vfn.tabpagebuflist(i)
--         local winnr = vfn.tabpagewinnr(i)
--         local file = vfn.pathshorten(vfn.fnamemodify(vfn.bufname(buflist[winnr]), ":p:~:t"))
--         -- line = line .. " " .. i .. " " .. file
--         line = string.format("%s %d %s ", line, i, file)
--         i = i + 1
--     end
-- 	  -- After the last tab fill with TabLineFill and reset tab page nr
-- 	  line = line .. "%#TabLineFill#%T"
--
-- 	  -- Right align the label to close the current tab page
--     if vfn.tabpagenr("$") > 1 then
--         line = line .. "%=%#TabLine#%999Xclose"
--     end
--     return line
-- end
-- opt.tabline = "%!v:lua.tabline()"
