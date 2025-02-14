extends CanvasLayer

class_name ui

@onready var action_bar_screen = $action_bar_screen

func _on_move_button_pressed() -> void:
	GameManager.GAME_STATES.SHOW_POSSIBLE_MOVES
	print("move_button is pressed")
