extends Control

@onready var joystick: TouchScreenButton = $VirtualJoystick
@onready var look_area: TouchScreenButton = $LookArea
@onready var up_button: Button = $UpButton
@onready var down_button: Button = $DownButton

var drag_start := Vector2.ZERO
var is_dragging := false

func _process(delta: float) -> void:
    var cam = get_tree().get_first_node_in_group("camera")
    if cam == null:
        return

    # ---- Joystick : mouvement ----
    if joystick.is_pressed():
        var pos = joystick.get_local_mouse_position()
        # Normalisation pour éviter vitesse infinie
        cam.move_input = pos.normalized()
    else:
        cam.move_input = Vector2.ZERO

    # ---- Zone tactile : rotation ----
    if look_area.is_pressed():
        var touch = look_area.get_local_mouse_position()
        if is_dragging:
            cam.look_input = touch - drag_start
        drag_start = touch
        is_dragging = true
    else:
        cam.look_input = Vector2.ZERO
        is_dragging = false

    # ---- Boutons ↑ ↓ ----
    cam.vertical_input = 0.0
    if up_button.is_pressed():
        cam.vertical_input += 1.0
    if down_button.is_pressed():
        cam.vertical_input -= 1.0