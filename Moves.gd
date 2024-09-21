extends Node2D
#@onready var position = $"..".get_position
@export_range(0,7,1) var horizontal_movement_range = 0
@export_range(0,7,1) var vertical_movement_range = 1
@export_range(0,7,1) var diagonal_movement_range = 0
@onready var board = get_parent().get_parent().get_parent()
@onready var piece = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(board.name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func calculate_available_moves(self_position):
	var movable_squares = []
	print(self_position.x, horizontal_movement_range)
	#horizontal check
	if horizontal_movement_range != 0:
		
		var horizontal_negative_extreme = max(0, self_position.x - horizontal_movement_range)
		var horizontal_positive_extreme = min(7, self_position.x + horizontal_movement_range)
		
		if self_position.x != 7: 
			var available_squares = check_squares(self_position.x+1, horizontal_positive_extreme, "horizontal", self_position)
			for square in available_squares:
				movable_squares.append(square)
			#movable_squares.append(check_squares(self_position.x+1, horizontal_positive_extreme, "horizontal", self_position))				
		if self_position.x != 0:
			var available_squares = check_squares(self_position.x-1, horizontal_positive_extreme, "horizontal", self_position)
			for square in available_squares:
				movable_squares.append(square) 
			#movable_squares.append(check_squares(self_position.x-1, horizontal_negative_extreme, "horizontal", self_position))
	
	#vertical check
	if vertical_movement_range != 0:
		var vertical_positive_extreme = max(self_position.y + vertical_movement_range, 7)
		var vertical_negative_extreme = min(self_position.y - vertical_movement_range, 0)
	
		if self_position.y != 7: 
			var available_squares = check_squares(self_position.y+1, vertical_positive_extreme, "vertical", self_position)
			for square in available_squares:
				movable_squares.append(square)
					
		if self_position.y != 0: 
			var available_squares = check_squares(self_position.y-1, vertical_positive_extreme, "vertical", self_position)
			for square in available_squares:
				movable_squares.append(square)
		
	#diagonal check
	if diagonal_movement_range != 0:
		
		#in this case - ascending does not refer to increasing but instead the direction i.e. asciending = / shape, descending = \ shape
		var diagonal_ascending_positive_extreme = min(7, self_position.x + diagonal_movement_range)
		var diagonal_ascending_negative_extreme = max(0, self_position.x - diagonal_movement_range)
		
		if self_position.y != 7:
			var available_squares = check_squares(self_position.x+1, diagonal_ascending_positive_extreme, "diagonal_right_up", self_position)
			for square in available_squares:
				movable_squares.append(square)

		if self_position.y != 0: 
			var available_squares = check_squares(self_position.x-1, diagonal_ascending_negative_extreme, "diagonal_right_up", self_position)
			for square in available_squares:
				movable_squares.append(square)
		
		var diagonal_descending_negative_extreme = min(7, self_position.x + diagonal_movement_range) #top left
		var diagonal_descending_positive_extreme = max(0, self_position.x - diagonal_movement_range) #bottom right
		
		if self_position.y != 0: 
			var available_squares = check_squares(self_position.x+1, diagonal_descending_negative_extreme, "diagonal_left_up", self_position)
			for square in available_squares:
				movable_squares.append(square)

		if self_position.y != 7: 
			var available_squares = check_squares(self_position.x-1, diagonal_descending_positive_extreme, "diagonal_left_up", self_position)
			for square in available_squares:
				movable_squares.append(square)
	

	return movable_squares
	
	
#Helper functions
func check_squares(start_position, end_position, direction, self_position):
	var movable_squares = []
	
	if direction == "vertical":
		for y_coord in range(start_position, end_position):
			if    board.is_empty(board.get_square(self_position.x, y_coord)): movable_squares.append([self_position.x, y_coord])
			elif  board.is_enemy(piece.type, board.get_square(self_position.x, y_coord)): movable_squares.append([self_position.x, y_coord]); break
			else: break
	
	if direction == "horizontal":
		for x_coord in range(start_position, end_position):
			if    board.is_empty(board.get_square(x_coord, self_position.y)): movable_squares.append([x_coord, self_position.y])
			elif  board.is_enemy(piece.type, board.get_square(x_coord, self_position.y)): movable_squares.append([x_coord, self_position.y]); break
			else: break
	
	if direction == "diagonal_right_up":
		var y_increment = 0
		for x_coord in range(start_position, end_position):
						
			if end_position > self_position.x: y_increment += 1
			elif end_position < self_position.x: y_increment -= 1
			
			if self_position.y + y_increment > 7 || self_position.y + y_increment < 0: break
			
			if    board.is_empty(board.get_square(x_coord, self_position.y + y_increment)): movable_squares.append([x_coord, self_position.y + y_increment])
			elif  board.is_enemy(piece.type, board.get_square(x_coord, self_position.y + y_increment)): movable_squares.append([x_coord, self_position.y + y_increment]); break
			else: break

	if direction == "diagonal_left_up":
		var y_increment = 0
		for x_coord in range(start_position, end_position):
			
			if end_position > self_position.x: y_increment += 1
			elif end_position < self_position.x: y_increment -= 1
			
			if self_position.y + y_increment > 7 || self_position.y + y_increment < 0: break
			
			if    board.is_empty(board.get_square(x_coord, self_position.y + y_increment)): movable_squares.append([x_coord, self_position.y + y_increment])
			elif  board.is_enemy(piece.type, board.get_square(x_coord, self_position.y + y_increment)): movable_squares.append([x_coord, self_position.y + y_increment]); break
			else: break
	
	return movable_squares

