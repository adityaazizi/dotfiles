local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font & UI
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19
config.enable_tab_bar = false
-- macOS: "RESIZE" keeps the traffic-light buttons but hides the title bar
-- Linux: "NONE" fully removes the title bar (WezTerm still handles edge-resize)
if wezterm.target_triple:find("darwin") then
	config.window_decorations = "RESIZE"
else
	config.window_decorations = "NONE"
end

-- Colors (Coolnight)
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

-- The Maximize Logic
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	-- We use a slight delay or call it directly; maximize should work here
	window:gui_window():maximize()
end)

return config
