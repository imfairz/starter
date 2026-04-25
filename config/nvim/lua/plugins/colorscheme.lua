return {
	{
		"rebelot/kanagawa.nvim",
		opts = {
			theme = "dragon",
		},
		priority = 100,
	},
	{
		"Shatur/neovim-ayu",
		priority = 100,
	},
	{
		"marko-cerovac/material.nvim",
		opts = {
			contrast = {
				terminal = true,
			},
			disable = {
				colored_cursor = false,
			},
		},
		priority = 100,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme catppuccin-macchiato")
		end,
	},
}
