extends Node2D


@export var level_scenes: Array[PackedScene]

@export_group("Debug")
@export var debug_level_index: int = 0
@export var crt_filter_on: bool = true
@export var show_level_number: bool = false
@export var show_level_text: String = "Current Level: %d"

var current_level_index: int = 0
var current_level: Level = null

@onready var crt_filter: ColorRect = $CanvasLayer/CRTFilter
@onready var level_number_label: Label = $CanvasLayer/LevelNumber
@onready var bgm_player: AudioStreamPlayer2D = $BGMPlayer


func _ready() -> void:
	_init_debug_options()
	_start_level_loop()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _start_level_loop() -> void:
	bgm_player.play()
	if (debug_level_index != 0 and debug_level_index < level_scenes.size()):
		current_level_index = debug_level_index
		_load_level(debug_level_index)
	else:
		_load_level(current_level_index)


func _load_level(index: int) -> void:
	if current_level != null:
		remove_child(current_level)
		current_level.queue_free()
	current_level = level_scenes[index].instantiate() as Level
	add_child(current_level)
	current_level.connect("finished", _on_level_finished)
	current_level.connect("restarted", _on_level_restarted)

	level_number_label.text = show_level_text % index


func _on_level_finished() -> void:
	current_level_index += 1
	if (current_level_index < level_scenes.size()):
		_load_level(current_level_index)
	else:
		print("We are at the end of the current game")


func _on_level_restarted() -> void:
	_load_level(current_level_index)


func _init_debug_options() -> void:
	if !crt_filter_on:
		crt_filter.visible = false

	if show_level_number:
		level_number_label.visible = true
