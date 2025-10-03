extends CharacterBody2D

class_name Player


const DAMAGE = preload("res://assets/sound/damage.wav")
const JUMP = preload("res://assets/sound/jump.wav")

@export var fallen_off_y: float = 500.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel
@onready var shooter: Shooter = $Shooter
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var hurt_timer: Timer = $HurtTimer

#const GRAVITY: float = 690.0
#const JUMP_SPEED: float = -270.0
const RUN_SPEED: float = 150.0
const MAX_FALL: float = 350.0
const GRAVITY: float = 2000.0  # increased
const JUMP_SPEED: float = -540.0  # increased
const HURT_JUMP_VELOCITY: Vector2 = Vector2(0, -130.0)

var is_hurt: bool = false


func _ready() -> void:
	pass


func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)
	
 
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	get_input()

	velocity.y = clampf(velocity.y, JUMP_SPEED, MAX_FALL)
	
	move_and_slide()
	update_debug_label()
	fallen_off()


func play_effect(effect: AudioStream) -> void:
	sound.stop()
	sound.stream = effect
	sound.play()


func get_input() -> void:
	if is_hurt == true:
		return
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_SPEED
		play_effect(JUMP)
	
	# wall jump
	if is_on_wall() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_SPEED
		sound.play()

	# shoot
	var shoot_dir: Vector2 = Vector2.LEFT if sprite_2d.flip_h else Vector2.RIGHT
	if Input.is_action_just_pressed("shoot"):
		shooter.shoot(shoot_dir)
		

	velocity.x = RUN_SPEED * Input.get_axis("left", "right")
	if not is_equal_approx(velocity.x, 0.0):
		sprite_2d.flip_h = true if velocity.x < 0 else false
	


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

func apply_hurt_jump() -> void:
	is_hurt = true
	velocity = HURT_JUMP_VELOCITY
	play_effect(DAMAGE)
	hurt_timer.start()

func apply_hit() -> void:
	apply_hurt_jump()

func _on_hit_box_area_entered(area: Area2D) -> void:
	call_deferred("apply_hit")
	


func _on_hurt_timer_timeout() -> void:
	is_hurt = false
