extends CharacterBody2D

# --- CONFIGURAÇÔES ---
const MAX_SPEED := 300.0
const ACCELERATION := 1200.0
const  FRICTION := 1600.0
const JUMP_VELOCITY := -500.0 # No Godot, o eixo Y negativo aponta para cima

var can_double_jump := false # Código preparado, mas desativado

func _physics_process(delta: float) -> void: # Essa função roda 60 vezes por segundo
	apply_gravity(delta)
	handle_jump()
	handle_horizontal_movement(delta)
	move_and_slide()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
		
func handle_jump() -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func handle_horizontal_movement(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		# aceleta suavemente até a velocidade máxima
		velocity.x = move_toward(
			velocity.x,
			direction * MAX_SPEED,
			ACCELERATION * delta
		)
	else:
		#desaceleração suave quando solta o botão
		velocity.x = move_toward(
			velocity.x,
			0,
			FRICTION * delta
		)
		
		
		
		
		
