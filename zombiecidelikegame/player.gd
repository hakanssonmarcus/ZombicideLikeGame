extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var mouse_sensitivity := 0.001
var horizontal_input := 0.0
var vertical_input := 0.0

@onready var horizontal_pivot := $HorizontalPivot
@onready var vertical_pivot := $HorizontalPivot/VerticalPivot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	velocity.y += -gravity * delta
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var input := Vector3.ZERO
	#input.x = Input.get_axis("move_left", "move_right")
	#input.z = Input.get_axis("move_forward", "move_back")
	
	#apply_central_force(input * 1200.0 * delta)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	horizontal_pivot.rotate_y(horizontal_input)
	vertical_pivot.rotate_x(vertical_input)
	vertical_pivot.rotation.x = clamp(vertical_pivot.rotation.x,
		deg_to_rad(-30),
		deg_to_rad(0)
	)
	horizontal_input = 0.0
	vertical_input = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			horizontal_input = - event.relative.x * mouse_sensitivity
			vertical_input = - event.relative.y * mouse_sensitivity
