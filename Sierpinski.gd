extends Node2D


@onready var Left: Node2D = $Node2D3
@onready var Right: Node2D = $Node2D2
@onready var Top: Node2D = $Node2D

const POINT:PackedScene = preload("uid://bfttyci3kenta")
var auxPoint : Vector2

var Vertex : Array[Node2D] = []
var isRunning = false
var rng

func _ready() -> void:
	print(Vertex)
	Vertex =  [Left, Right, Top]
	rng = RandomNumberGenerator.new()
	rng.randomize()
	var pos : Vector2 = (Left.global_position - Right.global_position - Top.global_position) / 2
	instantiatePoint(pos)

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Start"):
		if !isRunning:
			isRunning = true
			StartTriangle()
		else:
			isRunning = false

var times = 0
func StartTriangle():
	var randomIndex = rng.randi_range(0, Vertex.size() - 1)
	var selectedVertex = Vertex[randomIndex]
	var pos : Vector2 = (selectedVertex.global_position - auxPoint) / 2
	
	instantiatePoint(pos)
	times += 1
	
	if isRunning and times < 10000:
		await get_tree().process_frame
		StartTriangle()
	

func instantiatePoint(_pos : Vector2):
	var _node: Node2D = POINT.instantiate()
	add_child(_node)
	_node.global_position = _pos
	auxPoint = _pos
	print("pos: ", _pos)
