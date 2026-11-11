#!/bin/bash

sudo dnf install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx