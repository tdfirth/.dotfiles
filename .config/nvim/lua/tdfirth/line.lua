local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

-- Set up the colors
local colors = require("tdfirth.theme.colors")
local heirline_colors = {
	bg = colors.gray_700,
	fg = colors.gray_100,
	red = colors.red_500,
	dark_red = colors.red_500,
	green = colors.green_500,
	blue = colors.blue_500,
	gray = colors.gray_500,
	-- TODO purple, orange and cyan
	orange = colors.yellow_500,
	purple = colors.blue_500,
	cyan = colors.blue_300,
	diag_warn = colors.yellow_500,
	diag_error = colors.red_500,
	diag_hint = colors.green_500,
	diag_info = colors.blue_500,
	git_del = colors.red_500,
	git_add = colors.green_500,
	-- TODO a better change color?
	git_change = colors.yellow_500,
}
require("heirline").load_colors(heirline_colors)

local ViMode = {
	-- Get vim current mode, this information will be required by the provider
	-- and the highlight functions, so we compute it only once per component
	-- evaluation and store it as a component attribute
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()

		-- execute this only once, this is required if you want the ViMode
		-- component to be updated on operator pending mode
		if not self.once then
			vim.api.nvim_create_autocmd("ModeChanged", {
				pattern = "*:*o",
				command = "redrawstatus",
			})
			self.once = true
		end
	end,
	-- Now we define some dictionaries to map the output of mode() to the
	-- corresponding string and color. We can put these into `static` to compute
	-- them at initialisation time.
	static = {
		mode_names = { -- change the strings if you like it vvvvverbose!
			n = "N",
			no = "N?",
			nov = "N?",
			noV = "N?",
			["no\22"] = "N?",
			niI = "Ni",
			niR = "Nr",
			niV = "Nv",
			nt = "Nt",
			v = "V",
			vs = "Vs",
			V = "V_",
			Vs = "Vs",
			["\22"] = "^V",
			["\22s"] = "^V",
			s = "S",
			S = "S_",
			["\19"] = "^S",
			i = "I",
			ic = "Ic",
			ix = "Ix",
			R = "R",
			Rc = "Rc",
			Rx = "Rx",
			Rv = "Rv",
			Rvc = "Rv",
			Rvx = "Rv",
			c = "C",
			cv = "Ex",
			r = "...",
			rm = "M",
			["r?"] = "?",
			["!"] = "!",
			t = "T",
		},
		-- mode_colors = {
		-- 	n = "blue",
		-- 	i = "green",
		-- 	v = "cyan",
		-- 	V = "cyan",
		-- 	["\22"] = "cyan",
		-- 	c = "orange",
		-- 	s = "purple",
		-- 	S = "purple",
		-- 	["\19"] = "purple",
		-- 	R = "orange",
		-- 	r = "orange",
		-- 	["!"] = "red",
		-- 	t = "red",
		-- },
	},
	-- We can now access the value of mode() that, by now, would have been
	-- computed by `init()` and use it to index our strings dictionary.
	-- note how `static` fields become just regular attributes once the
	-- component is instantiated.
	-- To be extra meticulous, we can also add some vim statusline syntax to
	-- control the padding and make sure our string is always at least 2
	-- characters long. Plus a nice Icon.
	provider = function(self)
		return " %2(" .. self.mode_names[self.mode] .. "%)  "
	end,
	-- Same goes for the highlight. Now the foreground will change according to the current mode.
	hl = function(self)
		-- local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { fg = "bg", bg = "fg", bold = true }
	end,
	-- Re-evaluate the component only on ModeChanged event!
	-- This is not required in any way, but it's there, and it's a small
	-- performance improvement.
	update = {
		"ModeChanged",
	},
}
local FileNameBlock = {
	-- let's first set up some attributes needed by this component and it's children
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}
-- We can now define some children separately and add them later

