return {
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
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim",          cmd = "Mason", build = ":MasonUpdate" },
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
                astro = {},
            },
        },
        config = function(_, opts)
            for server, config in pairs(opts.servers) do
                config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
                -- require for lspconfig with neovim 0.11
                vim.lsp.config(server, config)
            end
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = { "lua_ls", "bashls", "html", "tailwindcss", "yamlls", "ts_ls", "rust_analyzer", "gopls", "biome", "dockerls", "docker_compose_language_service", "lemminx", "astro", "svelte", "tsgo", "vacuum" },
        }
    },
    {
        "b0o/schemastore.nvim",
        lazy = true,
        version = false,
        enabled = false,
    }
}
