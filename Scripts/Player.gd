extends CharacterBody3D

var last_direction
var tongueing = false
var sending = true
const SPEED = 5.0
var tongue
var tonguehome
var tonguedest

func _ready():	
	tongue = $Tongue
	tonguehome = $"Tongue Home Marker"
	tonguedest = $"Tongue Final Point"

func _physics_process(delta):
	handle_tongue()
	if not tongueing:
		handle_walking()

func handle_walking():
	if Input.is_action_just_pressed("tongue"):
		tongueing = true
		sending = true
	
	var input_dir = Input.get_vector("walk_left", "walk_right", 'ui_up', 'ui_down')
	var direction = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		last_direction = direction.x
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func handle_tongue():
	var tonguedestpos = tongue.position 
	
	if Input.is_action_pressed("tongue") and sending:
		tongue.position.x += .2
		tongue.position.y += .2
		
	elif Input.is_action_just_released("tongue"):
		retract()

func retract():
	sending = false
	#print('tongue pos',tongue.position)
	#sprint('tonguehomepos', tonguehome.position)
	tongue.position = tonguehome.position
	tongueing = false

func die():
	print('owie pyoro not feel so good....')
