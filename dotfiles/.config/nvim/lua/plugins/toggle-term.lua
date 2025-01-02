return {
	-- amongst your other plugins
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-t>]],
				direction = "tab",
				start_in_insert = false,
				insert_mappings = true,
				terminal_mappings = true,
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

			vim.api.nvim_create_autocmd("BufLeave", {
				pattern = "*",
				callback = function()
					if vim.fn.tabpagenr("$") > 2 then
						vim.cmd("tabclose")
					end
				end,
			})
		end,
	},
}
