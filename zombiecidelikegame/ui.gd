extends CanvasLayer

class_name ui

@onready var action_bar_screen = $action_bar_screen

func _on_move_button_pressed() -> void:
	#get_tree().call_group("Global", "set_game_state", "SHOW_POSSIBLE_MOVES")
	get_tree().call_group("Global", "toggleShowPossibleMoves")
	print("move_button is pressed")
