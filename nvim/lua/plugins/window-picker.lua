return {
	"s1n7ax/nvim-window-picker",
	name = "window-picker",
	event = "VeryLazy",
	version = "2.0.1",
	config = function()
		local window_picker = require("window-picker")
		window_picker.setup({
			show_prompt = false,
			hint = "floating-big-letter",
			autoselect_one = true,
			include_current_win = false,
			filter_rules = {
				-- filter using buffer options
				bo = {
					-- if the file type is one of following, the window will be ignored
					filetype = { "neo-tree", "neo-tree-popup", "notify" },
					-- if the buffer type is one of following, the window will be ignored
					buftype = { "terminal", "quickfix" },
				},
			},
			other_win_hl_color = "#e35e4f",
		})
	end,
}
