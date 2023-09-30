extends CharacterBody2D


@export var mass := 70.0
@export var walking_speed := 100

@export_category("Rope")
@export var min_rope_length := 75.0
@export var max_rope_length := 250.0
@export var rope_adjustment_speed := 70.0

@export_category("Hammer")
@export var hammer_mass := 10.0
@export var min_rotation_speed := TAU / 2.0
@export var max_rotation_speed := TAU * 3.0
@export var rotation_adjustment_speed := TAU / 8.0
## An extra factor by which the hammer's rotational speed affects the player's position.
## Tuned for a good game feel.
@export var fudge_factor := 2.0

var _angle_to_hammer := 0.0
var _rotation_speed := PI * 1.5
var _rope_length := 150.0

@onready var _hammer := $Hammer


func _physics_process(delta):
	var direction := Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	position += direction * walking_speed * delta

	# Adjust rope length
	var rope_adjustment := Input.get_axis("reel_in", "let_out")
	_rope_length = clampf(_rope_length + rope_adjustment * rope_adjustment_speed * delta,
		min_rope_length, max_rope_length)
		
	# Adjust spinning speed
	var power_adjustment := Input.get_axis("decrease_power", "increase_power")
	_rotation_speed = clampf(_rotation_speed + power_adjustment * delta * rotation_adjustment_speed,
		min_rotation_speed, max_rotation_speed)
	
	# Adjust hammer position
	_angle_to_hammer += _rotation_speed * delta
	_hammer.position = Vector2(cos(_angle_to_hammer), sin(_angle_to_hammer)) * _rope_length
	
	# _rotation_speed here is a proxy for "power" being applied
	position += Vector2(1,0).rotated(_angle_to_hammer) * hammer_mass / mass * _rotation_speed * fudge_factor
	
	queue_redraw()


func _draw():
	draw_line(Vector2.ZERO, $Hammer.position, Color.SLATE_GRAY, 4)
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, Color.CADET_BLUE)
	draw_circle($Hammer.position, $Hammer/CollisionShape2D.shape.radius, Color.SLATE_GRAY)
