class_name BaseLevel

extends Node2D

@export var player_scene: PackedScene
@onready var spawn_location: Node2D = $SpawnLocation


func _ready() -> void:
	var player = player_scene.instantiate()
	add_child(player)
	player.position = spawn_location.position
	player.connect("died", _on_player_died)


func _on_player_died():
	print("Hello")
