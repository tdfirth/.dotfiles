local M = {}

local data_path = vim.fn.stdpath("data") .. "/sync.json"

local function project_root()
	return vim.fn.getcwd()
end

local function read_config()
	local f = io.open(data_path, "r")
	if not f then
		return {}
	end
	local content = f:read("*a")
	f:close()
	if content == "" then
		return {}
	end
	local ok, data = pcall(vim.json.decode, content)
	if not ok then
		return {}
	end
	return data
end

local function write_config(data)
	local f = io.open(data_path, "w")
	if not f then
		vim.notify("sync: failed to write " .. data_path, vim.log.levels.ERROR)
		return
	end
	f:write(vim.json.encode(data))
	f:close()
end

local function get_server()
	local config = read_config()
	return config[project_root()]
end

local syncing = false

local function sync()
	local server = get_server()
	if not server then
		vim.notify("sync: no server set for " .. project_root(), vim.log.levels.WARN)
		return
	end
	if syncing then
		return
	end
	syncing = true

	local cwd = project_root()
	local dirname = vim.fn.fnamemodify(cwd, ":t")
	local src = cwd .. "/"
	local dest = server .. ":~/" .. dirname .. "/"

	vim.system(
		{ "rsync", "-az", "--delete", "--filter=:- .gitignore", src, dest },
		{ text = true },
		function(result)
			syncing = false
			vim.schedule(function()
				if result.code ~= 0 then
					vim.notify("sync: rsync failed (exit " .. result.code .. ")\n" .. (result.stderr or ""), vim.log.levels.ERROR)
				else
					vim.notify("sync: done", vim.log.levels.INFO)
				end
			end)
		end
	)
end

local function setup_autocmd()
	local group = vim.api.nvim_create_augroup("Sync", { clear = true })
	if get_server() then
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = group,
			callback = sync,
		})
	end
end

vim.api.nvim_create_user_command("SyncServer", function(opts)
	if opts.args == "" then
		local server = get_server()
		if server then
			vim.notify("sync: " .. server)
		else
			vim.notify("sync: no server set for " .. project_root())
		end
		return
	end
	local config = read_config()
	config[project_root()] = opts.args
	write_config(config)
	vim.notify("sync: server set to " .. opts.args)
	setup_autocmd()
end, { nargs = "?" })

vim.api.nvim_create_user_command("SyncServerClear", function()
	local config = read_config()
	config[project_root()] = nil
	write_config(config)
	vim.notify("sync: server cleared for " .. project_root())
	setup_autocmd()
end, {})

vim.api.nvim_create_user_command("Sync", function()
	sync()
end, {})

setup_autocmd()

return M
