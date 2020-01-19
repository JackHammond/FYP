FROM docker/whalesay:latest
LABEL Name=ms_flutter_front_end Version=0.0.1
RUN apt-get -y update && apt-get install -y fortunes
CMD /usr/games/fortune -a | cowsay
