return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				vue = { "eslint" },
			}
		end,
	},
}
