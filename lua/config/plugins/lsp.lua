return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local lsp_files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/lsp/", "*.lua", false, true)
			for _, file in ipairs(lsp_files) do
				local lsp_name = file:match("([^/]+)%.lua$")
				require("lsp." .. lsp_name)
			end
		end,
	}
}
