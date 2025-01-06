extends Control

@onready var slot_scene = preload("res://Scenes/slot.tscn")
@onready var board_grid = $Board/BoardGrid
@onready var piece_scene = preload("res://Scenes/piece.tscn")
@onready var arrow_scene = preload("res://Scenes/arrows.tscn")
@onready var indicator_scene = preload("res://Scenes/indicators.tscn")

var circle_piece_counter = {0: 0, 1: 0, 2: 0, 3: 0}
var square_piece_counter = {7: 0, 8: 0, 9: 0, 10: 0}

var grid_array := []
var movement_indicators = []
var auto_setup = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.ready_to_add_piece.connect(add_piece)
	SignalBus.show_correct_icons.connect(show_correct_icons)
	SignalBus.movement_options.connect(show_movement_indicators)
	SignalBus.reset_movement_options.connect(reset_movement_indicators)
	SignalBus.reset_ability_indicators.connect(reset_arrows)
	SignalBus.show_end_turn.connect(show_end_turn)
	var ycor = 12
	for i in range(25):
		var xcor = -12
		for n in range(25):
			create_slot()
			grid_array[-1].slot_ID = Vector2(xcor, ycor)
			if DataHandler.board_dict.has(grid_array[-1].slot_ID):
				DataHandler.board_dict[grid_array[-1].slot_ID] = grid_array[-1]
			xcor += 1
		ycor -= 1
	board_setup.call_deferred()
	#Hide Icons
	$Background/PortalSwap.visible = false
	$Background/Fireball.visible = false
	$Background/TidalWave.visible = false
	$Background/Sap.visible = false
	$Background/Launch.visible = false
	$Background/End_Turn.visible = false
	#Squares Start first
	$Board/CirclesTurn.visible = false
	$Board/SquaresTurn.visible = false
	
func board_setup():
	#C:CIRCLES #S:SQUARES
	#Void
	add_piece(6, Vector2(0,12)) #Void-C
	add_piece(13, Vector2(0,-12)) #Void-S
	#Amalgam
	add_piece(4, Vector2(0,6)) #Amalgam-C
	add_piece(11, Vector2(0,-6)) #Amalgam-S
	#Portal
	add_piece(5, Vector2(6,6)) #Portal-C1
	add_piece(12, Vector2(6,-6)) #Portal-S1
	add_piece(5, Vector2(-6,6)) #Portal-C2
	add_piece(12, Vector2(-6,-6)) #Portal-S2
	
	$Board/SquaresTurn.visible = true
	PlayerHandler.setup_ready = true

func board_auto_setup():
	DataHandler.clicked_slot = null
	DataHandler.clicked_piece = null
	#Ruby
	add_piece(0, Vector2(5,9)) #Ruby-C1
	add_piece(7, Vector2(5,-9)) #Ruby-S1
	add_piece(0, Vector2(6,9)) #Ruby-C2
	add_piece(7, Vector2(6,-9)) #Ruby-S2
	#Pearl
	add_piece(1, Vector2(2,10)) #Pearl-C1
	add_piece(8, Vector2(2,-10)) #Pearl-S1
	add_piece(1, Vector2(2,11)) #Pearl-C2
	add_piece(8, Vector2(2,-11)) #Pearl-S2
	#Amber
	add_piece(2, Vector2(3,10)) #Amber-C1
	add_piece(9, Vector2(3,-10)) #Amber-S1
	add_piece(2, Vector2(3,11)) #Amber-C2
	add_piece(9, Vector2(3,-11)) #Amber-S2
	#Jade
	add_piece(3, Vector2(5,7)) #Jade-C1
	add_piece(10, Vector2(5,-7)) #Jade-S1
	add_piece(3, Vector2(5,8)) #Jade-C2
	add_piece(10, Vector2(5,-8)) #Jade-S2
	$Background/CirclePiecesContainer.visible = false
	$Background/SquarePiecesContainer.visible = false
	# Set everything as needed to start the game with squares going first when turn is ended
	$Background/AutoSetup.visible = false
	PlayerHandler.setup_turn = 16
	PlayerHandler.player_turn = "Circles"



