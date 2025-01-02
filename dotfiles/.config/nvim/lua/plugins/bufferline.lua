return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		vim.opt.termguicolors = true

		local groups = require("bufferline.groups")
		require("bufferline").setup({
			options = {
				-- 	groups = {
				-- 		options = {
				-- 			toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
				-- 		},
				-- 		items = {
				-- 			{
				-- 				name = "Terminals", -- Mandatory
				-- 				highlight = { underline = false, sp = "orange" }, -- Optional
				-- 				-- priority = 1, -- determines where it will appear relative to other groups (Optional)
				-- 				-- icon = " ", -- Optional
				-- 				matcher = function(buf) -- Mandatory
				-- 					return buf.buftype == "terminal"
				-- 				end,
				-- 			},
				-- 			groups.builtin.ungrouped,
				-- 		},
				-- 	},
			},
		})

		vim.keymap.set("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { silent = true })
		vim.keymap.set("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { silent = true })
		vim.keymap.set("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { silent = true })
		vim.keymap.set("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { silent = true })
		vim.keymap.set("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { silent = true })
		vim.keymap.set("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { silent = true })
		vim.keymap.set("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { silent = true })
		vim.keymap.set("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { silent = true })
		vim.keymap.set("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { silent = true })
		vim.keymap.set("n", "<leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>", { silent = true })

		vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { silent = true, desc = "Toggle Pin" })

		vim.keymap.set("n", "]b", "<Cmd>BufferLineMoveNext<CR>", { silent = true, desc = "Move Next" })
		vim.keymap.set("n", "[b", "<Cmd>BufferLineMovePrev<CR>", { silent = true, desc = "Move Prev" })
	end,
}
