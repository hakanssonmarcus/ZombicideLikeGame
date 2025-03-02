extends GridMap

const player_scene = preload("res://player.tscn")
const zombie_scene = preload("res://zombie.tscn")

var PLAYER_START_POSTION := map_to_local(Vector3i(0,0,4))
var ZOMBIE_START_POSTION := map_to_local(Vector3i(1,0,0))

var PLAYER_CURRENT_POSITION := PLAYER_START_POSTION

#TODO: Move func to Player scene
func update_player_position(position: Vector3i) -> void:
	var localPos = map_to_local(position)
	PLAYER_CURRENT_POSITION = localPos
	var playerInstance = get_child(0)
	playerInstance.position = Vector3(localPos.x, localPos.y + 1, localPos.z)

func highlight_tiles() -> void:
	var leftZoneOfPlayerPosition = local_to_map(PLAYER_CURRENT_POSITION) - Vector3i(1,0,0)
	var rightZoneOfPlayerPosition = local_to_map(PLAYER_CURRENT_POSITION) + Vector3i(1,0,0)
	var norhtZoneOfPlayerPosition = local_to_map(PLAYER_CURRENT_POSITION) - Vector3i(0,0,1)
	var southZoneOfPlayerPosition = local_to_map(PLAYER_CURRENT_POSITION) + Vector3i(0,0,1)

	var leftCellItem = get_cell_item(leftZoneOfPlayerPosition)
	var rightCellItem = get_cell_item(rightZoneOfPlayerPosition)
	var northCellItem = get_cell_item(norhtZoneOfPlayerPosition)
	var southCellItem = get_cell_item(southZoneOfPlayerPosition)
	
	#TODO: Add more complex check if zone should be highlighted
	if leftCellItem == 0:
		set_cell_item(leftZoneOfPlayerPosition, 2, 0)
	
	if rightCellItem == 0:
		set_cell_item(rightZoneOfPlayerPosition, 2, 0)
	
	if northCellItem == 0:
		set_cell_item(norhtZoneOfPlayerPosition, 2, 0)
	
	if southCellItem == 0:
		set_cell_item(southZoneOfPlayerPosition, 2, 0)
		

func remove_highlight_tiles() -> void:
	var highlightedCells = get_used_cells_by_item(2)
	for cell in highlightedCells:
		print(cell)
		set_cell_item(cell, 0)

func get_mouse_hit_pos():
	const RAY_LENGTH = 1000
	var space_state = get_world_3d().direct_space_state
	var cam: Camera3D = get_viewport().get_camera_3d()
	var mousepos = get_viewport().get_mouse_position()

	var origin = cam.project_ray_origin(mousepos)
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	if result:
		return result.position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var playerInstance = player_scene.instantiate()
	var zombieInstance = zombie_scene.instantiate()
	
	playerInstance.position = Vector3(PLAYER_START_POSTION.x, PLAYER_START_POSTION.y + 1, PLAYER_START_POSTION.z)
	zombieInstance.position = Vector3(ZOMBIE_START_POSTION.x, ZOMBIE_START_POSTION.y + 1, ZOMBIE_START_POSTION.z)
	
	add_child(playerInstance)
	add_child(zombieInstance)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed == true:
			var elementPosHitByMouse = get_mouse_hit_pos()
			if elementPosHitByMouse:
				var clickedElem = get_cell_item(local_to_map(elementPosHitByMouse))
				if clickedElem == 2:
					update_player_position(local_to_map(elementPosHitByMouse))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	pass
