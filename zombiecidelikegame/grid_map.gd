extends GridMap

const player_scene = preload("res://player.tscn")
const zombie_scene = preload("res://zombie.tscn")

const GRID_OFFSET = Vector3i(1,0,1)

var PLAYER_START_POSTION := setGamePositionToGridMapPosition(Vector3i(1,1,5))
var ZOMBIE_START_POSTION := setGamePositionToGridMapPosition(Vector3i(2,1,1))

var PLAYER_CURRENT_GRIDMAP_POSITION := PLAYER_START_POSTION

var PLAYER_CURRENT_GAME_POSITION := getGamePositionByGridMapPosition(PLAYER_CURRENT_GRIDMAP_POSITION)

func setGamePositionToGridMapPosition(gamePosition: Vector3i) -> Vector3i:
	gamePosition.x = gamePosition.x * 2 - GRID_OFFSET.x
	gamePosition.z = gamePosition.z * 2 - GRID_OFFSET.z
	return gamePosition
	
func getGamePositionByGridMapPosition(gamePosition: Vector3i) -> Vector3i:
	gamePosition.x = (gamePosition.x + GRID_OFFSET.x) / 2
	gamePosition.y = 0
	gamePosition.z = (gamePosition.z + GRID_OFFSET.z) / 2
	return gamePosition

func update_player_position(gamePosition: Vector3i) -> void:
	PLAYER_CURRENT_GRIDMAP_POSITION = setGamePositionToGridMapPosition(gamePosition)

func highlight_tiles() -> void:
	print("players current game position: ", PLAYER_CURRENT_GAME_POSITION)
	var cells = get_used_cells()
	var leftZoneOfPlayerPosition = PLAYER_CURRENT_GAME_POSITION - Vector3i(1,0,0)
	var rightZoneOfPlayerPosition = PLAYER_CURRENT_GAME_POSITION + Vector3i(1,0,0)
	var norhtZoneOfPlayerPosition = PLAYER_CURRENT_GAME_POSITION - Vector3i(0,0,1)
	var southZoneOfPlayerPosition = PLAYER_CURRENT_GAME_POSITION + Vector3i(0,0,1)
	
	var lefZoneCellOfPlayerPosition = leftZoneOfPlayerPosition - GRID_OFFSET
	var rightZoneCellOfPlayerPosition = rightZoneOfPlayerPosition - GRID_OFFSET
	var norhtZoneCellOfPlayerPosition = norhtZoneOfPlayerPosition - GRID_OFFSET
	var southZoneCellOfPlayerPosition = southZoneOfPlayerPosition - GRID_OFFSET
	
	#print("leftZoneOfPlayerPosition: ", leftZoneOfPlayerPosition)
	print("rightZoneOfPlayerPosition: ", rightZoneOfPlayerPosition)
	print("gridmap right cell: ", setGamePositionToGridMapPosition(rightZoneOfPlayerPosition))
	#print("norhtZoneOfPlayerPosition: ", norhtZoneOfPlayerPosition)
	#print("southZoneOfPlayerPosition: ", southZoneOfPlayerPosition)

	var leftCellItem = get_cell_item(lefZoneCellOfPlayerPosition)
	var rightCellItem = get_cell_item(rightZoneCellOfPlayerPosition)
	var northCellItem = get_cell_item(norhtZoneCellOfPlayerPosition)
	var southCellItem = get_cell_item(southZoneCellOfPlayerPosition)
	
	if leftCellItem == 0:
		set_cell_item(lefZoneCellOfPlayerPosition, 2, 0)
	
	if rightCellItem == 0:
		set_cell_item(rightZoneCellOfPlayerPosition, 2, 0)
	
	if northCellItem == 0:
		set_cell_item(norhtZoneCellOfPlayerPosition, 2, 0)
	
	if southCellItem == 0:
		set_cell_item(southZoneCellOfPlayerPosition, 2, 0)
		

func remove_highlight_tiles() -> void:
	var highlightedCells = get_used_cells_by_item(2)
	for cell in highlightedCells:
		print(cell)
		set_cell_item(cell, 0)


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
