extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	setup()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_username_text_changed(new_text):
	ClientSettings.username = new_text


func _on_option_button_item_selected(index):
	match index:
		0:
			ClientSettings.movement = ClientSettings.movement_types.ORBIT
		1:
			ClientSettings.movement = ClientSettings.movement_types.FREE
		var default:
			print("??? How did you select an option which does not exist?")


func _on_touch_toggle_toggled(toggled_on):
	ClientSettings.touch = toggled_on


func _on_save_button_up():
	ClientSettings.save_settings()

func _on_load_button_up():
	ClientSettings.load_settings()
	setup()
	
func setup():
	# Set up Camera Type
	match ClientSettings.movement:
		ClientSettings.movement_types.ORBIT:
			$CameraType.select(0)
		ClientSettings.movement_types.FREE:
			$CameraType.select(1)
	
	# Set up Username
	$Username.text = ClientSettings.username
	
	# Set up Touch Toggle
	$TouchToggle.button_pressed = ClientSettings.touch
