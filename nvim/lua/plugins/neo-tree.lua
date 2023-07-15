return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Neotree",
	init = function()
		vim.g.neo_tree_remove_legacy_commands = true
	end,
	config = function()
		local neotree = require("neo-tree")

		vim.cmd("let g:neo_tree_remove_legacy_commands = 1")
		vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

		neotree.setup({
			-- log_level = "trace",
			log_to_file = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			close_if_last_window = true,
			auto_clean_after_session_restore = true,
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
			name = {
				trailing_slash = true,
				use_git_status_colors = false,
				highlight = "NeoTreeFileName",
			},
			sources = { "filesystem" },
			source_selector = {
				winbar = true,
				content_layout = "center",
				sources = {
					{ source = "filesystem", display_name = "󰈙 File" },
				},
			},
			window = {
				position = "left",
				width = 50,
				mappings = {
					["e"] = function()
						vim.api.nvim_exec("Neotree focus filesystem left", true)
					end,
					["s"] = function()
						vim.api.nvim_exec("Neotree focus document_symbols left", true)
					end,
					["o"] = "system_open",
				},
			},
			commands = {
				system_open = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					-- macOs: open file in default application in the background.
					-- Probably you need to adapt the Linux recipe for manage path with spaces. I don't have a mac to try.
					vim.api.nvim_command("silent !open -g " .. path)
					-- Linux: open file in default application
					vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
				end,
			},
			filesystem = {
				bind_to_cwd = true,
				follow_current_file = true,
				use_libuv_file_watcher = true,
				filtered_items = {
					visible = true, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
				},
			},
			events = {
				{
					event = "file_renamed",
					handler = function(args)
						-- fix references to file
						print(args.source, " renamed to ", args.destination)
					end,
				},
				{
					event = "file_moved",
					handler = function(args)
						-- fix references to file
						print(args.source, " moved to ", args.destination)
					end,
				},
			},
			icon = {
				folder_closed = "󰉋",
				folder_open = "󰝰",
				folder_empty = "󱧸",
				default = "󰈔",
				highlight = "NeoTreeFileIcon",
			},
			git_status = {
				symbols = {
					-- Change type
					added = "󰐗", -- or "✚", but this is redundant info if you use git_status_colors on the name
					modified = "󱍷", -- or "", but this is redundant info if you use git_status_colors on the name
					deleted = "󰚃", -- this can only be used in the git_status source
					renamed = "󰛿", -- this can only be used in the git_status source
					-- Status type
					untracked = "󰋗",
					ignored = "󱑙",
					unstaged = "󰀨",
					staged = "󰗠",
					conflict = "",
				},
			},
			modified = {
				symbol = "",
				highlight = "NeoTreeModified",
			},
			document_symbols = {
				kinds = {
					File = { icon = "󰈙", hl = "Tag" },
					Namespace = { icon = "󰙅", hl = "Include" },
					Package = { icon = "󰏖", hl = "Label" },
					Class = { icon = "󰌗", hl = "Include" },
					Property = { icon = "󰆧", hl = "@property" },
					Enum = { icon = "󰒻", hl = "@number" },
					Function = { icon = "󰊕", hl = "Function" },
					String = { icon = "󰀬", hl = "String" },
					Number = { icon = "󰎠", hl = "Number" },
					Array = { icon = "󰅨", hl = "Type" },
					Object = { icon = "󰅩", hl = "Type" },
					Key = { icon = "󰌋", hl = "" },
					Struct = { icon = "󰌗", hl = "Type" },
					Operator = { icon = "󰆕", hl = "Operator" },
					TypeParameter = { icon = "󰊄", hl = "Type" },
					StaticMethod = { icon = "󰡱 ", hl = "Function" },
				},
			},
		})
	end,
}
