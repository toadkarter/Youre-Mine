extends Node2D

signal text_displayed

const FINAL_PARAGRAPH_SPACING: float = 75.0

@export var scroll_speed: float = 40.0
@export var starting_scroll_position = 400
@export var final_paragraph_finish_position = 150.0

var text_intro_complete: bool = false

@onready var scrolling_text: Label = $CanvasLayer/ScrollingText
@onready var final_paragraph: Label = $CanvasLayer/FinalParagraph
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bgm_player: AudioStreamPlayer2D = $BGMPlayer


func _ready() -> void:
	bgm_player.play()
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
	animation_player.play("final_paragraph_fade_out")
