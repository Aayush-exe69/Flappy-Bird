extends Node2D

signal hit
signal scored

func _ready():
	add_to_group("Pipes")

func _on_body_entered(body: Node2D) -> void:
	print("HIT")
	hit.emit()

func _on_score_area_body_entered(body: Node2D) -> void:
	if body.name == "birds":
		scored.emit()
