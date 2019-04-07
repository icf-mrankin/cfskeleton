#!/usr/bin/env bash
cp -R './build/static' './wwwroot'
cp './build/ROOT.war' './build_archive/'$(date +'%Y%m%d_%H%M')'.war'