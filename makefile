CFLAGS=-Wall
CLG = -fwarn-name-shadowing --make -O -dynamic

SFLAGS=-static -optl-static -optl-pthread

PROGS=ffilib.o sujit new hgrep hsize jntp words ctemp

%.o : %.hs
	ghc $(CLG) -c -o $@ $<

% : %.hs
	ghc $(CLG) -o $@ $<


all:$(PROGS)

hsize:hsize.hs ffilib.o
	ghc $(CLG) -o hsize hsize.hs ffilib.o

install:
	#do not send to /usr/local/bin since sudo will not work there
	install -m755 new /usr/local/bin
	install -m755 jntp /usr/bin
	install -o 0 -g 0 -m4711 sujit /usr/local/bin/

clean:
		-rm *.hi *.o $(PROGS)
