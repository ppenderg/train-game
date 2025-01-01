extends State


@export var test_state: State;


func enter() -> void:
	super()
	
func exit() -> void:
	super()


func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("exit"):
		hex_map.add_tile(5, -5)
		return test_state;
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
	
	
