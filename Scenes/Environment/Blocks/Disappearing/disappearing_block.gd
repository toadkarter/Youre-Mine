extends StaticBody2D

@export var seconds_before_start: float = 0.0
@export var seconds_between_toggle: float = 5.0
@export var start_visible: bool = true

@onready var collider: CollisionShape2D = $Collider
@onready var timer: Timer = $Timer


func _ready():
	if not start_visible:
		_toggle()
	
	await get_tree().create_timer(seconds_before_start).timeout
	timer.wait_time = seconds_between_toggle
	timer.connect("timeout", _on_timeout)
	timer.start()
	
	
func _on_timeout():
	_toggle()
	
	
func _toggle():
	visible = !visible
	collider.disabled = !collider.disabled
