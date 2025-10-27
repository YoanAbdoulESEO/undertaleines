extends CharacterBody2D

var speed = 100

@export var pv_max = 20
@export var pv_actual = 20

func _physics_process(delta: float) -> void:
		
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if velocity.length() > 0:
		#velocity.normalized() va normaliser le vector de velocity pour pas qu'on aille plus vite en diagonal 
		#surement on passe de (1,1) à (racine(2)/2,racine(2)/2)
		velocity = velocity.normalized() * speed;
	
	#gère les déplacements selon l'attribut velocity
	move_and_slide()

func take_damage(damage):
	pv_actual -= damage
	if pv_actual < 0:
		pv_actual = 0 
	if pv_actual == 0: 
		hide()
	
	get_parent().get_node("LifeBar/Life").size.x = pv_actual * 112 / 20
