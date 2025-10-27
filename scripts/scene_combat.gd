extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Frisk.hide()
	Frisk.process_mode = Node.PROCESS_MODE_DISABLED
