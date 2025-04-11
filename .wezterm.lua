-- Pull in the wezterm API
local wezterm = require("wezterm")
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

-- This table will hold the configuration.
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local act = wezterm.action
local opacity_toggle = false

-- general configurations
config = {
	automatically_reload_config = true,
	enable_tab_bar = true,
	tab_bar_at_bottom = true,
	show_new_tab_button_in_tab_bar = false,
	window_close_confirmation = "AlwaysPrompt",
	window_decorations = "RESIZE", -- disable the title bar but enable the resizable border
	color_scheme = "Tomorrow (dark) (terminal.sexy)",
	-- color_scheme = "tender (base16)",
	-- color_scheme = "rose-pine",
	font = wezterm.font("JetBrainsMono Nerd Font Mono"),
	font_size = 16,
	detect_password_input = true,
	tab_and_split_indices_are_zero_based = true,
	use_fancy_tab_bar = false,
  tab_max_width = 20,
	window_padding = { left = 1, right = 1, top = 1, bottom = 0 },
}

-- text on right-most side of tab line (workspace name)
wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

-- toggle opacity
wezterm.on('toggle-opacity', function(window, _)
  opacity_toggle = not opacity_toggle
  local opacity = opacity_toggle and 0.8 or 1.0 -- Adjust opacity levels here
  window:set_config_overrides({
    window_background_opacity = opacity,
  })
end)

config.unix_domains = {
  {
    name = 'unix',
  },
}

-- map the leader key
config.leader = {
  key = "b",
  mods = "CTRL",
  timeout_milliseconds = 1000,
}

-- mapping custom keybindings for window pane navigation
config.keys = {
	------------------------------------------------ PANE SPLITING ------------------------------------------------
	-- -- This will create a new split and run your default program inside it
	-- { key = "'", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- { key = ";", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	--
	-- ------------------------------------------------ PANE NAVIGATION ------------------------------------------------
	-- -- adjust pane size
	-- { key = "h", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 1 }) },
	-- { key = "j", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 1 }) },
	-- { key = "k", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 1 }) },
	-- { key = "l", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 1 }) },
	--
	-- -- select active pane
	-- { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	-- { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	-- { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	-- { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	--
	--  -- pane zoom
	-- { key = "0", mods = "ALT", action = act.TogglePaneZoomState },
	--
	------------------------------------------------ TAB CONFIGURATION ------------------------------------------------
	-- Rename the current tab
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
        description = wezterm.format({
          { Attribute = { Intensity = "Bold" } },
          { Foreground = { AnsiColor = "Fuchsia"} },
          { Text = "Enter new name for tab: " },
        }),
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end
      ),
    },
  },

  -- show tab navigator
	{ key = "/", mods = "CTRL", action = act.ShowTabNavigator },

  -- new tab
	{ key = "t", mods = "CTRL", action = act.SpawnTab 'CurrentPaneDomain' },

  -- tab navigation
  { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },

	------------------------------------------------ (GLOBAL) COPY MODE ------------------------------------------------
	{ key = "[", mods = "CTRL", action = act.ActivateCopyMode },

	------------------------------------------------ TOGGLE BACKGROUND OPACITY ------------------------------------------------
	{ key = "o", mods = "LEADER", action = act.EmitEvent 'toggle-opacity' },
}

-- and finally, return the configuration to wezterm
return config
