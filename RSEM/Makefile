# Definitions
build_path = build/
runtime_path = runtime/
build_output1 = ${runtime_path}rsem-calculate-expression
build_output2 = ${runtime_path}rsem_perl_utils.pm
runtime_fullpath = $(realpath ${runtime_path})
build_tool = runtime-container.DONE
build_number ?= none
git_commit ?= $(shell git rev-parse head)

# Steps
all: ${build_output1} $(build_output2) ${build_tool}

${build_output1} $(build_output2): ${build_path}Dockerfile
	cd ${build_path} && docker build -t rsembuild . 
	docker run -v ${runtime_fullpath}:/data rsembuild cp rsem-calculate-expression /data
	docker run -v ${runtime_fullpath}:/data rsembuild cp rsem_perl_utils.pm /data

${build_tool}: ${build_output1} $(build_output2) ${runtime_path}Dockerfile
	cd ${runtime_path} && docker build -t computationalgenomicslab/rsem:1.1.7--src--unstable--${git_commit}--${build_number} .
	docker rmi -f rsembuild
	touch ${build_tool}

push: all
	# Requires ~/.dockercfg 
	docker push computationalgenomicslab/rsem:1.1.7--src--unstable--${git_commit}--${build_number}
