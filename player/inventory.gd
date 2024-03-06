extends Control

onready var grid = $CenterContainer/GridContainer
var populated_inventory = false
var count = 0

func _ready():
	hide()
	
func _process(delta):
	if Input.is_action_pressed("close_inventory"):
		hide()
		get_tree().paused = false

func show():
	if !populated_inventory:
		populate_inventory()
		populated_inventory = true
	visible = true
	$CenterContainer/GridContainer/item_control.grab_focus()

func hide():
	populated_inventory = false
	visible = false
	
func populate_inventory():
	for item in PlayerData.inventory:
		grid.get_child(count).get_child(0).get_child(0).texture = load("res://room/" + item + ".png")
		count = count + 1
	count = 0
