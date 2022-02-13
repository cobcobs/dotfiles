local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({ { exe = "autopep8", filetypes = { "python" } } })

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ exe = "flake8", filetypes = { "python" } },
	{ exe = "codespell", filetypes = { "python" } },
})
