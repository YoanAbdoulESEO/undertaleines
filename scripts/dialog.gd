extends CanvasGroup

signal dialog_closed 

var is_open = false
var can_close = false
var current_index = 0
var messages: Array = []

func show_message(text: String):
	show_multiple_messages([text])
	
func show_multiple_messages(lines: Array):
	
	if is_open:
		return 
	
	is_open = true
	can_close = false 
	messages = lines
	current_index = 0
	
	_display_text(lines[current_index])
	
func _display_text(text: String):
	$Texte.text = ""
	can_close = false
	show()
	
	for lettre in text:
		$Texte.text += lettre
		await get_tree().create_timer(0.05).timeout 
		
	can_close = true
	
func _process(delta: float) -> void:
	if is_open and can_close and Input.is_action_just_pressed("action"):
		# Si on a encore des lignes à afficher
		current_index += 1
		if current_index < messages.size():
			_display_text(messages[current_index])
		else:
			close_message()
		
func close_message():
	is_open = false
	hide()
	emit_signal("dialog_closed")
	
	if Frisk:
		Frisk.can_move = true
