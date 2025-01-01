extends RefCounted
class_name Axial


var q = 0
var r = 0


static func create(q0, r0) -> Axial:
	var instance = Axial.new()
	instance.q = q0
	instance.r = r0
	return instance

func to_cubic() -> Cubic:
	return Cubic.create(q, r, -q-r);


func _to_string() -> String:
	return "(%s,%s)" % [q,r]
