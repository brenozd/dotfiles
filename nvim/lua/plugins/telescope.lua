return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.1",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
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
							-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
							-- you want to replicate these defaults and use the following actions. This means
							-- installing as a dependency of telescope in it's `requirements` and loading this
							-- extension from there instead of having the separate plugin definition as outlined
							-- above.
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
		telescope.load_extension("neoclip")

		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				require("lazygit.utils").project_root_dir()
			end,
		})
	end,
}
