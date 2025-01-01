extends RefCounted
class_name Axial


var q = 0
var r = 0


static func create(q0, r0) -> Axial:
	var instance = Axial.new()
	instance.q = q0
	instance.r = r0
	return instance


static func distance(a, b):
	return Cubic.distance(a.to_cubic(), b.to_cubic())
	
static func linedraw(a: Axial, b: Axial) -> Array[Axial]:
	var res = Cubic.linedraw(a.to_cubic(), b.to_cubic())
	var results: Array[Axial] = []
	for cube in res:
		results.append(cube.to_axial())
	return results

func to_cubic() -> Cubic:
	return Cubic.create(q, r, -q-r);


func _to_string() -> String:
	return "(%s,%s)" % [q,r]
