local wezterm = require("wezterm")
local act = wezterm.action
config = wezterm.config_builder()
-- local mux = wezterm.mux

-- START TERMINAL MAXIMIZED
-- wezterm.on("gui-startup", function()
-- 	local tab, pane, window = mux.spawn_window({})
-- 	window:gui_window():maximize()
-- end)

local config = {}

config.default_prog = { "pwsh.exe", "-NoLogo" }

-- LAUNCH MENU CONFIGURATION
config.launch_menu = {
	{
		label = "WSL: Debian (Zsh)",
		args = { "wsl.exe", "-d", "Debian" },
	},
	{
		label = "PowerShell",
		args = { "pwsh.exe", "-NoLogo" },
	},
}

config.wsl_domains = {
	{
		name = "WSL:Debian",
		distribution = "Debian",
	},
}
-- This man here causes WSL to be the default program, regardless.
-- config.default_domain = "WSL:Debian"

-- LAUNCH SIZE (commented out since I use Glazewm)
config.initial_cols = 120
config.initial_rows = 28

config.front_end = "OpenGL"
config.term = "xterm-256color"
config.max_fps = 144
config.prefer_egl = true
config.animation_fps = 1
config.color_scheme = "s3r0 modified (terminal.sexy)"
config.window_background_opacity = 0.8
config.win32_system_backdrop = "Acrylic"

config.font = wezterm.font("Reddit Mono")
config.font_size = 12
config.line_height = 1

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 0

config.use_dead_keys = false
config.scrollback_lines = 5000
config.automatically_reload_config = true

config.enable_tab_bar = false
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.window_decorations = "NONE | RESIZE"
config.window_close_confirmation = "NeverPrompt"

-- KEYBINDS
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
	-- VI MODE
	{
		key = "[",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},
	-- PANES AND TABS
	{
		key = "\\",
		mods = "CTRL",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "-",
		mods = "CTRL",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "k",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "h",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL|ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "j",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "k",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "l",
		mods = "CTRL|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "n",
		mods = "LEADER",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "w",
		mods = "CTRL",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "x",
		mods = "CTRL",
		action = act.CloseCurrentPane({ confirm = false }),
	},
}

-- CYCLE TABS
for i = 1, 6 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

return config
