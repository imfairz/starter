return {
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.cmd("filetype plugin indent on")
			vim.cmd("syntax enable")

			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_quickfix_mode = 0
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_compiler_method = "latexmk"
		end,
	},
	{
		"let-def/texpresso.vim",
	},
}
