extends PathFollow2D

@export var _speed: float = 50.0


func _physics_process(delta: float) -> void:
	progress += _speed * delta
