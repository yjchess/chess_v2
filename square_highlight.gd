extends Node2D

@export var x_coord: int
@export var y_coord: int


# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	global_position = Vector2(x_coord*18, y_coord*18)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
