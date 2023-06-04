extends Area2D

var isItem = true
var itemName = "sack"

func collect():
	print(itemName)
	$GPUParticles2D.emitting = true
	$Sack.visible = false
	monitorable = false
