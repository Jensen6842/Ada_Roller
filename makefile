make:
	gprclean -r -P build.gpr
	gprbuild -p -P build.gpr
	obj/main
test:
	gprclean -r -P build.gpr
	gprbuild -p -P build.gpr
	obj/main -t "4d20 + 2d10 + 7" 5
	obj/main -t "23 + 2d30" 5
	obj/main -t "4d20 + 2d10 + 7 + 1d34" 5
	obj/main -t "4d20+2d10+7" 5
	obj/main -t "4324d45320 + 2231d10532 + 7" 5
clean:
	gprclean -r -P build.gpr
build:
	gprbuild -p -P build.gpr
run:
	obj/main