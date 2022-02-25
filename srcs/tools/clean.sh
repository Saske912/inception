#!/bin/bash

sudo docker rm -f $(sudo docker ps -aq)
sudo docker volume rm -f $(sudo docker volume ls | gawk '{print $2}')