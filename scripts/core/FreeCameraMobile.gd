extends Camera3D

@export var move_speed: float = 10.0
@export var look_speed: float = 0.2

var rotation_x := 0.0
var rotation_y := 0.0

var move_input := Vector2.ZERO
var vertical_input := 0.0
var look_input := Vector2.ZERO

func _process(delta):
    # Rotation via swipe tactile
    rotation_y -= look_input.x * look_speed * delta
    rotation_x -= look_input.y * look_speed * delta
    rotation_x = clamp(rotation_x, -80, 80)
    rotation_degrees = Vector3(rotation_x, rotation_y, 0)

    # Déplacement via joystick + boutons
    var dir = (transform.basis * Vector3(move_input.x, 0, move_input.y)).normalized()
    dir.y = vertical_input
    global_translate(dir * move_speed * delta)
