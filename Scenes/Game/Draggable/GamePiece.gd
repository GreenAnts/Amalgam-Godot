extends Node2D

@export var piece_texture : Texture
@export var piece_color : Texture

func _ready():
	$PieceType.texture = piece_texture
	$PieceColor.texture = piece_color
