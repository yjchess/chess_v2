extends Node2D

@export var x_coord: int
@export var y_coord: int
@onready var parent_piece = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	#print(parent_piece)
	set_as_top_level(true)
	global_position = Vector2(x_coord*18, -y_coord*18)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		print("Mouse Event")

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("Clicked Highlight")
		parent_piece.move(x_coord, y_coord)
