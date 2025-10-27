extends CharacterBody2D

@export var speed = 100
var screen_size
var look = "right" # "left", "right", "up", "down"
var sprite_size = Vector2(20, 30)
var can_move = true 

func _ready() -> void:
	#permet de récupérer la taille de l'écran 
	screen_size = get_viewport_rect().size
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if not can_move:
		return 
		
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		look = "right"
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		look = "left"
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		look = "up"
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		look = "down"
		
	if velocity.length() > 0:
		#velocity.normalized() va normaliser le vector de velocity pour pas qu'on aille plus vite en diagonal 
		#surement on passe de (1,1) à (racine(2)/2,racine(2)/2)
		velocity = velocity.normalized() * speed;
		
		#avec le $ il va voir si le parent à bien un node qui correspond au type suivant le $
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	#gère les déplacements selon l'attribut velocity
	move_and_slide()
	
	# 4️⃣ Limiter le joueur à l'écran
	var half_size = $CollisionShape2D.shape.extents
	position.x = clamp(position.x, half_size.x, screen_size.x - half_size.x)
	position.y = clamp(position.y, half_size.y, screen_size.y - half_size.y)
	
	if velocity.x != 0:
		if velocity.x > 0: 
			$AnimatedSprite2D.animation = "move_right"
		else:
			$AnimatedSprite2D.animation = "move_left"
	elif velocity.y != 0: 
		if velocity.y > 0: 
			$AnimatedSprite2D.animation = "move_down"
		else:
			$AnimatedSprite2D.animation = "move_up"
	else:
		$AnimatedSprite2D.animation = "idle_" + look
		
