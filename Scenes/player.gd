extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
var score := 0
@onready var targetScore = len($"../CollectableContainer".get_children())

var back := false
func _physics_process(delta: float) -> void:
	if $Sprite2D.texture.fill_to.x > 1.3 and not back:
		$Sprite2D.texture.fill_to.x = lerp($Sprite2D.texture.fill_to.x, 1.2, 0.01)
	else:
		back = true
		$Sprite2D.texture.fill_to.x = lerp($Sprite2D.texture.fill_to.x, 2.0, 0.01)
		if $Sprite2D.texture.fill_to.x > 1.9: back = false
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func _update_UI() -> void:
	$"../UI/VBoxContainer/Score".text = "Score: " + str(score)
	if score >= targetScore:
		$"../UI/Win".show()
