M = {}

local function get_session_name()
	local name = vim.fn.getcwd()
	local branch = vim.fn.system("git branch --show-current")
	if vim.v.shell_error == 0 then
		return name .. branch
	else
		return name
	end
end

local function get_autocmds()
	return {
		{
			"VimEnter",
			function()
				if vim.fn.argc(-1) == 0 then
					local session_name = get_session_name()
					require("resession").load(session_name, { dir = "dirsession", silence_errors = true })
					return
				end
				local file_specified = false

				-- Loop through the command line arguments
				for _, arg in ipairs(vim.fn.argv()) do
					-- Ignore arguments starting with a dash "-"
					if not vim.startswith(arg, "-") then
						-- Get the absolute path of the argument
						local abs_path = vim.fn.fnamemodify(vim.fn.expand(arg), ":p")

						-- Check if the file is readable
						if vim.fn.filereadable(abs_path) == 1 then
							vim.cmd("e" .. vim.fn.fnameescape(abs_path))
							file_specified = true
						else
							print("File does not exist or is not readable: " .. abs_path)
						end
					end
				end

				-- If no valid file was specified, create a new empty buffer
				if not file_specified then
					vim.cmd(":enew|bd#")
				end
			end,
			descrption = "Changes automatically to execution directory",
		},
		{
			"VimLeavePre",
			function()
				local session_name = get_session_name()
				require("resession").save(session_name, { dir = "dirsession", notify = true })
			end,
			descrption = "Changes automatically to execution directory",
		},
		{
			{ "BufRead", "BufNewFile" },
			":set filetype=terraform",
			opts = {
				pattern = { "*.tfvars" },
			},
		},
	}
end

M.get_autocmds = get_autocmds

return M
