build_tool = runtime-container.DONE
nametag = fnothaft/gatk-hc:3.5

build: ${build_tool}

${build_tool}: Dockerfile hc.sh
	docker build -t ${nametag} .
	touch ${build_tool}

push: build
	# Requires ~/.dockercfg 
	docker push ${nametag}

test: build
