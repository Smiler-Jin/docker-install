#!/bin/bash
project_path='/home/wangdigang/work/docker_work/docker_install'
container_id='80745e514eda'
install_path='/home/wangdigang'

function copyFiles() {
  docker cp ${project_path}/docker_install.sh ${container_id}:${install_path}
  docker cp ${project_path}/Anaconda3-2020.11-Linux-x86_64.sh ${container_id}:${install_path}
  docker cp ${project_path}/software ${container_id}:${install_path}
}

# transfer install files
copyFiles
