extends Area2D

#func _on_body_shape_entered(body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
#	if body is TileMap:
#		_process_tilemap_collision(body, body_rid)

#func _process_tilemap_collision(body: Node2D, body_rid: RID) -> void:
#	var tilemap = body
#	var tile_coords = tilemap.get_coords_for_body_rid(body_rid)
#	for i in tilemap.get_layers_count():
#		var tile = tilemap.get_cell_tile_data(i, tile_coords)
#		if !tile is TileData:
#			continue
#		var kill = tile.get_custom_data_by_layer_id(0) # True or false for if deadly
#		if kill:
#			get_tree().reload_current_scene()
#		break

func _process(_delta):
	for body in get_overlapping_bodies():
		if (body.name == "Blue Portal" or body.name == "Orange Portal"):
			get_tree().reload_current_scene()
