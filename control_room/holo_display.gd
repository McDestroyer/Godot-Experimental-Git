extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	DebugDraw3D.scoped_config().set_thickness(0.005).set_center_brightness(0.)
	
	
	#var draw = Draw3D.new()
	#add_child(draw)
	## Draw scaling lines
	#for i in range(10):
		#draw.circle(Vector3.ZERO, Basis.IDENTITY.scaled(Vector3(.1*i,.1*i,.1*i)), Color(1, 0, 0, .5))
	## Draw sphere
	#for i in range(5):
		#draw.circle(Vector3.ZERO, Basis.IDENTITY.rotated(Vector3.LEFT, i*deg_to_rad(36)), Color(0, 0, 0.2, .5))
	#for i in range(5):
		#draw.circle(Vector3.ZERO, Basis.IDENTITY.rotated(Vector3.FORWARD, i*deg_to_rad(36)), Color(0, 0, 0.2, .5))
	#for i in range(5):
		#draw.circle(Vector3.ZERO, Basis.IDENTITY.rotated(Vector3.LEFT, deg_to_rad(90)).rotated(Vector3.UP, i*deg_to_rad(36)), Color(0, 0, 0.2, .5))
		#
	## Draw Other Ship
	#var obj_coords = Vector3(.01, .25, -.01)
	#draw.cube(obj_coords, Basis.IDENTITY.scaled(Vector3.ONE * .05))
	## Draw Arc
	#var dir_to_obj = Vector3.ZERO.direction_to(obj_coords)
	#var dist_to_obj = Vector3.ZERO.distance_to(obj_coords)
	#var floor_at_obj = Vector3(obj_coords.x, 0, obj_coords.z)
#
	#var side1 = obj_coords - Vector3.ZERO
	#var side2 = floor_at_obj - Vector3.ZERO
	#var normal = side1.cross(side2).normalized()
	#normal *= Vector3(-1, 1, -1)
#
	#draw.arc_normal(
		#Vector3.ZERO,
		#normal,
		#deg_to_rad(90),
		#obj_coords.angle_to(floor_at_obj)+PI/2,
		#dist_to_obj,
		#false, Color(0, 1, 0)
	#)
	#print(obj_coords.angle_to(floor_at_obj))
	#print(dir_to_obj)
	#print(dir_to_obj)
	#print(obj_coords.normalized()) #.cross(Vector3.UP)
	#print(dist_to_obj)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DebugDraw3D.draw_sphere(position, 1.0, Color(0, 1, 0, .1))
	var grid_circle_transform := Transform3D(Basis().scaled(Vector3(1, 0.001, 1)), position)
	#for i in range(10):
		#DebugDraw3D.draw_cylinder(grid_circle_transform.scaled(Vector3(1./(i+1.), 1., 1./(i+1.))), Color(1, 0, 0, .2))
	for i in range(10):
		DebugDraw3D.draw_cylinder(grid_circle_transform.scaled(Vector3(i/10., 1, i/10.)), Color(1, 0, 0, .2))
	DebugDraw3D.draw_line(position + Vector3(-1, 0, 0), position + Vector3(1, 0, 0), Color(1, 0, 0, .2))
	DebugDraw3D.draw_line(position + Vector3(0, 0, -1), position + Vector3(0, 0, 1), Color(1, 0, 0, .2))
	
	pass
