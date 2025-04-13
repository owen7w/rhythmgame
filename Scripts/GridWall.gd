extends GridActor
class_name GridWall

func _ready() -> void:
	print("hello")
	mesh = g.meshes["wall"];
	super();
