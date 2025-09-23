extends Node


signal on_create_bullet(
	pos: Vector2, dir: Vector2, speed: float, 
	ob_type: Constants.ObjectType
	)

func emit_on_create_bullet(
	pos: Vector2, dir: Vector2, speed: float, 
	ob_type: Constants.ObjectType
) -> void:
	on_create_bullet.emit(pos, dir, speed, ob_type)
