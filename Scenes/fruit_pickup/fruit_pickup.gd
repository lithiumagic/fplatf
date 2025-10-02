extends Area2D


@export var points: int = 2

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sound: AudioStreamPlayer2D = $Sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var list_names: Array[String] = []
	for anim_name in animated_sprite_2d.sprite_frames.get_animation_names():
		list_names.push_back(anim_name)
		
	animated_sprite_2d.animation = list_names.pick_random()
	animated_sprite_2d.play()

func _on_area_entered(area: Area2D) -> void:
	hide()
	set_deferred("monitoring", false)
	sound.play()


func _on_sound_finished() -> void:
	queue_free()
