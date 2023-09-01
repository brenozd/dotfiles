return {
	"dnlhc/glance.nvim",
	lazy = true,
    priority = 900,
	config = function()
		require("glance").setup({
			hooks = {
				before_open = function(results, open, jump, method)
					if #results == 1 then
						jump(results[1]) -- argument is optional
					else
						open(results) -- argument is optional
					end
				end,
			},
		})
	end,
}