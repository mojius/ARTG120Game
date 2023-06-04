extends Area2D

var isItem = false
var isNPC = true
var NPCname = "bear"

func collect():
	$GPUParticles2D.emitting = true
	$Scratcher.visible = false
	monitorable = false

