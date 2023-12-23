extends Node2D

const SPIKES_EXTEND_ANIMATION_NAME: String = "spikes_extend"
const SPIKES_RETRACT_ANIMATION_NAME: String = "spikes_retract"

@export var spikes_up_seconds: float = 1.0
@export var spikes_down_seconds: float = 2.0

var spikes_down: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.connect("animation_finished", _on_animation_finished)
	animation_player.play(SPIKES_EXTEND_ANIMATION_NAME)
	
	
func _on_animation_finished(animation_name: String) -> void:
	if animation_name == SPIKES_RETRACT_ANIMATION_NAME:
		await get_tree().create_timer(spikes_down_seconds).timeout
		animation_player.play(SPIKES_EXTEND_ANIMATION_NAME)
	elif animation_name == SPIKES_EXTEND_ANIMATION_NAME:
		await get_tree().create_timer(spikes_up_seconds).timeout
		animation_player.play(SPIKES_RETRACT_ANIMATION_NAME)


func _extend_spikes() -> void:
	animation_player.play(SPIKES_EXTEND_ANIMATION_NAME)
	spikes_down = false
	
	
func _retract_spikes() -> void:
	animation_player.play(SPIKES_RETRACT_ANIMATION_NAME)
	spikes_down = true
	
