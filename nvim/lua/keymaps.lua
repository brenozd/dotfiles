M = {}

local toolbox = require("legendary.toolbox")
local function get_keymaps()
	return {
        -- Utils
		{
			"<leader>q",
			function()
                vim.cmd("bd")
			end,
			description = "Close buffer",
		},
		-- Movement
		{
			"<leader>j",
			function()
				vim.ui.input({ prompt = "󰁆 " }, function(input)
					if input then
						vim.cmd("+" .. input)
					end
				end)
			end,
			description = "Move cursor N lines down",
		},
		{
			"<leader>k",
			function()
				vim.ui.input({ prompt = "󰁞 " }, function(input)
					if input then
						vim.cmd("-" .. input)
					end
				end)
			end,
			description = "Move cursor N lines up",
		},
		{
			"<leader>g",
			function()
				vim.ui.input({ prompt = " " }, function(input)
					if input then
						vim.cmd(":" .. input)
					end
				end)
			end,
			description = "Goto line",
		},
		--Splits
		{
			"<leader>x",
			":split<CR>",
			description = "Split horizontally",
			opts = { silent = true },
		},
		{
			"<leader>v",
			":vsplit<CR>",
			description = "Split vertically",
			opts = { silent = true },
		},
		{
			"<A-h>",
			require("smart-splits").resize_left,
			description = "Expand window to left",
			opts = {
				silent = true,
				expr = true,
			},
		},
		{
			"<A-l>",
			require("smart-splits").resize_right,
			description = "Expand window to right",
			opts = {
				silent = true,
				expr = true,
			},
		},
		{
			"<A-j>",
			require("smart-splits").resize_down,
			description = "Expand window downards",
			opts = {
				silent = true,
				expr = true,
			},
		},
		{
			"<A-k>",
			require("smart-splits").resize_up,
			description = "Expand window upwards",
			opts = {
				silent = true,
				expr = true,
			},
		},
		--Telescope
		{
			"<leader>ff",
			":Telescope find_files<CR>",
			description = "Find files",
			opts = { silent = true },
		},
		{
			"<leader>fg",
			":Telescope live_grep<CR>",
			description = "Search across files",
			opts = { silent = true },
		},
		{
			"<leader>b",
			":Telescope buffers<CR>",
			description = "Show loaded buffers",
			opts = { silent = true },
		},
		{
			"<leader>u",
			":Telescope undo<CR>",
			description = "Show undo history",
			opts = { silent = true },
		},
		{
			"<leader>c",
			":Telescope neoclip<CR>",
			description = "Show clipboard history",
			opts = { silent = true },
		},
		{
			"<leader>fs",
			":Telescope lsp_workspace_symbols<CR>",
			description = "Find symbols in workspace",
			opts = { silent = true },
		},
		--ToggleTerm
		{
			"<leader>t",
			":ToggleTerm direction=float<CR>",
			description = "Show terminal",
			opts = {
				silent = true,
			},
		},
		--IncRename
		{
			"<leader>rn",
			function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end,
			description = "Incremental rename",
			opts = { silent = true, expr = true },
		},
		--LazyGit
		{
			"<leader>y",
			":LazyGit<CR>",
			description = "Open LazyGit",
			opts = {
				silent = true,
			},
		},
		--MoveLine
		{ "<C-k>", { n = require("moveline").up, v = require("moveline").block_up }, "Move line/block one up" },
		{
			"<C-j>",
			{ n = require("moveline").down, v = require("moveline").block_down },
			"Move line/block one down",
		},
		--Neo-tree
		{
			"<leader>e",
			":Neotree focus<CR>",
			description = "Focus Neo-tree sidebar ",
			opts = { silent = true },
		},
		--Session
		{
			"<leader>ss",
			toolbox.lazy_required_fn("resession", "save"),
			description = "Save session",
		},
		{
			"<leader>sd",
			toolbox.lazy_required_fn("resession", "delete"),
			description = "Delete session",
		},
		{
			"<leader>sl",
			toolbox.lazy_required_fn("resession", "load"),
			description = "Load session",
		},
		--Window Picker
		{
			"<leader>m",
			function()
				local success, picker = pcall(require, "window-picker")
				local picked_window = picker.pick_window({ hint = "floating-big-letter" })
				if not success then
					print(
						"You'll need to install window-picker to use this command: https://github.com/s1n7ax/nvim-window-picker"
					)
					return
				end
				if picked_window then
					vim.api.nvim_set_current_win(picked_window)
				end
			end,
			description = "Pick window",
			opts = {},
		},
		--Trouble
		{
			"<leader>xx",
			":TroubleToggle<CR>",
			description = "Toggle trouble window",
			opts = { silent = true },
		},
		{
			"<leader>xw",
			":TroubleToggle workspace_diagnostics<CR>",
			description = "Toggle trouble workspace diagnostics",
			opts = { silent = true },
		},
		{
			"<leader>xd",
			":TroubleToggle document_diagnostics<CR>",
			description = "Toggle trouble document diagnostics",
			opts = { silent = true },
		},
		{
			"<leader>xl",
			":TroubleToggle loclist<CR>",
			description = "Toggle trouble document diagnostics",
			opts = { silent = true },
		},
		{
			"<leader>xq",
			":TroubleToggle quickfix<CR>",
			description = "Toggle trouble quickfix",
			opts = { silent = true },
		},
	}
end
M.get_keymaps = get_keymaps

return M
