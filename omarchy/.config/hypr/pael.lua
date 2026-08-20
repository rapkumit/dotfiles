-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 1,
  },
})

---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model   = "",
    kb_options = "",
    kb_rules   = "",

    numlock_by_default = true,
    
    sensitivity = 0,
    accel_profile = "flat",

    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.4,

      -- Use two-finger clicks for right-click instead of lower-right corner.
      clickfinger_behavior = true,

      -- Enable the touchpad while typing.
      disable_while_typing = false,

      -- Left-click-and-drag with three fingers.
      drag_3fg = 0,
    },
  },
})

-- Touchpad gestures.
-- 3-Finger Horizontal Swipe: Move along the scrolling tape (columns)
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "scroll_move",
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    mods = "SUPER",
    action = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------

-- Unbind List.
local unbindList = {
    -- Window Resizing Defaults
    "SUPER + ALT + code:20",          -- Expand window left a little
    "SUPER + CTRL + code:20",         -- Expand window left a lot
    "SUPER + code:20",                -- Expand window left
    "SUPER + ALT + SHIFT + code:21",  -- Expand window down a little
    "SUPER + CTRL + SHIFT + code:21", -- Expand window down a lot
    "SUPER + SHIFT + code:21",        -- Expand window down

    -- Clipboard Defaults
    "SUPER + C",                      -- Universal copy
    "SUPER + V",                      -- Universal paste (Frees up SUPER + V)
    "SUPER + X",                      -- Universal cut
    "SUPER + CTRL + V",               -- Clipboard manager

    -- File Manager
    "SUPER + ALT + SHIFT + F",
    "SUPER + SHIFT + B",
    "SUPER + SHIFT + ALT + B",
    "SUPER + SHIFT + N",

    -- Workspace
    "SUPER + mouse_down",
    "SUPER + mouse_up",
    "SUPER + SHIFT + mouse_down",
    "SUPER + SHIFT + mouse_up",
    "SUPER + SHIFT + LEFT", 
    "SUPER + SHIFT + RIGHT", 
    "SUPER + SHIFT + UP",
    "SUPER + SHIFT + DOWN",

    -- Screenshot
    "SUPER + SHIFT + S",

    -- Terminal
    "SUPER + T",

    -- Files
    "SUPER + E",
}
for _, bind_str in ipairs(unbindList) do
    hl.unbind(bind_str)
end

-- Bind List.
local bindList = {
  {"SUPER + V", "Clipboard Manager", "omarchy-shell shell toggle omarchy.clipboard"},
  {"SUPER + SHIFT + S", "Screenshot", "omarchy-capture-screenshot"},
  {"SUPER + T", "Terminal", { omarchy = "terminal" }},
  {"SUPER + E", "File Manager", { omarchy = "nautilus" }},

  {"SUPER + mouse:274", "Toggle window split", hl.dsp.layout("togglesplit")},
  {"SUPER + period", "Emojis", "omarchy-shell shell toggle omarchy.emojis"},

  -- Active workspace
  {"SUPER + SHIFT + mouse_down", "Scroll active workspace forward", hl.dsp.focus({ workspace = "e+1" })},
  {"SUPER + SHIFT + mouse_up", "Scroll active workspace backward", hl.dsp.focus({ workspace = "e-1" })},
  {"SUPER + SHIFT + RIGHT", "Scroll active workspace forward", hl.dsp.focus({ workspace = "e+1" })},
  {"SUPER + SHIFT + LEFT", "Scroll active workspace backward", hl.dsp.focus({ workspace = "e-1" })},
  {"SUPER + Q", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" })},

  -- Scrolling layout
  {"SUPER + mouse_down", "Next Column", hl.dsp.layout("move +col")},
  {"SUPER + mouse_up", "Previous Column", hl.dsp.layout("move -col")},

  -- we ball
  {"SUPER + CTRL + LEFT", "Swap window to the left", hl.dsp.window.swap({ direction = "l" })},
  {"SUPER + CTRL + RIGHT", "Swap window to the right", hl.dsp.window.swap({ direction = "r" })},
  {"SUPER + CTRL + UP", "Swap window up", hl.dsp.window.swap({ direction = "u" })},
  {"SUPER + CTRL + DOWN", "Swap window down", hl.dsp.window.swap({ direction = "d" })},
}
for _, item in ipairs(bindList) do
  local key, title, exec = item[1], item[2], item[3]
  hl.unbind(key)
  o.bind(key, title, exec)
end

-- Resize Windows with SUPER + ALT + Arrow Keys.
local resizeStepCount = 20
local resizeDirections = {
  RIGHT = { x = resizeStepCount, y = 0, desc = "Resize window right" },
  LEFT  = { x = -resizeStepCount,y = 0, desc = "Resize window left" },
  UP    = { x = 0, y = resizeStepCount, desc = "Resize window up" },
  DOWN  = { x = 0, y = -resizeStepCount, desc = "Resize window down" }
}
for dir, delta in pairs(resizeDirections) do
  hl.unbind("SUPER + ALT + " .. dir)
  o.bind(
    "SUPER + ALT + " .. dir,
    delta.desc,     
    hl.dsp.window.resize({ x = delta.x, y = delta.y, relative = true }), 
    { repeating = true }
  )
end

