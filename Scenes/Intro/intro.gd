extends Node2D

const FINAL_PARAGRAPH_SPACING: float = 75.0

@export var scroll_speed: float = 40.0
@export var starting_scroll_position = 400
@export var final_paragraph_finish_position = 150.0

@onready var scrolling_text: Label = $CanvasLayer/ScrollingText
@onready var final_paragraph: Label = $CanvasLayer/FinalParagraph


func _ready() -> void:
	scrolling_text.position.y = starting_scroll_position
	final_paragraph.position.y = starting_scroll_position + scrolling_text.size.y + FINAL_PARAGRAPH_SPACING


func _process(delta: float) -> void:
	scrolling_text.position.y -= scroll_speed * delta
	if final_paragraph.position.y >= final_paragraph_finish_position:
		final_paragraph.position.y -= scroll_speed * delta
	print(final_paragraph.position.y)
