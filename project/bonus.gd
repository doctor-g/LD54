extends Area2D

@export var color := Color.GOLD

func _on_body_entered(body):
	if body.is_in_group("player_character"):
		print("YAY")
	elif body.is_in_group("hammer"):
		print("OH NO")
	queue_free()


func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, color)
