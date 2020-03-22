.PHONY: all clean

all: neske.nes

neske.nes: *.asm
	nesasm neske.asm

clean:
	rm *.fns
	rm *.nes
	rm *.deb