extends Node2D

const SPIKES_EXTEND_ANIMATION_NAME: String = "spikes_extend"
const SPIKES_RETRACT_ANIMATION_NAME: String = "spikes_retract"
const RETRACTED_HEIGHT: float = 8.0

@export var spikes_up_seconds: float = 1.0
@export var spikes_down_seconds: float = 2.0
@export var start_retracted: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var spikes: StaticBody2D = $Spikes


func _ready() -> void:
	if start_retracted:
		spikes.position.y = RETRACTED_HEIGHT
		await get_tree().create_timer(spikes_down_seconds).timeout
	animation_player.connect("animation_finished", _on_animation_finished)
	animation_player.play(SPIKES_EXTEND_ANIMATION_NAME)
	
	
func _on_animation_finished(animation_name: String) -> void:
	if animation_name == SPIKES_RETRACT_ANIMATION_NAME:
		await get_tree().create_timer(spikes_down_seconds).timeout
		animation_player.play(SPIKES_EXTEND_ANIMATION_NAME)
	elif animation_name == SPIKES_EXTEND_ANIMATION_NAME:
		await get_tree().create_timer(spikes_up_seconds).timeout
		animation_player.play(SPIKES_RETRACT_ANIMATION_NAME)
