extends Node2D


@onready var timer = $DashTimer

func startDash(dur):
	timer.wait_time = dur
	timer.start()

func isDashing():
	return !timer.is_stopped()
