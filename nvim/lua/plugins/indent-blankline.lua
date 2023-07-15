return {

	"lukas-reineke/indent-blankline.nvim",
	config = function()
		local indent_blankline = require("indent_blankline")

		vim.opt.list = true

		indent_blankline.setup({
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = true,
			buftype_exclude = { "neo-tree", "neo-tree-popup"},
            filetype_exclude = { "dashboard", },
        })
	end,
}
