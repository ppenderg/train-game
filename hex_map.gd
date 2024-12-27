@tool
extends Node3D


@export var hex_tile: PackedScene;
@export var cube_mesh: PackedScene; 

@export var radius:= 1;

var map = {};
var selected = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		print("I am runnign now!");
	generate_map(radius, radius);



func generate_map(q_radius, r_radius) -> void:
	q_radius += 1;
	r_radius += 1;
	for i in range(-q_radius, q_radius):
		var r_1 = max(-q_radius, -i-q_radius)
		var r_2 = min(q_radius, -i+q_radius)
		for j in range(r_1, r_2):
			var k = -i-j
			if abs(i) < q_radius && abs(j) < r_radius && abs(k) < r_radius:
				#print(i, ",", j,",", k)
				var tile = hex_tile.instantiate() as HexTile; 
				var tile_position = hex_to_pixel(i, j);
				if !Engine.is_editor_hint():
					tile.set_axial(i, j);
				#tile.q = i;
				#tile.r = j;
				tile.position.x = tile_position.x;
				tile.position.z = tile_position.y;
				#if Engine.is_editor_hint():
					#print(Vector3(i,j,k), tile_position, tile.position, pixel_to_hex(tile.position.x, tile.position.z));
				map["(%s,%s)" % [i, j]] = tile;
				
				if !Engine.is_editor_hint():
					tile.connect("clicked", tile_clicked);
				tile.name = "(%s,%s)" % [i,j]
				$Tiles.add_child(tile);
		





func tile_clicked(tile: HexTile) -> void:
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
	
func cube_to_axial(q, r, s) -> Vector2:
	return Vector2(q, r);

func pixel_to_hex(x: float, y: float) -> Vector2:
	var q = sqrt(3)*x/3 -1.0*y/3;
	var r = 2.0*y/3;
	
	return Vector2(q, r);

func hex_to_pixel(q: int, r: int) -> Vector2:
	var x = sqrt(3)*q + (sqrt(3)/2)*r;
	var y = (3.0/2)*r;
	
	return Vector2(x, y); 



	
