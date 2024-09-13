local wezterm = require("wezterm")
local config = {}

config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font("JetBrains Mono")

wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"Hack Nerd Font Mono",
	"JetBrains Mono",
	"Hack",
	"PT Mono",
	"Fira Code",
})

return config
