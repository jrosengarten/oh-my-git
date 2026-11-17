extends Window

signal entered(text)
signal cancelled

func _text_entered(text):
	hide()
	entered.emit(text)
	queue_free()

func _close_requested():
	hide()
	cancelled.emit()
	queue_free()

func _visibility_changed():
	if visible:
		$LineEdit.grab_focus()
