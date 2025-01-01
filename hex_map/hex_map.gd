@tool
extends Node3D
class_name HexMap

@export var hex_tile: PackedScene;
@export var cube_mesh: PackedScene; 

@export var radius:= 1;

var map = {};
var selected = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		generate_map(radius, radius);
		print("I am runnign now!");


func add_tile(q, r, click_handler = tile_clicked) -> void:
	if map.has("(%s,%s)" % [q, r]):
		print("(%s, %s) exists already!" % [q, r])
		return  
	var tile = hex_tile.instantiate() as HexTile
	var tile_position = hex_to_pixel(q, r)
	tile.position.x = tile_position.x
	tile.position.z = tile_position.y
	map["(%s,%s)" % [q, r]] = tile;
	if !Engine.is_editor_hint():
		tile.set_axial(q, r)
		tile.connect("clicked", click_handler);
	$Tiles.add_child(tile)

func generate_map(q_radius=3, r_radius=3, click_handler = tile_clicked) -> void:
	q_radius += 1;
	r_radius += 1;
	for i in range(-q_radius, q_radius):
		var r_1 = max(-q_radius, -i-q_radius)
		var r_2 = min(q_radius, -i+q_radius)
		for j in range(r_1, r_2):
			var k = -i-j
			if abs(i) < q_radius && abs(j) < r_radius && abs(k) < r_radius:
				add_tile(i, j, click_handler)
		


func tile_clicked(tile: HexTile) -> void:
	if Engine.is_editor_hint():
		return
	selected.append(tile)
	print(selected)
	if selected.size() == 2:

		var a = selected[0].axial.to_cubic();
		var b = selected[1].axial.to_cubic();
		print("Coordinates: ", a, b)
		print("Distance: ", Cubic.cubic_distance(a, b))
		var path = Cubic.cubic_linedraw(a, b)
		for node in path:
			print(node);
			var instance = cube_mesh.instantiate()
			instance.position = map[node.to_axial().to_string()].position
			instance.position.y += 1
			add_child(instance);
			# map[node.to_axial().to_string()].position.y += 1

	







# Coordinate conversion functions

func axial_to_cube_vector(axial: Vector2) -> Vector3:
	return Vector3(axial.x, axial.y, -axial.x-axial.y)

func axial_to_cube(q, r) -> Vector3:
	return Vector3(q, r, -q-r)

func cube_to_axial_vector(cube: Vector3) -> Vector2:
	return Vector2(cube.x, cube.y)
	
func cube_to_axial(q, r, _s) -> Vector2:
	return Vector2(q, r);

func pixel_to_hex(x: float, y: float) -> Vector2:
	var q = sqrt(3)*x/3 -1.0*y/3;
	var r = 2.0*y/3;
	
	return Vector2(q, r);

func hex_to_pixel(q: int, r: int) -> Vector2:
	var x = sqrt(3)*q + (sqrt(3)/2)*r;
	var y = (3.0/2)*r;
	
	return Vector2(x, y); 



	
