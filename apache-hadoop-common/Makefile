# Definitions
build_path = build
runtime_path = runtime
runtime_fullpath = "${PWD}/${runtime_path}"
build_output = apache-hadoop-common
build_number ?= none
git_commit ?= $(shell git rev-parse HEAD)
nametag = computationalgenomicslab/apache-hadoop-common:2.6.2
build_tool = runtime-container.DONE

build: ${build_output} ${build_tool}

${build_tool}: ${runtime_path}/Dockerfile ${runtime_path}/apache-hadoop ${runtime_path}/hadoop-docker
	cd ${runtime_path} && docker build -t ${nametag} .
	touch ${build_tool}

${runtime_path}/apache-hadoop: ${build_output}
	echo "Moving apache-hadoop from container to ${runtime_fullpath}"
	docker run -v ${runtime_fullpath}:/data ${nametag}-build cp -rf /opt/apache-hadoop /data/
	
	# tomcat files must be writable
	chmod -R ugoa+rw ${runtime_fullpath}/apache-hadoop/share/hadoop/*/tomcat/

${runtime_path}/hadoop-docker: ${build_output}
	echo "Moving hadoop-docker from container to ${runtime_fullpath}"
	docker run -v ${runtime_fullpath}:/data ${nametag}-build cp -rf /opt/hadoop-docker /data/

${build_output}: ${build_path}/Dockerfile
	cd ${build_path} && docker build -t ${nametag}-build .

clean:
	rm -rf ${runtime_fullpath}/apache-hadoop ${runtime_fullpath}/hadoop-docker ${build_tool}
	docker rmi -f ${nametag}-build ${nametag}

push: build
	# Requires ~/.dockercfg 
	docker push ${nametag}
