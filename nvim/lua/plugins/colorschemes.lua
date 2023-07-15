local telescopeBorderless = function(flavor)
	local cp = require("catppuccin.palettes").get_palette(flavor)

	return {
		TelescopeBorder = { fg = cp.surface0, bg = cp.surface0 },
		TelescopeSelectionCaret = { fg = cp.flamingo, bg = cp.surface1 },
		TelescopeMatching = { fg = cp.peach },
		TelescopeNormal = { bg = cp.surface0 },
		TelescopeSelection = { fg = cp.text, bg = cp.surface1 },
		TelescopeMultiSelection = { fg = cp.text, bg = cp.surface2 },

		TelescopeTitle = { fg = cp.crust, bg = cp.green },
		TelescopePreviewTitle = { fg = cp.crust, bg = cp.red },
		TelescopePromptTitle = { fg = cp.crust, bg = cp.mauve },

		TelescopePromptNormal = { fg = cp.flamingo, bg = cp.crust },
		TelescopePromptBorder = { fg = cp.crust, bg = cp.crust },
	}
end

return {
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
	},
	{
		"rmehri01/onenord.nvim",
		priority = 1000,
	},
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = false,
				highlight_overrides = {
					latte = telescopeBorderless("latte"),
					frappe = telescopeBorderless("frappe"),
					macchiato = telescopeBorderless("macchiato"),
					mocha = telescopeBorderless("mocha"),
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					treesitter = true,
					treesitter_context = true,
					telescope = {
						enabled = true,
						style = "nvchad"
					},
					lsp_trouble = false,
					which_key = false,
					notify = true,
					barbecue = {
						dim_dirname = true, -- directory name is dimmed by default
						bold_basename = true,
						dim_context = false,
						alt_background = false,
					},
					dashboard = true,
					indent_blankline = {
						enabled = true,
						colored_indent_levels = false,
					},
					mason = true,
					neotree = true,
					noice = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
				},
			})
		end,
	},
	{
		"morhetz/gruvbox",
		priority = 1000,
	},
	{
		"sainnhe/sonokai",
		priority = 1000,
	},
	{
		"loctvl842/monokai-pro.nvim",
		priority = 1000,
		config = function()
			require("monokai-pro").setup()
		end,
	},
}
