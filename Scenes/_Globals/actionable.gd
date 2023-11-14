extends Area2D

#drag-n-drop variables
var draggable = false
var inside_dropspot = false
var offset : Vector2
var initialPos
var dropSpot_ref
var initial_DropSpot
var clicked_for_spot

func _process(_delta):
	print(draggable)
	if State.dialogue_on == false && draggable:
		if Input.is_action_just_pressed("click"):
			get_parent().scale = Vector2(1.20, 1.20)
			clicked_for_spot = true
			initialPos = get_parent().global_position
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true
		elif Input.is_action_pressed("click"):
			get_parent().global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			print("on released" + str(dropSpot_ref))
			var tween = get_tree().create_tween()
			if inside_dropspot:
				if get_tree().current_scene.gameMode == "tutorial":
					if get_parent().get_parent().get_parent().check_logic(get_parent(), dropSpot_ref) == false:
						#tween.tween_property(get_parent(), "global_position", initialPos, 0.2).set_ease(tween.EASE_OUT)
						get_parent().global_position = initialPos
						draggable = true
					else:
						tween.tween_property(get_parent(), "position", dropSpot_ref.position, 0.2).set_ease(tween.EASE_OUT)
						dropSpot_ref.spot_taken = true
						initial_DropSpot.spot_taken = false
				elif get_tree().current_scene.gameMode == "game":
					get_parent().game_logic(self, dropSpot_ref)
			else:
				#tween.tween_property(get_parent(), "global_position", initialPos, 0.2).set_ease(tween.EASE_OUT)
				get_parent().global_position = initialPos
			#get_parent().scale = Vector2(1.00, 1.00)

#drag and drop functions below
func _on_body_entered(drop_spot):
	if drop_spot.is_in_group('dropable'):
		dropSpot_ref = drop_spot
		inside_dropspot = true
		drop_spot.visible = true
		print("on entered" + str(dropSpot_ref))

func _on_body_exited(drop_spot):
	if drop_spot.is_in_group('dropable'):
		if drop_spot.spot_active == false:
			drop_spot.visible = false
		if clicked_for_spot == true:
			initial_DropSpot = drop_spot
			clicked_for_spot = false
		inside_dropspot = false		

func _on_mouse_entered():
	if not global.is_dragging:
		draggable = true
		get_parent().scale = Vector2(1.10, 1.10)

func _on_mouse_exited():
	if not global.is_dragging:
		draggable = false
		get_parent().scale = Vector2(1.00, 1.00)
