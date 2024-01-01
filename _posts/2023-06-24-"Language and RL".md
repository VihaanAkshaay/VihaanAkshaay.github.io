---
layout: post
title: '[Incomplete] A handbook with concepts and terms for Language conditioned RL '
author: Vihaan Akshaay
date: '2023-06-24 18:00:23 +0530'
category: Notes
summary: Using this as a notebook for writing terms and concepts new to me related to Language conditioned RL
thumbnail: landslide.png
---

#### Re-occuring Models and Papers:

###### MCIL: Multi-context imitation learning

Multi-context learning is a framework for generalizing across heterogeneous task and goal descriptions.
In a nutshell: Collect trajectories (also called 'play's in the paper). Look at the end and get image of goal states or some language description of the task. These images/texts are called contexts. Now a context conditioned policy function ($\pi_{\theta}(a_t|s_t,z)$) is trained with the MCIL objective function (where z is the context vector). Use seperate encoders for each scenario (ie image context or text context ...) to get z(context vector).

###### HULC: Hierarchical Universal Language Conditioned Policies
 

#### Some terms

* Natural lanuguage conditioned policy $\pi_{\theta}(a_t|s_t,l)$ : outputs action $a_t \in \mathcal{A}$ conditioned on current state $s_t \in \mathcal{S}$ and free-form language instruction $l \in \mathcal{L}$.

* 