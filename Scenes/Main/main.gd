extends Control


@onready var grid_container: GridContainer = $MarginContainer/GridContainer
const HIGH_SCORE_DISPLAY = preload("res://Scenes/HighScoreDisplay/high_score_display.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		GameManager.load_next_level()


func set_scores() -> void:
	for score: HighScore in GameManager.high_scores.get_scores_list():
		var high_score_display: HighScoreDisplayItem = HIGH_SCORE_DISPLAY.instantiate()
		high_score_display.setup(score)
		grid_container.add_child(high_score_display)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_scores()
