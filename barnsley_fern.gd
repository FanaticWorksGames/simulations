extends Node2D

var rng: RandomNumberGenerator

const POINT = preload("uid://bfttyci3kenta")

@export var initial_point: Node2D

var current_point: Vector2
var times = 0

func _enter_tree() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	current_point = initial_point.position

func _process(_delta: float) -> void:
	for i in range(100):
		run_algorithm()

func _algorithm_stem(new_position: Vector2) -> Vector2:
	var position_x: float = 0
	var position_y: float = 0.16 * new_position.y
	
	return Vector2(position_x, position_y)

func _algorithm_small_leafs(new_position: Vector2) -> Vector2:
	var position_x: float = 0.85 * new_position.x + 0.04 * new_position.y
	var position_y: float = -0.04 * new_position.x + 0.85 * new_position.y + 1.6
	
	return Vector2(position_x, position_y)

func _algorithm_left_leafs(new_position: Vector2) -> Vector2:
	var position_x: float = 0.2 * new_position.x - 0.26 * new_position.y
	var position_y: float = 0.23 * new_position.x + 0.22 * new_position.y + 1.6
	
	return Vector2(position_x, position_y)

func _algorithm_right_leafs(new_position: Vector2) -> Vector2:
	var position_x: float = -0.15 * new_position.x + 0.28 * new_position.y
	var position_y: float = 0.26 * new_position.x + 0.24 * new_position.y + 0.44
	
	return Vector2(position_x, position_y)

func run_algorithm():
	var probability = rng.randf()
	var new_point: Vector2
	
	if probability <= 0.01:
		new_point = _algorithm_stem(current_point)
	elif probability <= 0.86:
		new_point = _algorithm_small_leafs(current_point)
	elif probability <= 0.93:
		new_point = _algorithm_left_leafs(current_point)
	else: 
		new_point = _algorithm_right_leafs(current_point)
	
	instantiatePoint(new_point)

func instantiatePoint(point_position: Vector2):
	var _node: Node2D = POINT.instantiate()
	
	add_child(_node)
	#_node.global_position = point_position * 30
	var map_x: float = point_position.x
	var map_y: float = point_position.y * - 1
	var new_position: Vector2 = Vector2(map_x, map_y) * 100
	
	_node.global_position = Vector2(new_position.x, new_position.y + 25)
	current_point = point_position
