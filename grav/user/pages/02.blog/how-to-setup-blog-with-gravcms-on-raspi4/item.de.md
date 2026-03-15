---
title: So installieren Sie GravCMS auf Raspi4 mit GravCMS ...
published: true
sitemap:
  ignore: false
  changefreq: daily
  lastmod: 2024-08-11 21:36
aura:
  pagetype: website
  description: So installieren Sie GravCMS auf Raspi4 mit GravCMS ...
  image: Build-faster-Websites.png
feed:
  limit: 10
metadata:
  description: So installieren Sie GravCMS auf Raspi4 mit GravCMS ...
  og:url: https://blog.tsengel.de/mn/blog/how-to-setup-blog-with-gravcms-on-raspi4
  og:type: website
  og:title: So installieren Sie Free Blog mit GravCMS auf Raspi4 ... | Tsengels-Blog
  og:description: So installieren Sie GravCMS auf Raspi4 mit GravCMS ...
  og:image: https://blog.tsengel.de/user/pages/02.blog/how-to-setup-blog-with-gravcms-on-raspi4/Build-faster-Websites.png
  og:image:type: image/png
  og:image:width: 1435
  og:image:height: 792
  og:author: Tsengel😁
  twitter:card: summary_large_image
  twitter:title: So installieren Sie Free Blog mit GravCMS auf Raspi4 ... | Tsengels-Blog
  twitter:description: So installieren Sie GravCMS auf Raspi4 mit GravCMS ...
  twitter:site: '@@Bachka_Mongol'
  twitter:creator: '@@Bachka_Mongol'
  twitter:image: https://blog.tsengel.de/user/pages/02.blog/how-to-setup-blog-with-gravcms-on-raspi4/Build-faster-Websites.png
  article:published_time: '2022-01-30T17:54:00+00:00'
  article:modified_time: '2022-01-31T21:40:46+00:00'
  article:author: Tsengel😁
body_classes: header-dark header-transparent
hero_classes: text-dark title-h1h2 overlay-light hero-large parallax
media_order: grav-content-management-2 (1).jpg,20220130_220905.jpg,20220130_220948.jpg,20220130_221032.jpg,Build-faster-Websites.png
date: 2022-01-30 17:54
publish_date: 2022-01-30 17:54
hero_image: grav-content-management-2 (1).jpg
taxonomy:
  category:
  - blog
  tag:
  - Web
  - Blog
  - Computer
  - Linux
show_breadcrumbs: false
process:
  html: true
---


Dieser Blog wird mein Homerun auf einem Raspberry Pie 4 sein. Lassen Sie uns in diesem Artikel kurz erwähnen, was und welche Technologie verwendet wurde ... Ich hoffe, dass ich meinen Wortschatz bereichert habe, indem ich die englischen Anweisungen zur Installation von Ubuntu im Detail übersetzt habe,🤓😎.

===

