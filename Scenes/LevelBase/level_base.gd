extends Node2D

var _player_ref = Player

var EnemyBullet = preload("res://Scenes/Bullets/enemy_bullet.tscn") # or load()
var PlayerBullet = preload("res://Scenes/Bullets/player_bullet.tscn") # or load()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot_enemy"):
		pass
