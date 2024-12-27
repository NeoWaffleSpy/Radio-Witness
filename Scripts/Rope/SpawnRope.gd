extends Node

var piece_length := 4
var rope_part := []

func spawnRope(start: Vector3, end: Vector3) -> void:
	var length := start.distance_to(end)
	var num_pieces := length / piece_length
	#var piece_vector := (end - start) / num_pieces
	#for i in range(num_pieces):
		#var piece := RopePiece.new()
		#piece.position = start + piece_vector * i
		#piece.rotation = Quat(Vector3(0, 0, 1), atan2(piece_vector.y, piece_vector.x))
		#rope_part.append(piece)
		#get_parent().add_child(piece)