local set_cwd = function()
	local path = (MiniFiles.get_fs_entry() or {}).path
	if path == nil then
		return vim.notify("Cursor is not on valid entry")
	end
	vim.fn.chdir(vim.fs.dirname(path))
end
-- Yank in register full path of entry under cursor
local yank_path = function()
	local path = (MiniFiles.get_fs_entry() or {}).path
	if path == nil then
		return vim.notify("Cursor is not on valid entry")
	end
	vim.fn.setreg(vim.v.register, path)
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local b = args.data.buf_id
		vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
		vim.keymap.set("n", "gy", yank_path, { buffer = b, desc = "Yank path" })
	end,
})

return {
	"echasnovski/mini.files",
	version = "*",
	config = function()
		vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>", { desc = "Files" })
		require("mini.files").setup({})
	end,
}
