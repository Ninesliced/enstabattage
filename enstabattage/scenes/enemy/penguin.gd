extends Enemy

@export var move_back_force = 100.0

var base_velocity_y: float

func _ready():
	super()
	
	base_velocity_y = velocity.y


func _physics_process(delta):
	velocity.y = move_toward(velocity.y, base_velocity_y, move_back_force*delta)

	super(delta)
