local wezterm = require("wezterm")
local config = {}

config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font("JetBrains Mono")
config.font_size = 13.0
config.disable_default_key_bindings = true

wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"Hack Nerd Font Mono",
	"JetBrains Mono",
	"Hack",
	"PT Mono",
	"Fira Code",
})

return config
