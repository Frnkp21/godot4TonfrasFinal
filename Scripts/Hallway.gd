extends Node2D
@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player.position = Coordenadas.posicion

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
