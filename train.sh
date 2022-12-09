#!/bin/bash -l

# Job name
#SBATCH --job-name=UwU
#SBATCH --mail-type=NONE
#SBATCH --mail-user=yuhangli@andrew.cmu.edu

#SBATCH -p gpu
#SBATCH --gres=gpu:1

#SBATCH --time 0-24:00:00
#SBATCH --output=/lab_data/barblab/AlexP/will/train-dl/%A_%a.out
#SBATCH --mem=16GB

module load anaconda3

hostname
echo "job starting"
cd /lab_data/barblab/AlexP/will/train-dl/
conda activate DLPJ
python train.py -c config.yaml
echo "job finished"
