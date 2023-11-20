extends Control
var showPopUp = false
var currentPop = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	%PieceDescription.visible = false
	%Ability.visible = false
	%FocusAbility.visible = false

func set_ability(ability, image):
	%Ability.visible = true
	%AbilityIcon.texture = load(image)
	%AbilityName.text = ability
	
func GetPos(icon):
	%PieceDescription.global_position = icon.global_position + Vector2(%PieceList.size.x + 15, 0)

func focus_ability():
	%FocusAbility.visible = !%FocusAbility.visible
	
func _on_use_ability_toggled(button_pressed):
	if button_pressed == true:
		global.activate_ability(%AbilityName.text)
		#for tutorial
		%FocusAbility.visible = false
		if get_tree().current_scene.gameMode == "tutorial":
			get_node("../..").jade()
	else:
		global.activate_ability("none")
		for spot in global.spot_array:
			get_node("../DropSpots/" + spot).green_active(false)
		for spot in global.spot_array_taken:
			get_node("../DropSpots/" + spot).blue_active(false)
		#for tutorial
		if get_tree().current_scene.gameMode == "tutorial":
			get_node("../../RubyArrow").visible = false
			get_node("../../RubyNum").visible = false
			get_node("../../PearlArrow").visible = false
			get_node("../../PearlNum").visible = false
			get_node("../../JadeArrow").visible = false
			get_node("../../JadeNum").visible = false
			#get_node("../../AmberArrow").visible = false
			#get_node("../../AmberNum").visible = false


func _on_amalgam_button_toggled(button_pressed):
	GetPos(%AmalgamIcon)
	if button_pressed == true:
		%Pop_Title.text = "Amalgam:"
		%Pop_Details.text = "Acts as any one of the other Gems. The Amalgam is a wild card that can be either a Ruby, Jade, Amber, or Pearl"	
		%PieceDescription.visible = true
	else:
		%PieceDescription.visible = false

func _on_void_button_toggled(button_pressed):
	GetPos(%VoidIcon)
	if button_pressed == true:
		%Pop_Title.text = "Void:"
		%Pop_Details.text = "Move to the intersection on the opponent's center-half to win the game. Piece is also able to amplify abilities to increase range, as well as remove enemy portals."	
		%PieceDescription.visible = true
	else:
		%PieceDescription.visible = false

func _on_amber_button_toggled(button_pressed):
	GetPos(%AmberIcon)
	if button_pressed == true:
		%Pop_Title.text = "Amber:"
		%Pop_Details.text = "Amber removes from play all valid opponent pieces between it, as long as they are on a connecting intersection line. Increased to on line on either side if amplified by the Void"	
		%PieceDescription.visible = true
	else:

		%PieceDescription.visible = false

func _on_jade_button_toggled(button_pressed):
	GetPos(%JadeIcon)	
	if button_pressed == true:
		%Pop_Title.text = "Jade:"
		%Pop_Details.text = "Launches a piece behind the two Jades up to 4 intersections from the front piece. Increased two six if amplified by the Void."	
		%PieceDescription.visible = true
	else:
		%PieceDescription.visible = false

func _on_pearl_button_toggled(button_pressed):
	GetPos(%PearlIcon)
	if button_pressed == true:
		%Pop_Title.text = "Pearl:"
		%Pop_Details.text = "Creates a wave that removes enemy pieces in front up to 4 intersections and 2 intersections on each side. Increased to 5 in front and 3 on each side if amplified by the Void."	
		%PieceDescription.visible = true
	else:
		%PieceDescription.visible = false

func _on_ruby_button_toggled(button_pressed):
	GetPos(%RubyIcon)
	if button_pressed == true:
		%Pop_Title.text = "Ruby:"
		%Pop_Details.text = "Remove the first enemy piece in front of the two Rubys up to six intersections. Increased to 8 if amplified by the Void. May not pass through your other pieces."	
		%PieceDescription.visible = true
	else:
		%PieceDescription.visible = false

func _on_portal_button_toggled(button_pressed):
	GetPos(%PortalIcon)	
	if button_pressed == true:
		%Pop_Title.text = "Portal:"
		%Pop_Details.text = "May swap with any of your other pieces that are on a golden intersection. Other pieces (both you and your opponent) may jump over the portal in a strait line when using basic movement."	
		%PieceDescription.visible = true
	else:
		%PieceDescription.visible = false
