extends Node2D

var rng: RandomNumberGenerator

const POINT = preload("uid://bfttyci3kenta")

@export var initial_point: Node2D

var current_point: Vector2

func _enter_tree() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	current_point = initial_point.global_position

func _ready() -> void:
	run_algorithm()

func _algorithm_stem(position: Vector2) -> Vector2:
	var position_x: float = 0
	var position_y: float = 0.16 * position.y
	
	return Vector2(position_x, position_y)

func _algorithm_small_leafs(position: Vector2) -> Vector2:
	var position_x: float = 0.85 * position.x + 0.04 * position.y
	var position_y: float = -0.04 * position.x + 0.85 * position.y + 1.6
	
	return Vector2(position_x, position_y)

func _algorithm_left_leafs(position: Vector2) -> Vector2:
	var position_x: float = 0.2 * position.x - 0.26 * position.y
	var position_y: float = 0.23 * position.x + 0.22 * position.y + 1.6
	
	return Vector2(position_x, position_y)

func _algorithm_right_leafs(position: Vector2) -> Vector2:
	var position_x: float = -0.15 * position.x + 0.28 * position.y
	var position_y: float = 0.26 * position.x + 0.24 * position.y + 0.44
	
	return Vector2(position_x, position_y)

var times = 0
func run_algorithm():
	var probability = rng.randi_range(1, 100)
	var new_point: Vector2
	
	if probability <= 1:
		new_point = _algorithm_stem(current_point)
	elif probability <= 86:
		new_point = _algorithm_small_leafs(current_point)
	elif probability <= 93:
		new_point = _algorithm_left_leafs(current_point)
	else: 
		new_point = _algorithm_right_leafs(current_point)
	
	instantiatePoint(new_point)
	times += 1
	
	if times < 1000:
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().process_frame
		run_algorithm()

func instantiatePoint(_pos : Vector2):
	var _node: Node2D = POINT.instantiate()
	add_child(_node)
	_node.global_position = _pos
	current_point = _pos
	print("pos: ", _pos)
