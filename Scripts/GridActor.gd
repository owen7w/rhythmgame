extends Node
class_name GridActor

#reference to the GridManager
var g: GridManager;

#my mesh
var mesh : Mesh;

var meshInstance : MeshInstance3D;

#grid coordinates
var position := Vector3();
var index: int = 0

func _ready() -> void:
	meshInstance = MeshInstance3D.new();
	meshInstance.mesh = mesh;
	add_child(meshInstance);
	meshInstance.global_position = g.getDrawPosition(position);

#when the downbeat happens
func beat() -> void:
	position.z += 1;
	if g.isPlayerColliding(self):
		get_tree().reload_current_scene()
	#var occupant = g.getOccupant(g.player.position)
	#if (occupant == g.player):
		#get_tree().reload_current_scene()
		
	if (position.z >= g.size.z): 
		queue_free();

#put your visual somewhere
func _process(_delta: float) -> void:
	meshInstance.global_position = g.getDrawPosition(position);
