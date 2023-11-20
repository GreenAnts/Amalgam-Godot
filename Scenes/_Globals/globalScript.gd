extends Node

var is_dragging = false

var ruby_ability = false
var pearl_ability = false
var jade_ability = false
var amber_ability = false
var spot_array = []
var spot_array_taken = []

func activate_ability(ability):
	if ability == "Launch":
		ruby_ability = false
		pearl_ability = false
		jade_ability = true
		amber_ability = false
	elif ability == "Fireball":
		ruby_ability = true
		pearl_ability = false
		jade_ability = false
		amber_ability = false
	elif ability == "Wave":
		ruby_ability = false
		pearl_ability = true
		jade_ability = false
		amber_ability = false
	elif ability == "Sap":
		ruby_ability = false
		pearl_ability = false
		jade_ability = false
		amber_ability = true
	elif ability == "none":
		ruby_ability = false
		pearl_ability = false
		jade_ability = false
		amber_ability = false
	
