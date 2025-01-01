extends Node3D


var selected = []

@onready var hex_map: HexMap = $HexMap
@onready var state_machine: StateMachine = $StateMachine

@onready var curr_ui: Control = $CanvasLayer/TestUI

func _ready() -> void:
	
	# Generate the hex map, connect tiles to click handler
	hex_map.generate_map(3, 3, tile_clicked)
	
	# Start state machine
	state_machine.init(self, hex_map);
	

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event);

func _process(delta: float) -> void:
	state_machine.process_frame(delta);
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta);



func change_canvas(gui: Control) -> void:
	curr_ui.set_visible(false)
	curr_ui = gui
	curr_ui.set_visible(true)
	
	

func tile_clicked(tile: HexTile) -> void:
	if selected.size() >= 2:
		selected = []
	selected.append(tile)
	if selected.size() == 2:
		hex_map.linedraw(selected[0], selected[1]);
	#print(selected)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		selected = []
