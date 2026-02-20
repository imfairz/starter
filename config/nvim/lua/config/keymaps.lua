-- local telescope = require('telescope.builtin')
-- vim.keymap.set('n', '<C-p>', telescope.find_files, { desc = 'Telescope find files' })
-- vim.keymap.set('n', '<C><leader>', telescope.live_grep, { desc = 'Telescope live grep' })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>D", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- LazyGit
vim.keymap.set({ "n" }, "<leader>G", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
vim.keymap.set({ "n" }, "<C-a>", "ggVG", { desc = "Select All" })
vim.keymap.set({ "n" }, "<leader>qq", "<cmd>wqa<cr>", { desc = "Close nvim" })

-- Window Navigation
vim.keymap.set({ "n" }, "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
vim.keymap.set({ "n" }, "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set({ "n" }, "<C-j>", "<C-w>j", { desc = "Go to Down Window", remap = true })
vim.keymap.set({ "n" }, "<C-k>", "<C-w>k", { desc = "Go to Top Window", remap = true })

-- Snacks
vim.keymap.set({ "n" }, "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set({ "n" }, "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
vim.keymap.set({ "n" }, "gD", function()
	Snacks.picker.lsp_declarations()
end, { desc = "Goto Declaration" })
vim.keymap.set({ "n" }, "gr", function()
	Snacks.picker.lsp_references()
end, { desc = "References" })
vim.keymap.set({ "n" }, "gI", function()
	Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })
vim.keymap.set({ "n" }, "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set({ "n" }, "gai", function()
	Snacks.picker.lsp_incoming_calls()
end, { desc = "C[a]lls Incoming" })
vim.keymap.set({ "n" }, "gao", function()
	Snacks.picker.lsp_outgoing_calls()
end, { desc = "C[a]lls Outgoing" })
vim.keymap.set({ "n" }, "<leader>ss", function()
	Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })
vim.keymap.set({ "n" }, "<leader>sS", function()
	Snacks.picker.lsp_workspace_symbols()
end, { desc = "LSP Workspace Symbols" })

-- Nvim Tree
vim.keymap.set({ "n" }, "<C-b>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
-- vim.keymap.set({ "n" }, "<C-h>", "<cmd>NvimTreeFocus<cr>", { desc = "Focus to file tree" })

-- NeoTree
-- vim.keymap.set({ "n" }, "<C-b>", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })
-- vim.keymap.set({ "n" }, "<C-h>", "<cmd>Neotree focus<cr>", { desc = "Focus to file tree" })

-- Fzf
vim.keymap.set({ "n" }, "<leader><leader>", "<cmd>FzfLua files<cr>", { desc = "Search files in cwd" })
vim.keymap.set({ "n" }, "<leader>/", "<cmd>FzfLua live_grep<cr>", { desc = "Grep keyword from cwd" })

-- Bufferline
vim.keymap.set({ "n" }, "<leader>n", "<cmd>BufferLineCycleNext<cr>", { desc = "Go to next buffer" })
vim.keymap.set({ "n" }, "<leader>l", "<cmd>BufferLineCyclePrev<cr>", { desc = "Go to prev buffer" })
vim.keymap.set({ "n" }, "<leader>X", "<cmd>BufferLineCloseOthers<cr>", { desc = "Go to other buffer" })
vim.keymap.set({ "n" }, "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Go to buffer 1" })
vim.keymap.set({ "n" }, "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "Go to buffer 2" })
vim.keymap.set({ "n" }, "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "Go to buffer 3" })
vim.keymap.set({ "n" }, "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "Go to buffer 4" })
vim.keymap.set({ "n" }, "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "Go to buffer 5" })
vim.keymap.set({ "n" }, "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", { desc = "Go to buffer 6" })
vim.keymap.set({ "n" }, "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", { desc = "Go to buffer 7" })
vim.keymap.set({ "n" }, "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", { desc = "Go to buffer 8" })
vim.keymap.set({ "n" }, "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", { desc = "Go to buffer 9" })
vim.keymap.set({ "n" }, "<leader>$", "<cmd>BufferLineGoToBuffer -1<cr>", { desc = "Go to last buffer" })
vim.keymap.set({ "n" }, "<leader>X", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })

-- Grug-Far
vim.keymap.set({ "n" }, "<leader>F", "<cmd>botright vertical GrugFar<cr>", { desc = "Toggle grug-far" })
vim.keymap.set({ "n" }, "<leader><C-f>", "<cmd>bd! grug-far<cr>", { desc = "Close grug-far" })

-- CodeCompanion
-- vim.keymap.set({ "n" }, "<leader>cc", "<cmd>CodeCompanionAction<cr>", { desc = "Toggle CodeCompanion" })

-- ToggleTerm
vim.keymap.set("t", "<C-x>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- Lint
vim.keymap.set("n", "<leader>ll", function()
	require("lint").try_lint()
end, { desc = "Trigger linting for current file" })

-- OpenCode
local opencode = require("opencode")
vim.keymap.set({ "n", "x" }, "<leader>oct", function()
	opencode.ask("@this: ", { submit = true })
end, { desc = "Ask opencode…" })
vim.keymap.set({ "n", "x" }, "<leader>ocs", function()
	opencode.select()
end, { desc = "Execute opencode action…" })
vim.keymap.set({ "n", "t" }, "<leader>oct", function()
	opencode.toggle()
end, { desc = "Toggle opencode" })
vim.keymap.set({ "n", "x" }, "go", function()
	return opencode.operator("@this ")
end, { desc = "Add range to opencode", expr = true })
vim.keymap.set("n", "goo", function()
	return opencode.operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })
vim.keymap.set("n", "<S-C-u>", function()
	opencode.command("session.half.page.up")
end, { desc = "Scroll opencode up" })
vim.keymap.set("n", "<S-C-d>", function()
	opencode.command("session.half.page.down")
end, { desc = "Scroll opencode down" })
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })

-- Agentic
local agentic = require("agentic")
vim.keymap.set({ "n", "v" }, "<leader>agt", function()
	agentic.toggle()
end, { desc = "Toggle Agentic Chat" })
vim.keymap.set({ "n", "v" }, "<leader>aga", function()
	agentic.add_selection_or_file_to_context()
end, { desc = "Add file or selection to Agentic to Context" })
vim.keymap.set({ "n", "v" }, "<leader>agn", function()
	agentic.new_session()
end, { desc = "New Agentic Session" })
vim.keymap.set({ "n", "v" }, "<leader>ag0", function()
	agentic.stop_generation()
end, { desc = "Stop Agentic Generation" })
vim.keymap.set({ "n", "v" }, "<leader>agr", function()
	agentic.restore_session()
end, { desc = "Restore Agentic Session" })
