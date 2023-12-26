extends Node2D

@export var scroll_speed: float = 40.0
@export var starting_scroll_position = 400

@onready var scrolling_text: Label = $CanvasLayer/ScrollingText


func _ready():
	scrolling_text.position.y = starting_scroll_position


func _process(delta):
	scrolling_text.position.y -= scroll_speed * delta
