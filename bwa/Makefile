#Definitions
build_path = build
runtime_path = runtime
build_output = ${runtime_path}/bwa
runtime_fullpath = $(realpath ${runtime_path})
build_tool = runtime-container.DONE
build_number ?= none
git_commit ?= $(shell git rev-parse head)

#Steps
all: ${build_output} ${build_tool}

${build_output}: ${build_path}/Dockerfile
	cd ${build_path} && docker build -t bwabuild .
	docker run -v ${runtime_fullpath}:/data bwabuild cp bwa /data

${build_tool}: ${build_output} ${runtime_path}/Dockerfile
	cd ${runtime_path} && docker build -t bwa--src--unstable--${git_commit}--${build_number} .
	docker rmi -f bwabuild
	touch ${build_tool}

push: all
	# Requires ~/.dockercfg
	docker push bwa--src--unstable--${git_commit}--${build_number}
