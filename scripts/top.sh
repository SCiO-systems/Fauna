#!/bin/bash

for chunk in 1 2 3 4 5 
do
universe        = docker
docker_image    = dapaciat/r_3.6.0:latest
executable      = /bin/bash
arguments       =  try1.sh
queue 1
--export=chk=1,i=$chunk  
done

