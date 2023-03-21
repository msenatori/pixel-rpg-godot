extends CharacterBody2D

enum {
	MOVE, 
	ROLL,
	ATTACK
}

@export var acceleration = 500
@export var max_speed = 80
@export var friction = 500

@onready var animationPlayer = $Animation
@onready var animationTree = $AnimatorTree
@onready var animationState = animationTree.get("parameters/playback")

var state = MOVE


func _ready():
	velocity = Vector2.ZERO
	animationTree.active = true


func _physics_process(delta):
	match state:
		MOVE: 
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state(delta)


func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel('Attack')


func move_state(delta):
	var input_vector = Vector2(
		Input.get_action_strength("rigth") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength('up')
	)

	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attac_animation_finished():
	state = MOVE
