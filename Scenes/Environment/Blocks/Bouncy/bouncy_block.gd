extends RigidBody2D

@export var bounce_height: float = 300.0

@onready var hitbox: Area2D = $Hitbox

func _ready():
	hitbox.connect("body_entered", _on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Bounce:
		linear_velocity.y -= bounce_height
		
