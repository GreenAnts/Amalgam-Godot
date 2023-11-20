extends Control
var SMscene = preload("res://Scenes/SettingsMenu/SettingsMenu.tscn")
var GameScene = preload("res://Scenes/Game/Game.tscn")
var BGscene = preload("res://Scenes/MainMenu/BG.tscn")
var TutorialScene = preload("res://Scenes/Tutorial/Tutorial.tscn")

var GameStarted = false
var gameMode : String

func _on_ready():
	$SettingsMenu/CanvasLayer.visible = false
	$CanvasLayer/PanelContainer/VBoxContainer/ReturnMenu.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") && GameStarted == true:
		toggle()

func _on_start_btn_pressed():
	GameStarted = true
	gameMode = "game"
	toggle()
	var instance = GameScene.instantiate()
	add_child(instance)
	swapMenu()

func _on_tutorial_btn_pressed():
	GameStarted = true
	gameMode = "tutorial"
	toggle()
	var instance = TutorialScene.instantiate()
	add_child(instance)
	swapMenu()
	
func _on_settings_btn_pressed():
	$SettingsMenu/CanvasLayer.visible = !$SettingsMenu/CanvasLayer.visible

func _on_quit_btn_pressed():
	get_tree().quit()

func _on_return_menu_pressed():
	GameStarted = false
	gameMode = "none"
	if get_node_or_null("Game"):
		$Game.queue_free()
	else:
		$Tutorial.queue_free()
		State.tutorial_step = 0
	swapMenu()
	swapBG()
	$SettingsMenu/CanvasLayer.visible = false
	
# 						 #
# Custom Functions Below #
# 						 #

func toggle():
	$CanvasLayer.visible = !$CanvasLayer.visible 
	$SettingsMenu/CanvasLayer.visible = false
	swapBG()
	
#Background for Menu
func swapBG():
	if GameStarted == true && get_node_or_null("BG") != null:
		$BG.queue_free()
	elif GameStarted == false && get_node_or_null("BG") == null:
		var instance = BGscene.instantiate()
		add_child(instance)

func swapMenu():
	#Start Button
	if $CanvasLayer/PanelContainer/VBoxContainer/StartBtn.visible == true:
		$CanvasLayer/PanelContainer/VBoxContainer/StartBtn.visible = false
	else:
		$CanvasLayer/PanelContainer/VBoxContainer/StartBtn.visible = true
		
	#Tutorial Button
	if $CanvasLayer/PanelContainer/VBoxContainer/TutorialBtn.visible == true:
		$CanvasLayer/PanelContainer/VBoxContainer/TutorialBtn.visible = false
	else:
		$CanvasLayer/PanelContainer/VBoxContainer/TutorialBtn.visible = true
		
	#ReturnMenu Button
	if $CanvasLayer/PanelContainer/VBoxContainer/ReturnMenu.visible == true:
		$CanvasLayer/PanelContainer/VBoxContainer/ReturnMenu.visible = false
	else:
		$CanvasLayer/PanelContainer/VBoxContainer/ReturnMenu.visible = true
