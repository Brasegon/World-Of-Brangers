extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var playerClass = preload("res://Scenes/Player/Player.tscn");
	var playerInstance = playerClass.instance();
	playerInstance.init();
	add_child(playerInstance);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
