extends EnemyBase

var _seen_player: bool = false
var _can_jump: bool = false

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity.y += delta * _gravity

	move_and_slide()
	flip_me()


func flip_me() -> void:
	if _player_ref.global_position.x > global_position.x: # if seen player.
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false


func apply_jump() -> void:
	if not is_on_floor() or not _can_jump or not _seen_player:
		return
	
		

func _on_jump_timer_timeout() -> void:
	_can_jump = true
