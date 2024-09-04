extends Area2D

signal died
signal shield_changed


@export var cooldown = 0.3
@export var bullet_scene : PackedScene
@export var speed = 180
@onready var screensize = get_viewport_rect().size
var can_shoot = true
@export var max_shield = 100
var shield = max_shield

func _ready():
	$Timer.wait_time = cooldown

func set_shield(value):
	shield = min(max_shield, value)
	shield_changed.emit(max_shield, shield)
	if shield <= 0:
		hide()
		died.emit()

func _on_area_entered(area):
	if area.is_in_group("enemies"):
		area.explode()
		shield -= max_shield / 2

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	$Timer.start()
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(position + Vector2(0,-8))

func _process(delta):
	if Input.is_action_pressed("shoot"):
		shoot()
	var input = Input.get_vector("left", "right", "up", "down")
	if input.x > 0:
		$PlayerShip.frame = 2
		$AnimatedSprite2D.animation = "right"
	elif input.x <0:
		$PlayerShip.frame = 0
		$AnimatedSprite2D.animation = "left"
	else:
		$PlayerShip.frame = 1
		$AnimatedSprite2D.animation= "forward"
	
	position += input * speed * delta
	position = position.clamp(Vector2(8,8), screensize-Vector2(8,16))

func _on_timer_timeout():
	can_shoot = true



	
