extends CharacterBody3D

@export var move_speed: float = 5.0
@export var look_speed: float = 3.0

var move_input: Vector2 = Vector2.ZERO
var look_input: Vector2 = Vector2.ZERO

var cam: Camera3D

func _ready() -> void:
    cam = $Camera3D

func _physics_process(delta: float) -> void:
    # Rotation avec input tactile
    rotation.y -= look_input.x * look_speed * delta
    
    # Déplacement en fonction du joystick
    var dir = Vector3.ZERO
    var forward = -transform.basis.z
    var right = transform.basis.x
    dir += forward * move_input.y
    dir += right * move_input.x
    dir = dir.normalized()
    
    velocity.x = dir.x * move_speed
    velocity.z = dir.z * move_speed
    velocity.y += ProjectSettings.get_setting("physics/3d/default_gravity") * delta
    
    move_and_slide()
