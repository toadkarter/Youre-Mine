class_name Level

extends Node2D

signal finished

@export var player_scene: PackedScene
@export var seconds_before_next_level: float = 1.0

@onready var spawn_location: Node2D = $SpawnLocation
@onready var hud: HUD = $HUD


func _ready() -> void:
	get_tree().call_group("Debug", "queue_free")
	_init_player()


func _init_player() -> void:
	var player = player_scene.instantiate()
	add_child(player)
	player.position = spawn_location.position
	player.connect("died", _on_player_died)


func _on_player_died():
	hud.show_stinger_text()
	await get_tree().create_timer(seconds_before_next_level).timeout
	finished.emit()
