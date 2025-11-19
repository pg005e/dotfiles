local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

local act = wezterm.action
local opacity_toggle = false

config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
  show_new_tab_button_in_tab_bar = false,
  window_close_confirmation = "AlwaysPrompt",
  window_decorations = "RESIZE", -- disable the title bar but enable the resizable border
  -- color_scheme = 'Tomorrow (dark) (terminal.sexy)',
  color_scheme = 'Tomorrow Night (Gogh)',
  -- color_scheme = "tender (base16)",
  -- color_scheme = "rose-pine",
  font = wezterm.font("JetBrainsMono Nerd Font Mono"),
  font_size = 28,
  detect_password_input = true,
  tab_and_split_indices_are_zero_based = true,
  window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
  adjust_window_size_when_changing_font_size = true,
}

wezterm.on('toggle-opacity', function(window, _)
  opacity_toggle = not opacity_toggle
  local opacity = opacity_toggle and 0.8 or 1.0 -- Adjust opacity levels here
  window:set_config_overrides({
    window_background_opacity = opacity,
  })
end)

config.leader = {
  key = "0",
  mods = "CTRL",
  timeout_milliseconds = 1000,
}

config.keys = {
  ------------------------------------------------ TAB CONFIGURATION ------------------------------------------------
  -- Rename the current tab
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
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
  { key = "/", mods = "CTRL",         action = act.ShowTabNavigator },

  -- new tab
  { key = "n", mods = "LEADER",       action = act.SpawnTab 'CurrentPaneDomain' },

  -- tab navigation
  { key = "]", mods = "LEADER",       action = act.ActivateTabRelative(1) },
  { key = "[", mods = "LEADER",       action = act.ActivateTabRelative(-1) },

  ------------------------------------------------ REBIND ------------------------------------------------
  -- Command Palette
  { key = "P", mods = "CTRL | SHIFT", action = act.DisableDefaultAssignment }, -- unbind
  { key = "1", mods = "CTRL",         action = act.ActivateCommandPalette },   -- rebind

  -- Copy Mode
  { key = "[", mods = "CTRL",         action = act.ActivateCopyMode }, -- unbind

  ------------------------------------------------ TOGGLE BACKGROUND OPACITY ------------------------------------------------
  { key = "o", mods = "LEADER",       action = act.EmitEvent 'toggle-opacity' },
}

return config
