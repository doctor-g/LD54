extends RigidBody2D

@export var power := 5000

@onready var _hammer := $Hammer

var _force_vector : Vector2

func _physics_process(_delta):
	_force_vector = Vector2(0,power).rotated(_hammer.rotation)
	_hammer.apply_force(_force_vector)
