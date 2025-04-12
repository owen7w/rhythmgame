@tool
extends Node3D
class_name GridManager

@export var size := Vector3():
	set(val):
		size = val;
		create_grid();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_grid()

	if not Engine.is_editor_hint():
		var p := GridPlayer.new();
		p.position = Vector3(size.x/2, size.y/2, size.z);
		p.mesh = BoxMesh.new();
		p.g = self;
		add_child(p);

func create_grid():
	position.x = -(size.x/2.0);
	position.y = -(size.y/2.0);
	position.z = -size.z;
	
	for child in get_children():
		if child is MeshInstance3D:
			child.free();
	var mesh1 := BoxMesh.new();
	mesh1.size = Vector3(0.2,0.02,0.02);
	var mesh2 := BoxMesh.new();
	mesh2.size = Vector3(0.02,0.2,0.02);
	var mesh3 := BoxMesh.new();
	mesh3.size = Vector3(0.02,0.02,0.2);
	for row in size.x+1:
		for col in size.y+1:
			for i in size.z+1:
				var marker := MeshInstance3D.new()
				marker.mesh = mesh1
				marker.position = Vector3(row, col, i)
				add_child(marker);
				marker = MeshInstance3D.new()
				marker.mesh = mesh2
				marker.position = Vector3(row, col, i)
				add_child(marker);
				marker = MeshInstance3D.new()
				marker.mesh = mesh3
				marker.position = Vector3(row, col, i)
				add_child(marker);


#get the center of a cell based on cell coords
func getDrawPosition(c: Vector3) -> Vector3:
	return global_position + c - Vector3(0,0,0.5);

#get the GridActor that occupies a given cell
func getOccupant(c: Vector3) -> GridActor:
	for child in get_children():
		if child is GridActor:
			if child.position == c:
				return child;
	return null;

func step():
	#tell each actor that the beat happened
	
	#spawn new grid actors according to the level reader
	pass
