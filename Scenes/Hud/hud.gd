extends Control

const GAME_OVER = preload("res://assets/sound/game_over.ogg")
const YOU_WIN = preload("res://assets/sound/you_win.ogg")

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var hb_hearts: HBoxContainer = $MarginContainer/HBHearts
@onready var color_rect: ColorRect = $ColorRect
@onready var vb_game_over: VBoxContainer = $ColorRect/VBGameOver
@onready var vb_complete: VBoxContainer = $ColorRect/VBComplete
@onready var complete_timer: Timer = $CompleteTimer
@onready var sound: AudioStreamPlayer = $Sound




var _score: int = 0
var _hearts: Array
var _can_continue: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		GameManager.load_main()
	if _can_continue and event.is_action_pressed("shoot"):
		GameManager.load_main()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_hearts = hb_hearts.get_children()
	_score = GameManager.cached_score
	_on_score_update_requested(0)


func _enter_tree() -> void:
	SignalHub.score_update_requested.connect(_on_score_update_requested)
	SignalHub.player_hit.connect(_on_player_hit)
	SignalHub.on_level_complete.connect(on_level_complete)


func _exit_tree() -> void:
	GameManager.try_add_new_score(_score)


func _on_player_hit(lives, shake) -> void:
	for index in range(_hearts.size()):
		_hearts[index].visible = lives > index
	if lives <= 0:
		on_level_complete(false)


func on_level_complete(complete: bool) -> void:
	color_rect.show()
	if complete:
		vb_complete.show()
		sound.stream = YOU_WIN
	else:
		vb_game_over.show()
		sound.stream = GAME_OVER

	sound.play()
	get_tree().paused = true
	complete_timer.start()




func _on_score_update_requested(points: int) -> void:
	_score += points
	score_label.text = "%05d" % _score


func _on_complete_timer_timeout() -> void:
	_can_continue = true
