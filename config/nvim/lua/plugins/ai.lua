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
			-- I HATE COPILOT
			"github/copilot.vim",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			ignore_warnings = true,
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
		enabled = false,
	},
	{
		"nickjvandyke/opencode.nvim",
		dependencies = {
			---@module 'snacks'
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {}
			vim.o.autoread = true
		end,
	},
	{
		"carlos-algms/agentic.nvim",
		opts = {
			provider = "opencode-acp", -- "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp"
			diff_preview = {
				enabled = true,
				layout = "inline", -- "split" or "inline"
				center_on_navigate_hunks = true,
			},
		},
	},
}
