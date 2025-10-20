return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            update_focused_file = {
                enable = true,
            },
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 40,
            },
            renderer = {
                group_empty = false,
            },
            git = {
                ignore = false,
            },
        },
        -- enabled = false,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        lazy = false,
        opts = {
            window = {
                width = 30,
            },
        },
        enabled = false,
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "material",
            },
        },
    },
    {
        "akinsho/bufferline.nvim",
        events = "VeryLazy",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                themable = true,
                indicator = {
                    style = "underline",
                },
                numbers = "ordinal",
                separator_style = "slope",
                color_icons = true,
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = true,
                show_tab_indicators = true,
                show_duplicate_prefix = true,
                always_show_bufferline = true,
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true,
                    },
                },
            },
        },
    },
    {
        "saghen/blink.cmp",
        build = "cargo build --release",
        version = "1.*",
        dependencies = {
            { "rafamadriz/friendly-snippets" },
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "enter",
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                keyword = { range = "full" },
                accept = { auto_brackets = { enabled = true } },
                list = { selection = { preselect = true, auto_insert = true } },
                trigger = { show_on_keyword = true },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {}
    },
    {
        "MagicDuck/grug-far.nvim",
        opts = {},
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        enabled = false,
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {}
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {
            size = 20,
            open_mapping = [[<A-\>]],
            shade_terminals = true,
            shading_factor = 2,
            direction = 'horizontal',
        }
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim', 'nvim-mini/mini.icons', 'nvim-tree/nvim-web-devicons' },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            completions = { lsp = { enabled = true } },
        },
    } }
