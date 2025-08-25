extends CharacterBody3D

@export var speed: float = 4.0
@export var gravity: float = 9.8

var joystick_input := Vector2.ZERO

func _physics_process(delta):
    var input_vec = Vector2.ZERO
    
    # Input clavier/pc
    input_vec.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_vec.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

    # Input mobile (joystick)
    if joystick_input != Vector2.ZERO:
        input_vec = joystick_input
    
    if input_vec.length() > 0:
        input_vec = input_vec.normalized()
        var forward = -transform.basis.z
        var right = transform.basis.x
        var dir = (forward * input_vec.y + right * input_vec.x).normalized()
        velocity.x = dir.x * speed
        velocity.z = dir.z * speed
    else:
        velocity.x = lerp(velocity.x, 0, 0.2)
        velocity.z = lerp(velocity.z, 0, 0.2)

    if not is_on_floor():
        velocity.y -= gravity * delta
    else:
        velocity.y = 0

    move_and_slide()
