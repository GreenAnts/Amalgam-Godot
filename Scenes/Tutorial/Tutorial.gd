extends Node2D

#dialog manager variables
@export var dialogue_resource: DialogueResource
@export var dialogue_title: String = "tutorial"
var Balloon = preload("res://Dialogue/balloon.tscn")

func _ready():
	### DEBUG  TUTORIAL STATE
	State.tutorial_step = 0
	### 
	%TaskPanel.visible = false
	%RubyArrow.visible = false
	%RubyNum.visible = false
	%PearlArrow.visible = false
	%PearlNum.visible = false
	%JadeArrow.visible = false
	%JadeNum.visible = false
	#%AmberArrow.visible = false
	#%AmberNum.visible = false
	
	#set dialog manager and signals
	var dialogue_manager = Engine.get_singleton("DialogueManager")
	dialogue_manager.dialogue_ended.connect(_on_dialogue_ended)
	#set initial piece location for DropSpot.spot_taken to work
	#var spots_taken_at_start = ["DropSpot393", "DropSpot403", "DropSpot424", "DropSpot418",
	#	"DropSpot415", "DropSpot392", "DropSpot402", "DropSpot381", "DropSpot89"]
	#for spot in spots_taken_at_start:
	#	get_node("Game/DropSpots/" + spot).spot_taken = true

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
	for spot in global.spot_array:
		get_node("Game/DropSpots/" + spot).green_active(false)
	for spot in global.spot_array_taken:
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
		tween.tween_property($Game/CameraMovement/Camera2D, "position", %BotPieces/Portal.position, .3).set_ease(tween.EASE_OUT)
		return
	# --------------  Ready STEP 2 ---------------#
	elif State.tutorial_step == 2:
		%TaskPanel.visible = false
		var tween = get_tree().create_tween()
		tween.tween_property($Game/CameraMovement/Camera2D, "position", %BotPieces/Jade2.position, .5).set_ease(tween.EASE_OUT)
		return
	# --------------  Ready STEP 3  ---------------#
	elif State.tutorial_step == 3:
		%TopPieces/Amalgam.visible = false
		%TaskPanel.visible = false
		var tween = get_tree().create_tween()
		#var tween1 = get_tree().create_tween()
		tween.tween_property($Game/CameraMovement/Camera2D, "zoom", Vector2(2, 2), .5).set_ease(tween.EASE_OUT)
		tween.tween_property($Game/CameraMovement/Camera2D, "position", $Game/DropSpots/DropSpot345.position, .5).set_ease(tween.EASE_OUT)
		return
	# --------------  Ready STEP 4  ---------------#
	elif State.tutorial_step == 4:
		%TopPieces/Portal2.visible = false
		%TaskPanel.visible = false
		var tween = get_tree().create_tween()
		#var tween1 = get_tree().create_tween()
		tween.tween_property($Game/CameraMovement/Camera2D, "zoom", Vector2(2, 2), .5).set_ease(tween.EASE_OUT)
		tween.tween_property($Game/CameraMovement/Camera2D, "position", %BotPieces/Ruby.position, .5).set_ease(tween.EASE_OUT)
		return
	# --------------  Ready STEP 5  ---------------#
	elif State.tutorial_step == 5:
		%TopPieces/Amber2.visible = false
		%TaskPanel.visible = false
		%RubyArrow.visible = false
		%RubyNum.visible = false
		var tween = get_tree().create_tween()
		#var tween1 = get_tree().create_tween()
		tween.tween_property($Game/CameraMovement/Camera2D, "zoom", Vector2(2, 2), .5).set_ease(tween.EASE_OUT)
		tween.tween_property($Game/CameraMovement/Camera2D, "position", %BotPieces/Pearl.position, .5).set_ease(tween.EASE_OUT)
		return
	# --------------  Ready STEP 6  ---------------#
	elif State.tutorial_step == 6:
		%TopPieces/Jade2.visible = false
		%TaskPanel.visible = false
		%PearlArrow.visible = false
		%PearlNum.visible = false
		var tween = get_tree().create_tween()
		#var tween1 = get_tree().create_tween()
		tween.tween_property($Game/CameraMovement/Camera2D, "zoom", Vector2(2, 2), .5).set_ease(tween.EASE_OUT)
		tween.tween_property($Game/CameraMovement/Camera2D, "position", %BotPieces/Jade.position, .5).set_ease(tween.EASE_OUT)
		return
	# --------------  Ready STEP 7  ---------------#
	elif State.tutorial_step == 7:
		%TaskPanel.visible = false
		%JadeArrow.visible = false
		%JadeNum.visible = false
		var tween = get_tree().create_tween()
		#var tween1 = get_tree().create_tween()
		tween.tween_property($Game/CameraMovement/Camera2D, "zoom", Vector2(2, 2), .5).set_ease(tween.EASE_OUT)
		tween.tween_property($Game/CameraMovement/Camera2D, "position", %BotPieces/Jade.position, .5).set_ease(tween.EASE_OUT)
		return
