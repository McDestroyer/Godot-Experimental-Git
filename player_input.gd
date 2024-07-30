extends MultiplayerSynchronizer

# Set via RPC to simulate is_action_just_pressed.
@export var vertical := 0.0

# Synchronized property.
@export var direction := Vector2()

var movement_deadzone := .15

func _ready():
	# Only process for the local player
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())

@rpc("call_local")
func move_vertically(amount: float):
	vertical = amount

func _process(delta):
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down", movement_deadzone)
	
	var vert = 0
	if Input.is_action_pressed("custom_ascend"):
		vert += 1
	elif Input.is_action_pressed("custom_decend"):
		vert -= 1
		
	move_vertically.rpc(vert)
