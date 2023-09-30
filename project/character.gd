extends RigidBody2D

@export var power := 5000
@export var movement_power := 7000

@onready var _hammer := $Hammer

var _force_vector : Vector2

func _physics_process(delta):
	# Player-controlled movement feels better when it is directly
	# manipulating the position. Otherwise, using forces and physics,
	# it is realistic but not responsive enough to be fun.
	var direction := Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	position += direction * 100 * delta
	
	# Swing the hammer
	_force_vector = Vector2(0,power).rotated(_hammer.rotation)
	_hammer.apply_force(_force_vector)
