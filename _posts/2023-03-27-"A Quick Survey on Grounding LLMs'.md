---
layout: post
title: ' "A Survey on Grounding LLMs" '
author: Vihaan Akshaay
date: '2023-03-27 18:00:23 +0530'
category: Advanced
summary: This post is to put together current research on Grounding LLMs
thumbnail: robot-coding.png
---

# Resources Links:

Below is the link to multiple resources in LLM + Robotics:<br/>
[Awesome-LLM-Robotics](https://github.com/GT-RIPL/Awesome-LLM-Robotics)<br/><br/>

Below is a quick summary of some relevant papers from the above link.<br/>

## Is this a survey paper? Have to check:
[Grounding ‘Grounding’ in NLP](https://aclanthology.org/2021.findings-acl.375.pdf)

## Some Research Papers (Related to Grounding):
[Grounding Large Language Models in Interactive Environments with Online Reinforcement Learning](https://arxiv.org/pdf/2302.02662.pdf)
[Grounded Decoding: Guiding Text Generation with Grounded Models for Robot Control](https://grounded-decoding.github.io)

## Robotics Related
[Inner Monologue: Embodied Reasoning through Planning with Language Models](https://arxiv.org/pdf/2207.05608.pdf)
[Language Models as Zero-Shot Planners: Extracting Actionable Knowledge for Embodied Agents](https://arxiv.org/pdf/2201.07207.pdf)

## Class of Language-Conditioned Models
[Language-Conditioned Imitation Learning](https://arxiv.org/pdf/2010.12083.pdf)
[Language-Conditioned Reinforcement Learning to Solve Misunderstandings with Action Corrections](https://arxiv.org/pdf/2211.10168.pdf)
[Natural Language-conditioned Reinforcement Learning with Inside-out Task Language Development and Translation](https://arxiv.org/pdf/2302.09368.pdf)


## Paper Discussion
Our main paper to discuss (Along with relevant resources and citations expanded) for this blog post would be [Grounding Large Language Models in Interactive Environments with Online Reinforcement Learning](https://arxiv.org/pdf/2302.02662.pdf).

#### Language-Conditioned Environments

To get in detail, we shall start by understanding BabyAI-Text (The text based RL environment they are using here, as well as other alternate substitute env). [BABYAI: A PLATFORM TO STUDY THE SAMPLE EFFI- CIENCY OF GROUNDED LANGUAGE LEARNING](https://arxiv.org/pdf/1810.08272.pdf) is a 'Language Conditioned' environment with a language goal. It is built upon the [MiniGrid](https://github.com/Farama-Foundation/Minigrid) environment.
This typically has objects (4 types - box, ball, door, keys & 6 colors) and is placed in rooms of (8x8) along with the agent in random.

Action Space: The agent has 6 actions (move in one of four directions, toggle and pick up).
Observation Space: The agent observes 6x6 grid in front of it (Original BabyAI returns this information as a symbolical mapping - 3 matrices)
Reward (Typically multiplied by 20 for better reward propagation): 1 - 0.9*(N/H) # H - max number of steps in episode 

More Details for the BabyAI-Text can be obtained here [Appendix A](https://arxiv.org/pdf/2302.02662.pdf)

BabyAI-Text obtains textual descriptions of each observation.
Observation Space: List of template descriptions of the following format.





For baselines, the first basic one is [DRRN](https://arxiv.org/pdf/1606.03667.pdf). Explanation for the above is provided here.


#### Training:
They mainly use PPO for training the main model. Here is a good resource that explains [PPO self-contained](https://fse.studenttheses.ub.rug.nl/25709/1/mAI_2021_BickD.pdf) & [Entropy Regularization in RL](https://towardsdatascience.com/entropy-regularization-in-reinforcement-learning-a6fa6d7598df)