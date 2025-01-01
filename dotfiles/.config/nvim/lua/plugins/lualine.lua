return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		-- vim.cmd([[colorscheme github_dark]])
		require("lualine").setup({
			theme = 'OceanicNext',
			winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'buffers' },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},
			inactive_winbar = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {}
			},

			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = {},
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' }
			},
		})
	end,
}
