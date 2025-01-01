extends Node
class_name StateMachine

@export var start_state: State

var current_state: State;



func init(parent: Node3D, hex_map: HexMap) -> void:
	
	for child in get_children():
		child.init(parent, hex_map)
	
	change_state(start_state);
	
	


func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	print("Changed to ", new_state)
	current_state.enter()





func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)	

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)	
	
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)	
	
