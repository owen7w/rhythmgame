extends Node2D
var wall_size = 10
var debugMode = 0;

func _ready():
	var level2D = []
	return load_csv(level2D)
	
	
func load_csv(level2D):
	var file = FileAccess.open("res://Level/Level.csv", FileAccess.READ)
	var i = 0;
	var wall = []
	
	while !file.eof_reached():
		var csv = file.get_csv_line() 
		#puts each csv line into wall, which is then put into level2D 2DArray. This function also filters some cases
		
		if (csv.size() <= 1 && i != wall_size): #this is for adding lines if given a wall that isnt the correct size (usually at end)
			for j in range(wall_size - i - 1): #how many rows
				csv = []
				for k in range(wall_size): #making each empty column
					csv.append("")
				wall.append(csv)
				
				if (debugMode):
					print(csv , "\n")
					
		if (csv[0] == "s"): #next section found			
			i = 0
			level2D.append("s")
			
			if (debugMode):
				print("break")
				
				
		
		
		elif (i < wall_size): #building wall
			if (debugMode):
				print(csv , "\n")
			wall.append(csv)
			i = i + 1
			
		if (i >= wall_size): #if get 10 array elms, then it is a whole wall (avoid getting random bits at the end as a wall)
			level2D.append(wall) #put the whole wall array into the 2D level array 
			wall = []
			
			i = 0;
				
	print(level2D)
	return level2D
	file.close()
	
	
		
