extends Node2D


@export var level_scenes: Array[PackedScene]
@export var debug_level_index: int = 0

var current_level_index: int = 0
var current_level: Level = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (debug_level_index != 0 and debug_level_index < level_scenes.size()):
		_load_level(debug_level_index)
	else:
		_load_level(current_level_index)


func _load_level(index: int) -> void:
	if current_level != null:
		current_level.queue_free()
	current_level = level_scenes[index].instantiate() as Level
	add_child(current_level)
	current_level.connect("finished", _on_level_finished)


func _on_level_finished() -> void:
	current_level_index += 1
	if (current_level_index < level_scenes.size()):
		_load_level(current_level_index)
	else:
		print("We have finished this level")


