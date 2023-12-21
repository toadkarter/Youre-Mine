class_name Droppable

extends RigidBody2D

@export var seconds_before_falling = 0.5
@export var seconds_before_deletion = 5
@export var is_bounceable: bool = false
@onready var hitbox: Area2D = $Hitbox


func _ready() -> void:
	if is_bounceable:
		set_collision_mask_value(1, true)
		hitbox.set_collision_mask_value(1, true)
	gravity_scale = 0.0
	hitbox.connect("body_entered", _on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		_handle_player_collision()
	elif is_bounceable and body is Bounce:
		linear_velocity.y = -500


func _handle_player_collision() -> void:
	await get_tree().create_timer(seconds_before_falling).timeout
	gravity_scale = 1.0
	if !is_bounceable:
		await get_tree().create_timer(seconds_before_deletion).timeout
		queue_free()

