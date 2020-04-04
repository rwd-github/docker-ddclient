#!/bin/bash
set -o errexit -o pipefail -o nounset

mypath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

imagetag=ddclient
containername=${imagetag}
#imagetag=rwd1/gui
stdparams=""
additionalparams=""

function build {
	docker system prune --force
	docker build ${stdparams} -t ${imagetag} ${mypath}
}

function run {
	docker run -it --rm ${stdparams} \
	-v ${mypath}/config/:/config \
	--name ${containername} --hostname ${containername} ${additionalparams} ${imagetag} 
}


case $1 in
	b)
	echo "build"
	build
	;;
	r)
	echo "run"
	run
	;;
	br)
	build && run
	;;
	sh)
	additionalparams="--entrypoint /bin/sh"
	run
	;;
	*)
	echo "unbekanntes Kommando: $1"
	;;
esac



