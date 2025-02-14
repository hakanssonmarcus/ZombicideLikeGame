extends GridMap

const player_scene = preload("res://player.tscn")
const zombie_scene = preload("res://zombie.tscn")

const PLAYER_START_POSTION := Vector3i(1,1,5)
const ZOMBIE_START_POSTION := Vector3i(3,1,1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var playerInstance = player_scene.instantiate()
	var zombieInstance = zombie_scene.instantiate()
	
	playerInstance.position = PLAYER_START_POSTION
	zombieInstance.position = ZOMBIE_START_POSTION
	
	add_child(playerInstance)
	add_child(zombieInstance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
