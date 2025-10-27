extends StaticBody2D

@export var bullet_scene: PackedScene
@export var bullet_direction: Vector2 = Vector2.RIGHT

var bullet_number = 0

func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	bullet_number = 0
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("test1"):
		shoot()
	
func shoot():
	bullet_number = 0
	$AttackTimer.start()
	$AnimatedSprite2D.animation = "attack_1"
	

func _on_attack_timer_timeout() -> void:
	var bullet = bullet_scene.instantiate()
	
	var spawn_location = get_parent().get_node("SpawnBoss1/SpawnBoss1Location")
	spawn_location.progress_ratio = randf()
	
	bullet.position = spawn_location.position
	
	get_parent().add_child(bullet)
	
	bullet.direction = bullet_direction.normalized()

	bullet_number += 1
	
	if bullet_number >= 10:
		$AttackTimer.stop()
		$AnimatedSprite2D.animation = "idle"

func _on_animated_sprite_2d_animation_looped() -> void:
	if $AnimatedSprite2D.animation == "attack_1" or $AnimatedSprite2D.animation == "attack_2":
		$AnimatedSprite2D.animation = "idle"
