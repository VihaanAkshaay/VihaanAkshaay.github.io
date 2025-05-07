---
layout: post
title: ' [Incomplete] "Current ML techniques in Landslide Detection & Prediction" '
author: Vihaan Akshaay
tags: ['concept-note']
date: '2023-06-14 18:00:23 +0530'
category: Notes
summary: Just a short summary of the current methods for Landslide detection and prediction models
thumbnail: landslide.png
---

#### Notes from 'A dual-encoder U-Net for landslide deetection using Sentinel-2 and DEM data.

What are they doing:
- Semantic Segmentation: (A per-pixel classification) Landslide prediction.
- A duel-encoder architecture that use both 
- Workflow to construct the landslide dataset???


Good for us:
- They claim that the popularly used models are U-Net, Attention U-Net and Seg-Net (Which is still a little outdated) We can definitely develop a more landslide-science based model.
- 


Bad for us:


Datasets Available:
[Semantic Segmentation Dataset](https://ui.adsabs.harvard.edu/abs/2021CG....15504860D/abstract): Google Earth images of 2.39m spatial resolution in Jinsha River basin and corresponding per-pixel annotations.

[Iburi Landslide Dataset](https://zenodo.org/record/2577300#) - Check out the [original paper](https://link.springer.com/article/10.1007/s10346-019-01207-6#:~:text=The%20majority%20of%20landslides%20triggered,11a) for data description. 

Take-aways: 
- Since this paper is very recent (Published last week lol) we can rely on the related work section to a bit to understand background work so far. 

There are majorly 5 methods used - 'Visual Representation' [Example](https://link.springer.com/article/10.1007/s10346-019-01207-6#:~:text=The%20majority%20of%20landslides%20triggered,11a), 'Change Detection-based', 'Knowledge-based', 'ML based' and 'DL based'.

Most ML methods (like SVMs, random forest, logistic regression, bayesian classifier and DST) have already been tried out but the issue is the high requirement for data preprocessing and feature engineering.

DL methods are majorly object-detection (using bounding boxes to locate landslides in a given image) and segmentation based (classifying pixel by pixel as landslide or not-landslide). 

DL Object-detection (R-CNNs, Mask R-CNNs, YOLOs + Attention). Drawback: These only give a rectangular box around the landslide and not the exact boundary of the landslide.

DL Segmentation (FCN, U-Net, GCN, DeepLab on River Landslide dataset & LandsNet for Earthquake-triggered landslide detection)

## Next Steps:

Run RCNN on Instance Segmentation.
Define variations on RCNN architecture for Instance Segmentation.
Take out YOLO v8 model (More YOLO models as well) from the official package and run it on our data (for 7 bands or more)