extends Control

func _ready():
	if !OS.has_feature("standalone") and !game.skipped_title:
		game.skipped_title = true
		call_deferred("open_level_select")

func open_level_select():
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func quit():
	get_tree().quit()

func levels():
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")


func on_survey_pressed():
	game.open_survey()


func sandbox():
	var level_store = get_node("/root/levels")
	game.current_chapter = level_store.chapters.size() - 1
	game.current_level = level_store.chapters[game.current_chapter].levels.size() - 1
	get_tree().change_scene_to_file("res://scenes/main.tscn")
