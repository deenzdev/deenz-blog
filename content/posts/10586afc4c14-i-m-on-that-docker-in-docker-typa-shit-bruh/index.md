---
title: I'm on that Docker in Docker typa shit bruh and thats on god
date: 2025-08-06
draft: false
showHero: true
summary: Another unforeseen and self imposed task accomplished to a degree that actually leaves me satisfied.
tags:
  - docker
  - github
  - the-site
  - insomnia
categories:
  - dev
featured: featured.png
---
It seems like I have taken things, once again a smidgen further than I needed to. I have not yet gone to bed and I think I am past the 100h threshold or at least very close to it. That's where the "fun stuff" tends to happen. :^)
But I wanna start off linking a video I have been obsessed with recently:

{{< youtube IMgWnCMAigw >}}

{{< lead >}}
PURE UNFILTERED 100% FLOURIDE FREE SOVL
{{< /lead >}}

Goes hard, right?! Well, as I was saying....I spent the majority of the evening looking into getting this site indexed through google struggling quite a bit with their claim my `robots.txt` was blocking those poor Googlebots out but I could verifiably check the file myself right then and there and it allowed basically everything and everyone. I dismissed it as a matter of caching, that's essentially become my go-to excuse for any tech-related issue recently. And honestly, do I really that much about being exposed to even more bots and and fake queries muddying my metrics?! Surely not.

Regardless, I went and explored the rest of the Google Search Console site out of curiosity. It seemed fairly empty, a lot of space wasted on what might one day be a plethora of glistening dashboards displaying the tens of dozens of visitors I could have. If I just keep my head in the game, that is. One other "source of interactivity" was the the field to have my ´sitemap.xml´ analyzed. I wasn't quite sure what analyzed meant in that context but I thought it couldn't hurt. I haven't touched it myself or any of the related options so maybe I'll get some good insight into something, at least. 

Turns out that the vast majority of generated files in the public directory, and that incldues the sitemap as well, declare my baseURL as `http://localhost:1313`. Madness. And why haven't I bothered flushing that whole public folder by now. What the fuck is wrong with me...That's easy!

{{< lead >}}
I'm just kinda really fucking stupid sometimes (シ_ _)シ
{{< /lead >}}

{{< figure
    src="https://i.4cdn.org/g/1754523464962467.png"
    alt="literally me"
    class="text-align: center"
    caption="me for the first 8h of my shift"
    >}}

And so, my designated task for the day would be: Cleaning out the public directory, not break the site and maybe bring a modicum more order into things. And as these things tend to go with me, this small little chore quickly expanded into the idea of: HEY, why don't implement an actual CI/CD pipeline instead of awkwardly juggling the local files in my inventory. And HEY, why don't I move these static files into a Docker container too instead of having them on my godforsaken Desktop...

And HEYYYY, what if I automate the building process, flush the public directory, containerize my website's code alongside the nginx server and build an image from them, then tag it properly and push it to the DockerHub registry and then regularly have my running docker compose instance somehow pull that image new image and subsitute the outdated one with that???? What then, huh???

> :bulb: **Tip:** Only take medication you have been prescribed by a licensed physician.

I mean, in the grand scheme of things it's really not that outlandish, maybe only the part where...again, this is about 5MB of crude Markdown and copyright protected images that will probably get me in hot water soon enough lo but oh well...It's not so much about whether it makes sense or not and more so about whether I can make this happen in my current fugue state. (Spoiler: I can, yeah!)

The biggest challenge, if I am being honest, consisted of shutting out all the gitlab-ci.yml syntax I have been working with at my job for the past couple weeks. I have come to really love automation in this context. It's all very sensibly structured, the language makes sense, it's satisfying seeing multiple chained jobs turn green one after another. And I had kinda expected that a lot of the syntax carried over between the two git services and sure, they both have "jobs"...I guess. But the fuck are GitHub ACTIONS??? What a stupid name for a CI/CD platform. When I think of a seamless strand of interwoven processes, the last word that comes to mind is ACTIONS. 

