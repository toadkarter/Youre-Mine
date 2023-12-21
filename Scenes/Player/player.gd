class_name Player

extends CharacterBody2D

signal died

@export_group("Movement")
@export var speed: float = 150.0
@export var jump_velocity: float = -350.0
@export var fall_damage_velocity: float = 700.0

@export_group("Death")
@export var death_length: float = 1.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var will_die_from_fall_damage: bool = false
var is_dying: bool = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _physics_process(delta: float) -> void:
	if is_dying:
		return

	_handle_fall(delta)
	_handle_jump_input()
	_handle_move_input()
	_handle_move_animations()
	move_and_slide()

	_check_collisions()

	if will_die_from_fall_damage and is_on_floor():
		animation_player.stop()
		_die()


func _handle_fall(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

		if velocity.y > fall_damage_velocity and !will_die_from_fall_damage:
			will_die_from_fall_damage = true
			# animation_player.play("fall_damage")

func _handle_move_input() -> void:
	var direction: float = Input.get_axis("left", "right")
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


func _check_collisions() -> void:
	for index in get_slide_collision_count():
		var collider: KinematicCollision2D = get_slide_collision(index)
		var collided_object: Object = collider.get_collider()
		if collided_object is Damage:
			_die()
		if collided_object is Bounce and !is_dying:
			will_die_from_fall_damage = false
			velocity.y = jump_velocity * collided_object.get_jump_factor()


func _die():
	if is_dying:
		return
	is_dying = true
	animated_sprite.play("die")
	audio_stream_player.play()
	await get_tree().create_timer(death_length).timeout
	died.emit()