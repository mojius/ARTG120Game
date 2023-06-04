extends Area2D

var isItem = true
var itemName = "acorn"

func collect():
	$GPUParticles2D.emitting = true
	$Acorn.visible = false
	monitorable = false
