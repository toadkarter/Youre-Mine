extends Node2D
class_name Intro

signal finished

const FINAL_PARAGRAPH_SPACING: float = 75.0

@export var scroll_speed: float = 40.0
@export var starting_scroll_position = 400
@export var final_paragraph_finish_position = 150.0
@export var seconds_before_game_loop = 3.0

var text_intro_complete: bool = false

@onready var scrolling_text: Label = $CanvasLayer/ScrollingText
@onready var final_paragraph: Label = $CanvasLayer/FinalParagraph
@onready var stinger_background: ColorRect = $CanvasLayer/StingerBackground
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bgm_player: AudioStreamPlayer2D = $BGMPlayer
@onready var sfx_player: AudioStreamPlayer2D = $SFXPlayer


func _ready() -> void:
	bgm_player.play()
	stinger_background.visible = false
	scrolling_text.position.y = starting_scroll_position
	final_paragraph.position.y = starting_scroll_position + scrolling_text.size.y + FINAL_PARAGRAPH_SPACING


func _process(delta: float) -> void:
	if text_intro_complete:
		return
	
	scrolling_text.position.y -= scroll_speed * delta
	if final_paragraph.position.y >= final_paragraph_finish_position:
		final_paragraph.position.y -= scroll_speed * delta
		
	if scrolling_text.position.y <= -scrolling_text.size.y:
		text_intro_complete = true
		
	if text_intro_complete:
		_start_intro_stinger()


func _start_intro_stinger() -> void:
	var final_paragraph_animation_length: float = animation_player.get_animation("final_paragraph_fade_out").length
	animation_player.play("final_paragraph_fade_out")
	await get_tree().create_timer(final_paragraph_animation_length).timeout
	bgm_player.stop()
	sfx_player.play()
	stinger_background.visible = true
	await get_tree().create_timer(seconds_before_game_loop).timeout
	var stinger_fade_out_length: float = animation_player.get_animation("stinger_fade_out").length
	animation_player.play("stinger_fade_out")
	await get_tree().create_timer(stinger_fade_out_length).timeout
	finished.emit()
	
	
	
