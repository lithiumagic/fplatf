extends Node2D


const OBJECT_SCENES: Dictionary[Constants.ObjectType, PackedScene] = {
	Constants.ObjectType.BULLET_PLAYER: preload("res://Scenes/Bullets/player_bullet.tscn"),
	Constants.ObjectType.BULLET_ENEMY: preload("res://Scenes/Bullets/enemy_bullet.tscn"),
	Constants.ObjectType.EXPLOSION: preload("res://Scenes/Explosion/explosion.tscn"),
	Constants.ObjectType.PICKUP: preload("res://Scenes/fruit_pickup/fruit_pickup.tscn")
}



func _enter_tree() -> void:
	# Connect to global signal that requests bullet creation.
	# This function will respond to all emitted bullet requests.
	SignalHub.bullet_spawn_requested.connect(_on_bullet_requested)
	SignalHub.object_requested.connect(_on_object_requested)


func _on_bullet_requested(
	pos: Vector2, dir: Vector2, speed: float, ob_type: Constants.ObjectType) -> void:
	if OBJECT_SCENES.has(ob_type) == false:
		print('NO SUCH OBJECT!')
		return
	var new_bullet: Bullet = OBJECT_SCENES[ob_type].instantiate()  # where did type Bullet come from?
	new_bullet.setup(pos, dir, speed)
	call_deferred("add_child", new_bullet)


func _on_object_requested(pos: Vector2, ob_type: Constants.ObjectType) -> void:
	if OBJECT_SCENES.has(ob_type) == false:
		print('NO SUCH OBJECT!')
	var new_obj: Node2D = OBJECT_SCENES[ob_type].instantiate()
	new_obj.global_position = pos
	print("Explosion instanced at: ", pos)
	call_deferred("add_child", new_obj)
	
