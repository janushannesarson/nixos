return {
	{ "rebelot/kanagawa.nvim" },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{
		'projekt0n/github-nvim-theme',
		name = 'github-theme',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme

		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require('github-theme').setup({
				options = {
					darken = {
						floats = false,
					},
					terminal_colors = false,
				}
			})
			vim.cmd('colorscheme github_dark')
		end,
	},

}