func _on_auto_setup_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		auto_setup = true
		show_end_turn(true)
	else:
		auto_setup = false
		show_end_turn(false)

func create_slot():
	var new_slot = slot_scene.instantiate()
	board_grid.add_child(new_slot)
	grid_array.append(new_slot)

func hide_piece(piece_type):
	if piece_type == 0:
		$Background/CirclePiecesContainer/RubyCircle.visible = false
	if piece_type == 1:
		$Background/CirclePiecesContainer/PearlCircle.visible = false
	if piece_type == 2:
		$Background/CirclePiecesContainer/AmberCircle.visible = false
	if piece_type == 3:
		$Background/CirclePiecesContainer/JadeCircle.visible = false
	if piece_type == 7:
		$Background/SquarePiecesContainer/RubySquare.visible = false
	if piece_type == 8:
		$Background/SquarePiecesContainer/PearlSquare.visible = false
	if piece_type == 9:
		$Background/SquarePiecesContainer/AmberSquare.visible = false
	if piece_type == 10:
		$Background/SquarePiecesContainer/JadeSquare.visible = false
	
func add_piece(piece_type, location)->void:
	var add = func add():
		var new_piece = piece_scene.instantiate()
		get_node("../Gameplay").add_child(new_piece)
		new_piece.type = piece_type
		new_piece.load_icon(piece_type)
		new_piece.global_position = DataHandler.board_dict[location].global_position + DataHandler.slot_offset
		new_piece.slot_ID = location
		DataHandler.piece_dict[new_piece.slot_ID] = new_piece
	if (DataHandler.slot_is_empty() && piece_type not in [5,12]) || (DataHandler.slot_is_empty() && piece_type in [5,12] && DataHandler.golden_lines_dict.has(location)):
		if PlayerHandler.setup_ready == true && !auto_setup:
			if piece_type in circle_piece_counter && DataHandler.circle_starting_pos_dict.has(location):
				if circle_piece_counter[piece_type] == 1:
					hide_piece(piece_type)
				elif piece_type in circle_piece_counter:
					circle_piece_counter[piece_type] += 1
				add.call()
				print(DataHandler.piece_dict)
				reset_movement_indicators()
				$Background/AutoSetup.visible = false
			elif piece_type in square_piece_counter && DataHandler.square_starting_pos_dict.has(location):
				if square_piece_counter[piece_type] == 1:
					hide_piece(piece_type)
				elif piece_type in square_piece_counter:
					square_piece_counter[piece_type] += 1
				add.call()
				print(DataHandler.piece_dict)
				reset_movement_indicators()
				$Background/AutoSetup.visible = false
			else:
				$Background/CirclePiecesContainer/JadeCircle.button_pressed = false
				$Background/CirclePiecesContainer/AmberCircle.button_pressed = false
				$Background/CirclePiecesContainer/PearlCircle.button_pressed = false
				$Background/CirclePiecesContainer/RubyCircle.button_pressed = false
				$Background/SquarePiecesContainer/RubySquare.button_pressed = false
				$Background/SquarePiecesContainer/PearlSquare.button_pressed = false
				$Background/SquarePiecesContainer/AmberSquare.button_pressed = false
				$Background/SquarePiecesContainer/JadeSquare.button_pressed = false
				reset_movement_indicators()
				return
		else:
			add.call()
		if PlayerHandler.setup_ready == true:
				PlayerHandler.next_turn_step()
				reset_setup_toggle()
	DataHandler.clicked_piece = null

func add_circle(num):
	if $Background/End_Turn.visible == false && PlayerHandler.setup_turn % 2 == 0 && PlayerHandler.player_turn == "Circles":
		DataHandler.add_piece = num

