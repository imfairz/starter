local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.smartindent = true
vim.opt.softtabstop = 4

vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    update_in_insert = false,
})
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
vim.opt.number = true

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99
-- vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    -- checker = { enabled = true },
})
