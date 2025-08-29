extends Control

@onready var joystick = $VirtualJoystick
@onready var look_area = $LookArea
@onready var up_button = $UpButton
@onready var down_button = $DownButton

var drag_start := Vector2.ZERO
var is_dragging := false

func _process(delta):
    var cam = get_tree().get_first_node_in_group("camera")
    if cam == null:
        return
    
    # Joystick → mouvement
    var joy_pos = joystick.get_local_mouse_position()
    if joystick.is_pressed():
        cam.move_input = joy_pos.normalized()
    else:
        cam.move_input = Vector2.ZERO

    # Zone tactile → rotation
    if look_area.is_pressed():
        var touch = look_area.get_local_mouse_position()
        cam.look_input = touch - drag_start if is_dragging else Vector2.ZERO
        drag_start = touch
        is_dragging = true
    else:
        cam.look_input = Vector2.ZERO
        is_dragging = false

    # Boutons → montée/descente
    cam.vertical_input = 0.0
    if up_button.is_pressed():
        cam.vertical_input += 1.0
    if down_button.is_pressed():
        cam.vertical_input -= 1.0
