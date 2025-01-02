return {
	-- amongst your other plugins
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
				direction = "tab",
				winbar = {
					enabled = false,
					name_formatter = function(term) --  term: Terminal
						return term.name
					end,
				},
				float_opts = {
					-- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
					title_pos = "left",
				},
			})

			vim.keymap.set("n", "<leader>1", ":silent!tabclose | silent!ToggleTerm 1<CR>", { silent = true })
			vim.keymap.set("n", "<leader>3", ":silent!tabclose | silent!ToggleTerm 3<CR>", { silent = true })
			vim.keymap.set("n", "<leader>2", ":silent!tabclose | silent!ToggleTerm 2<CR>", { silent = true })
			vim.keymap.set("n", "<leader>4", ":silent!tabclose | silent!ToggleTerm 4<CR>", { silent = true })
			vim.keymap.set("n", "<leader>5", ":silent!tabclose | silent!ToggleTerm 5<CR>", { silent = true })
		end,
	},
}
