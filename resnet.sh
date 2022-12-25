#!/bin/bash
#SBATCH -p rise # partition (queue)
#SBATCH -D /work/eliciaye/h
#SBATCH --exclude=freddie,havoc,r4,r16,atlas,blaze,flaminio,manchester
##SBATCH --nodelist=bombe
#SBATCH -n 1 # number of tasks (i.e. processes)
#SBATCH --cpus-per-task=1 # number of cores per task
#SBATCH --gres=gpu:1
#SBATCH -t 7-00:00 # time requested (D-HH:MM)
#SBATCH -o resnetcifar_%A.out

pwd
hostname
date
echo starting job...
source ~/.bashrc
conda activate hrank

cd /work/eliciaye/h

# python3 rank_generation.py --arch resnet_56 --gpu 0
# mv ./rank_conv/resnet_56_limit5/* ./rank_conv/resnet_56
NAME=120
# JOB_DIR=./result/resnet_56/rs56_$NAME
# mkdir -p $JOB_DIR
# python main.py --job_dir $JOB_DIR --arch resnet_56 --compress_rate [0.1]+[0.60]*35+[0.0]*2+[0.6]*6+[0.4]*3+[0.1]+[0.4]+[0.1]+[0.4]+[0.1]+[0.4]+[0.1]+[0.4] --gpu 0

python3 evaluate.py --test_model_dir ./result/resnet_56/rs56_$NAME --arch resnet_56 --gpu 0

# python cal_flops_params.py --arch resnet_56 --compress_rate [0.1]+[0.60]*35+[0.0]*2+[0.6]*6+[0.4]*3+[0.1]+[0.4]+[0.1]+[0.4]+[0.1]+[0.4]+[0.1]+[0.4]

echo "All Done."