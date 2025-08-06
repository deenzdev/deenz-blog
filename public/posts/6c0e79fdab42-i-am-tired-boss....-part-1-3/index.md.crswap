---
title: I am tired boss...
date: 2025-08-05
draft: false
showHero: true
summary: A glimpse into Self-Hosting while I am simultaneously losing it.
tags:
  - personal
  - this site
  - docker
  - tutorial
  - cloudflare
categories:
  - personal
  - the-site
  - personal
featured: featured.png
---
So yeah, when I said yesterday that I wanted to take it slow and steady with this site so as to not burn myself out....**I truly meant it**. But one thing led to another. My thoughts started to wander to places best left buried for now. 
{{< lead >}}
(Hahaha, I miss her, bros...)
{{< /lead >}}
So, I had to distract myself whilst waiting for wagie hour to begin again.

Thus, I've had a little glimpse (strictly for future planning)  into how much domains go for these days. Can't hurt to familiarize myself with these things, two weeks ago I had never even thought about running something as pitiful as a blog ha! Well, turns out...this shit is dirt cheap.

As you can hopefully see, non-existant reader...I had to go for it. There was no other option...and so one thing led to another. I'll try to describe the Odysee that followed to the best of my ability but it's hard to reconstruct the exact steps. I will also note down explanations for a few terms, mostly for myself. That's gonna be a reoccurring thing. 

Essentially, I had very little idea how long the whole process would take nor did I have any specific plans to actually utilize this domain for the forseeable future but 4,99/year is hard to beat. Well, maybe it's actually easy to beat. It's truly crazy how cheap these things are.

So, I ended up purchasing this Domain from DreamHost, thus making them my Domain Name Registrar. Makes sense, right?

> A Domain Name Registrar is just a company or organization that manages the registration of internet domain names (like google.com or example.org) on behalf of individuals and businesses.

Well, I eventually received an E-Mail congratulating me of being the new owner of deenzcan.com and I was presented with an inconceivable list of services and storages and routing options my new registrar offered me. I didn't really want to do any of those things, it really was just about securing the name but then, I vaguely remembered the Netlify UI...there was something about it.
Something about a field talking about how I can substitute the ugly suffix-ed Netlify URL with my own if I had acquired such a thing.

