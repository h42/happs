PROGS=jntp
all:$(PROGS)

jntp:jntp.hs
	ghc -O -fwarn-name-shadowing -dynamic --make jntp.hs -o jntp

install:
	#do not send to /usr/local/bin since sudo will not work there
	install -m755 jntp /usr/bin

clean:
		-rm *.hi *.o $(PROGS)
