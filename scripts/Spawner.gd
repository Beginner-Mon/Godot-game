extends Node2D

var npcScene: PackedScene = preload("res://scene/Characters/npc.tscn")
@onready var spawn_marker = $StartPosition
@onready var target_marker = $TargetPosition
@onready var timer = $Timer
signal reached_target(node: ListNode)

var line: SinglyLinkedList = SinglyLinkedList.new()

var npc_stat: Array[NPCstat] = [
	preload("res://scene/Characters/NPC1.tres")
]

func _ready() -> void:
	timer.start()


func add_npc():
	var new_npc = npcScene.instantiate()
	var node: ListNode
	new_npc.stats = npc_stat[0]
	add_child(new_npc)
	if line.tail != null:
		var previous_obj = line.tail 
		node = line.add(new_npc)

		node.object.target_body = previous_obj.object

		node.object.move_to(node.object.target_body.position) 
	else:
		node = line.add(new_npc)
		node.object.move_to(target_marker.global_position) 
	node.object.global_position = spawn_marker.global_position  
	node.object.reached_target.connect(_on_free_line.bind(node)) 

func remove_first():
	var npc = line.remove_head()
	if npc:
		npc.queue_free()
	if line.head != null: 
		line.head.object.move_to(target_marker.global_position) 

func remove_npc(node: ListNode):
	var npc = line.remove_node(node)
	if npc:
		npc.queue_free()

func _on_free_line(node: ListNode):
	pass


func _on_timer_timeout() -> void:
	if line.Size() >= 5:
		timer.stop()
	else:
		add_npc()
