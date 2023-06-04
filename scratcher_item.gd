extends Area2D


var itemName = "scratcher"

func collect():
	print(itemName)
	$GPUParticles2D.emitting = true
	$Scratcher.visible = false
	monitorable = false
