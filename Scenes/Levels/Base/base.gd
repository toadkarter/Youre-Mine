class_name Level

extends Node2D

signal finished
signal restarted

@export var player_scene: PackedScene
@export var seconds_before_next_level: float = 1.5

var player: Player

@onready var spawn_location: Node2D = $SpawnLocation
@onready var hud: HUD = $HUD


func _ready() -> void:
	get_tree().call_group("Debug", "hide")
	_init_player()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart_level") and !player.is_dying:
		restarted.emit()


func _init_player() -> void:
	player = player_scene.instantiate()
	add_child(player)
	player.position = spawn_location.position
	player.connect("died", _on_player_died)


func _on_player_died():
	hud.show_stinger_text()
	await get_tree().create_timer(seconds_before_next_level).timeout
	finished.emit()
	queue_free()
