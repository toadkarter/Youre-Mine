extends Node2D


@export var level_scenes: Array[PackedScene]

@export_group("Debug")
@export var debug_level_index: int = 0
@export var crt_filter_on: bool = true

var current_level_index: int = 0
var current_level: Level = null

@onready var crt_filter: ColorRect = $CanvasLayer/CRTFilter


func _ready() -> void:
	_init_debug_options()
	_start_level_loop()


func _start_level_loop() -> void:
	if (debug_level_index != 0 and debug_level_index < level_scenes.size()):
		current_level_index = debug_level_index
		_load_level(debug_level_index)
	else:
		_load_level(current_level_index)


func _load_level(index: int) -> void:
	if current_level != null:
		current_level.queue_free()
	current_level = level_scenes[index].instantiate() as Level
	add_child(current_level)
	current_level.connect("finished", _on_level_finished)
	current_level.connect("restarted", _on_level_restarted)


func _on_level_finished() -> void:
	current_level_index += 1
	if (current_level_index < level_scenes.size()):
		_load_level(current_level_index)
	else:
		print("We have finished this level")


func _on_level_restarted() -> void:
	_load_level(current_level_index)


func _init_debug_options() -> void:
	if !crt_filter_on:
		crt_filter.visible = false
