all: build run

build:
	docker build --rm -t atdog/ctf-box .

run:
	docker run --privileged -p 2222:22 -v /Users/atdog/Desktop:/root/desktop --name=ctf -it atdog/ctf-box
