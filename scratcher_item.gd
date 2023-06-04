extends Area2D

var isItem = true
var itemName = "scratcher"

func collect():
	print(itemName)
	$GPUParticles2D.emitting = true
	$Scratcher.visible = false
	monitorable = false
