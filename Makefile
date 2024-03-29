.PHONY: deps test train play play-gui play-human

LEVEL="snakeai/levels/10x10-blank.json"

build:
	docker build -t python3 .

run:
	docker run -it -v .:project python3 /bin/bash

deps:
	python3 -m pip install --upgrade -r requirements.txt

test:
	PYTHONPATH=$(PYTHONPATH):. py.test snakeai/tests

train:
	./train.py --level $(LEVEL) --num-episodes 30000

play:
	./play.py --interface cli --agent dqn --model dqn-final.model --level $(LEVEL) --num-episodes 100

play-gui:
	./play.py --interface gui --agent dqn --model dqn-final.model --level $(LEVEL) --num-episodes 10

play-human:
	./play.py --interface gui --agent human --level $(LEVEL) --num-episodes 1
