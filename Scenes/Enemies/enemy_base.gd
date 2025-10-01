extends CharacterBody2D

class_name EnemyBase

const FALL_OFF_Y: float = 200.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var points: int = 1
@export var speed: float = 30.0

var _gravity: float = 800.0
var _player_ref: Player


func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)
	if _player_ref == null:
		print('no player ref found')
		queue_free()

func _physics_process(delta: float) -> void:
	if global_position.y > FALL_OFF_Y:
		queue_free()


func flip_me() -> void:
	if _player_ref.global_position.x > global_position.x: # if seen player.
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false



func die() -> void:
	print("Spawning explosion at: ", global_position)
	SignalHub.emit_object_requested(global_position, Constants.ObjectType.EXPLOSION)
	SignalHub.emit_object_requested(global_position, Constants.ObjectType.PICKUP)
	set_physics_process(false)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	pass # Replace with function body.


func _on_hit_box_area_entered(area: Area2D) -> void:
	die()
	queue_free()
