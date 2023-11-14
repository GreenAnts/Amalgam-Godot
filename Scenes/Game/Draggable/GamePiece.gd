extends Node2D

@export var piece_texture : Texture

func _ready():
	$Sprite2D.texture = piece_texture
