extends CharacterBody2D

class_name Player

@export var fallen_off_y: float = 500.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel

#const GRAVITY: float = 690.0
#const JUMP_SPEED: float = -270.0
const RUN_SPEED: float = 150.0
const MAX_FALL: float = 350.0

const GRAVITY: float = 2000.0  # increased
const JUMP_SPEED: float = -540.0  # increased



func _ready() -> void:
	pass


func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)
	
 
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_SPEED

	velocity.x = RUN_SPEED * Input.get_axis("left", "right")
	if not is_equal_approx(velocity.x, 0.0):
		sprite_2d.flip_h = true if velocity.x < 0 else false
	
	velocity.y = clampf(velocity.y, JUMP_SPEED, MAX_FALL)
	
	move_and_slide()
	update_debug_label()
	fallen_off()

func update_debug_label() -> void:
	var debug_str: String = ""
	debug_str += "Floor: %s\n" % [is_on_floor()]
	debug_str += "V: %1.f, %1.f\n" % [velocity.x, velocity.y]
	debug_str += "P: %1.f, %1.f" % [global_position.x, global_position.y]
	debug_label.text = debug_str


func fallen_off() -> void:
	if global_position.y  > fallen_off_y:
		queue_free()
	pass
