extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Frisk.hide()
	Frisk.process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	if Input.is_action_pressed("test3"):
		$CanvasLayer/Life.size.x = 112
