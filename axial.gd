extends RefCounted
class_name Axial


var q = 0
var r = 0


static func create(q, r) -> Axial:
	var instance = Axial.new()
	instance.q = q
	instance.r = r
	return instance

func to_cubic() -> Cubic:
	return Cubic.create(q, r, -q-r);


func _to_string() -> String:
	return "(%s,%s)" % [q,r]
