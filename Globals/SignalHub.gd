extends Node

# SIGNAL: bullet_spawn_requested
# -------------------------------------
# Emitted by: Shooter (player/enemy shooter scripts)
# Listened by: ObjectMaker
# Purpose: Requests creation of a bullet in the game world.
# Arguments:
#   - pos (Vector2): Where the bullet should be spawned
#   - dir (Vector2): Direction the bullet should travel
#   - speed (float): How fast the bullet moves
#   - ob_type (Constants.ObjectType): Enum value for the bullet type
signal bullet_spawn_requested(
	pos: Vector2, dir: Vector2, speed: float, 
	ob_type: Constants.ObjectType
	)


# SIGNAL: object_requested
# -------------------------------------
# Emitted by: enemy_base.gd when die() func is invoked
# Listened by: ObjectMaker
# Purpose: Requests creation of an explosion in the game world.
# Arguments:
#   - pos (Vector2): Where the explosion should be spawned
#   - ob_type (Constants.ObjectType): Enum value for the explosion
signal object_requested(pos: Vector2, ob_type: Constants.ObjectType)
signal score_update_requested(points: int)
signal boss_killed
signal player_hit(lives: int, shake: bool)
signal on_level_complete(complete: bool)


func emit_boss_killed() -> void:
	boss_killed.emit()

func emit_on_level_complete(complete: bool) -> void:
	on_level_complete.emit(complete)


# Wrapper function to emit the `on_create_bullet` signal.
# Allows centralized control over bullet creation logic.
func emit_bullet_spawn_requested(
	pos: Vector2, dir: Vector2, speed: float, 
	ob_type: Constants.ObjectType
) -> void:
	bullet_spawn_requested.emit(pos, dir, speed, ob_type)


func emit_object_requested(pos: Vector2, ob_type: Constants.ObjectType) -> void:
	object_requested.emit(pos, ob_type)


func emit_score_update_requested(points: int) -> void:
	score_update_requested.emit(points)


func emit_player_hit(lives, shake) -> void:
	player_hit.emit(lives, shake)
