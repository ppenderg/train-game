extends Node
class_name State

@export var gui : Control;

var parent: Node3D
var hex_map: HexMap

func init(par: Node3D, map: HexMap) -> void:
	parent = par
	hex_map = map
	

func enter() -> void:
	if gui:
		parent.change_canvas(gui);
	
func exit() -> void:
	pass


func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
	
	
