return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", cmd = "Mason", build = ":MasonUpdate" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "saghen/blink.cmp" },
		},
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				vtsls = {
					settings = {
						vtsls = {
							tsserver = {
								globalPlugins = {
									{
										name = "@vue/typescript-plugin",
										location = vim.fn.stdpath("data")
											.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
										languages = { "vue" },
										configNamespace = "typescript",
									},
								},
							},
						},
					},
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
				},
			},
		},
		config = function(_, opts)
			for server, config in pairs(opts.servers) do
				vim.lsp.enable(server)
				vim.lsp.config(server, config)
			end
		end,
	},
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				-- "lua_ls",
				"bashls",
				"html",
				"tailwindcss",
				"yamlls",
				"rust_analyzer",
				"gopls",
				"biome",
				"dockerls",
				"docker_compose_language_service",
				"lemminx",
				"astro",
				"svelte",
				-- "tsgo",
				"vacuum",
				"vue_ls",
				"vtsls",
				"eslint",
				"angularls",
			},
		},
	},
	{
		"b0o/schemastore.nvim",
		lazy = true,
		version = false,
		enabled = false,
	},
}