local FileName = {
	provider = function(self)
		-- first, trim the pattern relative to the current directory. For other
		-- options, see :h filename-modifers
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return "[No Name]"
		end
		-- now, if the filename would occupy more than 1/4th of the available
		-- space, we trim the file path to its initials
		-- See Flexible Components section below for dynamic truncation
		if not conditions.width_percent_below(#filename, 0.25) then
			filename = vim.fn.pathshorten(filename)
		end
		return filename
	end,
	hl = { fg = utils.get_highlight("Directory").fg },
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(
	FileNameBlock,
	FileName, -- a new table where FileName is a child of FileNameModifier
	{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)

local FileType = {
	provider = function()
		return vim.bo.filetype
	end,
	hl = { fg = "fg" },
}

local FileEncoding = {
	provider = function()
		local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
		return enc
	end,
	hl = { fg = "fg" },
}

local FileFormat = {
	provider = function()
		local fmt = vim.bo.fileformat
		return fmt ~= "unix" and fmt:upper()
	end,
	hl = { fg = "fg" },
}

local FileSize = {
	provider = function()
		-- stackoverflow, compute human readable file size
		local suffix = { "b", "k", "M", "G", "T", "P", "E" }
		local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
		fsize = (fsize < 0 and 0) or fsize
		if fsize < 1024 then
			return fsize .. suffix[1]
		end
		local i = math.floor((math.log(fsize) / math.log(1024)))
		return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
	end,
}

-- We're getting minimalists here!
local Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	provider = "%7(%l/%3L%):%02c %P",
	hl = { fg = "fg" },
}

local LSPActive = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },

	-- You can keep it simple,
	-- provider = " [LSP]",

	-- Or complicate things a bit and get the servers names
	provider = function()
		local names = {}
		for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return " [" .. table.concat(names, " ") .. "] "
	end,
	hl = { fg = "fg" },
}

local Diagnostics = {
	condition = conditions.has_diagnostics,

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	update = { "DiagnosticChanged", "BufEnter" },

	{
		provider = "![",
	},
	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and (self.errors .. " ")
		end,
		hl = { fg = "diag_error", bold = true },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warnings .. " ")
		end,
		hl = { fg = "diag_warn", bold = true },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info .. " ")
		end,
		hl = { fg = "diag_info", bold = true },
	},
	{
		provider = function(self)
			return self.hints > 0 and self.hints
		end,
		hl = { fg = "diag_hint", bold = true },
	},
	{
		provider = "]",
	},
}

local Git = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	hl = { fg = "orange" },

	{ -- git branch name
		provider = function(self)
			return self.status_dict.head
		end,
		hl = { bold = true },
	},
	-- You could handle delimiters, icons and counts similar to Diagnostics
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = "(",
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and ("+" .. count)
		end,
		hl = { fg = "git_add" },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and ("-" .. count)
		end,
		hl = { fg = "git_del" },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and ("~" .. count)
		end,
		hl = { fg = "git_change" },
	},
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = ")",
	},
}

local Fill = {
	provider = "%=",
}

local Space = { provider = " " }

local StatusLine = {
	hl = { bg = "bg" },
	ViMode,
	Space,
	Git,
	Space,
	FileNameBlock,
	Fill,
	FileType,
	Space,
	LSPActive,
	Space,
	Diagnostics,
	Space,
	FileEncoding,
	Space,
	FileFormat,
	Space,
	FileSize,
	Space,
	Ruler,
}

local TerminalName = {
	-- we could add a condition to check that buftype == 'terminal'
	-- or we could do that later (see #conditional-statuslines below)
	provider = function()
		local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
		return " " .. tname
	end,
	hl = { fg = "blue", bold = true },
}

local WinBars = {
	fallthrough = false,
	{ -- Hide the winbar for special buffers
		condition = function()
			return conditions.buffer_matches({
				buftype = { "nofile", "prompt", "help", "quickfix" },
				filetype = { "^git.*", "fugitive" },
			})
		end,
		init = function()
			vim.opt_local.winbar = nil
		end,
	},
	{ -- A special winbar for terminals
		condition = function()
			return conditions.buffer_matches({ buftype = { "terminal" } })
		end,
		utils.surround({ "", "" }, "dark_red", {
			FileType,
			Space,
			TerminalName,
		}),
	},
	{ -- An inactive winbar for regular files
		condition = function()
			return not conditions.is_active()
		end,
		utils.surround({ "", "" }, "bg", { hl = { fg = "gray", force = true }, FileNameBlock }),
	},
	-- A winbar for regular files
	utils.surround({ "", "" }, "bg", FileNameBlock),
}

local TabLine = {}

local StatusColumn = {}

vim.api.nvim_create_autocmd("User", {
	pattern = "HeirlineInitWinbar",
	callback = function(args)
		local buf = args.buf
		local buftype = vim.tbl_contains({ "prompt", "nofile", "help", "quickfix" }, vim.bo[buf].buftype)
		local filetype = vim.tbl_contains({ "gitcommit", "fugitive" }, vim.bo[buf].filetype)
		if buftype or filetype then
			vim.opt_local.winbar = nil
		end
	end,
})

return {
	statusline = StatusLine,
	-- 	winbar = WinBars,
}
