extends Control

@onready var slot_scene = preload("res://Scenes/slot.tscn")
@onready var board_grid = $Board/BoardGrid
@onready var piece_scene = preload("res://Scenes/piece.tscn")
@onready var arrow_scene = preload("res://Scenes/arrows.tscn")
@onready var indicator_scene = preload("res://Scenes/indicators.tscn")

var grid_array := []
var movement_indicators = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.ready_to_add_piece.connect(add_piece)
	SignalBus.show_correct_icons.connect(show_correct_icons)
	SignalBus.movement_options.connect(show_movement_indicators)
	SignalBus.reset_movement_options.connect(reset_movement_indicators)
	SignalBus.reset_ability_indicators.connect(reset_arrows)
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	#Ruby
	add_piece(0, Vector2(1,10)) #Ruby-C1
	add_piece(7, Vector2(1,-10)) #Ruby-S1
	add_piece(0, Vector2(1,11)) #Ruby-C2
	add_piece(7, Vector2(1,-11)) #Ruby-S2
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
	add_piece(3, Vector2(1,8)) #Jade-C1
	add_piece(10, Vector2(1,-8)) #Jade-S1
	add_piece(3, Vector2(1,9)) #Jade-C2
	add_piece(10, Vector2(1,-9)) #Jade-S2
	
func create_slot():
	var new_slot = slot_scene.instantiate()
	board_grid.add_child(new_slot)
	grid_array.append(new_slot)

func add_piece(piece_type, location)->void:
	if DataHandler.slot_is_empty() && piece_type not in [5,12]:
		var new_piece = piece_scene.instantiate()
		get_node("../Gameplay").add_child(new_piece)
		new_piece.type = piece_type
		new_piece.load_icon(piece_type)
		new_piece.global_position = DataHandler.board_dict[location].global_position + DataHandler.piece_offset
		new_piece.slot_ID = location
		DataHandler.piece_dict[new_piece.slot_ID] = new_piece
	elif DataHandler.slot_is_empty() && piece_type in [5,12] && DataHandler.golden_lines_dict.has(location):
		var new_piece = piece_scene.instantiate()
		get_node("../Gameplay").add_child(new_piece)
		new_piece.type = piece_type
		new_piece.load_icon(piece_type)
		new_piece.global_position = DataHandler.board_dict[location].global_position + DataHandler.piece_offset
		new_piece.slot_ID = location
		DataHandler.piece_dict[new_piece.slot_ID] = new_piece
	else:
		SignalBus.toggle_add_piece.emit(piece_type)
	DataHandler.clicked_piece = null
		
func _on_ruby_pressed() -> void:
	SignalBus.toggle_add_piece.emit(0)

func _on_pearl_pressed() -> void:
	SignalBus.toggle_add_piece.emit(1)
	
func _on_amber_pressed() -> void:
	SignalBus.toggle_add_piece.emit(2)
	
func _on_jade_pressed() -> void:
	SignalBus.toggle_add_piece.emit(3)

func _on_amalgam_pressed() -> void:
	SignalBus.toggle_add_piece.emit(4)

func _on_portal_pressed() -> void:
	SignalBus.toggle_add_piece.emit(5)

func _on_void_pressed() -> void:
	SignalBus.toggle_add_piece.emit(6)

func _on_remove_piece_pressed() -> void:
	DataHandler.remove = true

#Portal Swap
func _on_portal_swap_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$Background/PortalSwap.button_pressed = true
		DataHandler.swap_ready = DataHandler.clicked_piece
	else:
		$Background/PortalSwap.button_pressed = false
		DataHandler.swap_ready = null

#Fireball
func _on_fireball_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$Background/Fireball.button_pressed = true
		DataHandler.fireball_ready = true
		var count = 0
		if DataHandler.ruby_indicator_coord != null:
			for arr_step in DataHandler.ruby_targets.size():
				if DataHandler.ruby_targets[arr_step] != []:
					for targets in DataHandler.ruby_targets[arr_step].size():
						if DataHandler.ruby_targets[arr_step][targets] != []:
							print(DataHandler.ruby_indicator_coord)
							var ruby_data = DataHandler.ruby_indicator_coord[targets+count]
							var arrow = arrow_scene.instantiate()
							get_node("../Indicators").add_child(arrow)
							arrow.global_position = DataHandler.board_dict[ruby_data[0]].global_position + DataHandler.arrow_offset
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
							arrow.global_position = DataHandler.board_dict[pearl_data[0]].global_position + DataHandler.arrow_offset
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
		$Background/Sap.button_pressed = true
		DataHandler.sap_ready = true
		if DataHandler.amber_indicator_coord != null:
			for i in DataHandler.amber_targets.size():
				for amber_data in DataHandler.amber_indicator_coord[i]:
					var arrow = arrow_scene.instantiate()
					get_node("../Indicators").add_child(arrow)
					print(DataHandler.amber_indicator_coord)
					print(DataHandler.amber_targets)
					arrow.global_position = DataHandler.board_dict[amber_data[0]].global_position + DataHandler.arrow_offset
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
		$Background/Launch.button_pressed = true
		DataHandler.launch_ready = true
		for i in DataHandler.jade_targets.size():
			for n in DataHandler.jade_targets[i]:
				var indicator = indicator_scene.instantiate()
				get_node("../Indicators").add_child(indicator)
				indicator.global_position = DataHandler.board_dict[n].global_position + DataHandler.arrow_offset
				#Set Data for instance
				indicator.pos = n
				indicator.targets = DataHandler.jade_targets[i]
	else:
		$Background/Launch.button_pressed = false
		DataHandler.launch_ready = false
		reset_arrows()
	
func _on_setup_pressed() -> void:
	for n in get_node("../Gameplay").get_children():
			n.queue_free()
	DataHandler.piece_dict = {}
	board_setup()
	
func show_movement_indicators(coord_arr):
	for i in coord_arr:
		for child in $Board/BoardGrid.get_children():
			if child.slot_ID == i:
				movement_indicators.append(child)
				child.get_node("Sprite2D").visible = true

func reset_movement_indicators():
	for i in DataHandler.board_dict:
		for slot in movement_indicators:
			slot.get_node("Sprite2D").visible = false

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
	else:
		$Background/PortalSwap.visible = false
		$Background/Fireball.visible = false
		$Background/TidalWave.visible = false
		$Background/Sap.visible = false
		$Background/Launch.visible = false

func reset_arrows():
	for n in get_node("../Indicators").get_children():
			n.queue_free()
