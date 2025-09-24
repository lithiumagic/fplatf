extends Node

# SIGNAL: on_create_bullet
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

# Wrapper function to emit the `on_create_bullet` signal.
# Allows centralized control over bullet creation logic.
func emit_bullet_spawn_requested(
	pos: Vector2, dir: Vector2, speed: float, 
	ob_type: Constants.ObjectType
) -> void:
	bullet_spawn_requested.emit(pos, dir, speed, ob_type)
