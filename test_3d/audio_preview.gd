extends MeshInstance3D

var stream = preload("res://short-adventurous-intro-1-117090.ogg")
var preview

func _ready():
	var gen = AudioStreamPreviewGenerator.new()
	gen.connect("preview_complete", _on_preview_complete)
	preview = gen.generate_preview(stream)
	
func _on_preview_complete(stream_id):
	if stream.get_instance_id() != stream_id:
		return
		
	print(preview.get_length())
	var imageSize = Vector2i(1024,256)
	var rectLine = Rect2i(0,0,1,0)
	var image = Image.create(imageSize.x,imageSize.y, false, Image.FORMAT_RGBA8)
	
	image.fill(Color.BLACK)
	var previewLen = preview.get_length()
	for i in range(0, imageSize.x):
		var ofs = i * previewLen / imageSize.x
		var ofs_n = (i+1) * previewLen / imageSize.x
		var max = preview.get_max(ofs, ofs_n) * 0.5 + 0.5
		var min = preview.get_min(ofs, ofs_n) * 0.5 + 0.5
		rectLine.position.x = i;
		rectLine.size.y = (max - min) * imageSize.y
		rectLine.position.y = (imageSize.y - rectLine.size.y) * 0.5	
		image.fill_rect(rectLine,Color.YELLOW)
		
	var texture = ImageTexture.create_from_image(image)
	var mat = get_active_material(0)
	mat.albedo_texture = texture
	mat.albedo_color = Color.WHITE

func _process(delta):
	pass
