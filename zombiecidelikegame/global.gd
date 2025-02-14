extends Node3D

const player_scene = preload("res://player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var playerInstance = player_scene.instantiate()
	playerInstance.position = Vector3i(1,2,4)
	#add_child(playerInstance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
