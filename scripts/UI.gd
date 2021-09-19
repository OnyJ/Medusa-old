extends Control

signal start_game


func show_screen(name):
	match name:
		"GameOver":
			$GameOver.show()
			yield(get_tree().create_timer(1.0), "timeout")
			show_screen("Menu")
		"Menu":
			$GameOver.hide()
			$Menu.show()
		"Game":
			$GameOver.hide()
			$Menu.hide()


func _on_Play_pressed():
	# set scores to 0
	# allow Medusa to move
	show_screen("Game")
	emit_signal("start_game")
