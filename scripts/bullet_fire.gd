extends Area2D

@export var speed: float = 150.0
@export var direction: Vector2 = Vector2.LEFT

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
	# Optionnel : auto-destruction hors écran
	if not get_viewport_rect().has_point(global_position):
		queue_free()
