extends Sprite2D
@export var white = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if white == false:
		texture = load(texture.resource_path.replace("white","black"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
