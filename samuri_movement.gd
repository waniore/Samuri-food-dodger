extends CharacterBody2D

const SPEED = 400
const JUMP_VELOCITY = -500
const DASH_SPEED = 1500
const DASH_DURATION = 0.15

var can_double_jump = true
var is_dashing = false
var dash_direction = 0.0
var can_dash = true
var play_dash_animation = false
var can_play = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast_left: RayCast2D = $"Raycast left"
@onready var raycast_right: RayCast2D = $"Raycast right"
@onready var dash_timer: Timer = $"Dash Timer"
@onready var dash_cooldown_timer: Timer = $"Dash Cooldown Timer"
@onready var dash_animation_time: Timer = $"Dash animation time"

func play_dash_anim():
	can_play = false
	animated_sprite.play("Dash")
	dash_animation_time.start()

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor() and not is_dashing:
		velocity += get_gravity() * delta

	# Reset double jump when landed
	if is_on_floor():
		can_double_jump = true

	# Jumping
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			
		elif can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false
		
	# Dash trigger
	if Input.is_action_just_pressed("dash") and not is_dashing and can_dash:
		is_dashing = true
		can_dash = false
		play_dash_animation = true
		dash_direction = -1 if animated_sprite.flip_h else 1
		dash_timer.start()
		dash_cooldown_timer.start()
		if can_play:
			play_dash_anim()
			
		

	# Dash movement
	if is_dashing:
		velocity.x = dash_direction * DASH_SPEED
		
	else:
		# Normal movement
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED
			animated_sprite.flip_h = direction < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animation
	if not is_dashing and can_play:
		if is_on_floor():
			if velocity.x != 0:
				animated_sprite.play("Run")
			else:
				animated_sprite.play("Idle")
		else:
			animated_sprite.play("Jump")
	

	
		

	move_and_slide()

func _on_dash_timer_timeout() -> void:
	is_dashing = false
	


func _on_dash_cooldown_timer_timeout() -> void:
	can_dash = true # Replace with function body.






func _on_dash_animation_time_timeout() -> void:
	can_play = true # Replace with function body.