**Techniken und Technologien, die zur Erstellung dieses Blogs verwendet wurden:**
1. [Raspberry Pie 4 Model B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)
2. [Raspberry Pi OS Lite](https://www.raspberrypi.com/software/operating-systems/)
3. So installieren Sie das System: Sandisk microSDHC 32 GB Class10
4. [Raspberry Pi дээр GravCMS хэрхэн Nginx + PHP7-тай суулгах вэ?](https://getgrav.org/blog/raspberrypi-nginx-php7-dev)

![Grav-Teaser](Build-faster-Websites.png "Build-faster-Websites")

##### 1. [Raspberry Pie 4 Model B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)

Dieser Minicomputer war in letzter Zeit bei meinen Experimenten sehr hilfreich. Insgesamt verwende ich persönlich fünf davon und habe letzten Sommer beschlossen, ein persönliches CMS (Content Management System) für meinen Blog zu installieren und zu konfigurieren. Begann mit Raspberry Pie 3 Model B, aber zusätzlich zur Überhitzung war die Ladegeschwindigkeit von Webseiten deutlich langsamer als beim Raspberry Pie 4 Model B.
Beim Kauf sollten Sie darüber nachdenken, wie und wofür Sie es verwenden möchten. Es gibt viele Teile zu kaufen, wie Kabel, Bildschirm und Internetkabel, Gehäuse ...

Der Raspberry Pi 4 Model B ist ein Einplatinencomputer mit Abmessungen von nur 56 × 17 × 85 mm, geeignet für einfache Aufgaben. Somit kann es als Desktop-Ersatz (einfache Office-Anwendungen), NAS-Konsole oder Mediacenter verwendet werden. Letzteres unterstützt jetzt die 4K-Anzeige.

##### 2. [Raspberry Pi OS Lite](https://www.raspberrypi.com/software/operating-systems/)

Debian basiert auf Linux und ähnelt Ubuntu. Wenn Sie also Ihr Ubuntu installiert und eine Weile ausprobiert haben, können Sie es sofort auf diesem System ausführen. Natürlich, in ein paar Jahren, welche Setzlinge, wo man sie findet, wie man sie installiert usw. Aber Raspberry Pie wird auf der ganzen Welt verwendet, und wenn Sie Fragen oder neue Ideen haben, können Sie jederzeit auf Englisch um Antworten und Hilfe bitten. Dies beantwortet die Frage, warum ich häufig verwendete Techniken und Technologien verwende. Eine einfache Möglichkeit, Zeit zu sparen und Ihr Wissen zu erweitern, indem Sie bereits vorhandenes Wissen ergänzen. Natürlich ist es nicht billig, aber ich glaube, dass chinesische oder asiatische Elektronik in der Nähe günstiger zu finden ist. Es ist sehr wichtig, die Höhe Ihres Bedarfs zu kennen und zu lernen, genügend Geld zu investieren, nicht unbedingt auf der Suche nach dem teuersten. Mit anderen Worten: Alles, was Sie lernen, ist eine Investition in die Zukunft, 🤗.

##### 3. So installieren Sie das System: Sandisk microSDHC 32 GB Class10

Zumindest Klasse 10 ist in Ordnung, da diese Geschwindigkeit auch von der Geschwindigkeit Ihres Systems (Festplatte) abhängt.

##### 4. [Raspberry Pi дээр GravCMS хэрхэн Nginx + PHP7-тай суулгах вэ?](https://getgrav.org/blog/raspberrypi-nginx-php7-dev)

Warum[GravCMS](https://getgrav.org/)ist es? Als ich vor drei bis vier Jahren einen Freund bat, ihm beim Aufbau einer benutzerfreundlichen Website für einen Gartenservice zu helfen, schien dies die einfachste Lösung zu sein, und letztes Jahr beschloss ich, zu Hause einen Server auf meinem Raspi zu bauen.

**Welches CMS wurde verwendet:**
- Typo3
- Drupal
- Joomla
- Wordpress
- GramCMS

Wenn Sie schon einmal programmiert haben, haben Sie wahrscheinlich schon von Markdown gehört. Im Allgemeinen handelt es sich um eine Auszeichnungssprache in der Programmierung und wird als Kommentarsprache (README.md in jedem Projekt auf Github und Gitlab ...) in allen Code-Projekten verwendet. Für mich bedeutet das, dass ich es einfach nutzen kann, ohne viele verschiedene Regeln studieren zu müssen. Ansonsten habe ich die kostenlose Version verwendet und die einzige Erweiterung, die ich bekam, war Photo Gallery ([Lightbox Gallery Premium](https://getgrav.org/premium/lightbox-gallery)= 25 $). Es gab auch die Möglichkeit, Bilder kostenlos anzuzeigen und eine kostenlose Erweiterung zu nutzen, aber ich habe sie mir sofort gekauft, weil ich sofort mit der Nutzung beginnen wollte. Sie können eine finden, die für Sie geeignet ist, oder selbst eine Erweiterung programmieren.
Jedenfalls spare ich dadurch 30 Minuten für meinen Artikel, 😊😇.
Darüber hinaus besteht ein weiteres Merkmal darin, dass der Cache verwendet wird und die hohen Anforderungen an die Verschränkung mit der Datenbank sofort beseitigt werden, 🤩🥳. Hmmm, Zeitersparnis und weniger Ärger sind wichtig, zumindest für meine Bedürfnisse ...

!!! Das erste, was Sie also lernen müssen, ist Markdown, 😎.

Die meisten Anwendungsentwicklungsprogramme können Markdown auf der Benutzerseite anzeigen. Wenn Sie den Chrome-Browser verwenden, können Sie eine Erweiterung für diesen Browser installieren, die dies ebenfalls anzeigt (https://chrome.google.com/webstore/detail/markdown-viewer/ckkdlimhmcjmikdlpkmbgfkaikojcbjk?hl=en).

Wie Sie Ihr Raspi zubereiten, erfahren Sie im Artikel unter dem folgenden Link ausführlich. Natürlich sollten Sie den Umgang mit Linux erlernen. Wenn Sie daran interessiert sind, die Must-Haves zu erledigen, und keine Erfahrung haben, lassen Sie es mich wissen oder senden Sie mir einen Fehler.

[https://getgrav.org/blog/raspberrypi-nginx-php7-dev](https://getgrav.org/blog/raspberrypi-nginx-php7-dev)

[gallery descEnabled="true" margins=10 lastRow="justify" captions="false" border=0]
![Webserver on Raspi 4](20220130_220948.jpg "Webserver on Raspi 4")
![Webserver on Raspi 4](20220130_221032.jpg "Webserver on Raspi 4")
![Raspi-Farm](20220130_220905.jpg "Raspi-Farm")
[/gallery]

Es ist etwas staubig, also reinige ich es mit einer Bürste und einem Blasebalg, 😅😂.


!!! Im nächsten Artikel beschreibe ich kurz, wie man diesen Server mit einem Domainnamen verbindet und die Verschlüsselung mit Letsencrypt aktiviert. Dieser Artikel ist sehr kurz, daher werde ich ihn verbessern, wann immer ich Zeit habe oder einen Vorschlag zur Erweiterung habe!