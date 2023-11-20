extends CharacterBody2D

@export var SPEED = 500
@export var zoomSpeed = Vector2(.5, .5)
@export var zoomMin = Vector2(1, 1)
@export var zoomMax = Vector2(5, 5)

var zoom

func _physics_process(_delta):

	velocity = Input.get_vector("pan_left", "pan_right", "pan_up", "pan_down") * SPEED
	move_and_slide()
	
	if Input.is_action_just_pressed("zoom_in"):
		zoom = $Camera2D.zoom + zoomSpeed
		$Camera2D.zoom = zoom.clamp(zoomMin, zoomMax)
		
	if Input.is_action_just_pressed("zoom_out"):
		zoom = $Camera2D.zoom - zoomSpeed
		$Camera2D.zoom = zoom.clamp(zoomMin, zoomMax)
