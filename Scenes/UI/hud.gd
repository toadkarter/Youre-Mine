class_name HUD

extends CanvasLayer

@onready var stinger_label: Label = $StingerLabel
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D


func show_stinger_text() -> void:
	stinger_label.visible = true
	audio_stream_player.play()