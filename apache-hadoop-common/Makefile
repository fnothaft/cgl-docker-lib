# Definitions
build_path = build
runtime_path = runtime
runtime_fullpath = $(realpath $runtime_path)
build_output = apache-hadoop
build_number ?= none
git_commit ?= $(shell git rev-parse HEAD)
nametag = computationalgenomicslab/apache-hadoop-common:2.6.2
build_tool = runtime-container.DONE

build: ${build_output} ${build_tool}

${build_tool}: ${runtime_path}/Dockerfile
	cd ${runtime_path} && docker build -t ${nametag} .
	touch ${build_tool}

${build_output}: ${build_path}/Dockerfile
	cd ${build_path} && docker build -t ${nametag}-build .
	echo "Moving build results to ${fullpath}"
	docker run -v ${runtime_fullpath}:/data ${nametag}-build cp -r /opt/apache-hadoop /data/
	docker run -v ${runtime_fullpath}:/data ${nametag}-build cp -r /opt/hadoop-docker /data/

clean:
	docker rmi -f ${nametag}-build ${nametag}
	rm -rf ${runtime_fullpath}/apache-hadoop ${runtime_fullpath}/hadoop-docker

push: build
	# Requires ~/.dockercfg 
	docker push ${nametag}
