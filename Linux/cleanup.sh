#!/bin/bash
rm /tmp/* -r  -f
rm /var/tmp/* -r -f
apt clean -y
rm ~/.cache/thumbnails/* -r -f
