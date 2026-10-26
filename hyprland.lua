-- ~/.config/hypr/hyprland.lua
-- Portado de hyprland.conf (Hyprland 0.55+)
-- Wiki: https://wiki.hypr.land/Configuring/

------------------
---- MONITORS ----
------------------

hl.monitor({
	output = "eDP-1",
	mode = "1366x768@60",
	position = "auto",
	scale = "auto",
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "kitty"
local fileManager = "nautilus"
local launcher = "rofi"
local browser = "firefox"
local ide = "vscodium"

local mainMod = "SUPER"

---------------
---- TEMA ----
---------------

-- Gruvbox Material (dark / medium) — mesma paleta do Waybar e do AwesomeWM
local palette = {
	bg0 = "#282828",
	bg1 = "#32302f",
	bg2 = "#3c3836",
	bg3 = "#45403d",
	fg0 = "#d4be98",
	fg1 = "#ddc7a1",
	grey0 = "#7c6f64",
	red = "#ea6962",
	orange = "#e78a4e",
	yellow = "#d8a657",
	green = "#a9b665",
	aqua = "#89b482",
	blue = "#7daea3",
	purple = "#d3869b",
}

-- "#rrggbb" -> "rgba(rrggbbaa)"
local function rgba(hex, alpha)
	return "rgba(" .. (hex:gsub("#", "")) .. (alpha or "ff") .. ")"
end

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("hyprpaper -c /home/guilherme/.config/hypr/hyprpaper.conf")
	hl.exec_cmd("wl-paste --watch cliphist store &")
	hl.exec_cmd("wl-paste --type image --watch cliphist store &")
	hl.exec_cmd("wl-clip-persist --clipboard regular")
	hl.exec_cmd("waybar")
	hl.exec_cmd("swayosd-server")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,

		border_size = 2,

		col = {
			active_border = { colors = { rgba(palette.green), rgba(palette.aqua) }, angle = 45 },
			inactive_border = rgba(palette.bg2),
		},

		-- Permite redimensionar janelas arrastando bordas e gaps
		resize_on_border = false,

		-- Veja https://wiki.hypr.land/Configuring/Tearing/ antes de ativar
		allow_tearing = false,

		layout = "dwindle",
	},
})

hl.config({
	decoration = {
		rounding = 10,
		rounding_power = 2,

		-- Transparência de janelas focadas e não focadas
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = rgba(palette.bg0, "ee"),
		},

		blur = {
			enabled = true,
			size = 8,
			passes = 2,
			vibrancy = 0.1696,
		},
	},
})

-- Animações
hl.config({
	animations = {
		enabled = true,
	},
})

--              NAME              TIPO      PONTOS
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Layouts
hl.config({
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
})

hl.config({
	misc = {
		force_default_wallpaper = -1, -- 0 ou 1 desativa os wallpapers de mascote
		disable_hyprland_logo = false,
	},
})

-----------------
---- INPUT ----
-----------------

hl.config({
	input = {
		kb_layout = "br",
		kb_variant = "abnt2",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 a 1.0, 0 = sem modificação

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ide))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(launcher .. " -show drun"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu --with-nth 2 | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("cliphist wipe"))
hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("grim ~/Images/screenshots/screenshot_$(date +%s).png"))
hl.bind(
	mainMod .. " + Print",
	hl.dsp.exec_cmd('grim -g "$(slurp)" ~/Images/screenshots/screenshot_$(date +%s).png')
)
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind(
	mainMod .. " + CTRL + Print",
	hl.dsp.exec_cmd(
		[[sh -c 'f=~/Images/screenshots/screenshot_$(date +%F_%H-%M-%S).png; grim -g "$(slurp)" "$f" && wl-copy < "$f"']]
	)
)

-- Mover o foco com mainMod + setas
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
-- Trocar de workspace com mainMod + [0-9]
-- Mover a janela ativa para um workspace com mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 -> tecla 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Workspace especial (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Percorrer workspaces existentes com mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mover/redimensionar janelas com mainMod + botão esquerdo/direito do mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Teclas de volume e brilho (swayosd)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"), { locked = true, repeating = true })

-- Controle de mídia (requer playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

------------------------------
---- WINDOWS AND WORKSPACES ----
------------------------------

hl.window_rule({
	name = "kitty-opacity",
	match = { class = "kitty" },
	opacity = "0.95 0.8",
})

hl.window_rule({
	-- Ignora pedidos de maximizar de todos os apps
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	-- Corrige problemas de arrasto com XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})
