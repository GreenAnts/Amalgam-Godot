extends StaticBody2D

var spot_active = false
var spot_taken = false

func _ready():
	visible = false
	if get_tree().current_scene.gameMode == "tutorial":
		%Red.visible = true
		%Green.visible = false
		%Blue.visible = false
	else:
		%Red.visible = false
		%Green.visible = true
		%Blue.visible = false
	
func _process(delta):
	if global.is_dragging == false && visible == true && spot_active == false:
		visible = false
		
func red_active():
	visible = true
	%Red.visible = true
	%Green.visible = false
	%Blue.visible = false

func green_active(active):
	spot_active = active
	if active == true:
		visible = true
		%Red.visible = false
		%Green.visible = true
		%Blue.visible = false
	else:
		visible = false
		%Red.visible = true
		%Green.visible = false
		%Blue.visible = false

func blue_active(active):
	spot_active = active
	if active == true:
		visible = true
		%Red.visible = false
		%Green.visible = false
		%Blue.visible = true
	else:
		visible = false
		%Red.visible = true
		%Green.visible = false
		%Blue.visible = false
	
