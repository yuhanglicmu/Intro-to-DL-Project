# Intro-to-DL-Project-
HiFi GAN training and implementation according to
https://arxiv.org/abs/2006.05694

**Structure**
![alt text](https://github.com/yuhanglicmu/Intro-to-DL-Project/blob/main/HiFi-GAN.png)

**Generator G:**

1. Feedforward WaveNet:

Initially used in text-to-speech tasks and generate a more smooth and human-like sound. It will be used for denoising purposes.
It uses the autoregressive convolutional structure that maps the input sound wave into values predicted in Q channels [0, Q]. A larger Q is equivalent to a more vivid voice because it allow the outputs have higher dimension.

2. Input: speech with noise & speech with no noise

3. Training step 1: 
Train it with 70K (500K in paper) steps and lr = 0.001
Use L1 and spectrogram loss*spectrogram loss ensures the input and output are similar sound
Make sure the WaveNet grasps the waveform of the speech (warm-up)

**Postnet (Posterior Network):**

Probabilistic model: have a Conv layer and tanh activation

1. Training step 2: 
train the Feedforward and Postnet together
50K (500K in paper) steps and lr = 0.0001
use L1 and spectrogram loss 

**Four Discriminators**

3 Waveform discriminators with downsampling (16kHz, 8kHz, 4kHz)
This also improves the denoising performance as well as enhances speech clarity and speaker identity. (potentially helpful for the MOS score)

1. Mel Spec Discriminator
The input spectrogram is obtained by STFT of the output wave from the Postnet
This discriminator is useful in eliminating the long tail dereverberation

2. Training step 3: 
Training the Generator with lr =0.00001
Four discriminators are randomly initialized at lr = 0.001 for about 85K (500K in paper) steps
Use adversarial losses and deep feature matching losses (need more analysis)
Update the discriminators twice for every step of the generator
Optimizer: Adam

**How to use the code:**
1. Install the required packages with requirement.txt (Use the python 3.6.*)
2. Download the data speech via https://keithito.com/LJ-Speech-Dataset/
3. Put the data under the directory in config.yaml
4. Run the train.sh file in the command window, edit it according to your cluster

The log file for tensor board and .pth file cannot be uploaded because of the large size.
The .out file can be viewed to check the trainging process. (1XX.out & 2XX.out)
