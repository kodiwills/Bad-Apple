extends VideoPlayer

var tex: Texture
var image : Image
var color : Color
var size : Vector2
var cell_size : Vector2

onready var tile_map : TileMap = get_node("TileMap")

func _ready():
	cell_size = tile_map.cell_size


func _process(delta):
	# get image data and unlock it for reading
	tex = get_video_texture()
	image = tex.get_data()
	if not image:
		return
	image.lock()
	
	size = tex.get_size() / cell_size
	size.round()
	for x in size.x:
		for y in size.y:
			var pos : Vector2 = Vector2(x * cell_size.x, y * cell_size.y).round()
			color = image.get_pixelv(pos)
			if color.is_equal_approx(Color.white):
				tile_map.set_cell(x, y, 1)
			else:
				tile_map.set_cell(x, y, 0)
	
	# for every frame get the texture, get the color val for every pixel, then convert to the tilemap
