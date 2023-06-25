extends ColorRect

var stream = preload("res://short-adventurous-intro-1-117090.ogg")
var preview

func _ready():
	var gen = AudioStreamPreviewGenerator.new()
	gen.connect("preview_updated", _on_preview_updated)
	preview = gen.generate_preview(stream)
	
func _on_preview_updated(stream_id):
	if stream.get_instance_id() == stream_id:
		queue_redraw()

func _draw():
	var rect = get_rect()
	var rectSize = rect.size
	var previewLen = preview.get_length()
	for i in range(0, rectSize.x):
		var ofs = i * previewLen / rectSize.x
		var ofs_n = (i+1) * previewLen / rectSize.x
		var max = preview.get_max(ofs, ofs_n) * 0.5 + 0.5
		var min = preview.get_min(ofs, ofs_n) * 0.5 + 0.5
		draw_line(Vector2(i,  min * rectSize.y), 
		Vector2(i, max * rectSize.y), Color(1, 1, 0, 1), 1, false)
