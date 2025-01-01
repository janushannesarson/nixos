return {
	'hrsh7th/nvim-cmp',
	config = function()
		local cmp = require('cmp')
		cmp.setup({
			mapping = {
				['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.close(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'buffer' },
				{ name = 'path' },
				{ name = 'luasnip' },
			},
		})
	end,
	dependencies = {
		'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
		'hrsh7th/cmp-buffer', -- Buffer completions
		'hrsh7th/cmp-path', -- Path completions
		'hrsh7th/cmp-cmdline', -- Cmdline completions
		'hrsh7th/cmp-vsnip', -- Snippet completions
		'hrsh7th/vim-vsnip', -- Snippet engine
		'l3MON4d3/LuaSnip'
	},
}
