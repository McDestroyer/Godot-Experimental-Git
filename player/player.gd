extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const CENTER_POS = Vector3(0,0,0)

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Set by the authority, synchronized on spawn.
@export var player := 1 :
	set(id):
		player = id
		# Give authority over the player input to the appropriate peer.
		$PlayerInput.set_multiplayer_authority(id)

# Player synchronized input.
@onready var input = $PlayerInput

func _ready():
	# Set the camera as current if we are this player.
	if player == multiplayer.get_unique_id():
		$Camera3D.current = true
	# Only process on server.
	# EDIT: Left the client simulate player movement too to compesate network latency.
	# set_physics_process(multiplayer.is_server())


func _physics_process(delta):

	# Movement
	match ClientSettings.movement:
		
		# Free cam movement
		ClientSettings.movement_types.FREE:
			# Handle vertical.
			velocity.y = input.vertical * SPEED

			# Handle movement.
			var direction = (transform.basis * Vector3(input.direction.x, 0, input.direction.y)).normalized()
			if direction:
				velocity.x = direction.x * SPEED
				velocity.z = direction.z * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				velocity.z = move_toward(velocity.z, 0, SPEED)
		
		# Orbital cam movement
		ClientSettings.movement_types.ORBIT:
			#var angle := (transform.basis * Vector3(input.direction.x, 0, input.direction.y)).normalized()
			var x_axis := Vector3(1,0,0)
			var y_axis := Vector3(0,1,0)
			var r_speed := ClientSettings.sensitivity / 3000
			
			position = CENTER_POS + (position - CENTER_POS).rotated(y_axis, input.direction.x * r_speed / delta)
			position = CENTER_POS + (position - CENTER_POS).rotated(x_axis, input.direction.y * r_speed / delta)
			look_at(CENTER_POS)
		

	move_and_slide()
