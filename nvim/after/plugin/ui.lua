require("scrollbar.handlers.gitsigns").setup()
require("hlslens").setup()

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "neo-tree" },
			winbar = { "neo-tree" },
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

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
		follow_current_file = {
			enabled = true,
		},
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

local noice = require("noice")

noice.setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = true, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = true, -- add a border to hover docs and signature help
	},
})

local telescope = require("telescope")
telescope.setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		undo = {
			entry_format = " $ID | 󰦒 $STAT |  $TIME",
			side_by_side = true,
			layout_strategy = "vertical",
			layout_config = {
				preview_height = 0.8,
			},
			mappings = {
				i = {
					["<CR>"] = require("telescope-undo.actions").restore,
					["<S-CR>"] = require("telescope-undo.actions").yank_deletions,
					["<C-CR>"] = require("telescope-undo.actions").yank_additions,
				},
			},
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("lazygit")
telescope.load_extension("noice")
telescope.load_extension("undo")

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		require("lazygit.utils").project_root_dir()
	end,
})

require("scrollbar").setup({
	excluded_buftypes = {
		"terminal",
		"neo-tree",
	},
	excluded_filetypes = {
		"cmp_docs",
		"cmp_menu",
		"noice",
		"prompt",
		"TelescopePrompt",
		"neo-tree",
	},
})

require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
})
