extends Camera2D

var V := 10

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		position.x += 1 * V
	if Input.is_action_pressed("ui_left"):
		position.x -= 1 * V
	if Input.is_action_pressed("ui_down"):
		position.y += 1 * V
	if Input.is_action_pressed("ui_up"):
		position.y -= 1 * V