func add_square(num):
	if $Background/End_Turn.visible == false && PlayerHandler.setup_turn % 2 == 1 && PlayerHandler.player_turn == "Squares":
		DataHandler.add_piece = num

func show_setup_indicators(player):
	var setup_array = []
	if player == "Circles":
		for key in DataHandler.circle_starting_pos_dict.keys():
			if not DataHandler.piece_dict.has(key):
				setup_array.append(key)
		show_movement_indicators(setup_array, "Green")
	else:
		for key in DataHandler.square_starting_pos_dict.keys():
			if not DataHandler.piece_dict.has(key):
				setup_array.append(key)
		show_movement_indicators(setup_array, "Green")


	
# SETUP CIRCLE PIECES
func _on_ruby_circle_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		add_circle(0)
		show_setup_indicators("Circles")
		$Background/CirclePiecesContainer/JadeCircle.button_pressed = false
		$Background/CirclePiecesContainer/AmberCircle.button_pressed = false
		$Background/CirclePiecesContainer/PearlCircle.button_pressed = false
func _on_pearl_circle_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		add_circle(1)
		show_setup_indicators("Circles")
		$Background/CirclePiecesContainer/JadeCircle.button_pressed = false
		$Background/CirclePiecesContainer/AmberCircle.button_pressed = false
		$Background/CirclePiecesContainer/RubyCircle.button_pressed = false

func _on_amber_circle_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		add_circle(2)
		show_setup_indicators("Circles")
		$Background/CirclePiecesContainer/JadeCircle.button_pressed = false
		$Background/CirclePiecesContainer/PearlCircle.button_pressed = false
		$Background/CirclePiecesContainer/RubyCircle.button_pressed = false

func _on_jade_circle_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		add_circle(3)
		show_setup_indicators("Circles")
		$Background/CirclePiecesContainer/AmberCircle.button_pressed = false
		$Background/CirclePiecesContainer/PearlCircle.button_pressed = false
		$Background/CirclePiecesContainer/RubyCircle.button_pressed = false

# SETUP SQUARE PIECES
func _on_ruby_square_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		add_square(7)
		show_setup_indicators("Squares")
		$Background/SquarePiecesContainer/PearlSquare.button_pressed = false
		$Background/SquarePiecesContainer/AmberSquare.button_pressed = false
		$Background/SquarePiecesContainer/JadeSquare.button_pressed = false
func _on_pearl_square_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		add_square(8)
		show_setup_indicators("Squares")
		$Background/SquarePiecesContainer/RubySquare.button_pressed = false
		$Background/SquarePiecesContainer/AmberSquare.button_pressed = false
		$Background/SquarePiecesContainer/JadeSquare.button_pressed = false

func _on_amber_square_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		add_square(9)
		show_setup_indicators("Squares")
		$Background/SquarePiecesContainer/RubySquare.button_pressed = false
		$Background/SquarePiecesContainer/PearlSquare.button_pressed = false
		$Background/SquarePiecesContainer/JadeSquare.button_pressed = false

func _on_jade_square_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		add_square(10)
		show_setup_indicators("Squares")
		$Background/SquarePiecesContainer/RubySquare.button_pressed = false
		$Background/SquarePiecesContainer/PearlSquare.button_pressed = false
		$Background/SquarePiecesContainer/AmberSquare.button_pressed = false

func reset_setup_toggle():
	$Background/CirclePiecesContainer/RubyCircle.button_pressed = false
	$Background/CirclePiecesContainer/PearlCircle.button_pressed = false
	$Background/CirclePiecesContainer/AmberCircle.button_pressed = false
	$Background/CirclePiecesContainer/JadeCircle.button_pressed = false
	$Background/SquarePiecesContainer/RubySquare.button_pressed = false
	$Background/SquarePiecesContainer/PearlSquare.button_pressed = false
	$Background/SquarePiecesContainer/AmberSquare.button_pressed = false
	$Background/SquarePiecesContainer/JadeSquare.button_pressed = false

