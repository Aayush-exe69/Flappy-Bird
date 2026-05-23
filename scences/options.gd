extends Control


func _on_sound_pressed() -> void:
	AudioServer.set_bus_mute(0, !AudioServer.is_bus_mute(0))


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scences/main_menu.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0 , value)
