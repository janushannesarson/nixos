return {
	-- amongst your other plugins
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = function()
			require("toggleterm").setup {
				open_mapping = [[<c-\>]],
				direction = 'horizontal',
			}

			-- vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")
		end
	}
}
