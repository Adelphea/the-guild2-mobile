extends Camera3D

@export var move_speed: float = 10.0
@export var look_speed: float = 0.3

var rotation_x := 0.0
var rotation_y := 0.0

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
    if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
        rotation_y -= event.relative.x * look_speed * 0.01
        rotation_x -= event.relative.y * look_speed * 0.01
        rotation_x = clamp(rotation_x, -90, 90)
        rotation_degrees = Vector3(rotation_x, rotation_y, 0)

func _process(delta):
    var dir = Vector3.ZERO
    if Input.is_action_pressed("ui_up"):
        dir.z -= 1
    if Input.is_action_pressed("ui_down"):
        dir.z += 1
    if Input.is_action_pressed("ui_left"):
        dir.x -= 1
    if Input.is_action_pressed("ui_right"):
        dir.x += 1
    if Input.is_action_pressed("ui_page_up"):
        dir.y += 1
    if Input.is_action_pressed("ui_page_down"):
        dir.y -= 1
    
    global_translate(dir.normalized() * move_speed * delta)
