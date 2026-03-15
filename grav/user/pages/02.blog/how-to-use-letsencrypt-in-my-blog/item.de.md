---
title: Wie wird Free Blog verschlüsselt? - Verbessern Sie die Verschlüsselung!
published: true
aura:
  pagetype: website
  description: Wie wird Free Blog verschlüsselt? - Verbessern Sie die Verschlüsselung!
  image: letsencrypt.4y3.jpeg
feed:
  limit: 10
metadata:
  description: Wie wird Free Blog verschlüsselt? - Verbessern Sie die Verschlüsselung!
  og:url: https://blog.tsengel.de/mn/blog/how-to-use-letsencrypt-in-my-blog
  og:type: website
  og:title: Wie wird Free Blog verschlüsselt? - Verbessern Sie die Verschlüsselung!
    | Tsengels-Blog
  og:description: Wie wird Free Blog verschlüsselt? - Verbessern Sie die Verschlüsselung!
  og:image: https://blog.tsengel.de/user/pages/02.blog/how-to-use-letsencrypt-in-my-blog/letsencrypt.4y3.jpeg
  og:image:type: image/jpeg
  og:image:width: 960
  og:image:height: 720
  og:author: Tsengel😁
  twitter:card: summary_large_image
  twitter:title: Wie wird Free Blog verschlüsselt? - Verbessern Sie die Verschlüsselung!
    | Tsengels-Blog
  twitter:description: Wie wird Free Blog verschlüsselt? - Verbessern Sie die Verschlüsselung!
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


Kommentare werden beim nächsten Mal veröffentlicht. Diesmal war es wichtig, die Flash-Verschlüsselung zu aktualisieren. So habe ich es geschafft, zwischendurch ein paar Bilder für euch zu machen... Wie versprochen habe ich eine kleine Erklärung beigefügt. Später, wenn ich schreibe, wie man installiert, mehr im nächsten Artikel ...

===

Ok, natürlich wurde mein Plan, 600 km und 4 Stunden nach Berlin zu reisen, aufgrund einer Zugverspätung verschoben, also schaute ich mir unterwegs noch einen Film an und fiel plötzlich ein, dass ich hier nichts geschrieben hatte, also beschloss ich, einen kleinen Kommentar zu posten.
Ok, lasst uns nächstes Jahr in einem Artikel die Verschlüsselung in Theorie und Praxis erklären. Hier erfahren Sie, wie Sie die kostenlose Verschlüsselung nur für Webseiten verwenden. Möglicherweise haben Sie anhand der Bilder bereits gesehen, dass ich Letsencrypt auf dieser Blogseite verwendet habe.

[Letsencrypt](https://letsencrypt.org/)Die Nutzung ist weltweit kostenlos und nur 90 Tage gültig. Um es nutzen zu können, müssen Sie es also aktualisieren, bevor es abläuft. Wie im Bild unten gezeigt, habe ich am letzten Tag aktualisiert. Warum wird nicht automatisiert, sondern nur der günstigste tsengel.de-Domainname gefunden?[бүртгэгч](https://www.ionos.de/)weil es keine automatische Registrierung unterstützt, nur weil der Rabatt im ersten Jahr 12 € beträgt (ab Juli 2022 sind es 24 € pro Jahr)... Wenn es die Erstellung automatisierter TXT-Daten unterstützt, könnte die im Bild gezeigte Skript so programmiert werden, dass sie sich in 30 oder 60 Tagen automatisch verlängert.

Für mich ist es in Ordnung, weil es auf einer persönlichen Seite ist. Am zehnten von drei Monaten vergaß ich jedoch, das Video hochzuladen, machte nach ein bis zwei Minuten einen Schnappschuss vom Bildschirm und aktualisierte nur das Verschlüsselungszertifikat.

Auf dem Bild kann man es fast sofort erkennen. Lassen Sie uns lernen, mit Linux umzugehen. Es gibt viele kostenlose oder günstige Optionen. Mit diesem Wissen können Sie ein wenig hinzufügen und daraus einen Beruf machen.

Was genau wurde also in welcher Reihenfolge getan?
1. Kaufen Sie eine Webseitenadresse ([where to buy domain name](https://www.google.com/search?q=where+to+buy+domains&oq=where+to+buy+domains&aqs=chrome..69i57j0i512l2j0i22i30l7.6648j0j7&sourceid=chrome&ie=UTF-8))
2. Geben Sie als Adresse die IP-Adresse Ihres Webservers ein
3. Ihre Adresse sollte auch auf dem Webserver (Nginx, Apache oder anderer Webserver) angegeben werden.
4. Letsencrypt muss installiert sein
5. Aktualisieren Sie Ihr SSL-Verschlüsselungszertifikat
6. Aktualisieren oder starten Sie Ihren Webserver neu

Voilà! Das ist es, 😎.

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