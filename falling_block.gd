extends StaticBody2D

@onready var area_2d: Area2D = $Area2D
@onready var timer: Timer = $Area2D/Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var animations = ["donut 1", "donut 2", "donut 3", "candy"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play(animations.pick_random()) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 150 * delta
	


func _on_area_2d_body_entered(_body: Node2D) -> void:
	timer.start()
	# Replace with function body.



func _on_timer_timeout() -> void:
	get_tree().reload_current_scene() # Replace with function body.
