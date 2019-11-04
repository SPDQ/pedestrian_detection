# pedestrian_detection

## Introduction
I tried three pedestrian detection algorithm. The program can track moving pedestrians in the video. In folder part1, I used two algorithms
to detect pedestrians in a video whose background is static. In imgdif.m, I used frame difference method. In backdif.m, I used background 
difference method. In folder part2, I tried to detect moving pedestrians in a video whose background is not static. The method I used in 
zhongx.m is window tracing method.

## Results
The process of frame difference

<img src='https://github.com/SPDQ/pedestrian_detection/tree/master/part1/fdf.png' width='800'>
<img src='demo/part1/fmor.png' width='800'>
<img src='demo/part1/outcome2.png' width='800'>

The process of background difference

<img src='demo/part1/background.png' width='600'>
<img src='demo/part1/bgdif.png' width='600'>
<img src='demo/part1/bgmor.png' width='600'>
<img src='demo/part1/outcome1.png' width='600'>
