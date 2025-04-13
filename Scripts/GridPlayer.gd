extends GridActor
class_name GridPlayer

signal moved(Vector3)

func beat() -> void:
	pass

func _process(delta: float) -> void:
	var moved_now := false;
	if (Input.is_action_just_pressed("ui_left")):
		position.x -= 1;
		moved_now = true;
	elif (Input.is_action_just_pressed("ui_right")):
		position.x += 1;
		moved_now = true;
	
	if (Input.is_action_just_pressed("ui_up")):
		position.y += 1;
		moved_now = true;
	elif (Input.is_action_just_pressed("ui_down")):
		position.y -= 1;
		moved_now = true;
	
	if (moved_now): moved.emit(position)
	
	super(delta);
