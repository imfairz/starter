return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"rust",
				"go",
				"lua",
				"vim",
				"javascript",
				"typescript",
				"tsx",
				"css",
				"html",
				"dockerfile",
				"markdown",
				"xml",
				"astro",
				"svelte",
				"vue",
				"arduino",
				"prisma",
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				javascript = { "biome", "biome-organize-imports" },
				javascriptreact = { "biome", "biome-organize-imports" },
				typescript = { "biome", "biome-organize-imports" },
				typescriptreact = { "biome", "biome-organize-imports" },
				html = { "prettier" },
				astro = { "prettier" },
				yaml = { "prettier" },
				vue = { "prettier" },
				json = { "prettier" },
				go = { "gopls", "goimports", "golines" },
				arduino = { "clang-format" },
			},
			formatters = {
				prettier = {
					append_args = { "--tab-width", "4" },
				},
				biome = {
					indent_style = "tab",
					indent_width = 4,
				},
			},
			notify_on_error = true,
			notify_no_formatters = true,
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				timeout_ms = 500,
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"prettier",
				"yamlfix",
				"vacuum",
				"biome",
				"hyprls",
				"gofumpt",
				"goimports",
				"golines",
				"gotests",
				"arduino-language-server",
				"clang-format",
			},
		},
	},
	{
		"m4xshen/autoclose.nvim",
		opts = {},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			pre_hook = function(ctx)
				require("ts_context_commentstring.internal").update_commentstring(ctx)
			end,
		},
	},
}
