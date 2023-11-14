extends Node2D

#dialog manager variables
@export var dialogue_resource: DialogueResource
@export var dialogue_title: String = "tutorial"
var Balloon = preload("res://Dialogue/balloon.tscn")

var spot_array = []
var spot_array_taken = []

func _ready():
	%TaskPanel.visible = false
	print(%Portal/Sprite2D.texture)
	#set dialog manager and signals
	var dialogue_manager = Engine.get_singleton("DialogueManager")
	dialogue_manager.dialogue_ended.connect(_on_dialogue_ended)
	#set piece location for DropSpot.spot_taken to work
	var spots_taken_at_start = ["DropSpot89", "DropSpot381", "DropSpot390", "DropSpot392",
		"DropSpot401", "DropSpot393", "DropSpot400", "DropSpot403", "DropSpot412", "DropSpot424",
		"DropSpot418", "DropSpot419"]
	for spot in spots_taken_at_start:
		get_node("Game/DropSpots/" + spot).spot_taken = true

func dialogue_start():
	#Dialogue Manager
	var balloon = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_title)
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
	# --------------  STEP 0	 --------------#
	if State.tutorial_step == 0:
		State.tutorial_step += 1
		$Game/CameraMovement/Camera2D.zoom = Vector2(3,3)
		$Game/CameraMovement/Camera2D.position = %Amalgam.position
		return
	# --------------  STEP 1	 --------------#
	elif State.tutorial_step == 1:
		State.tutorial_step += 1
		%TaskPanel.visible = false
		var tween = get_tree().create_tween()
		tween.tween_property($Game/CameraMovement/Camera2D, "position", %Portal.position, 2).set_ease(tween.EASE_OUT)
		return
	# --------------  STEP 2	 --------------#
	elif State.tutorial_step == 2:
		State.tutorial_step += 1
		%TaskPanel.visible = false
		var tween = get_tree().create_tween()
		tween.tween_property($Game/CameraMovement/Camera2D, "position", %Amalgam.position, 2).set_ease(tween.EASE_OUT)
		return
		
func check_logic(piece, drop_spot):
	print(State.tutorial_step)
	print(drop_spot)
	print(piece)
	if drop_spot.spot_taken == false:
		# --------------  STEP 1	 --------------#
		if State.tutorial_step == 1:
			if piece.name == "Amalgam" && spot_array.has(drop_spot.name):
				start_scene()
				set_scene()
			else:
				print("Return False")
				return(false)
		# --------------  STEP 2	 --------------#
		elif State.tutorial_step == 2:
			if piece.name == "Portal" && spot_array.has(drop_spot.name):
				start_scene()
				set_scene()
			else:
				return(false)
	else: return(false)

func _on_dialogue_ended(resource: DialogueResource):
	State.dialogue_on = false
	# --------------  STEP 1	 --------------#
	if State.tutorial_step == 1:
		spot_array = ["DropSpot90", "DropSpot99", "DropSpot110", "DropSpot100",
		"DropSpot101", "DropSpot370", "DropSpot369", "DropSpot379"]
		%TaskPanel.visible = true
		for spot in spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
	# --------------  STEP 2	 --------------#
	if State.tutorial_step == 2:
		spot_array = ["DropSpot406", "DropSpot440"]
		spot_array_taken = ["DropSpot424"]
		%Task1.text = "The PORTAL still moves from one intersection to another \"TOUCHING\" intersection, however,
		the PORTAL must stay on the golden lines known as the GATE PATH. The \"Touching\" intersections are a lot farther
		apart along the outer edge of the board as you can see, the BLUE circles indicate where this portal is allowed to move this turn."
		%Task2.text = "Move your PORTAL to a GREEN circle"
		%TaskPanel.visible = true
		for spot in spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
		for spot in spot_array_taken:
			get_node("Game/DropSpots/" + spot).blue_active(true)