I don't know, it's likely just a matter of having been used to different conventions for so long, I'm being a pissbaby. Which is funny considering that I used GitHub for considerably longer than GitLab. Well, time to write my own VCS so I stop complaining aha! God no...At least not anytime soon.

In GitHub's defense, I always really liked their UI and it gives me more of a feeling of being "in control" than the GitLab one has done so far. That might be because my lack of admin privileges on our on-premise instance might obfuscate a lot of the functionality but I consistently feel like I am missing something or forgot something in the ether that is GitLab, many things are just too tucked away. Perhaps an incentive to utilize the GitLab API and work on some centralized dashboard where I can see all the reviewed merge requests I have forgotten about. (Graphana use case real?)

Nevertheless, I got to work. The nice thing when working on personal projects is the opportunity to only focus on functionality. I mean, you can't really mess up that much structurally in a YAML file anyways but I don't find myself checking trailing whitespace over and over again. I know my IDE should do that by itself but I haven't gotten around to click that checkbox yet bro chill...Feel free to check my crap (BUT FUNCTIONAL) code yourself, it should be inside `.github/workflows/github-workflow.yml`.

{{< github repo="dekaratas/deenz-blog" showThumbnail=true >}}

The only notable section is how GitHub seemingly handles environments and environment variables/secrets. There seem to be very clear distinctions between them all and different contexts...and I am not quite sure how I actually got the docker login command to recognize both values finally after a good half hour but I am not complaining. AND DON'T TELL ME TO READ THE DOCS. I read the docs. They're very short worded when it comes to this particular topic. Very few good examples. But oh well, I figured it out. :^)
Ohh, and deciphering what damn Docker registry I have to log into was also a lot of guess work. I hope to have a more surefire way to determine that in the future. (I am likely just being stupid...) but I will definitely update this part when I hear something, even just for my own sake.

As you can see, all that pipeline really does is utilize some variables to build both the static files from the hugo directory and a tagged docker image in accordance to this stupidly simplistic Dockerfile.

```
# Stage 1: Build Hugo site

FROM hugomods/hugo:reg-node-0.148.2 AS builder

WORKDIR /site
COPY . .
RUN hugo --minify -b https://www.deenzcan.com

# Stage 2: Serve with Nginx

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/\*
COPY --from=builder /site/public /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

I haven't spun up too many instances of nginx myself in the past but what I failed to provide is a more customized .config file. Something I definitely want to look into tomorrow when I am done with work.
Ultimately, it all does what it's supposed to do which is what matters...

{{< lead >}}
TO MEEEEEE
{{< /lead >}}

And also to my steadily growing docker-compose.yml. The actual core of my work if you will.

```
services:
  blog:
    container_name: deenz-blog
    image: deenzdev/deenz-blog-images
    labels:
      - com.centurylinklabs.watchtower.scope=deenz
    ports:
      - "9000:80"
    restart: unless-stopped

  watchtower:
    image: containrrr/watchtower
    container_name: watchtower
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - WATCHTOWER_POLL_INTERVAL=30                            
      - WATCHTOWER_CLEANUP=true                                 
      - WATCHTOWER_INCLUDE_RESTARTING=true                      
      - WATCHTOWER_SCOPE=deenz             
    restart: unless-stopped
```

This little blog section had to be adjusted somewhat to dictate a scope for the Watchtower service.
That one is pretty much responsible for what I had suggested earlier. It keeps a steady on your container group and will, if so configured, in regular intervals pull a new docker image, compare versions and switch them out before you can even notice. It's really nifty and you should chceck out the [documentation](https://containrrr.dev/watchtower/) , faceless reader...if you're interested in it.

So, after messing around with some folder on my desktop being the source of my site, I am quite proud to have a reproducible pipeline that will store cleaned up ready-to-run containers of it at different points in time. Kinda cool!! Well,  I've said. I'm a sucker for automation lol. 

Alright, this has been way too much. I will try to keep myself shorter in the future. For the next few days I SWEAR, I'll take it a bit easier. Just gotta get through the workday bros. Just gotta get through another day. Just gotta get to the end of the week my guys....Ok, **CYA!!!** :^)
