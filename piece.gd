class_name Piece
extends Node2D


var type: String
var x_coord: int
var y_coord: int
const CELL_WIDTH = 18
const BOARD_SIZE = 8
@onready var Moves_Node = $Moves

static func new_piece(type:String, x_coord:int, y_coord:int):
	var texture
	var my_scene: PackedScene = load("res://piece.tscn")
	var new_piece: Piece = my_scene.instantiate()
	new_piece.type = type
	new_piece.x_coord = x_coord
	new_piece.y_coord = y_coord
	new_piece.global_position = Vector2(x_coord * CELL_WIDTH + (CELL_WIDTH / 2), -y_coord * CELL_WIDTH - (CELL_WIDTH / 2))
	match type:
		"pawn": new_piece.get_child(0).texture = preload("res://Assets/white_pawn.png")
		"black_pawn": 
			new_piece.get_child(0).texture = preload("res://Assets/white_pawn.png")
			new_piece.get_child(0).white = false
			
		"rook": new_piece.get_child(0).texture = preload("res://Assets/white_rook.png")
		"black_rook":
			new_piece.get_child(0).texture = preload("res://Assets/white_rook.png")
			new_piece.get_child(0).white = false
		
		"knight": new_piece.get_child(0).texture = preload("res://Assets/white_knight.png")
		"black_knight": 
			new_piece.get_child(0).texture = preload("res://Assets/white_knight.png")
			new_piece.get_child(0).white = false
			
		"bishop": new_piece.get_child(0).texture = preload("res://Assets/white_bishop.png")
		"black_bishop": 
			new_piece.get_child(0).texture = preload("res://Assets/white_bishop.png")
			new_piece.get_child(0).white = false
		
		"queen": new_piece.get_child(0).texture = preload("res://Assets/white_queen.png")
		"black_queen": 
			new_piece.get_child(0).texture = preload("res://Assets/white_queen.png")
			new_piece.get_child(0).white = false
		
		"king": new_piece.get_child(0).texture = preload("res://Assets/white_king.png")
		"black_king": 
			new_piece.get_child(0).texture = preload("res://Assets/white_king.png")
			new_piece.get_child(0).white = false
		
	return new_piece

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_2d_mouse_entered():
	#print("Mouse Entered")
	get_child(0).set_self_modulate(Color(.50, .50, .60, 1))
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	#print("Mouse Left")
	get_child(0).set_self_modulate(Color(1, 1, 1, 1))
	pass # Replace with function body.


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("Mouse clicked")
		print(Moves_Node.calculate_available_moves(Vector2(x_coord, y_coord)))
	pass # Replace with function body.