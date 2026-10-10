return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			local ensureInstalled = {
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
				"fish",
			}
			local alreadyInstalled = require("nvim-treesitter.config").get_installed()
			local parsersToInstall = vim.iter(ensureInstalled)
				:filter(function(parser)
					return not vim.tbl_contains(alreadyInstalled, parser)
				end)
				:totable()
			require("nvim-treesitter").install(parsersToInstall)
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
					append_args = { "--tab-width", "2" },
				},
				biome = {
					indent_style = "space",
					indent_width = 2,
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
