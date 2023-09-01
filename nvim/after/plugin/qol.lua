require("better_escape").setup({
	mapping = { "kj", "jk", "jj", "kk" }, -- a table with mappings to use
	timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
	clear_empty_lines = false, -- clear line after escaping if there is only whitespace
	keys = function()
		return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
	end,
})

local indent_blankline = require("indent_blankline")
indent_blankline.setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	buftype_exclude = { "neo-tree", "neo-tree-popup" },
	filetype_exclude = { "dashboard" },
})

require("mini.bufremove").setup()
require("colorizer").setup()
require("stickybuf").setup()
