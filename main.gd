extends Node2D


var enemy = preload("res://enemy.tscn")
var score = 0
signal died

func _ready():
	spawn_enemies()

func spawn_enemies():
	for x in range(9):
		for y in range(4):
			var e = enemy.instantiate()
			var pos = Vector2(x * (16 + 8) + 24, 26 * 4 + y * 16)
			add_child(e)
			e.start(pos)
			e.died.connect(_on_enemy_died)

func _on_enemy_died(value):
	score += value
	$CanvasLayer/UI.update_score(score)

func update_shield() -> void:
	pass # Replace with function body.
