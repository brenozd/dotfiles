return {
	"mrjones2014/smart-splits.nvim",
	version = ">=1.0.0",
	priority = 999,
	config = function()
		require("smart-splits").setup({
			ignored_filetypes = {
				"nofile",
				"quickfix",
				"prompt",
				"neo-tree",
			},
			ignored_buftypes = { "neo-tree" },
		})
	end,
}
