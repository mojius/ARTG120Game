extends Area2D

var isItem = true
var itemName = "acorn"
var isNPC = false
var killbox = false

func collect():
	var particle = $GPUParticles2D
	$GPUParticles2D.emitting = true
	$Acorn.visible = false
	monitorable = false
	await get_tree().create_timer(particle.lifetime).timeout
	queue_free()
