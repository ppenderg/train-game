extends RefCounted
class_name Cubic

# 0: North east
# 1: East
# 2: South east
# 3: South west

# var cubic_direction_vectors = [
# 	Cubic.create(1, -1, 0),
# 	Cubic.create(1, 0, -1),
# 	Cubic.create(0, 1, -1),
# 	Cubic.create(-1, 1, 0),
# 	Cubic.create(-1, 0, 1),
# 	Cubic.create(0, -1, 1),
# ]

var q = 0
var r = 0
var s = 0


# Static Functions
static func create(q0, r0, s0) -> Cubic:
	var instance = Cubic.new();
	instance.q = q0;
	instance.r = r0;
	instance.s = s0;
	return instance;

static func cubic_add(a, b):
	return Cubic.create(a.q+b.q, a.r+b.r, a.s+b.s);

static func cubic_subtract(a, b):
	return Cubic.create(a.q-b.q, a.r-b.r, a.s-b.s);
	
static func cubic_distance(a, b):
	var vec = cubic_subtract(a, b)
	return max(abs(vec.q), abs(vec.r), abs(vec.s));

static func cubic_lerp(a: Cubic, b:Cubic, t) -> Cubic:
	return Cubic.create(lerp(a.q, b.q, t), lerp(a.r, b.r, t), lerp(a.s, b.s, t));

static func cubic_linedraw(a: Cubic, b: Cubic):
	var N = cubic_distance(a, b)
	var results = []
	for i in range(0, N+1):
		results.append(cubic_lerp(a, b, i*1.0/N).cubic_round())
	return results
	

func cubic_round():
	var q1 = round(q)
	var r1 = round(r)
	var s1 = round(s)

	if q1 == -0: q1 = 0
	if r1 == -0: r1 = 0
	if s1 == -0: s1 = 0
	
	var q_diff = abs(q1-q)
	var r_diff = abs(r1-r)
	var s_diff = abs(s1-s)
	
	
	if q_diff > r_diff && q_diff > s_diff:
		q1 = -r1-s1
	elif r_diff > s_diff:
		r1 = -q1-s1
	else:
		s1 = -q-r
	
	return Cubic.create(q1, r1, s1)


# Methods







func to_axial() -> Axial:
	return Axial.create(q, r)

func _to_string() -> String:
	return "(%s,%s,%s)" %[q, r, s]
