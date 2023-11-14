extends Node2D

#dialog manager variables
@export var dialogue_resource: DialogueResource
@export var dialogue_title: String = "tutorial"
var Balloon = preload("res://Dialogue/balloon.tscn")

var spot_array = []
var spot_array_taken = []

func _ready():
	%TaskPanel.visible = false
	#set dialog manager and signals
	var dialogue_manager = Engine.get_singleton("DialogueManager")
	dialogue_manager.dialogue_ended.connect(_on_dialogue_ended)
	#set initial piece location for DropSpot.spot_taken to work
	var spots_taken_at_start = ["DropSpot89", "DropSpot381", "DropSpot390", "DropSpot392",
		"DropSpot401", "DropSpot393", "DropSpot400", "DropSpot403", "DropSpot412", "DropSpot424",
		"DropSpot418", "DropSpot419"]
		#"DropSpot67", "DropSpot165", "DropSpot156", "DropSpot167",
		#"DropSpot176", "DropSpot178", "DropSpot187", "DropSpot168", "DropSpot175", "DropSpot199",
		#"DropSpot193", "DropSpot194"
	for spot in spots_taken_at_start:
		get_node("Game/DropSpots/" + spot).spot_taken = true

func dialogue_start():
	#Dialogue Manager
	var balloon = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_title + "_0")
	State.dialogue_on = true
	set_scene()
	
func start_scene():
	State.dialogue_on = true
	var balloon = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_title + "_" + str(State.tutorial_step))
	for spot in spot_array:
		get_node("Game/DropSpots/" + spot).green_active(false)
	for spot in spot_array_taken:
		get_node("Game/DropSpots/" + spot).blue_active(false)
		
func set_scene():
	# --------------  Ready STEP 0 --------------#
	if State.tutorial_step == 0:
		$Game/CameraMovement/Camera2D.zoom = Vector2(3,3)
		$Game/CameraMovement/Camera2D.position = %BotPieces/Amalgam.position
		return
	# --------------  Ready STEP 1 ---------------#
	elif State.tutorial_step == 1:
		%TaskPanel.visible = false
		var tween = get_tree().create_tween()
		tween.tween_property($Game/CameraMovement/Camera2D, "position", %BotPieces/Portal.position, 1).set_ease(tween.EASE_OUT)
		return
	# --------------  Ready STEP 2 ---------------#
	elif State.tutorial_step == 2:
		%TaskPanel.visible = false
		var tween = get_tree().create_tween()
		tween.tween_property($Game/CameraMovement/Camera2D, "position", %BotPieces/Jade2.position, .5).set_ease(tween.EASE_OUT)
		return
	# --------------  Ready STEP 3  ---------------#
	elif State.tutorial_step == 3:
		%TaskPanel.visible = false
		var tween = get_tree().create_tween()
		#var tween1 = get_tree().create_tween()
		tween.tween_property($Game/CameraMovement/Camera2D, "zoom", Vector2(2, 2), .5).set_ease(tween.EASE_OUT)
		tween.tween_property($Game/CameraMovement/Camera2D, "position", $Game/DropSpots/DropSpot345.position, .5).set_ease(tween.EASE_OUT)
		return
		
func _on_dialogue_ended(resource: DialogueResource):
	State.dialogue_on = false
	# --------------  SHOW STEP 0 TASK	 --------------#
	if State.tutorial_step == 0:
		spot_array = ["DropSpot90", "DropSpot99", "DropSpot110", "DropSpot100",
		"DropSpot101", "DropSpot370", "DropSpot369", "DropSpot379"]
		%TaskPanel.visible = true
		for spot in spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
	# --------------  SHOW STEP 1 TASK	 --------------#
	if State.tutorial_step == 1:
		spot_array = ["DropSpot406", "DropSpot440"]
		spot_array_taken = ["DropSpot424"]
		var file = FileAccess.open("res://LabelText/MovePortal.txt", FileAccess.READ)
		%Task1.text = file.get_as_text()
		%Task2.text = "Move your PORTAL to a GREEN circle"
		%TaskPanel.visible = true
		for spot in spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
		for spot in spot_array_taken:
			get_node("Game/DropSpots/" + spot).blue_active(true)
	# --------------  SHOW STEP 2 TASK	 --------------#
	if State.tutorial_step == 2:
		spot_array = ["DropSpot383"]
		spot_array_taken = ["DropSpot381", "DropSpot382", "DropSpot394",
		"DropSpot405", "DropSpot404", "DropSpot403", "DropSpot392"]
		var file = FileAccess.open("res://LabelText/RemovePiece.txt", FileAccess.READ)
		%Task1.text = file.get_as_text()
		%Task2.text = "Move your PORTAL to the GREEN circle, therefore removing the opponent's PORTAL from play."
		%TaskPanel.visible = true
		for spot in spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
		for spot in spot_array_taken:
			get_node("Game/DropSpots/" + spot).blue_active(true)
	# --------------  SHOW STEP 3 TASK	 --------------#
	if State.tutorial_step == 3:
		spot_array = ["DropSpot345"]
		spot_array_taken = ["DropSpot449"]
		var file = FileAccess.open("res://LabelText/RemovePortal.txt", FileAccess.READ)
		%Task1.text = file.get_as_text()
		%Task2.text = "Move your PORTAL to the GREEN circle, therefore removing the opponent's PORTAL from play."
		%TaskPanel.visible = true
		for spot in spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
		for spot in spot_array_taken:
			get_node("Game/DropSpots/" + spot).blue_active(true)
	# --------------  SHOW STEP 4 TASK	 --------------#
	if State.tutorial_step == 4:
		spot_array = ["DropSpot345"]
		spot_array_taken = ["DropSpot449"]
		var file = FileAccess.open("res://LabelText/RemovePortal.txt", FileAccess.READ)
		%Task1.text = file.get_as_text()
		%Task2.text = "Move your PORTAL to the GREEN circle, therefore removing the opponent's PORTAL from play."
		%TaskPanel.visible = true
		for spot in spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
		for spot in spot_array_taken:
			get_node("Game/DropSpots/" + spot).blue_active(true)

func check_logic(piece, drop_spot):
	print(State.tutorial_step)
	print(drop_spot)
	print(piece)
	if drop_spot.spot_taken == false:
		# --------------  STEP 0	 --------------#
		if State.tutorial_step == 0:
			if piece.name == "Amalgam" && spot_array.has(drop_spot.name):
				State.tutorial_step += 1
				start_scene()
				set_scene()
			else:
				return(false)
		# --------------  STEP 1	 --------------#
		elif State.tutorial_step == 1:
			if piece.name == "Portal" && spot_array.has(drop_spot.name):
				State.tutorial_step += 1
				start_scene()
				set_scene()
			else:
				return(false)
		# --------------  STEP 2	 --------------#
		elif State.tutorial_step == 2:
			if piece.name == "Jade2" && spot_array.has(drop_spot.name):
				State.tutorial_step += 1
				start_scene()
				set_scene()
			else:
				return(false)
		# --------------  STEP 3	 --------------#
		elif State.tutorial_step == 3:
			if piece.name == "Portal2" && spot_array.has(drop_spot.name):
				State.tutorial_step += 1
				start_scene()
				set_scene()
			else:
				return(false)
	else: return(false)