func _on_dialogue_ended(_resource: DialogueResource):
	State.dialogue_on = false
	# --------------  SHOW STEP 0 TASK	 --------------#
	if State.tutorial_step == 0:
		global.spot_array = ["DropSpot90", "DropSpot99", "DropSpot110", "DropSpot100",
		"DropSpot101", "DropSpot370", "DropSpot369", "DropSpot379"]
		%TaskPanel.visible = true
		for spot in global.spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
	# --------------  SHOW STEP 1 TASK	 --------------#
	if State.tutorial_step == 1:
		global.spot_array = ["DropSpot406", "DropSpot440"]
		global.spot_array_taken = ["DropSpot424"]
		var file = FileAccess.open("res://LabelText/MovePortal.txt", FileAccess.READ)
		%Task1.text = file.get_as_text()
		%Task2.text = "Move your PORTAL to a GREEN circle"
		%TaskPanel.visible = true
		for spot in global.spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
		for spot in global.spot_array_taken:
			get_node("Game/DropSpots/" + spot).blue_active(true)
	# --------------  SHOW STEP 2 TASK	 --------------#
	if State.tutorial_step == 2:
		global.spot_array = ["DropSpot383"]
		global.spot_array_taken = ["DropSpot381", "DropSpot382", "DropSpot394",
		"DropSpot405", "DropSpot404", "DropSpot403", "DropSpot392"]
		var file = FileAccess.open("res://LabelText/RemovePiece.txt", FileAccess.READ)
		%Task1.text = file.get_as_text()
		%Task2.text = "Move your PORTAL to the GREEN circle, therefore removing the opponent's PORTAL from play."
		%TaskPanel.visible = true
		for spot in global.spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
		for spot in global.spot_array_taken:
			get_node("Game/DropSpots/" + spot).blue_active(true)
	# --------------  SHOW STEP 3 TASK	 --------------#
	if State.tutorial_step == 3:
		global.spot_array = ["DropSpot345"]
		global.spot_array_taken = ["DropSpot449"]
		var file = FileAccess.open("res://LabelText/RemovePortal.txt", FileAccess.READ)
		%Task1.text = file.get_as_text()
		%Task2.text = "Move your PORTAL to the GREEN circle, therefore removing the opponent's PORTAL from play."
		%TaskPanel.visible = true
		for spot in global.spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
		for spot in global.spot_array_taken:
			get_node("Game/DropSpots/" + spot).blue_active(true)
	# --------------  SHOW STEP 4 TASK	 --------------#
	if State.tutorial_step == 4:
		global.spot_array = ["DropSpot391"]
		global.spot_array_taken = ["DropSpot400", "DropSpot380", "DropSpot402", "DropSpot389", "DropSpot411", "DropSpot412"]
		var file = FileAccess.open("res://LabelText/Ruby00.txt", FileAccess.READ)
		%Task1.text = file.get_as_text()
		%Task2.text = "Move your RUBY to the GREEN circle, therefore removing the opponent's AMBER from play."
		%TaskPanel.visible = true
		%RubyArrow.visible = true
		%RubyNum.visible = true
		for spot in global.spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
		for spot in global.spot_array_taken:
			get_node("Game/DropSpots/" + spot).blue_active(true)
	# --------------  SHOW STEP 5 TASK	 --------------#
	if State.tutorial_step == 5:
		global.spot_array = ["DropSpot404"]
		global.spot_array_taken = ["DropSpot414", "DropSpot416", "DropSpot405"]
		var file = FileAccess.open("res://LabelText/Ruby00.txt", FileAccess.READ)
		%Task1.text = file.get_as_text()
		%Task2.text = "Move your Pearl to the GREEN circle, therefore removing the opponent's Jade from play."
		%TaskPanel.visible = true
		%PearlArrow.visible = true
		%PearlNum.visible = true
		for spot in global.spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
		for spot in global.spot_array_taken:
			get_node("Game/DropSpots/" + spot).blue_active(true)
	# --------------  SHOW STEP 6 TASK	 --------------#
	if State.tutorial_step == 6:
		global.spot_array = ["DropSpot393"]
		global.spot_array_taken = ["DropSpot382", "DropSpot369", "DropSpot370", "DropSpot371", "DropSpot380"]
		var file = FileAccess.open("res://LabelText/Ruby00.txt", FileAccess.READ)
		%Task1.text = file.get_as_text()
		%Task2.text = "Move your JADE to the GREEN circle, therefore removing the opponent's Jade from play."
		%TaskPanel.visible = true
		for spot in global.spot_array:
			get_node("Game/DropSpots/" + spot).green_active(true)
		for spot in global.spot_array_taken:
			get_node("Game/DropSpots/" + spot).blue_active(true)

