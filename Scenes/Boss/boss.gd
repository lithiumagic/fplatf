extends Node2D


@onready var animation_tree: AnimationTree = $AnimationTree
@onready var hit_box: Area2D = $Visuals/HitBox
@onready var shooter: Shooter = $Visuals/Shooter

var _player_ref: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)
	if _player_ref == null:
		print('no player ref found')
		queue_free()



func activate_collisions() -> void:
	hit_box.set_deferred("monitorable", true)
	hit_box.set_deferred("monitoring", true)


func _on_trigger_area_entered(_area: Area2D) -> void:
	animation_tree["parameters/conditions/on_trigger"] = true


func boss_shoot() -> void:
	var shoot_dir: Vector2 = shooter.global_position.direction_to(_player_ref.global_position)
	shooter.shoot(shoot_dir)