![Image of aforementioned UI view](https://i.imgur.com/p2c01dC.png)

Can't hurt to have a quick look, huh. And so I quickly rolled out their documentation. Familiarized with the process and it seemed more daunting in the moment than anything else. I know what a DNS is or at least, what its job is in the grand scheme of things. What I wasn't too familiar with were the various types of DNS records that could exist all belonging to the same IP address. 

![More Netlify](https://i.imgur.com/VX07mAK.png)

Now, the necessary configuration didn't seem too scary in and of itself but what bothered me was the fact that I could just as well host this little static site myself. And not have to rely on Netlify to hold all my files. And before considering what kind of time investment that might carry, I had "just another little glimpse" into some online articles.

The next obstacle presented itself soon enough. Being tied to this horrendous apartment complex, access to my router's configs and the option of port forwarding, thus exposing a port of my machine to the outside world were not feasible. Nor did I want to crawl back to some hosting platform again, now that I put this idea into my head. So, the third option I have found seemed quite intriguing. Cloudfare's Tunneling Service which they provided free of charge.

Alright, I thought. Can't be too hard. Cloudflare is a reputable company (in some regards less than others), they surely have some accessible documentation and and UIs to work with. And they did, actually. I suppose the fact that I don't know what half the options within my dashboard are for is moreso a sign of my own lack of competence rather than one of Cloudflare's lack of accessability but I read up on everything regarding tunneling in the context of exposing your host machine to the world (securely, of course) and was excited to get this done and over with, as intrigued as I was. And considering it was already past 2am.

> Tunneling refers to creating a secure connection that makes your locally-running application accessible over the internet, bypassing the need for traditional web hosting services. Instead of uploading your code to a hosting platform, you run your application on your own computer (localhost) and use a tunneling service to create a public URL that forwards traffic to your local machine. It's like creating a temporary bridge from the internet directly to your development environment.

Except, next problem. I can't use tunneling without having moved my domain from DreamHost to Cloudflare and having the NameServer entries point at them instead. Before that though, I was also supposed to turn off DNSSEC at my old provider because otherwise I could run into issues regarding DNS resolving.

> DNSSEC creates a secure domain name system by adding cryptographic signatures to existing DNS records. These digital signatures are stored in DNS name servers alongside common record types like A, AAAA, MX, CNAME, etc. By checking its associated signature, you can verify that a requested DNS record comes from its authoritative name server and wasn’t altered en-route, opposed to a fake record injected in a man-in-the-middle attack.

Well, I promptly forgot about the last part but eagerly went through the rest of the onboarding process which was rather self exaplantory. I had moved my domain to Cloudflare within minutes or rather, I just switched out the old NS entries with the ones Cloudflare provided me with. That should have been enough, in theory to get started with the process of tunneling.

> DNS records are instructions stored in the Domain Name System that tell computers how to handle requests for a particular domain. They're like a phone book that translates human-readable domain names into various types of network information.

In regards to that, I want to briefly note the steps down in such a way that I have undergone them to get this domain and the various subdomains onto the world wide web. I still haven't slept. I don't feel so good. I need to find a solution to get rid of all these grammatical errors. Whatever...

### A Step by Step guide for how to set up a tunnel through Cloudflare to expose one of your localhost ports that's currently serving a website

1. Install `cloudflared`
2. Log into your Cloudflare account after `cloudflared tunnel login` opens a browser window
3. Create a new tunnel with \`cloudflared tunnel create <TUNNEL_NAME>
4. This should also create a credential file at \~/.cloudflared/<TUNNEL_ID>.json
5.  Create a `config.yml` inside `~/.cloudflared/`

```
tunnel: my-smut-site
credentials-file: /home/sneedroot/.cloudflared/<TUNNEL_ID>.json

ingress:
  - hostname: www.sneedsite.com
    service: http://localhost:8080
  - service: http_status:404
```

6. Set up the dns record for your exposed subdomain via `cloudflared tunnel route dns romm romm.deenzcan.com`
7. Run the tunnel
8. Either temporarily through \`cloudflared tunnel run romm\`
9. Or as a persistent systemd service (if you're using systemd) `sudo cloudflared service install`

**GOOD JOB YOU DID IT**

There's some odd fascination seeing your website be publicly available just like all the other 3 slop sites you cycle through regularly. I am still very much enthralled. 

Now there are obviously security concerns you have to take into considerations. Cloudflare has an honestly impressive plethora of free options and configurations available with which you can play.

But I am mainly interested in solving as much on my end as possible. I've spun up a Kali container to poke around a bit and there's a lot that can be improved. I will get to that over the next couple days.

{{< alert icon="fire" cardColor="#e63946" iconColor="#1d3557" textColor="#f1faee" >}}
If you're exposing ports serving things you haven't secured or written yourself you probably want to implement security posthaste!
{{< /alert >}}

That being said, whilst engrossed in that rush, I decided to also host some other services through Docker on several subdomains that I got locked down via Cloudflare's access policy. The plan is to use WireGuard as a VPN and reverse proxies for everything but my blog to reject any access that isn't me or me-approved. But I was crashing out too hard for that today....heh...

{{< gallery >}}
  <img src="gallery/01.png" class="grid-w33" />
  <img src="gallery/03.png" class="grid-w33" />
  <img src="gallery/04.png" class="grid-w33" />
  <img src="gallery/05.png" class="grid-w33" />
{{< /gallery >}}

I am still a novice when it comes to containerization despite having to write image build pipelines on a daily basis for my job lol but I think I have learned more about the process last night than I have in my time on the job rip. I might share my compose file once it it's a bit more sensible.

I have set up a small variety of other things and butted my head and quite a few other problems last night but I suppose I can embellish on those some other time. This is getting way too long already.

OH YEAH, I didn't forget my self-imposed task from yesterday either.
Funnily enough, I realized that KaTeX was already implemented.

{{< katex >}}
\\[ N(t) = N_0 e^{-\\lambda t} \\]

Utterly based.
And also, the [About]({{% ref "/about" %}}) section is done.
Well..._done_. I am not really done with it. But I have written enough to be satisfied for now.

As to what I want to have finished by the next time I visit here? Ideally a self-hosted E-Mail server so I can spam people with from my shiny @deenzcan.com  address hehehe.

{{< typeit >}}
Until then...CYA<br>
:^)
{{< /typeit >}}
