extends CharacterBody2D

# --- CONFIGURAÇÔES ---
const MAX_SPEED := 300.0 #Velocidade máxima horizontal
const ACCELERATION := 1200.0 #O quão rápido ele chega na velocidade máxima
const  FRICTION := 1600.0 #O quão rápido ela desacelera 
const JUMP_VELOCITY := -500.0 # No Godot, o eixo Y negativo aponta para cima

var can_double_jump := false # Código preparado, mas desativado

func _physics_process(delta: float) -> void: # Essa função roda 60 vezes por segundo
	apply_gravity(delta)
	handle_jump()
	handle_horizontal_movement(delta)
	move_and_slide()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity().y * delta #Aplica gravidade suavemente. Multiplicar por delta para manter estavel
		
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
		
#Camera2D
func _ready() -> void:
	var camera = $Camera2D
	var tilemap = $"../TileMapLayer"
	
	var used_rect = tilemap.get_used_rect() #A área onde existe tiles. Em quantidade de tiles
	var tile_size = tilemap.tile_set.tile_size # Isso retorna Vector2 (32, 32)
	
	#Cálculo do mapa
	var map_width = used_rect.size.x * tile_size.x
	var map_height = used_rect.size.y * tile_size.y
	# Se tiver: 100 tiles
	# 100 x 32 = 3200 pixels
	
	# Limites da camera
	camera.limit_left = 0
	camera.limit_top = 0
	camera.limit_right = map_width 
	camera.limit_bottom = map_height 
