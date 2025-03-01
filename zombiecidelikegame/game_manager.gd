extends Node3D

class_name GameManager

const ui_scene = preload("res://ui.tscn")

var uiInstance = ui_scene.instantiate()

const GAME_STATES = {
	RUNNING = "RUNNING",
	PAUSED = "PAUSED",
	NOT_STARTED = "NOT_STARTED",
	SHOW_POSSIBLE_MOVES = "SHOW_POSSIBLE_MOVES"
}

@export
var GAME_STATE = "NOT_STARTED"

var isActionBarVisible := false
var isPossibleMovesVisible := false

func get_game_state() -> String:
	return GAME_STATE

func set_game_state(state: String) -> void:
	print("Set game state to: ", state)
	GAME_STATE = state

func toggleShowPossibleMoves() -> void:
	if GAME_STATE != GAME_STATES.SHOW_POSSIBLE_MOVES:
		set_game_state(GAME_STATES.SHOW_POSSIBLE_MOVES)
		get_tree().call_group("GridMap", "highlight_tiles")
	else:
		set_game_state(GAME_STATES.RUNNING)
		get_tree().call_group("GridMap", "remove_highlight_tiles")
	
func toggleActionBarHandler() -> void:
	if Input.is_action_just_pressed("open_action_bar"):
		if isActionBarVisible:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			uiInstance.hide()
			isActionBarVisible = !isActionBarVisible
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			uiInstance.show()
			isActionBarVisible = !isActionBarVisible
			
func possibleMovesHandler() -> void:
	if GAME_STATE == "SHOW_POSSIBLE_MOVES":
		if isPossibleMovesVisible:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			uiInstance.hide()
			isPossibleMovesVisible = !isPossibleMovesVisible
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			uiInstance.show()
			isPossibleMovesVisible = !isPossibleMovesVisible
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_game_state(GAME_STATES.RUNNING)
	add_child(uiInstance)
	uiInstance.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	toggleActionBarHandler()
