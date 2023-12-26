extends Node2D
class_name Outro

signal finished

@export var credits: Array[String]
@export var credit_length: float = 1.0

@onready var stinger_background: ColorRect = $CanvasLayer/StingerBackground
@onready var credit_label: Label = $CanvasLayer/CreditLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	stinger_background.visible = false
	for credit in credits:
		await _display_credit(credit)
		
	stinger_background.visible = true
	await get_tree().create_timer(credit_length * 2).timeout
	var fade_out_length = animation_player.get_animation("stinger_text_fade_out").length
	animation_player.play("stinger_text_fade_out")
	await get_tree().create_timer(fade_out_length).timeout
	finished.emit()

func _display_credit(credit: String):
	credit_label.visible = true
	credit_label.text = credit
	await get_tree().create_timer(credit_length).timeout
	credit_label.visible = false
	await get_tree().create_timer(0.2).timeout
	
