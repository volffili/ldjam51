extends CanvasLayer

func show_text(title, sub, c = Color.WHITE):
	if $death.visible:
		return
	$Title.modulate = c
	$SubText.modulate = c
	$Title.text = title
	$SubText.text = sub
	$Title.visible = true
	$SubText.visible = true
	$Timer.start()

func _on_timer_timeout():
	$Title.visible = false
	$SubText.visible = false

func _on_restart_pressed():
	get_tree().reload_current_scene()

func win():
	$win.visible = true
