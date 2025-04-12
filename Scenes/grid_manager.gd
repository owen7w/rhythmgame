@tool
extends Node3D

@export var reload := false:
	set(ignore):
		reload = false;
		create_grid()
		
@export var rows: int
@export var cols: int
# how far along the grid goes on the z-axis
@export var depth: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_grid()
	
		
			
			
		
func create_grid():
	var marker: Marker3D
	for row in rows:
		var new_row: Node3D = Node3D.new()
		$Grid.add_child(new_row)
		new_row.name = "row_" + str(row + 1)
		for col in cols:
			for i in depth:
				marker = Marker3D.new()
				new_row.add_child(marker)
				marker.global_position += Vector3(row, col, i)
				print(marker.global_position)
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
