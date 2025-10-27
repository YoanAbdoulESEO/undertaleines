extends StaticBody2D

@export var bullet_scene: PackedScene
@export var bullet_direction: Vector2 = Vector2.LEFT

var bullet_number = 0

func _ready() -> void:
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	bullet_number = 0
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("test2"):
		shoot()
	
func shoot():
	bullet_number = 0
	$AttackTimer.start()
	$AnimatedSprite2D.animation = "attack_1"
	

func bruh() -> void:
	var bullet = bullet_scene.instantiate()
	
	var spawn_location = get_parent().get_node("SpawnBoss2/SpawnBoss2Location")
	spawn_location.progress_ratio = randf()
	
	bullet.position = spawn_location.position
	
	get_parent().add_child(bullet)
	
	bullet.direction = bullet_direction.normalized()

	bullet_number += 1
	
	if bullet_number >= 10:
		$AttackTimer.stop()
		$AnimatedSprite2D.animation = "idle"

func bruh2() -> void:
	if $AnimatedSprite2D.animation == "attack_1" or $AnimatedSprite2D.animation == "attack_2":
		$AnimatedSprite2D.animation = "idle"


func _on_animated_sprite_2d_animation_looped() -> void:
	pass # Replace with function body.
