---
layout: post
title: '[Incomplete] "A Survey on Grounding LLMs" '
tags: ['concept-note']
author: Vihaan Akshaay
date: '2023-03-27 18:00:23 +0530'
category: Advanced
summary: This post is to put together current research on Grounding LLMs
thumbnail: robot-coding.png
---

# Contents
This post is an attempt at writing a quick introduction to grounding LLMs with the real world in an abstract sense.
I aim on trying to understand the term 'grounding' in the aspect of LLMs in Mostly Robotics environments. For this purpose, we investigate and break down three papers.

**Paper 1** - [Grounding 'grounding' in NLP](http://www.cs.cmu.edu/~awb/papers/2021.findings-acl.375.pdf). \
**Paper 2** - [Grounding Large Language Models in Interactive Environments with Online Reinforcement Learning](https://arxiv.org/pdf/2302.02662.pdf) \
**Paper 3** - [Grounded Decoding: Guiding Text Generation with Grounded Models for Robot Control](https://grounded-decoding.github.io)

## [Paper 1](http://www.cs.cmu.edu/~awb/papers/2021.findings-acl.375.pdf):
In short, this paper tries to explain the gap between the psychological 'grounding' and the grounding in research and suggests ideas to bridge this gap (in a very abstract sense).

### What is Grounding????? Psychology behind it!!
LLMs were able to obtain a decent understanding of physical rules of the...
But lacked grounding ....

Grounding according to Cognitive Studies - 'Grounding is the process of building a common ground based on shared mutual information in order to successfully communicate' (or) 'What mutual information is needed to establish successful communication'
Current research/state of grounding has gaps in three dimensions - Coordination in grounding, Purviews of grounding & Constraints of grounding.
We first understand each of them to investigate them further.

According to Cognitive Science, "grounding" is "The process of establishing what mutual informatin is required for successful communication between two interlocutors" (interlocutors - communicator)

Grounding can majorly be put into three classes - *'direct grounding'*, *'indirect grounding'* and *'functional grounding'*

1) Coordination in Grounding: (Static & Dynamic)

**Static Grounding** assumes that 'evidence for common ground or the gold truth for grounding is given/attained psuedo-automatically'.
**Dynamic Grounding** claims that 'common ground / mutual information needed is attained through interactions/feedback'

Insert the example image from grounding grounding paper.

CLAIM: *prioritize dynamic grounding*

2) Purviews of Grounding: 
This talks about 'different stages behind reaching a common ground'.

a) Localization: This is a function purely of the agent. This is the ability of the agent to localize the concept.
If the agent had to locate a 'blue sweater' it has to understand the concepts of blue and sweater and as a composition of the whole unit.

b) External Knowledge: After localizing the concept, the next step is to ensure consistency of current context of concept with existing knowledge.
Most of current efforts (Verify?) are focused on localizing with few efforts to maintain consistency of grounded concept across many other knowledge sources.

c) Common Sense: Once the basic grounding is done, some scenario-based grounding that is observable helps in building a common ground that does not always need articulation of meticulous details.

d) Personalized consensus: 

3) Constraints of Grounding:
 

#### Grounding 'Grounding'
This section covers grounding adapted to 'NLP'


