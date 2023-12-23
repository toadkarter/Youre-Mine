extends StaticBody2D

@export var seconds_before_start: float = 0.0
@export var seconds_between_toggle: float = 5.0

@onready var collider: CollisionShape2D = $Collider
@onready var timer: Timer = $Timer


func _ready():
	await get_tree().create_timer(seconds_before_start).timeout
	timer.wait_time = seconds_between_toggle
	timer.connect("timeout", _on_timeout)
	timer.start()
	
	
func _on_timeout():
	visible = !visible
	collider.disabled = !collider.disabled
