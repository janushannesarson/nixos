return {
	-- amongst your other plugins
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 9999999999999,
				open_mapping = [[<c-\>]],
				direction = "tab",
				winbar = {
					enabled = false,
					name_formatter = function(term) --  term: Terminal
						return term.name
					end,
				},
			})

			-- vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>")
		end,
	},
}
