extends Button

func _on_pressed():
	get_parent().get_parent().dialogue_start()
	queue_free()
