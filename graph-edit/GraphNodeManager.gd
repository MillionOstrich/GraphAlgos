extends Node2D

#Color to draw edges
export var edge_color = Color(1.0, 1.0, 1.0)
export var edge_thickness = 1
#export var edge_font = Font()

var node_scene = preload("GraphNodeScene.tscn")

#Internal structure for holding edges
var edges = []
class GraphEdge:
	var from
	var to
	var cost
	
	func contains_node(_node):
		return from == _node or to == _node


func add_node(_pos):
	pass
	
func remove_node(_name):
	pass

func add_edge(_from, _to, _cost):
	var edge = GraphEdge.new()
	edge.from = _from
	edge.to = _to
	edge.cost = _cost
	edges.push_back(edge)
	
func remove_edge(_index):
	edges.remove(_index)

func get_nearest_edge(_pos, _maxDist):
	var point = make_canvas_pos_local(_pos)
	var near_edge = null
	var near_dist = _maxDist * _maxDist
	for e in edges:
		var from = get_node(e.from).get_pos()
		var to = get_node(e.to).get_pos()
		var dist = _line_distance2(from,to,point)
		if dist < near_dist:
			neat_dist = dist
			near_edge = e

func _line_distance2(_la, _lb, _pt):
	var ap = _pt - _la
	var ab = _lb - _la
	var dab = ab.length_squared()
	
	if dab < 0.01:
		return ap.length_squared()
	else:
		var t = min(max(ap.dot(ab) / dab,0),1)
		return _pt.distance_square_to(_la+ab*t)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process():
	update()
	
func _draw():
	for e in edges:
		var from = get_node(e.from).get_pos()
		var to = get_node(e.to).get_pos()
		draw_line(from,to,edge_color,edge_thickness)
		#draw_string(edge_font,(from+to)/2," " + e.cost,edge_color)
	