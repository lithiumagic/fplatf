extends Area2D


var _boss_killed: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.boss_killed.connect(boss_killed)


func boss_killed() -> void:
	_boss_killed = true
