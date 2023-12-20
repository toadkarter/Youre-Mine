class_name HUD

extends CanvasLayer

@onready var stinger_background: ColorRect = $StingerBackground
@onready var stinger_label: Label = $StingerBackground/StingerLabel
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D


func show_stinger_text() -> void:
	stinger_background.visible = true
	audio_stream_player.play()