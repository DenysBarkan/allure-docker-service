#!/bin/bash

echo "Cleaning results"

if [ "$(ls -A $RESULTS_DIRECTORY | wc -l)" != "0" ]; then
    if [ -e $RESULTS_HISTORY ]; then
        if [ "$(ls -A $RESULTS_HISTORY | wc -l)" != "0" ]; then
            rm -rf $TEMP_RESULTS_HISTORY/*
            cp --recursive --preserve=timestamps -rf $RESULTS_HISTORY/* $TEMP_RESULTS_HISTORY
            rm -rf $RESULTS_DIRECTORY/*
            cp --recursive --preserve=timestamps -rf $TEMP_RESULTS_HISTORY $RESULTS_HISTORY
        fi
    else
        rm -rf $RESULTS_DIRECTORY/*
    fi
fi

$ROOT/keepAllureHistory.sh
$ROOT/generateAllureReport.sh
$ROOT/renderEmailableReport.sh
