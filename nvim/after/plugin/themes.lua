require("themery").setup({
	themes = vim.fn.getcompletion("", "color"), -- Your list of installed colorschemes
	themeConfigFile = "~/.config/nvim/lua/theme.lua", -- Described below
	livePreview = true, -- Apply theme while browsing. Default to true.
})
