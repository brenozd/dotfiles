return {
	"stevearc/resession.nvim",
    priority = 997,
	config = function()
		local resession = require("resession")
	resession.setup()
		-- Resession does NOTHING automagically, so we have to set up some keymaps
	end,
}
