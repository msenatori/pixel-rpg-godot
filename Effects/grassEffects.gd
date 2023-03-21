extends Node2D


@onready var animated = $AnimatedSprite2D

func _ready():
	animated.frame = 0
	animated.play("default")


func _on_animated_sprite_2d_animation_finished():
	queue_free()
