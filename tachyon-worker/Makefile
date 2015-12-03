build_tool = runtime-container.DONE
build_number ?= none
git_commit ?= $(shell git rev-parse HEAD)
nametag = computationalgenomicslab/tachyon-worker:0.8.2

all: ${build_tool}

${build_tool}: Dockerfile start-tachyon-worker.sh
	docker build -t ${nametag} .
	touch ${build_tool}

clean:
	rm ${build_tool}
