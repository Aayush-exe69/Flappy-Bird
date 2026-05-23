extends Control



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scences/main.tscn")


func _on_settings_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scences/options.tscn")


func _on_exit_3_pressed() -> void:
	get_tree().quit()
