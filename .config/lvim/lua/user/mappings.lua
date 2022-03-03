local M = {}

M.config = function()
	lvim.keys.normal_mode["<C-p>"] = ":Telescope<CR>"
	lvim.keys.normal_mode["cn"] = [[/\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn]]
	lvim.keys.normal_mode["cN"] = [[?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN]]
	lvim.keys.normal_mode["j"] = { "v:count ? 'j' : 'gj'", { expr = true } }
	lvim.keys.normal_mode["k"] = { "v:count ? 'k' : 'gk'", { expr = true } }

	lvim.builtin.which_key.mappings["rp"] = { [[:'{,'}s/<C-r><C-w>//g<Left><Left>]], "Replace in Paragraph" }
	lvim.builtin.which_key.mappings["ra"] = { [[:%s/<C-r><C-w>//g<Left><Left>]], "Replace All" }
	lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope find_files<CR>", "Find File" }
	lvim.builtin.which_key.mappings["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy Find" }
	lvim.builtin.which_key.mappings["c"] = {
		"<cmd>lua require('Comment.api').toggle_current_linewise()<CR>",
		"Comment",
	}
	lvim.builtin.which_key.mappings[";"] = { "<cmd>Alpha<CR>", "Dashboard" }
	lvim.builtin.which_key.mappings["sP"] = { "<cmd>Telescope projects<CR>", "Recent Project" }

	lvim.builtin.which_key.mappings["bd"] = { "<cmd>BufferKill<CR>", "Delete Buffer" }
	lvim.builtin.which_key.mappings["Ls"] = {
		":source ~/.config/lvim/config.lua<CR>",
		"Source LunarVim's configuration",
	}
end

return M
