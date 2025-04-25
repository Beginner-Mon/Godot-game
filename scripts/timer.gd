extends Control

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

@export var time_left: int = 60

func _ready() -> void:
	label.text = str(time_left)
	timer.wait_time = 1.0
	timer.start()

func _on_timer_timeout() -> void:
	time_left -=1
	label.text = str(time_left)
	if time_left <= 0:
		label.text = "Time Out"
