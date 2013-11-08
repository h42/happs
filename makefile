PROGS=sujit jntp new words

all:$(PROGS)

SFLAGS=-static -optl-static -optl-pthread

sujit:sujit.hs
	ghc -O -fwarn-name-shadowing -dynamic --make sujit.hs -o sujit

jntp:jntp.hs
	ghc -O -fwarn-name-shadowing -dynamic --make jntp.hs -o jntp

new:new.hs
	ghc -O -fwarn-name-shadowing -dynamic --make new.hs -o new

words:words.hs
	ghc -O -fwarn-name-shadowing -dynamic --make words.hs -o words

install:
	#do not send to /usr/local/bin since sudo will not work there
	install -m755 pretty /usr/local/bin
	install -m755 jntp /usr/bin
	install -o 0 -g 0 -m4711 sujit /usr/local/bin/

clean:
		-rm *.hi *.o $(PROGS)
