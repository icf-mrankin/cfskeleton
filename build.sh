#!/usr/bin/env bash
cp -R './build/static' './wwwroot'
mkdir -p './build_archive'
cp './build/ROOT.war' './build_archive/'$(date +'%Y%m%d_%H%M')'.war'