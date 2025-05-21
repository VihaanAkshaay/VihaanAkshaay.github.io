---
layout: post
title: 'My Take On Solo Leveling - Personal Leveling'
author: Vihaan Akshaay
tags: ['dev-log']
date: '2025-05-06 20:45:23 +0530'
category: Notes
summary: Introduction to Personal Leveling
thumbnail: landslide.png
---

#### Chatter:
I DO NOT SEE WHAT'S SPECIAL ABOUT THE ANIME SOLO LEVELING. Well, tbh I did have fun watching it, but it just was a bit too plain for my liking, idk. He just kept getting stronger and stronger and stronger.
Well, then I thought, what if I could make a leveling system for myself? (I'm gonna call it personal leveling for a reason I'll reveal in the future :)))) )

So here it is.



#### version (0.1)
As part of my interview for XXX.AI (I don't think I signed an NDA, but just to be safe, I'm not going to mention the company name, since it might make it harder for them to come up with new tasks for later interviews).

<iframe width="560" height="315" 
        src="https://www.youtube.com/embed/n5J8d-Ot7PI" 
        frameborder="0" 
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
        allowfullscreen>
</iframe>

Basically, I used Langgraph to build a simple computer control tool.
For someone who is new to Langgraph, let me give you a quick rundown on how it works.

So you start with an empty graph and you add nodes to it. All tools (like clicking a button, opening a website etc) can be put together as a node (usually called tool node). Your chatbot, in this case will also be a node. You connect all these nodes somehow to form your graph and think of these things executing in a conditional manner, like a flowchart to get the job done.

For example, if I had one tool to open safari, one tool to click and type, and one node is a chatbot, I could connect these nodes in a way that the chatbot opens safari, types in the url, and then goes to the chatbot node. The neat thing about langgraph is that you won't have to hardcode the path/flow, it will automatically figure it out.

I'd say, that role was my DREAM ROLE. No doubts.
But unfortunately, I didn't get it. I even mailed the CEO why I didn't make it when the fit was good and interview went alright. Maybe I bombed the behavioral interview? Idk. I just really wanted that role and that company, something felt amazing about it, but well meh its okay (copium).

