---
layout: post
title: ' "How do I start building robots?" '
author: Vihaan Akshaay
date: '2020-05-20 14:35:23 +0530'
category: Beginner
summary: This post gives a rough base for a person to get started with robotics
thumbnail: toyrobot.png
---

#### Robots are everywhere!

From being a part of fictional work 
 like [Noisy Boy](https://realsteel.fandom.com/wiki/Noisy_Boy) from Real Steel, <br />
['You pass butter'](https://www.youtube.com/watch?v=X7HmltUWXgs) from Rick and Morty <br />
And my all time favorite ['Wall-E'](https://www.youtube.com/watch?v=OSKLo9ZCfsk) <br />
As well as in various real life instances like
Softbank's [Nao](https://www.softbankrobotics.com/emea/en/nao), a bipedal robot extensively used in education and research <br/>
[Spot](https://www.bostondynamics.com/spot), MIT's [Cheetah](https://www.youtube.com/watch?v=xNeZWP5Mx9s) and other scintillating quadrupeds <br/>

Oh wow! that could be a post on its own. But coming back to this one here, <br/>
Have these made you want to build your own robots? Could be a swarm of [Killjoy](https://www.youtube.com/watch?v=ua-iIRQDY8g&vl=id)'s nanobots or something insane like the Ultron! That's upto you, but the first hurdle usually is 'How do I start building robots?' (see what I did there :p) If you're stuck with this, then you're exactly the person I'm writing this post for! 

Now before we get readied with how to build a simple robot, let's first know what a [robot](https://en.wikipedia.org/wiki/Robot) is.
To be very honest, from the resources I've been exposed to, I've not come across a satisfactory definition of a robot. But yes, eventually I've settled with a conglomeration of various definitions. A very conjectural take on a robot would be to call it a machine that performs a particular kind of task. To describe the task a little better, it can be broken down into three sub-parts. 

![](/assets/img/posts/How-Do-I-Build-Robots/Robotflow.jpeg){:class="img-fluid"}

Let's go over an example to understand how this division works. Imagine you're asked to pick up a certain object in front of you. A quick breakdown of how you would perform the above task would be <br/>
- You will look at the surroundings and locate the object of interest. (*perception*)
- You would decide on how you're going to move your body, hands in specific to reach the object without colliding with other obstacles in the scene (*decision making*)
- Now you'd perform the action by moving your hands, grasping the object and taking it to the goal position(*action!)*

Getting a little more in-detail about the sub-topics mentioned, 

###### Perception 
 This module corresponds to the part where the robot tries to understand its surrounding. Similar to how we use our sensory organs to understand our state and the environment around us, robots use an array of sensors for the same. To begin with, a quick list of entry-level sensors you could use for your robot can be found [here](http://www.robotplatform.com/knowledge/sensors/types_of_robot_sensors.html). So when you're planning on building your own robot, the first thing is to decide what kind of inputs you want your robot to work with. For instance, if your robot shuold listen to sounds, a microphone is to be added, if the robot needs vision, you're gonna have to look into different cameras (details like type of camera, data stream and resolution which will be covered exclusively in another post). It is trivial to know that all your sensor does, is flush you with data. Diving deeper into the "electronics" pillar of your robot, once you have your sensors ready, the next step is to have a central unit to process and channel this stream of data. This ican be considered the 'brain' equivalent of your robot. <br/>
 Most of your data transmission happens in terms of voltages. For sensors which are basic and only stream simple 'numerical'* data, the standard go-to board would be an [Arduino Uno](https://www.youtube.com/playlist?list=PLA567CE235D39FA84). A smaller version with lesser pins would be an Arduino Nano and a bigger version to this is an Arduino Mega. Once you start stepping into a little complicated data like an image stream, you could use a [Raspberry Pi](https://projects.raspberrypi.org/en). You can think of this as a very compact PC. By that I mean, you can plug it with a display and a keyboard and BOOM! there you go! (*NOTE* You don't need a dedicated input and output device setup to work with your Raspberry pi. Read about [SSH](https://www.raspberrypi.org/documentation/remote-access/ssh/)). So the idea is to attach a PC equivalent on your robot to process all your data, and fancy terms like [Edge AI](https://wire19.com/what-is-edge-ai/) that companies like NVIDIA is working on, has given us, roboticists a lot of powerful chipsets like the [Jetson Family](https://www.nvidia.com/en-in/autonomous-machines/embedded-systems/). The next upgrade from the RPi would be a jetson nano

