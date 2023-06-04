extends Area2D


var itemName = "acorn"

func collect():
	$GPUParticles2D.emitting = true
	$Acorn.visible = false
	monitorable = false
