extends Area2D

var isItem = true
var itemName = "sack"
var isNPC = false

func collect():
	print(itemName)
	var particle = $GPUParticles2D
	$GPUParticles2D.emitting = true
	$Sack.visible = false
	monitorable = false
	await get_tree().create_timer(particle.lifetime).timeout
	queue_free()
