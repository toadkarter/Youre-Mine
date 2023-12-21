class_name Droppable

extends RigidBody2D

@export var seconds_before_falling = 0.5
@export var seconds_before_deletion = 5
@onready var hitbox: Area2D = $Hitbox


func _ready() -> void:
	gravity_scale = 0.0
	hitbox.connect("body_entered", _on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		_handle_player_collision()


func _handle_player_collision() -> void:
	await get_tree().create_timer(seconds_before_falling).timeout
	gravity_scale = 1.0
	await get_tree().create_timer(seconds_before_deletion).timeout
	queue_free()

