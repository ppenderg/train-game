extends Node3D
class_name HexTile


signal clicked(tile: HexTile)


var axial = Axial.create(0, 0);

var y = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.pressed && event.button_index == 1:
		set_y(10+y)
		clicked.emit(self)
		print("Hello!")
		

func set_axial(q, r):
	axial.q = q;
	axial.r = r;

func set_axial_vector(position: Vector2):
	axial.q = position.x;
	axial.r = position.y
	
func get_axial(): 
	return axial;


func set_y(height: int):
	y = height
	position.y = y*.1
