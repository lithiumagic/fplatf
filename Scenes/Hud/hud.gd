extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel

var _score: int = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		GameManager.load_main()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _enter_tree() -> void:
	SignalHub.score_update_requested.connect(_on_score_update_requested)


func _on_score_update_requested(points: int) -> void:
	_score += points
	score_label.text = "%05d" % _score
