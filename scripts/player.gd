extends CharacterBody2D

## Script de déplacement du personnage
## Compatible mobile + clavier

@export var speed := 150.0

func _physics_process(delta):
	var direction := Vector2.ZERO

	# Déplacement clavier/flèches (ou virtuel si mappé)
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Appliquer le mouvement
	velocity = direction.normalized() * speed
	move_and_slide()
