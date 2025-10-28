extends StaticBody2D

@export var dialog_texts = ["Howdy Vava !", "Comme on se retrouve...", "Je te rassure, je ne te ferai aucun mal...", "Mais à Ness, je ne peux rien lui promettre...", "Je crois que le royaume voisin l'a kidnappée...", "Bon courage pour la retrouver nyehehe (pas ma réplique mais tkt)"]
var player_in_range = false
var can_dialog = true

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)
	
	var dialog_node = Hud.get_node("Dialog")
	
	dialog_node.dialog_closed.connect(_on_dialog_closed)

func _on_body_entered(body):
	if body.name == "Frisk":  
		player_in_range = true

func _on_body_exited(body):
	if body.name == "Frisk":
		player_in_range = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("action") and can_dialog:  # bouton action
		show_dialog()

func show_dialog():
	var dialog_box = Hud.get_node("Dialog")
	
	can_dialog = false
	
	dialog_box.show_multiple_messages(dialog_texts)
	
	var player = Frisk
	if player:
		player.can_move = false
	
func _on_dialog_closed() -> void:
	await get_tree().create_timer(0.5).timeout 
	can_dialog = true
