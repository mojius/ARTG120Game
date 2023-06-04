extends StaticBody2D




func destroy():
	$CollisionShape2D.disabled = true
	$Sprite2D.visible = false
	$GPUParticles2D.emitting = true
	
	print("destroyed")
