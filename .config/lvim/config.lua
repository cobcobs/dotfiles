lvim.leader = "space"
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.lsp.diagnostics.virtual_text = false
lvim.colorscheme = "github_light"

require("user.settings").config()
require("user.builtin").config()
require("user.plugins").config()
require("user.autocommands").config()
require("user.mappings").config()
require("user.theme").telescope_theme()