## [Paper 2](https://arxiv.org/pdf/2302.02662.pdf)
Our main paper to discuss (Along with relevant resources and citations expanded) for this blog post would be [Grounding Large Language Models in Interactive Environments with Online Reinforcement Learning](https://arxiv.org/pdf/2302.02662.pdf). 

The discussion starts with how LLMs that were trained on massive text datasets were able to capture aspects of *physical rules of the real world*, *color* and *affordances between bodies and objects* on a very generic scale **but** but LLMs suffer from lack of grounding which prevent them from using functioning well, specifically in interactive environments. A classic example could be, asking ChatGPT to play chess. Here is a HILARIOUS [video](https://www.youtube.com/watch?v=rSCNW1OCk_M) that I just couldn't stop laughing at. If we hypothetically assume that there is an abstract state (of the chess board) that ChatGPT assumes to be making moves for, is not the exact state we assume the board to be in. This lead to ChatGPT suggesting very random moves that were mostly illegal.\

The authors blame this nature of the LLM on the training process (token by token), lack of ability to intervene in environment (the absense of dynamic grounding as we saw from previous paper) and lack in abilities to learn based on data colllected from interacting with the environment.


#### Language-Conditioned Environments

To get in detail, we shall start by understanding BabyAI-Text (The text based RL environment they are using here, as well as other alternate substitute env). [BABYAI: A PLATFORM TO STUDY THE SAMPLE EFFI- CIENCY OF GROUNDED LANGUAGE LEARNING](https://arxiv.org/pdf/1810.08272.pdf) is a 'Language Conditioned' environment with a language goal. It is built upon the [MiniGrid](https://github.com/Farama-Foundation/Minigrid) environment.
This typically has objects (4 types - box, ball, door, keys & 6 colors) and is placed in rooms of (8x8) along with the agent in random.

Action Space: The agent has 6 actions (move in one of four directions, toggle and pick up).
Observation Space: The agent observes 6x6 grid in front of it (Original BabyAI returns this information as a symbolical mapping - 3 matrices)
Reward (Typically multiplied by 20 for better reward propagation): 1 - 0.9*(N/H) # H - max number of steps in episode 

More Details for the BabyAI-Text can be obtained here [Appendix A](https://arxiv.org/pdf/2302.02662.pdf)

BabyAI-Text obtains textual descriptions of each observation.
Observation Space: List of template descriptions of the following format.

NOTE: They first compare DRRN and Symbolic-PPO with roughly similar number of parameters that symbolic observations from BabyAI encode biases that ease learning compared to text descriptions. Hard to accept CLAIM. [Appendix B.1 Page Number 19](https://arxiv.org/pdf/2302.02662.pdf)

#### LLMs as policies
This paper uses LLMs as policies for textual interactive environments.\
Prompt to the LLM is (task description) + (textual description of current state) + (set of possible actions).  [Table 2 Page 26 for examples]

We expect the prompt to return a probability distribution over possible actions. There are three ways to execute this.
Option 0: Generate a string and make an ad-hoc mapping that maps this string to possible actions. (This is a bit unclear to me yet)
Option 1: Add actions heads (an MLP with # of output nodes = # of possible actions)
Option 2: Let actions be represented by strings which are essentially tokens in order. Calculate probabilities for actions from token-wise probabilities ([Section 3.2](https://arxiv.org/pdf/2302.02662.pdf)). After obtaining probabilities of possible strings (actions), normalise them. This method has a drawback though. We need a forward pass for each of the actions. But this brings advantages such as 1) no need for a new ad-hoc mapping 2) leverage language modeling head's prior and 3) robust to any action space.

For training these policies, PPO can be adapted. Here is a good resource that explains [PPO self-contained](https://fse.studenttheses.ub.rug.nl/25709/1/mAI_2021_BickD.pdf) & [Entropy Regularization in RL](https://towardsdatascience.com/entropy-regularization-in-reinforcement-learning-a6fa6d7598df). To give a quick introduction to PPO, we start with Q values and V state values. Add notes here later, for meeting, open notability.

The paper also has introduced an implementation of Lamorel for parallel LLM deployment?

#### Experiments

They call their model GFLAN-T5 (G for grounded :)). They use Flan-T5 780M for their policy LLM, because of the open-source access and close link between training corpus and language-conditioned interactive environment. \
They compare their model with three baselines. 

The first one is the [symbolic PPO](https://arxiv.org/abs/1707.06347) 
the next one is [DRRN](https://arxiv.org/pdf/1606.03667.pdf) - Deep Reinforcement Relevance Network (Add an image here). Explanation for the above is provided here.
The final one is NPAE-FLAN-T5 (NonPretrained with Actionheads and Embeddingspretrained). This essentially initializes pre-trained weights for embedding module and the decoder with random weights. For further in-depth study, they also define more agents (Discuss Appendix 2)

With these different agents, they explore **Q1. Sample Efficiency**, **Q2. Generalization to new objects**, **Q3. Generalization to new tasks**, **Q4. Impact of online interventions**.

###### Q1. Sample Efficiency
To understand how efficient the samples are, we can look at the learning curve over episodes. Agents were trained on 1.5 million steps on randomly sampled tasks and 8 distractors. [Section 4.1 Figure 2].\
The next step, to understand how number of actions affect the learning, they vary action space (restricted - 3 actions, canonical 3 + 3 and augmented - 3 + 6) and distractors. [Page 8 Figure 4]

###### Q2. Generalization to new objects
Two experiments are conducted for this. **Experiment1:** An environment with nouns that are not in training vocabulary (like a tree). **Experiment2:** An environment with invented objects.\
It can be see that GFlan-T5 is not affected in Experiment 1. IT supports that GFlan-T5 has functionally grounded the symbols that describe the geometry of the environment and the instructions. (Symbols like 'in front' and 'steps')

###### Q3. Generalization to new tasks
To verify if agent ahs generalized over the symbols it has grounded during finetuning, we extend experiments with new unseen tasks. [Section 4.3]
This is done by 1) Making new compositions of learned tasks 2)  Using synonyms for actions 3) Exploring new language

## [Paper 3](https://grounded-decoding.github.io):
The paper opens with 'language-conditioned robotic policies' like the one we saw from the previous paper, that learn from interaction data acn obtain some necessary grounding but are limited by the lack of high-level semantic understanding. \

"If we want to make use of semantic knowlege in a language model while still situating it in an embodied setting, we must construct an action sequence that is both likely according to the language model and also realizable according to grounded models of the environment." 



# Resources Links:
CoRL Deadline (May 15 - June 8)  https://www.corl2023.org

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
[Say Can](https://say-can.github.io)

## Class of Language-Conditioned Models
[CLIPort](https://arxiv.org/pdf/2109.12098.pdf)
[Language-Conditioned Imitation Learning](https://arxiv.org/pdf/2010.12083.pdf)
[Language-Conditioned Reinforcement Learning to Solve Misunderstandings with Action Corrections](https://arxiv.org/pdf/2211.10168.pdf)
[Natural Language-conditioned Reinforcement Learning with Inside-out Task Language Development and Translation](https://arxiv.org/pdf/2302.09368.pdf)

## Human Feedback Related (Dynamic Grounding)
[Verbally Soliciting Human Feedback in Continuous Human-Robot Collaboration: Efects of the Framing and Timing of Reminders](https://dl.acm.org/doi/pdf/10.1145/3568162.3576980)

### Extending this to new ideas:
HRL and LLM, read more about [this paper](https://arxiv.org/abs/2303.16563).