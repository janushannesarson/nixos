return {
	-- Comment 1
	"folke/which-key.nvim",
	dependencies = {

	},
	event = "VeryLazy",
	opts = {
		preset = "helix",
		spec = {
			{ '<leader>c', group = 'Code',     mode = { 'n' } },
			{ '<leader>d', group = 'Document' },
			{ '<leader>r', group = 'Rename' },
			{ '<leader>f', group = 'Find' },
			{ '<leader>w', group = 'Workspace' },
			{ '<leader>t', group = 'Toggle' },
			{ '<leader>h', group = 'Hunk',     mode = { 'n' } },
		},
		delay = function(ctx)
			return 0
		end,
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			spelling = {
				enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			-- Comment 2
			presets = {
				operators = false, -- adds help for operators like d, y, ...
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = false, -- default bindings on <c-w>
				nav = false, -- misc bindings to work with windows
				z = false, -- bindings for folds, spelling and others prefixed with z
				g = false, -- bindings for prefixed with g
			},
		},
		-- Comment 3
		icons = {
			mappings = false,
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({
					global = false,

				})
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
