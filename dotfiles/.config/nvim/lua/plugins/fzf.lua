return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		require("fzf-lua").setup({
			keymap = {
				fzf = {
					-- use cltr-q to select all items and convert to quickfix list
					["ctrl-q"] = "select-all+accept",
				},
			},
		})
		-- use `fzf-lua` for replace vim.ui.select
		require("fzf-lua").register_ui_select()
		vim.keymap.set("n", "<leader>ff", require("fzf-lua").files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>fg", require("fzf-lua").live_grep, { desc = "Live Grep" })
		vim.keymap.set("n", "<leader>fb", require("fzf-lua").buffers, { desc = "Find Buffers" })
		vim.keymap.set("n", "<leader>fs", require("fzf-lua").git_status, { desc = "Git Status" })
		vim.keymap.set("n", "<leader>fd", require("fzf-lua").diagnostics_workspace, { desc = "Workspace Diagnostics" })
		vim.keymap.set("n", "<leader>fD", require("fzf-lua").diagnostics_document, { desc = "Document Diagnostics" })

		-- under cursor
		vim.keymap.set("n", "<leader>fr", require("fzf-lua").lsp_references, { desc = "References" })
		vim.keymap.set("n", "<leader>fd", require("fzf-lua").lsp_definitions, { desc = "Definitions" })
		vim.keymap.set("n", "<leader>fl", require("fzf-lua").lsp_finder, { desc = "LSP Finder" })

		-- visual
		vim.keymap.set("v", "<leader>fg", require("fzf-lua").grep_visual, { desc = "Grep Visual" })

		vim.keymap.set("n", "<leader>fc", require("fzf-lua").colorschemes, { desc = "Color Schemes" })

		-- local fzf = require('fzf-lua')
		-- local function get_directories_in_repos()
		-- 	local repos_path = vim.fn.expand("~/repos")
		-- 	local directories = {}
		--
		-- 	for _, entry in ipairs(vim.fn.readdir(repos_path)) do
		-- 		local full_path = repos_path .. "/" .. entry
		-- 		if vim.fn.isdirectory(full_path) == 1 then
		-- 			table.insert(directories, full_path)
		-- 		end
		-- 	end
		--
		-- 	return directories
		-- end
		--
		-- local directories = get_directories_in_repos()
		--
		-- local function open_custom_directory_picker()
		-- 	fzf.fzf_exec(directories, {
		-- 		prompt = 'Directories> ',
		-- 		actions = {
		-- 			-- Open the selected directory with `cd` or similar action
		-- 			['default'] = function(selected)
		-- 				print("You selected: " .. selected[1])
		-- 				vim.cmd("cd " .. selected[1])
		-- 			end,
		-- 		},
		-- 	})
		-- end

		-- vim.keymap.set('n', '<leader>d', open_custom_directory_picker, { noremap = true, silent = true })
		-- local actions = require("fzf-lua.actions")
		-- require("fzf-lua").setup({
		-- 	keymap = {
		-- 		fzf = {
		-- 			["ctrl-a"] = "toggle-all",
		-- 		},
		-- 	},
		-- 	actions = {
		-- 		files = {
		-- 			["ctrl-q"] = actions.file_sel_to_qf,
		-- 		},
		-- 	},
		-- })
	end,
}
