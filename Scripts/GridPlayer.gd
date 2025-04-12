extends GridActor
class_name GridPlayer

func beat() -> void:
	pass

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("ui_left")):
		position.x -= 1;
	elif (Input.is_action_just_pressed("ui_right")):
		position.x += 1;
	
	if (Input.is_action_just_pressed("ui_up")):
		position.y += 1;
	elif (Input.is_action_just_pressed("ui_down")):
		position.y -= 1;
	
	super(delta);
