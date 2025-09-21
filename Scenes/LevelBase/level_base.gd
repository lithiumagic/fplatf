extends Node2D

var _player_ref = Player

var EnemyBullet = preload("res://Scenes/Bullets/enemy_bullet.tscn") # or load()
var PlayerBullet = preload("res://Scenes/Bullets/player_bullet.tscn") # or load()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot_enemy"):
		pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot_enemy"):
		var e_bullet = EnemyBullet.instantiate()  # Instantiates the scene
		add_child(e_bullet)                   # Adds it to the current scene tree
		e_bullet.position = _player_ref.position
		
	if Input.is_action_just_pressed("shoot_player"):
		var p_bullet = PlayerBullet.instantiate()  # Instantiates the scene
		add_child(p_bullet)                   # Adds it to the current scene tree
		p_bullet.position = _player_ref.position
