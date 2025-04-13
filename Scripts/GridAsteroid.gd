extends GridActor
class_name GridAsteroid


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mesh = g.meshes["asteroid"];
	super();
	
	
