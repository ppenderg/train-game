extends Node3D
class_name HexTile


signal clicked(tile: HexTile)


var axial = Axial.create(0, 0);

var y = 0


func _on_area_3d_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton && event.pressed && event.button_index == 1:
		# set_y(10+y)
		clicked.emit(self)
		print("Hello!")
		

func set_axial(q, r):
	axial.q = q;
	axial.r = r;

func set_axial_vector(vec: Vector2):
	axial.q = vec.x;
	axial.r = vec.y
	
func get_axial(): 
	return axial;


func set_y(height: int):
	y = height
	position.y = y*.1
