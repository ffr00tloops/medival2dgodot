extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("up")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	var is_attacking = false

	if velocity. y < 0:
		$AnimatedSprite2D.play("up")
	elif velocity. y > 0:
		$AnimatedSprite2D.play("fall")
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("walk")
		$AnimatedSprite2D.flip_h = true
	elif Input.is_action_pressed("attack1") and not is_attacking:
		is_attacking = true
		$AnimatedSprite2D.play("slash")
	else:
		$AnimatedSprite2D.play("idle")
