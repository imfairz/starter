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
                terminal = true
            },
            disable = {
                colored_cursor = false,
            },
        },
        config = function()
            vim.cmd("colorscheme material-darker")
        end,
        priority = 100,

    }
}
