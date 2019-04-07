#!/usr/bin/env bash
cp -R './build/static' './wwwroot/static'
cp './build/ROOT.war' './build_archive/'$(date +'%Y%m%d_%H%M')'.war'