#Portal Swap
func _on_portal_swap_toggled(toggled_on: bool) -> void:
	if toggled_on:
		reset_movement_indicators()
		$Background/PortalSwap.button_pressed = true
		DataHandler.swap_ready = DataHandler.clicked_piece
		var golden_lines_pieces = []
		for piece in DataHandler.piece_dict.keys():
			if GameLogic.check_player_of_piece(piece) == GameLogic.check_player_of_piece(DataHandler.swap_ready) && DataHandler.golden_lines_dict.has(piece) && DataHandler.piece_dict[piece].type not in [5,12]:
				golden_lines_pieces.append(piece)
		show_movement_indicators(golden_lines_pieces, "Purple")
	else:
		$Background/PortalSwap.button_pressed = false
		DataHandler.swap_ready = null
		reset_movement_indicators()

#Fireball
func _on_fireball_toggled(toggled_on: bool) -> void:
	if toggled_on:
		reset_movement_indicators()
		$Background/Fireball.button_pressed = true
		DataHandler.fireball_ready = true
		var count = 0
		if DataHandler.ruby_indicator_coord != null:
			for arr_step in DataHandler.ruby_targets.size():
				if DataHandler.ruby_targets[arr_step] != []:
					for targets in DataHandler.ruby_targets[arr_step].size():
						if DataHandler.ruby_targets[arr_step][targets] != []:
							var ruby_data = DataHandler.ruby_indicator_coord[targets+count]
							var arrow = arrow_scene.instantiate()
							get_node("../Indicators").add_child(arrow)
							arrow.global_position = DataHandler.board_dict[ruby_data[0]].global_position + DataHandler.slot_offset
							arrow.rotation_degrees = DataHandler.convert_direction_to_rotation(ruby_data[1])
							#Set Data for instance
							arrow.pos = ruby_data[0]
							arrow.targets = DataHandler.ruby_targets[arr_step][targets]
					count += 2 
	else:
		$Background/Fireball.button_pressed = false
		DataHandler.fireball_ready = false
		reset_arrows()

#Tidalwave
func _on_tidal_wave_toggled(toggled_on: bool) -> void:
	if toggled_on:
		reset_movement_indicators()
		$Background/TidalWave.button_pressed = true
		DataHandler.tidalwave_ready = true
		var count = 0
		if DataHandler.pearl_indicator_coord != null:
			for arr_step in DataHandler.pearl_targets.size():
				if DataHandler.pearl_targets[arr_step] != []:
					for targets in DataHandler.pearl_targets[arr_step].size():
						if DataHandler.pearl_targets[arr_step][targets] != []:
							var pearl_data = DataHandler.pearl_indicator_coord[targets+count]
							var arrow = arrow_scene.instantiate()
							get_node("../Indicators").add_child(arrow)
							arrow.global_position = DataHandler.board_dict[pearl_data[0]].global_position + DataHandler.slot_offset
							arrow.rotation_degrees = DataHandler.convert_direction_to_rotation(pearl_data[1])
							#Set Data for instance
							arrow.pos = pearl_data[0]
							arrow.targets = DataHandler.pearl_targets[arr_step][targets]
					count += 2 
	else:
		$Background/TidalWave.button_pressed = false
		DataHandler.tidalwave_ready = false
		reset_arrows()
#Sap
func _on_sap_toggled(toggled_on: bool) -> void:
	if toggled_on:
		reset_movement_indicators()
		$Background/Sap.button_pressed = true
		DataHandler.sap_ready = true
		if DataHandler.amber_indicator_coord != null:
			for i in DataHandler.amber_targets.size():
				for amber_data in DataHandler.amber_indicator_coord[i]:
					var arrow = arrow_scene.instantiate()
					get_node("../Indicators").add_child(arrow)
					arrow.global_position = DataHandler.board_dict[amber_data[0]].global_position + DataHandler.slot_offset
					arrow.rotation_degrees = DataHandler.convert_direction_to_rotation(amber_data[1])
					#Set Data for instance
					arrow.pos = amber_data[0]
					arrow.targets = DataHandler.amber_targets[i]
	else:
		$Background/Sap.button_pressed = false
		DataHandler.sap_ready = false
		reset_arrows()

