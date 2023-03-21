extends Node2D

var GrassEffect = preload("res://Effects/grassEffects.tscn")


func _create_grass_fx():
	var grassEffects = GrassEffect.instantiate()
	var world = get_tree().current_scene
	world.add_child(grassEffects)
	grassEffects.global_position = global_position

func _on_hurbox_area_entered(area):
	_create_grass_fx()
	queue_free()
