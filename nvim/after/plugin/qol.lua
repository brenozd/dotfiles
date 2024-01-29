require("nvim-cursorline").setup()
require("mini.bufremove").setup()
require("colorizer").setup()
require("stickybuf").setup()

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

-- UFO Setup
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = (" 󰁂 %d "):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
end

require("ufo").setup({
  open_folder_hl_timeout = 0,
	fold_virt_text_handler = handler,
})

require("leap").add_default_mappings()
-- require("harpoon").setup()
