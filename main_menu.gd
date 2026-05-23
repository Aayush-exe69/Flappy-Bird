extends Control



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scences/main.tscn")


func _on_settings_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scences/options.tscn")


func _on_exit_3_pressed() -> void:
	get_tree().quit()


func _on_sound_pressed() -> void:
	AudioServer.set_bus_mute(0, !AudioServer.is_bus_mute(0))


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scences/main_menu.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0 , value)
