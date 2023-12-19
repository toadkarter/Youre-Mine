extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	_handle_fall(delta)
	_handle_jump_input()
	_handle_move_input()
	_handle_move_animations()
	move_and_slide()


func _handle_fall(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta


func _handle_move_input() -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)


func _handle_move_animations() -> void:
	if velocity .x != 0 or velocity.y != 0:
		animated_sprite.play("run")
		if velocity.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif velocity.x < 0 and !animated_sprite.flip_h:
			animated_sprite.flip_h = true
	else:
		animated_sprite.play("default")


func _handle_jump_input() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
