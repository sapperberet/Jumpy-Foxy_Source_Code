extends Node2D


var Cherry =preload("res://frog.tscn")


func _on_timer_timeout():
	var cherryTemp = Cherry.instantiate()
	var rng = RandomNumberGenerator.new()
	var ranint = rng.randi_range(30,1300)
	cherryTemp.position = Vector2(ranint, 400)
	get_node("CherrySpawn").add_child(cherryTemp)
