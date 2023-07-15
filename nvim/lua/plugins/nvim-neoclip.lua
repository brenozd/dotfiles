return {
	"AckslD/nvim-neoclip.lua",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"kkharji/sqlite.lua",
		module = "sqlite",
	},
	config = function()
		require("neoclip").setup({
			enable_persistent_history = true,
			continuous_sync = true,
			content_spec_column = false,
		})
	end,
}
