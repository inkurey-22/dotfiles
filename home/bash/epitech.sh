# All the epitech related stuff

alias epitest='docker run --rm --security-opt "label:disable" -it -v $(pwd):/usr/src/project epitechcontent/epitest-docker /bin/bash -c "cd /usr/src/project; exec bash"'

function tek_pdf() {
    cwd=$(pwd)
    files_to_convert=$(find -maxdepth 1 -name '*.md')
    docker run --rm --privileged -v "$cwd":/work -w="/work" ghcr.io/epitech/docker-md-converter:master -y '$(dirname "$cwd")'.yaml $files_to_convert
}
