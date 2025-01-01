extends State


@export var default_state: State

func enter() -> void:
	super()
	
func exit() -> void:
	super()


func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("exit"):
		return default_state
	
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null
	
	
