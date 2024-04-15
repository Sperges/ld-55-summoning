extends Node3D

const spirit_scene := preload("res://scenes/spirit.tscn")


var round := 0
var spirits := [10, 20, 30]


func _ready():
	GameEvents.map_altered.connect(_on_map_altered)
	spawn_spirits()


func _on_map_altered(str: String) -> void:
	if str == "chamber_01" or str == "chamber_02":
		spawn_spirits()


func spawn_spirits() -> void:
	for i in spirits[round]:
		var spirit = spirit_scene.instantiate()
		add_child(spirit)
		var pos := Vector3.FORWARD.rotated(Vector3.UP, randf_range(0, 2 * PI)) * randf_range(0, 42)
		spirit.position = pos + Vector3(0, randf_range(0, 5), 0)
	round += 1
