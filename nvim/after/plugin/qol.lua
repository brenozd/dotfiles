require("better_escape").setup({
	mapping = { "kj", "jk", "jj", "kk" }, -- a table with mappings to use
	timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
	clear_empty_lines = false, -- clear line after escaping if there is only whitespace
	keys = function()
		return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
	end,
})

require("ibl").setup({
	indent = {
		char = "",
		tab_char = { "" },
		smart_indent_cap = true,
		priority = 2,
	},
})

require("inc_rename").setup()
require("nvim-cursorline").setup()
require("mini.bufremove").setup()
require("colorizer").setup()
require("stickybuf").setup()