func check_logic(piece, drop_spot):
	print(State.tutorial_step)
	print(drop_spot)
	print(piece)
	if drop_spot.spot_taken == false:
		# --------------  STEP 0	 --------------#
		if State.tutorial_step == 0:
			if piece.name == "Amalgam" && global.spot_array.has(drop_spot.name):
				State.tutorial_step += 1
				start_scene()
				set_scene()
			else:
				return(false)
		# --------------  STEP 1	 --------------#
		elif State.tutorial_step == 1:
			if piece.name == "Portal" && global.spot_array.has(drop_spot.name):
				State.tutorial_step += 1
				start_scene()
				set_scene()
			else:
				return(false)
		# --------------  STEP 2	 --------------#
		elif State.tutorial_step == 2:
			if piece.name == "Jade2" && global.spot_array.has(drop_spot.name):
				State.tutorial_step += 1
				start_scene()
				set_scene()
			else:
				return(false)
		# --------------  STEP 3	 --------------#
		elif State.tutorial_step == 3:
			if piece.name == "Portal2" && global.spot_array.has(drop_spot.name):
				State.tutorial_step += 1
				start_scene()
				set_scene()
			else:
				return(false)
		# --------------  STEP 4	 --------------#
		elif State.tutorial_step == 4:
			if piece.name == "Ruby" && global.spot_array.has(drop_spot.name):
				State.tutorial_step += 1
				start_scene()
				set_scene()
			else:
				return(false)
		# --------------  STEP 5	 --------------#
		elif State.tutorial_step == 5:
			if piece.name == "Pearl2" && global.spot_array.has(drop_spot.name):
				State.tutorial_step += 1
				start_scene()
				set_scene()
			else:
				return(false)
		# --------------  STEP 6	 --------------#
		elif State.tutorial_step == 6:
			if piece.name == "Jade" && global.spot_array.has(drop_spot.name):
				ready_ability("Jade", "Launch")
				for spot in global.spot_array:
					get_node("Game/DropSpots/" + spot).green_active(false)
				for spot in global.spot_array_taken:
					get_node("Game/DropSpots/" + spot).blue_active(false)
				$Game/GameUI.focus_ability()
				global.spot_array = []
				global.spot_array_taken = []
			elif global.jade_ability == true && piece.name == "Amber2" && global.spot_array.has(drop_spot.name):
				State.tutorial_step += 1
				start_scene()
				set_scene()
			else:
				
				return(false)
		else: return(false)
	
func ready_ability(piece, ability):
	$Game/GameUI.set_ability(ability, "res://Images/Pieces/" + piece + ".png")

func jade():
	global.spot_array = ["DropSpot403", "DropSpot94", "DropSpot373"]
	global.spot_array_taken = ["DropSpot226", "DropSpot232"]
	for spot in global.spot_array:
		get_node("Game/DropSpots/" + spot).green_active(true)
	for spot in global.spot_array_taken:
		get_node("Game/DropSpots/" + spot).blue_active(true)
	%JadeArrow.visible = true
	%JadeNum.visible = true
