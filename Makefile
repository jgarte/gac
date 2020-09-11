clean:
	rm *.pdf *.midi *.mp3 *.wav

wav:
	timidity chords.midi -Ow -o link-chords.wav

linkc:
	mv chords.pdf link-chords.pdf

linkh:
	mv chords.pdf link-hexachords.pdf
