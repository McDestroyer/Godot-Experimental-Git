extends Node

var touch := false
var movement := movement_types.ORBIT
var sensitivity := 1.0
var username := "user"


enum movement_types {
	ORBIT,
	FREE,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	load_settings()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func save_settings():
	var file = FileAccess.open("user://settings.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(
		{
			"touch": touch,
			"movement": movement,
			"sensitivity": sensitivity,
			"username": username,
		}
	))

func load_settings():
	# If there is no file, skip the process.
	if not FileAccess.file_exists("user://settings.json"):
		print("No settings file")
		return
	
	# Load the settings into the variables from the json file.
	var file = FileAccess.open("user://settings.json", FileAccess.READ)
	var content = file.get_as_text()
	var data = JSON.parse_string(content)
	
	touch = data["touch"]
	movement = data["movement"]
	sensitivity = data["sensitivity"]
	username = data["username"]
