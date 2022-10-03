extends CanvasLayer

func show_text(title, sub):
	$Title.text = title
	$SubText.text = sub
	$Title.visible = true
	$SubText.visible = true
	$Timer.start()

func _on_timer_timeout():
	$Title.visible = false
	$SubText.visible = false
