return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        lazy = false,
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "bash", "rust", "go", "lua", "vim", "javascript", "typescript", "tsx", "css", "html" },
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
        "m4xshen/autoclose.nvim",
        opts = {},
    },
}
