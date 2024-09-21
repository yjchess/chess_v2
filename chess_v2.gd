extends Sprite2D

var board : Array
const CELL_WIDTH = 18
const BOARD_SIZE = 8
#var Piece = preload("res://piece.tscn").instantiate()
@onready var pieces = $Pieces

# Called when the node enters the scene tree for the first time.
func _ready():
	board.append([4, 2, 3, 5, 6, 3, 2, 4])
	board.append([1, 1, 1, 1, 1, 1, 1, 1])
	board.append([null, null, null, null, null, null, null, null])
	board.append([null, null, null, null, null, null, null, null])
	board.append([null, null, null, null, null, null, null, null])
	board.append([null, null, null, null, null, null, null, null])
	board.append([-1, -1, -1, -1, -1, -1, -1, -1])
	board.append([-4, -2, -3, -5, -6, -3, -2, -4])
	
	setup_board()

func setup_board():
	for y in BOARD_SIZE:
		for x in BOARD_SIZE:
			match(board[y][x]):
				
				+1: create_piece("pawn",         x, y)
				-1: create_piece("black_pawn",   x, y)
				
				+4: create_piece("rook",         x, y)
				-4: create_piece("black_rook",   x, y)
				
				+2: create_piece("knight",       x, y)
				-2: create_piece("black_knight", x, y)
				
				+3: create_piece("bishop",       x, y)
				-3: create_piece("black_bishop", x, y)
				
				+5: create_piece("queen",        x, y)
				-5: create_piece("black_queen",  x, y)

				+6: create_piece("king",         x, y)
				-6: create_piece("black_king",   x, y)
	
	#print(board)
				
func create_piece(piece_name, x, y):
	var piece = Piece.new_piece(piece_name, x, y)
	pieces.add_child(piece)
	board[y][x] = piece
	#holder.global_position = Vector2(x * CELL_WIDTH + (CELL_WIDTH / 2), -y * CELL_WIDTH - (CELL_WIDTH / 2))
	
func get_square(x, y):
	return board[y][x]

func is_empty(value):
	#print(value)
	if value == null:
		return true
	else:
		return false

func is_enemy(self_type, type_to_check):
	
	if type_to_check != null:
		if "black" in type_to_check.type && "black" in self_type || "black" not in type_to_check.type && "black" not in self_type:
			return false
		else:
			return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
