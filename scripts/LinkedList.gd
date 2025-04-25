class_name SinglyLinkedList
extends Object

var head: ListNode = null
var tail: ListNode = null

func add(data: Object) -> ListNode:
	var new_node = ListNode.new(data)
	if head == null:
		head = new_node
		tail = new_node
	else:
		tail.next = new_node
		tail = new_node
	return new_node

func remove_head() -> Object:
	if head == null:
		return null
	var removed_data = head.object
	head = head.next
	if head == null:
		tail = null
	return removed_data

func remove_node(node: ListNode) -> Object:
	if node == null or head == null:
		return null
	if node == head:
		return remove_head()
	var current = head
	while current != null and current.next != node:
		current = current.next
	if current == null:
		return null
	var removed_data = node.object
	current.next = node.next
	if node == tail:
		tail = current
	return removed_data

func clear():
	while head != null:
		var data = remove_head()
		if data is Node:
			data.queue_free()
