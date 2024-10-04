extends Node
var first_move = true
@onready var board = get_parent().get_parent().get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func calculate_available_moves(piece_type, position):
	var movable_squares = []
	var check_squares = []
	var check_attack_squares = []
	if piece_type == "pawn" || piece_type == "black_pawn":
		var direction
		if piece_type ==      "pawn": direction = +1
		if piece_type =="black_pawn": direction = -1
		
		check_squares.append([position.x, position.y+direction]) 
		if first_move && board.is_empty(board.get_square(position.x, position.y+direction)):
			check_squares.append([position.x, position.y+2*direction])
		
		check_attack_squares.append([position.x-1, position.y+direction])
		check_attack_squares.append([position.x+1, position.y+direction])
		
	if piece_type =="knight" || piece_type == "black_knight":
		print("Checking for Knight")
		check_squares.append([position.x-2, position.y-1])
		check_squares.append([position.x-2, position.y+1])
		
		check_squares.append([position.x+2, position.y-1])
		check_squares.append([position.x+2, position.y+1])
		
		check_squares.append([position.x-1, position.y-2])
		check_squares.append([position.x-1, position.y+2])
		
		check_squares.append([position.x+1, position.y-2])
		check_squares.append([position.x+1, position.y+2])	
		
		check_attack_squares.append([position.x-2, position.y-1])
		check_attack_squares.append([position.x-2, position.y+1])
		
		check_attack_squares.append([position.x+2, position.y-1])
		check_attack_squares.append([position.x+2, position.y+1])
		
		check_attack_squares.append([position.x-1, position.y-2])
		check_attack_squares.append([position.x-1, position.y+2])
		
		check_attack_squares.append([position.x+1, position.y-2])
		check_attack_squares.append([position.x+1, position.y+2])	
	
	var in_bound_squares = []
	if len(check_squares) > 0:
		for square in check_squares:
			if square[0] >= 0 && square[0] <= 7 && square[1] >= 0 && square[1] <=7:
				in_bound_squares.append(square)
				
		for valid_square in in_bound_squares:
			if check_availability(valid_square) == true:
				movable_squares.append(valid_square)

	in_bound_squares = []
	if len(check_attack_squares) > 0:
		for square in check_attack_squares:
			if square[0] >= 0 && square[0] <= 7 && square[1] >= 0 && square[1] <=7:
				in_bound_squares.append(square)
			
		for valid_square in in_bound_squares:
			if check_attackability(piece_type, valid_square) == true:
				movable_squares.append(valid_square)
	
	return movable_squares

func check_availability(square):
	var square_content = board.get_square(square[0], square[1])
	return board.is_empty(square_content)


func check_attackability(piece_type, square):
	return board.is_enemy(piece_type, board.get_square(square[0], square[1]))
