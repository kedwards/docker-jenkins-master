#!/usr/bin/env bash

set -Eeo pipefail

OPTS=':n:v:r:h'
SCRIPT_NAME=$(basename $(readlink -nf $0) ".sh")
SCRIPT_DIR=$(dirname $(readlink -f "$0"))
REPO_NAME=kevinedwards

show_help()
{
    cat << EOF
Usage: ${SCRIPT_NAME}.sh -n <image_name> -v <image_version> [-r <repository_name>] [-h]
Run the installer, with following options:
  -r  repository name default: ${REPO_NAME}
  -n  image name
  -v  image version
  -h  display help

EOF
}

OPTIND=1
while getopts ${OPTS} OPT
do
  case "${OPT}" in
    h)  show_help
        exit 1;;
    n)  IMAGE_NAME=$OPTARG;;
    r)  REPO_NAME=$OPTARG;;
    v)  VERSION=$OPTARG;;
    \?)	# unknown flag
    	show_help
        exit 1;;
  esac
done

shift $(($OPTIND - 1))

trap show_help INT

[ -z ${IMAGE_NAME} ] && show_help && exit 1

docker build --no-cache -t "${REPO_NAME}/${IMAGE_NAME}:${VERSION}" ${SCRIPT_DIR} && \
docker image tag "${REPO_NAME}/${IMAGE_NAME}:${VERSION}" "${REPO_NAME}/${IMAGE_NAME}:latest"

cat > ${SCRIPT_DIR}/jenkins-master.sh <<EOF
#!/usr/bin/env bash
set -Eeuo pipefail

docker container run --rm -idt \
--name ${IMAGE_NAME} \
--env JAVA_OPTS=-Dhudson.footerURL=http://kevinedwards.ca \
--p 8080:8080
-v /vagrant/jenkins_home:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
${REPO_NAME}/${IMAGE_NAME}:latest \
"\$@"
EOF
