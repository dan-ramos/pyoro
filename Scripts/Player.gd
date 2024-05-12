extends CharacterBody3D

var last_direction = 1
var tongueing = false
var sending = true
const SPEED = 5.0
var tongue
var tonguehome
var tonguedest
var tonguepath
var tonguespeed = 18
var retractspeed = 40

var line_radius = 0.1
var line_resoultion = 180
var tonguepos = Vector3(0,0,0)

func _ready():	
	tongue = $Tongue
	tonguehome = $"Tongue Home Marker"
	tonguedest = $"Tongue Final Point"
	tonguepath = $Path3D

func _physics_process(delta):
	if not tongueing:
		handle_walking()
	else:
		handle_tongue(delta)

func handle_walking():
	if Input.is_action_just_pressed("tongue"):
		tongueing = true
		sending = true
	
	var input_dir = Input.get_vector("walk_left", "walk_right", 'ui_up', 'ui_down')
	var direction = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		last_direction = direction.x
		tonguedest.position.x = self.position.x + 40 * direction.x
		tonguedest.position.y = self.position.y + 50 
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func handle_tongue(delta):
	handle_middle_tongue()
	
	if sending:
		var tonguedestpos = tongue.position 
		
		if Input.is_action_pressed("tongue") and sending:
			#tongue.position.x += .2 * last_direction
			#tongue.position.y += .2
			tongue.position = tongue.position.move_toward(tonguedest.position, delta * tonguespeed)
			
		elif Input.is_action_just_released("tongue"):
			sending = false
	else:
		retract(delta)

func handle_middle_tongue():
	tonguepath.curve.clear_points()
	
	tonguepath.curve.add_point(tongue.position * Vector3(1,1.5,1) - self.position)
	tonguepath.curve.add_point(tonguehome.position - self.position)
	

func retract(delta):
	sending = false
	#print('tongue pos',tongue.position)
	#print('tonguehomepos', tonguehome.position)
	tongue.position = tongue.position.move_toward(tonguehome.position, delta * retractspeed)
	if tongue.position == tonguehome.position:
			tongueing = false
			tonguepath.curve.clear_points()

func die():
	print('owie pyoro not feel so good....')
