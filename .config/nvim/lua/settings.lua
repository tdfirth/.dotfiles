---  HELPERS  ---

local cmd = vim.cmd
local opt = vim.opt
local vfn = vim.fn

---  VIM ONLY COMMANDS  ---

cmd "filetype plugin on"
cmd('let &titleold="' .. TERMINAL .. '"')
cmd "set inccommand=split"
cmd "set iskeyword+=-"
cmd "set whichwrap+=<,>,[,],h,l"

-- THEME --
vim.g.colors_name = "herdwick"

---  SETTINGS  ---

opt.backup = false -- creates a backup file
opt.clipboard = "unnamedplus" --

---  SETTINGS  ---

opt.backup = false -- creates a backup file
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.colorcolumn = "99999"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
opt.hidden = true -- required to keep multiple buffers and open multiple buffers
opt.hlsearch = false -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- smart case
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.pumheight = 10 -- pop up menu height
opt.scrolloff = 999 -- minimal number of screen lines to keep above and below the cursor
opt.showmode = true -- Show mode, e.g. INSERT 
opt.showtabline = 1 -- always show tabs
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- creates a swapfile
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.title = true -- set the title of window to the value of the titlestring
-- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
opt.undodir = CACHE_PATH .. "/undo" -- set an undo directory
opt.undofile = true -- enable persisten undo
opt.updatetime = 300 -- faster completion
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.shortmess:append "c"
opt.tabstop = 2 -- insert 4 spaces for a tab
opt.cursorline = true -- highlight the current line
opt.number = true -- set numbered lines
opt.relativenumber = false -- set relative numbered lines
opt.numberwidth = 4 -- set number column width to 2 {default 4}
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.wrap = true -- display lines as one long line
opt.spell = false
opt.spelllang = "en"
opt.wildmode = "list:longest"

-- STATUSLINE --
opt.laststatus = 2
opt.statusline = "%#CursorColumn# %t %#CursorLine#%m %=%#CursorColumn# %y %l:%c | %p%% "

-- TABLINE --
function tabline()
    local i = 1
    local line = ""
    while i <= vim.fn.tabpagenr("$") do
        -- Set highlight based on current tab
        if i == vfn.tabpagenr() then
          line = line .. "%#TabLineSel#"
        else
	        line = line .. "%#TabLine#"
        end
        -- Add a separator bar
        if i ~= 1 then
          line = line .. "|"
        end
        -- Set the file name
        local buflist = vfn.tabpagebuflist(i)
        local winnr = vfn.tabpagewinnr(i)
        local file = vfn.pathshorten(vfn.fnamemodify(vfn.bufname(buflist[winnr]), ":p:~:t"))
        -- line = line .. " " .. i .. " " .. file
        line = string.format("%s %d %s ", line, i, file)
        i = i + 1
    end
	  -- After the last tab fill with TabLineFill and reset tab page nr
	  line = line .. "%#TabLineFill#%T"

	  -- Right align the label to close the current tab page
    if vfn.tabpagenr("$") > 1 then
        line = line .. "%=%#TabLine#%999Xclose"
    end
    return line
end
opt.tabline = "%!v:lua.tabline()"
