clean:
	rm *.pdf *.midi *.mp3 *.wav

wav:
	timidity chords.midi -Ow -o link-chords.wav
