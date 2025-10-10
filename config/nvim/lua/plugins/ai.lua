return {
    {
        "supermaven-inc/supermaven-nvim",
        opts = {
            keymaps = {
                accept_suggestion = "<C-a>",
                clear_suggestion = "<C-esc>",
                accept_word = "<C-j>",
            },
            log_level = "info",
            disable_inline_completion = false,
        },
    },
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "github/copilot.vim",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            display = {
                action_palette = {
                    width = 95,
                    height = 10,
                    prompt = "Prompt ",
                    provider = "fzf_lua",
                    opts = {
                        show_default_actions = true,
                        show_default_prompt_library = true,
                        title = "CodeCompanion actions",
                    },
                },
            },
        },
    }
}
