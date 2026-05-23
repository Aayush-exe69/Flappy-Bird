extends Node

signal hit

@export var pipe_scene : PackedScene


var game_running : bool
var game_over : bool
var scroll
var score

const SCROLL_SPEED : int = 4

var screen_size : Vector2i
var ground_height : int
var pipes : Array

const PIPE_DELAY : int = 100
const PIPE_RANGE : int = 200


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()

	$Ground.hit.connect(_on_ground_hit)

	new_game()

func new_game():
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	$ScoreLabel.text = "SCORE: " + str(score)
	$GameOver.hide()
	get_tree().call_group("Pipes", "queue_free")
	pipes.clear()
	generate_pipes()
	$birds.reset()
	$birds.set_physics_process(true)   # add this
	
func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $birds.flying:
						$birds.flap()
						check_top()

func start_game():
	game_running = true
	$birds.flying = true
	$birds.flap()
	$PipeTimer.start()


func _process(delta: float) -> void:
	if game_running:
		$Ground.position.x -= SCROLL_SPEED

		if $Ground.position.x <= -$Ground.get_node("Sprite2D").texture.get_width():
			$Ground.position.x = 0

		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED


func _on_pipe_timer_timeout() -> void:
	generate_pipes()
	
func generate_pipes():
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.y - ground_height) / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(bird_hit)
	pipe.scored.connect(scored)
	add_child(pipe)
	pipes.append(pipe)

func scored():
	score += 1
	$ScoreLabel.text = "SCORE: " + str(score)
	
func check_top():
	if $birds.position.y < 0:
		$birds.falling = true 
		stop_game()
		
func stop_game():
	$PipeTimer.stop()
	$GameOver.show()
	$birds.flying = false
	game_running = false
	game_over = true
	
func bird_hit():	
	$birds.falling = true
	stop_game()
	


func _on_ground_hit() -> void:
	$birds.velocity = Vector2.ZERO
	$birds.set_physics_process(false)
	stop_game()


func _on_game_over_restart() -> void:
	new_game()
