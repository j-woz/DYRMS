#!/bin/sh
set -eu

export TURBINE_LOG=0 TURBINE_DEBUG=0 ADLB_DEBUG=0
swift-t cctw.swift $*
