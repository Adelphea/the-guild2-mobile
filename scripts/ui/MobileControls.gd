extends Control

@onready var joystick: TouchScreenButton = $VirtualJoystick
@onready var look_area: TouchScreenButton = $LookArea
@onready var up_button: Button = $UpButton
@onready var down_button: Button = $DownButton

var drag_start := Vector2.ZERO
var is_dragging := false

func _process(delta: float) -> void:
    # On cherche le joueur au lieu de la caméra
    var player = get_tree().get_first_node_in_group("player")
    if player == null:
        return

    # ---- Joystick : mouvement ----
    if joystick.is_pressed():
        var pos = joystick.get_local_mouse_position()
        # Normalisation pour avoir un vecteur entre -1 et 1
        player.move_input = pos.normalized()
    else:
        player.move_input = Vector2.ZERO

    # ---- Zone tactile : rotation ----
    if look_area.is_pressed():
        var touch = look_area.get_local_mouse_position()
        if is_dragging:
            player.look_input = touch - drag_start
        drag_start = touch
        is_dragging = true
    else:
        player.look_input = Vector2.ZERO
        is_dragging = false

    # ---- Boutons ↑ ↓ (désactivés pour le joueur, utiles pour caméra libre) ----
    # On pourrait les garder pour un saut ou autre action plus tard.
    player.vertical_input = 0.0
    if up_button.is_pressed():
        player.vertical_input += 1.0
    if down_button.is_pressed():
        player.vertical_input -= 1.0
