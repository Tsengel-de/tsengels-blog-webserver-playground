---
title: How is Free Blog encrypted? - Upgrade encryption!
published: true
aura:
  pagetype: website
  description: How is Free Blog encrypted? - Upgrade encryption!
  image: letsencrypt.4y3.jpeg
feed:
  limit: 10
metadata:
  description: How is Free Blog encrypted? - Upgrade encryption!
  og:url: https://blog.tsengel.de/mn/blog/how-to-use-letsencrypt-in-my-blog
  og:type: website
  og:title: How is Free Blog encrypted? - Upgrade encryption! | Tsengels Blog
  og:description: How is Free Blog encrypted? - Upgrade encryption!
  og:image: https://blog.tsengel.de/user/pages/02.blog/how-to-use-letsencrypt-in-my-blog/letsencrypt.4y3.jpeg
  og:image:type: image/jpeg
  og:image:width: 960
  og:image:height: 720
  og:author: Tsengel😁
  twitter:card: summary_large_image
  twitter:title: How is Free Blog encrypted? - Upgrade encryption! | Tsengels Blog
  twitter:description: How is Free Blog encrypted? - Upgrade encryption!
  twitter:site: '@@Bachka_Mongol'
  twitter:creator: '@@Bachka_Mongol'
  twitter:image: https://blog.tsengel.de/user/pages/02.blog/how-to-use-letsencrypt-in-my-blog/letsencrypt.4y3.jpeg
  article:published_time: '2022-03-11T02:24:00+00:00'
  article:modified_time: '2022-03-22T09:05:12+00:00'
  article:author: Tsengel😁
media_order: letsencrypt.4y3.jpeg,letsencryp4.jpeg,letsencrypt.jpg,letsencrypt1.jpeg,letsencrypt2.jpeg,letsencrypt3.jpeg,letsencrypt6.jpeg,letsencrypt7.jpeg,letsencrypt8.jpeg,letsencrypt9.jpeg,letsencrypt-ubuntu.png
date: 2022-03-11 02:24
taxonomy:
  category:
  - blog
  tag:
  - Web
  - SiMS
  - Computer
  - Linux
sitemap:
  ignore: false
  changefreq: daily
  lastmod: 2024-08-11 21:36
body_classes: header-dark header-transparent
hero_classes: text-dark title-h1h2 overlay-light hero-large parallax
hero_image: letsencrypt.4y3.jpeg
show_breadcrumbs: false
process:
  html: true
---


Comments will be posted next time. This time it was important to upgrade the flash encryption. So, I managed to make some pictures for you in between... As promised, I included a little explanation. Later, when I write how to install, more in the next article ...

===

Ok, naturally, my plan to travel 600 km and 4 hours to Berlin was postponed due to a train delay, so I finished watching a movie on the way and suddenly remembered that I haven't written anything here, so I decided to post a little comment.
Ok, let's explain encryption in theory and practice in an article next year. Here's how to use free encryption for web pages only. You may have already seen from the pictures that I used Letsencrypt on this blog page.

[Letsencrypt](https://letsencrypt.org/)usage is free worldwide and valid for 90 days only. So what you need to do to use it is to update it before it expires. As shown in the picture below, I updated on the last day. Why is it not automated, just the cheapest tsengel.de domain name found?[бүртгэгч](https://www.ionos.de/)because it does not support automated registration, only because the discount, the first year, is 12 € (from July 2022 it will be 24 € per year)... If it supported the creation of automated TXT-data, the one in the picture could be scripted to automatically renew in 30 or 60 days.

It's fine for me because it's on a personal page. However, on the 10th of 3 months, I forgot to upload the video, and in 1-2 minutes, I took a snapshot of the screen and only updated the encryption certificate.

From the picture, you can see it almost immediately. Let's learn to use Linux, there are many free or cheap options available. With this knowledge, you can add a little and make it a profession.

So what exactly was done in what order?
1. Purchase a web page address ([where to buy domain name](https://www.google.com/search?q=where+to+buy+domains&oq=where+to+buy+domains&aqs=chrome..69i57j0i512l2j0i22i30l7.6648j0j7&sourceid=chrome&ie=UTF-8))
2. Enter the IP address of your web server as the address
3. Your address should also be specified on the web server (nginx, apache or other web server)
4. Letsencrypt must be installed
5. Update your SSL encryption certificate
6. Update or restart your web server

Voilà! That's it, 😎.

[gallery descEnabled="true" margins=10 lastRow="justify" captions="false" border=0]
![letsencrypt](letsencrypt.jpg "letsencrypt")
![letsencrypt1](letsencrypt1.jpeg "letsencrypt1")
![letsencrypt2](letsencrypt2.jpeg "letsencrypt2")
![letsencrypt3](letsencrypt3.jpeg "letsencrypt3")
![letsencryp4](letsencryp4.jpeg "letsencryp4")
![letsencrypt6](letsencrypt6.jpeg "letsencrypt6")
![letsencrypt9](letsencrypt9.jpeg "letsencrypt9")
![letsencrypt7](letsencrypt7.jpeg "letsencrypt7")
![letsencrypt8](letsencrypt8.jpeg "letsencrypt8")
![letsencrypt-ubuntu](letsencrypt-ubuntu.png "letsencrypt-ubuntu")
[/gallery]