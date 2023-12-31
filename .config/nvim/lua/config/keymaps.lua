-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- oil nvim
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- Telescope File Browser
vim.keymap.set("n", "<leader>fo", "<CMD>Telescope file_browser<CR>", { desc = "Open file browser" })

vim.keymap.set("i", "jk", "<Esc>")