#### version (0.2)
This was when I was wondering, why not work on this a little bit more? Also, [RANT] IDK IF ITS JUST MY LINKEDIN RECOMMENDATIONS, BUT MOST ML/AI ROLES WANT ME TO BE AN EXPERT IN APPLIED NLP. LIKE MAHN! HAVING 2 PAPERS IN TOP AI CONFERENCES (Workshop though, but FIRST AUTHOR!!!, in reinforcement learning and computer vision though, but RL AND CV ARE COOLER!? I'm kidding, please give me something interesting to work on, idc if its a different bunch of letters) NOT ENOUGH? [RANT DONE] Anyway, that was only more reason to work on this, and kinda develop my 'Applied NLP' skills too! duh.

I started with a simple front end. Check this video out (I've never touched React/Typescript before, so this was mostly just vibe coding and debugging)

<iframe width="560" height="315" 
        src="https://www.youtube.com/watch?v=g-UUaUwOGvg" 
        frameborder="0" 
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
        allowfullscreen>
</iframe>

### version 1.0 YAY!

###### Chatter:
I had another screening round with another NLP company actually for applied AI engineer. (Idk how I made it in honestly, it was a pure NLP research role, maybe they liked that I had papers?)
And OMG. The person who interviewed me, was, "happy". I felt so good talking to him. He radiated so much positivity. That was when I realised, despite being in one of the most beautiful places in the world (Santa Barbara), staying in my room for the past year, I hadn't met a happy person in a long time. Idk, my roommates are amazing, no question. But this guy, he was different, he was happy on another level. I don't mind dropping his name, but well idk man, not sure if its okay. Anyway, I told him about the personal leveling thing, and he raised a very interesting question. (That kinda showed that he genuinely had good 'NLP' intuition haha) he asked how am I going to take care of memory. If this system is going to give me goals, keep track of my progress, if it has to analyse my progress, strengths and weaknesses, how will it keep track? what's the memory in the backend going to be like? just the chat history will blow up. I had never thought about it that deep, I was thinking of something like how chatgpt does? it says 'memory updated' so all I thought was, it would just keep using the chat history but keep summarising it and use that as context later. Well I realised this in itself is a very interesting Research Question. Anyway, I didn't make it past that  round in that company. I wasn't sad though, the first round did not have any technical questions tbh, very minimal and I was honest and told him my experience is mostly in Robotics/RL/CV and not NLP. Well, yeah. But then that conversation with Tawab Safi ( ;) ) was extremely interesting (He knew Solo Leveling, so he was invested in this too!).

###### Back to the topic.
MCP. Man MCP took off!!!! I kept seeing MCP all over my linkedin and twitter.
Well I wanted to check it out more. I saw, I tried, I appreciated.

It's really nice ngl. It reminded me so much of ROS (Robot Operating System). Why? well if I made a new RGBD camera, it'll be a pain for one to write things from scratch on how to use the sensors, read the data and all that. But with ROS, I can also release something (node) like a package that peopel can just add to their existing robot. Essentially, Connect the hardware, add the node, and it'll work!!

MCP felt like that. MCP has a 'Client' and a 'Server'. Each tool you add is a server. For example, if I want a program to use my calendar, I used to check out python packages and functions to use system stuff like calendar on my mac, and then write a bunch of code with it and then connect it with my AI Agent or something. But with MCP, all I need to do is, "look for a calendar MCP server", "add the server to my mac", and "connect it to my central program(client) that wants to use it". And I'm done. It's a 3 step (and hardly few lines of code) process. No hassle.
It's like you have a mobile phone, and you want an app. You just go to the app store and get the app you want. You're done. And to my surprise, THERE ARE A BUNCH OF SERVERS ALREADY MADE! So if there's a new functionality I want added to my program, I just google for a MCP server and add it to my program. done.

Now for Client, Langgraph has a MCP client I can use. DONE! So to test things out, in addition to the tools I had from before, I added a calendar MCP server.
Next is the memory, I wanted the first prototype to have some kinda memory things to build upon. I added a 'Knowledge Graph'(Graphiti) MCP server, that works in an interesting manner.


I'll show you a quick example of how this works.
My prompt was something like this: I want to practice more dynamic programming. I might have another interview lined up, so ideally practicing leetcode would be nice. can you list out some problems I can practice, make maybe 30 minute or an hour long slots on my calendar for the same please? Also keep track of the questions, I'll keep you updated on my progress.

It made calendar events and added the memory in the graphiti server. This is how it looked!!

![Graph Memory](/assets/img/posts/My-Take-On-Solo-Leveling-:-Personal-Leveling/graph.png)

![Calendar Events](/assets/img/posts/My-Take-On-Solo-Leveling-:-Personal-Leveling/calendar.png)


Well, here is where I wanted to test if the program was any good. I said, I'm done with fibonacci. The agent immediately deleted that node from the graph. :(
To be honest, I would have thought, keeping track of the problems I've done would be a good idea since it'll kinda help track progress as well as give a better idea of my skill set?
So I reprompted it asked the agent to keep track of the problems I've done and it altered the graph to look like this instead (which I thought was more apt for this use case)

![Graph Memory](/assets/img/posts/My-Take-On-Solo-Leveling-:-Personal-Leveling/graph-after-change.png)

That's version 1.0
I'm so excited for this, not because it works and does something, or that I've learned a lot of LLM tools (hmmmm maybe a bit but that's not the core reason) but because of the potential for improvements.
Like how do I make the model use the tools better? Do I need to finetune it or do I need to collect more data? Data for better tools can be synthetic? 
For the model to plan out things better, do I check out more subreddits for relevant data? I also learnt how to run ollama langgraph client, should I hand pick super small models for these tasks, instead of running it on ChatGPT (which is definitely overkill) Only time will tell.

ALSO! SOMETHING INTERESTING! This project has a meta angle to it. I'm trying to build this program, I'm trying to build myself as I build this program, and I'm trying to make that make the program better.
Hmmmm.