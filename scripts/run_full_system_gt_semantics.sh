#!/bin/bash

export OLLAMA_BASE_URL="${OLLAMA_BASE_URL:-http://localhost:11434}"
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source /opt/ros/humble/setup.bash

cd $SCRIPT_DIR
source ../simulator/wheelchair_unity/install/setup.bash
source ../ai_module/install/setup.bash

cd ../simulator/wheelchair_unity
./src/vehicle_simulator/mesh/unity/environment/Model.x86_64 &
ros2 launch language_planner vehicle_simulator_gt_semantics_launch.xml &
sleep 5

cd $SCRIPT_DIR
cd ../ai_module
ros2 launch language_planner sort3d_gt_semantics_launch.xml ll_model:=qwen3.6:27b captioner_batch_size:=4 object_query_type:=clip
