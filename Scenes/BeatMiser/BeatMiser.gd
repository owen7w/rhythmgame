extends Node
class_name BeatMiser

#var inputTimes: Array = [];
var lastBeat: int = Time.get_ticks_msec();
const WINDOW: int = 110;

signal DownBeat;

func _ready() -> void:
	$MidiPlayer.midi_event.connect(
		func(channel, event):
			if (event.type == 0x90 && event.note == 0):
				DownBeat.emit();
	)
	DownBeat.connect(
		func():
			lastBeat = Time.get_ticks_msec();
	)
	$MidiPlayer.play();
func upTempo() ->void:
	$MidiPlayer.set_tempo($MidiPlayer.tempo + 2);

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("ui_accept")):
		#handling slightly late presses is trivial
		if (Time.get_ticks_msec() - lastBeat < WINDOW):
			print("hit late") #late success
		#otherwise, wait and see if a beat is coming
		else:
			var waiter = BeatWaiter.new();
			waiter.BeatSignal = DownBeat;
			waiter.MaxWaitTime = (WINDOW / 1000.0);
			call_deferred("add_child", waiter);
			var success = await waiter.Interrupt;
			if (success): 
				print("hit early") #early success
			else: 
				print("miss")
				upTempo();
