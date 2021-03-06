extends Node


###
# Swipe Detector implementation
# Captures a gesture and stores a history of all
# captured gestures.


# Constant Imports

const SwipeGesture = preload('swipe_gesture.gd')

const DetectionState = preload('detection_state.gd')
const GesturePattern = preload('gesture/pattern.gd')

const ShapeMatch = preload('matching/shape_match.gd')
const EuclideanMatch = preload('matching/euclidean_match.gd')


# Singleton Imports

var Directions = preload('directions.gd').new()
var InputProvider = preload('input/input_provider.gd').new()


## Signals

# Signal triggered when swipe captured
signal swiped(gesture)
signal swipe_ended(gesture) # alias for `swiped`

# Signal triggered when swipe started
signal swipe_started(partial_gesture)

# Signal triggered when gesture is updated
signal swipe_updated(partial_gesture)
signal swipe_updated_with_delta(partial_gesture, delta)

# Signal triggered when swipe failed
# This means the swipe didn't pass thresholds and requirements
# to be detected as swipe.
signal swipe_failed()

# Signal triggered when gesture detected
signal pattern_detected(pattern_name, actual_gesture)

## Exported Variables

# Enable or disable gesture detection
export var detect_gesture = true setget detect

# Determine process method to be used
const PROCESS_FIXED = 'Fixed'
const PROCESS_IDLE  = 'Idle'
export (String, 'Idle', 'Fixed') var process_method = PROCESS_FIXED

# Minimum distance between points
export var distance_threshold = 25.0

# Indicate minimum swipe duration
# "A swipe will be a swipe if it the duration
# is at least {{duration_threshold}} seconds"
export var duration_threshold = 0.05

# Maximum duration
# You can the maximum swipe duration
export var limit_duration = false
export var maximum_duration = -1.0

# Minimum swipe points
# "A swipe will be captured if it has at least {{minimum_points}} points
export var minimum_points = 2

# Maximum points
# You can limit points captured so a Swipe will end prematurely
export var limit_points = false
export var maximum_points = -1

# Threshold for gesture detection
export var pattern_detection_score_threshold = 80

# Debug mode: will print debug information
export var debug_mode = false

## Implementation

func debug(message, more1='', more2='', more3=''):
	if debug_mode:
		print('[DEBUG][SwipeDetector] ', message, more1, more2, more3)



onready var gesture_history = []
var swipe_input
onready var ready = true

onready var pattern_detections = {}
onready var detection_areas = []
onready var states

func _ready():
	detection_areas = detect_areas()
	initialize_states()
	swipe_input = InputProvider.get_swipe_input(self)
	set_swipe_process(process_method, detect_gesture)

func detect_areas():
	var areas = []
	for child in get_children():
		if child.get_type() == 'Area2D':
			areas.append(child)
	return areas

func state(area):
	if area != null:
		return states[area.get_name()]
	else:
		return states['_singleton']

func initialize_states():
	states = {}
	if detection_areas.size() > 0:
		for area in detection_areas:
			states[area.get_name()] = DetectionState.new(area.get_name())
	else:
		states['_singleton'] = DetectionState.new()

func _input(ev):
	swipe_input.process_input(ev)

func connect_detection_areas():
	for area in detection_areas:
		area.connect('input_event', swipe_input, 'process_area_input', [area])

func set_swipe_process(method, value):
	if swipe_input.has_method('process_input'):
		if detection_areas.size() > 0:
			connect_detection_areas()
		else:
			set_process_input(value)
	elif swipe_input.has_method('process'):
		if method == PROCESS_IDLE:
			set_process(value)
		elif method == PROCESS_FIXED:
			set_fixed_process(value)

func detect(detect=true):
	if ready == true:
		set_swipe_process(process_method, detect)
		if not detect:
			clean_states()
	return self

func reached_point_limit(area):
	return limit_points and state(area).gesture.point_count() >= maximum_points

func reached_duration_limit(area):
	return limit_duration and state(area).gesture.get_duration() >= maximum_duration

func reached_limit(area):
	return reached_point_limit(area) or reached_duration_limit(area)

func _fixed_process(delta):
	swipe_input.process(delta)

func _process(delta):
	swipe_input.process(delta)

func process_swipe(delta, area=null):
	var state = state(area)
	if not state.capturing and swiping_started(area):
		swipe_start(area)
	elif state.capturing and swiping(area) and not reached_limit(area):
		swipe_update(delta, area)
	elif state.capturing and swiping(area) and reached_limit(area):
		swipe_stop(area, true)
	elif state.capturing and not swiping(area):
		swipe_stop(area)
	state.was_swiping = swiping(area)


func clean_states():
	initialize_states()


func swiping_started(area):
	return not state(area).was_swiping and swiping(area)

func swiping(area):
	return swipe_input.swiping(area)


func swipe_point(area):
	return swipe_input.swipe_point(area)


func swipe_start(area):
	var state = state(area)
	var point = swipe_point(area)
	debug('Swipe started on point ', point)
	state.capturing = true
	state.last_update_delta = 0.0
	state.gesture = SwipeGesture.new(area)
	add_gesture_data(area, point)
	emit_signal('swipe_started', state.gesture)
	return self


func swipe_stop(area, forced=false):
	var state = state(area)
	var gesture = state.gesture
	if gesture.point_count() > minimum_points and gesture.get_duration() > duration_threshold:

		if forced:
			state.capturing = false
		
		var direction = gesture.get_direction()
		
		if direction == "up":
			EventListener.raise("SwipeCommand", Enums.DIRECTION.UP)
		elif direction == "down":
			EventListener.raise("SwipeCommand", Enums.DIRECTION.DOWN)
		elif direction == "left":
			EventListener.raise("SwipeCommand", Enums.DIRECTION.LEFT)
		elif direction == "right":
			EventListener.raise("SwipeCommand", Enums.DIRECTION.RIGHT)

		print('(Direction: ' + gesture.get_direction()  + ')')
		emit_signal('swiped', gesture)
		emit_signal('swipe_ended', gesture)
		gesture_history.append(gesture)
	else:
		debug('Swipe stopped on point ', gesture.last_point(), ' (failed)')
		emit_signal('swipe_failed')
	clean_states()
	return self


func swipe_update(delta, area):
	var state = state(area)
	var gesture = state.gesture
	var point = swipe_point(area)
	state.last_update_delta += delta
	if gesture.last_point().distance_to(point) > distance_threshold:
		debug('Swipe updated with point ', point, ' (delta: ' + str(delta) + ')')
		add_gesture_data(area, point, state.last_update_delta)
		emit_signal('swipe_updated', state.gesture)
		emit_signal('swipe_updated_with_delta', state.gesture, state.last_update_delta)
		state.last_update_delta = 0.0


func add_gesture_data(area, point, delta=0):
	var gesture = state(area).gesture
	gesture.add_point(point)
	gesture.add_duration(delta)
	return self


func history():
	return gesture_history


func set_duration_threshold(value):
	duration_threshold = value
	return self


func set_distance_threshold(value):
	distance_threshold = value
	return self

func points_to_gesture(points):
	return SwipeGesture.new(points)