extends Sprite2D

var board : Array
const CELL_WIDTH = 18
const BOARD_SIZE = 8
#var Piece = preload("res://piece.tscn").instantiate()
@onready var pieces = $Pieces
var displaying_highlights = false
var turn = "white"

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameStats.load_board == true:
		board = GameStats.current_board
		GameStats.load_board = false
	else:
		board.append([null, null, null, null, null, null, null, null])
		board.append([null, null, null, null, null, null, null, null])
		board.append([null, null, null, null, null, null, null, null])
		board.append([null, null, null, null, null, null, null, null])
		board.append([null, null, null, null, null, null, null, null])
		board.append([null, null, null, null, null, null, null, null])
		board.append([null, null, null, null, null, null, null, null])
		board.append([null, null, null, null, null, null, null, null])
		#board.append([-1, -1, -1, -1, -1, -1, -1, -1])
		#board.append([-4, -2, -3, -5, -6, -3, -2, -4])
	
		create_randomised_start(board, "white")
		create_randomised_start(board, "black")
	
	setup_board()

func setup_board():
	for y in BOARD_SIZE:
		for x in BOARD_SIZE:
			match(board[y][x]):
				
				+1: create_piece("pawn",         x, y, +1)
				-1: create_piece("black_pawn",   x, y, -1)
				
				+4: create_piece("rook",         x, y, +4)
				-4: create_piece("black_rook",   x, y, -4)
				
				+2: create_piece("knight",       x, y, +2)
				-2: create_piece("black_knight", x, y, -2)
				
				+3: create_piece("bishop",       x, y, +3)
				-3: create_piece("black_bishop", x, y, -3)
				
				+5: create_piece("queen",        x, y, +5)
				-5: create_piece("black_queen",  x, y, -5)

				+6: create_piece("king",         x, y, +6)
				-6: create_piece("black_king",   x, y, -6)
	
	#print(board)
				
func create_piece(piece_name, x, y, piece_num):
	var piece = Piece.new_piece(piece_name, x, y, piece_num)
	pieces.add_child(piece)
	#board[y][x] = piece
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
		if type_to_check < 0 && "black" in self_type || type_to_check > 0 && "black" not in self_type:
			return false
		else:
			return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func display_available_moves(available_moves):

	for move in available_moves:
		display_available_move(move)
		
		
func display_available_move(move):
	var highlighted_square_scene = preload("res://square_highlight.tscn")
	var instance = highlighted_square_scene.instantiate()
	instance.x_coord = move[0]
	instance.y_coord = -move[1]
	add_child(instance)


func create_randomised_start(board, colour):
	var points_total = 0
	var empty_spots = []
	var filled_spots = []
	var piece_colour
	
	if colour == "white":
		piece_colour = 1
		for i in range(0, 3):
			for j in range (0,8):
				empty_spots.append([i,j])
		
		#add the king
		empty_spots.remove_at(4)
		filled_spots.append([0,4,6])
	
	else:
		piece_colour = -1
		for i in range(5,8):
			for j in range (0,8):
				empty_spots.append([i,j])
		
		#add the king
		empty_spots.remove_at(20)
		filled_spots.append([7,4,-6])
	
	#print(empty_spots)
	
	
	#filled_spots.append([x_coord, y_coord, piece_type])
	#print(empty_spots)
	
	var rng = RandomNumberGenerator.new()	
	
	#place queen on a random square:
	var queen_square = rng.randi_range(0, len(empty_spots)-1)
	var queen_array = empty_spots[queen_square]
	queen_array.append(5*piece_colour)
	filled_spots.append(queen_array)
	points_total += 9
	#print(len(empty_spots))
	empty_spots.remove_at(queen_square)
	#print(len(empty_spots))
		
	while points_total < 35:
		#print(empty_spots)
		var piece
		var index = rng.randi_range(0, len(empty_spots)-1)
		if empty_spots[index][0] == 0:
			piece = rng.randi_range(2, 4) * piece_colour
		else:
			#give the pawn a 50 percent chance to be spawned
			var pawn_spawn = rng.randi_range(0,1)
			if pawn_spawn == 1:
				piece = 1*piece_colour
			else:
				piece = rng.randi_range(2, 4) * piece_colour
		
		var piece_array = empty_spots[index]
		piece_array.append(piece)
		filled_spots.append(piece_array)
		empty_spots.remove_at(index)

		
		match piece:
			+1: points_total += 1
			-1: points_total += 1
			
			+2: points_total += 3
			-2: points_total += 3
			
			+3: points_total += 3
			-3: points_total += 3
			
			+4: points_total += 5
			-4: points_total += 5
			
			+5: points_total += 9
			-5: points_total += 9
	
	while points_total < 40:
		#if len(empty_spots) == 0:
		#	print(filled_spots)
		#print(len(empty_spots))
		var piece
		match points_total:
			39: piece = 1 * piece_colour
			38: piece = 1 * piece_colour
			37: piece = rng.randi_range(1,3) * piece_colour
			36: piece = rng.randi_range(1,3) * piece_colour
			35: piece = rng.randi_range(1,4) * piece_colour
		
		var index = rng.randi_range(0, len(empty_spots)-1)		
		var piece_array = empty_spots[index]
		piece_array.append(piece)
		filled_spots.append(piece_array)
		empty_spots.remove_at(index)
		
		match piece:
			+1: points_total += 1
			-1: points_total += 1
			
			+2: points_total += 3
			-2: points_total += 3
			
			+3: points_total += 3
			-3: points_total += 3
			
			+4: points_total += 5
			-4: points_total += 5
		
	#print(filled_spots)
	#print(empty_spots)
	#print(points_total)
	
	for piece in filled_spots:
		board[piece[0]][piece[1]] = piece[2]

func enlarge_board():
	scale.x = 1.5
	scale.y = 1.5

func normalize_board():
	scale.x = 1
	scale.y = 1

func select_board(viewport, event, shape_idx):
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		GameStats.current_board = board
		GameStats.load_board = true
		get_tree().change_scene_to_file("res://main.tscn")


func move(old_x, old_y, new_x, new_y):
	
	var selected_piece = board[old_x][old_y]
	print(old_x, old_y, new_x, new_y)
	for piece in pieces.get_children():
		if piece.x_coord == new_x && piece.y_coord == new_y:
			piece.queue_free()
			
	board[new_x][new_y] = selected_piece
	board[old_x][old_y] = null
	

	
