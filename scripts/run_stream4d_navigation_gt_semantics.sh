#!/bin/bash

export OLLAMA_BASE_URL="${OLLAMA_BASE_URL:-http://localhost:11434}"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source /opt/ros/humble/setup.bash

cd $SCRIPT_DIR
cd ../ai_module
source ./install/setup.bash
ros2 launch language_planner stream4d_gt_semantics_launch.xml ll_model:=qwen3.6:35b