#Launch
func _on_launch_toggled(toggled_on: bool) -> void:
	if toggled_on:
		reset_movement_indicators()
		$Background/Launch.button_pressed = true
		DataHandler.launch_ready = true
		for i in DataHandler.jade_targets.size():
			for n in DataHandler.jade_targets[i]:
				var indicator = indicator_scene.instantiate()
				get_node("../Indicators").add_child(indicator)
				indicator.global_position = DataHandler.board_dict[n].global_position + DataHandler.slot_offset
				#Set Data for instance
				indicator.pos = n
				indicator.targets = DataHandler.jade_targets[i]
	else:
		$Background/Launch.button_pressed = false
		DataHandler.launch_ready = false
		reset_arrows()

func show_movement_indicators(coord_arr, color = null):
	for i in coord_arr:
		for slot in $Board/BoardGrid.get_children():
			if slot.slot_ID == i:
				movement_indicators.append(slot)
				if color == null || color == "Green":
					slot.get_node("Green").visible = true
				elif color == "Purple":
					slot.get_node("Purple").visible = true

func reset_movement_indicators():
	for i in DataHandler.board_dict:
		for slot in movement_indicators:
			slot.get_node("Green").visible = false
			slot.get_node("Purple").visible = false

func show_end_turn(bool_val):
	$Background/End_Turn.visible = bool_val

func show_correct_icons(piece):
	if piece != null:
		if  piece == "Portal":
			$Background/PortalSwap.visible = true
			$Background/PortalSwap.button_pressed = false
			DataHandler.swap_ready = null
		if  piece == "Ruby":
			$Background/Fireball.visible = true
			$Background/Fireball.button_pressed = false
			DataHandler.fireball_ready = false
		if  piece == "Pearl":
			$Background/TidalWave.visible = true
			$Background/TidalWave.button_pressed = false
			DataHandler.tidalwave_ready = false
		if  piece == "Amber":
			$Background/Sap.visible = true
			$Background/Sap.button_pressed = false
			DataHandler.sap_ready = false
		if  piece == "Jade":
			$Background/Launch.visible = true
			$Background/Launch.button_pressed = false
			DataHandler.launch_ready = false
		if  piece == "Ruby_Used":
			$Background/Fireball.visible = false
		if  piece == "Pearl_Used":
			$Background/TidalWave.visible = false
		if  piece == "Amber_Used":
			$Background/Sap.visible = false
		if  piece == "Jade_Used":
			$Background/Launch.visible = false
		if  piece == "Portal_Off":
			$Background/PortalSwap.visible = false
			$Background/PortalSwap.button_pressed = false
			DataHandler.swap_ready = null
	else:
		$Background/PortalSwap.visible = false
		$Background/Fireball.visible = false
		$Background/TidalWave.visible = false
		$Background/Sap.visible = false
		$Background/Launch.visible = false

func reset_arrows():
	for n in get_node("../Indicators").get_children():
			n.queue_free()

func _on_end_turn_pressed() -> void:
	if GameLogic.check_win() == "Squares":
		$Winner/Squares.visible = true
		return
	elif GameLogic.check_win() == "Circles":
		$Winner/Circles.visible = true
		return
	if auto_setup == true:
		board_auto_setup()
	if PlayerHandler.player_turn == "Squares":
		$Board/CirclesTurn.visible = true
		$Board/SquaresTurn.visible = false
	elif PlayerHandler.player_turn == "Circles":
		$Board/SquaresTurn.visible = true
		$Board/CirclesTurn.visible = false
	show_correct_icons(null)
	PlayerHandler.end_turn()
	auto_setup = false
	
