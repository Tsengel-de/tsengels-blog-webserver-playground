---
title: Grundlegende Schutzmaßnahmen – Privatsphäre 3
published: true
aura:
  pagetype: article
  description: Security Essentials – Datenschutz 3 – Wie schützen Sie Ihre Festplatte?
  image: bitlocker-7.jpg
feed:
  limit: 10
metadata:
  description: Security Essentials – Datenschutz 3 – Wie schützen Sie Ihre Festplatte?
  og:url: https://blog.tsengel.de/mn/blog/how-to-protect-encrypting-3
  og:type: article
  og:title: Grundlegende Sicherheit – Datenschutz 3 | Tsengels-Blog
  og:description: Security Essentials – Datenschutz 3 – Wie schützen Sie Ihre Festplatte?
  og:image: https://blog.tsengel.de/user/pages/02.blog/how-to-protect-encrypting-3/bitlocker-7.jpg
  og:image:type: image/jpeg
  og:image:width: 1920
  og:image:height: 1080
  og:author: Tsengel😁
  twitter:card: summary_large_image
  twitter:title: Grundlegende Sicherheit – Datenschutz 3 | Tsengels-Blog
  twitter:description: Security Essentials – Datenschutz 3 – Wie schützen Sie Ihre
    Festplatte?
  twitter:site: '@@Bachka_Mongol'
  twitter:creator: '@@Bachka_Mongol'
  twitter:image: https://blog.tsengel.de/user/pages/02.blog/how-to-protect-encrypting-3/bitlocker-7.jpg
  article:published_time: '2021-11-14T16:30:00+00:00'
  article:modified_time: '2024-08-11T21:02:19+01:00'
  article:author: Tsengel😁
media_order: bitlocker-7.jpg,bitlocker-1.jpg,bitlocker-2.jpg,bitlocker-3.jpg,bitlocker-4.jpg,bitlocker-5.jpg,bitlocker-6.jpg,bitlocker-8.jpg,bitlocker-9.jpg,bitlocker-10.jpg,bitlocker-11.jpg,bitlocker-12.jpg,bitlocker-13.jpg
date: 2021-11-14 16:30
publish_date: 2021-11-14 16:30
body_classes: header-dark header-transparent
sitemap:
  changefreq: daily
  lastmod: 2024-08-10 21:24
hero_classes: text-dark title-h1h2 overlay-light hero-large parallax
hero_image: bitlocker-7.jpg
taxonomy:
  category:
  - blog
  tag:
  - Nähren
  - Computer
  - Windows
show_breadcrumbs: false
process:
  html: true
---


Lassen Sie uns in Teil 3 dieser Serie etwas tiefer in die Systemsicherheit eintauchen. Mit anderen Worten: So schützen Sie die Festplatte Ihres Windows 11-Systems. Wenn Sie es nicht selbst tun, ist es besser, es anhand des fremden Namens und Bildes zu verstehen.

===

Denn wenn Ihr Computer oder Laptop einmal verloren geht, müssen Sie sich weniger Sorgen um Ihre persönlichen oder geschäftlichen Geheimnisse machen. Nach vielen Jahren gelang es Microsoft, diese Verschlüsselungsfunktion in Windows einzuführen, beginnend mit Windows 10.

### Festplattenverschlüsselung unter Windows ...

!!! Aufmerksamkeit! Wenn Sie über eine kabellose Tastatur (Wireless-Tastatur) verfügen, prüfen Sie sofort beim Einschalten des Computers, ob diese angeschlossen ist, bevor das System startet! Oder verwenden Sie eine kabelgebundene Tastatur und bewahren Sie sie in der Nähe auf.

Sie können es auf allen an Ihr System angeschlossenen Festplatten aktivieren, indem Sie die folgende Reihenfolge befolgen.
1. Überprüfen Sie die Größe Ihrer Festplatte in der Computerverwaltung
- Wenn Sie 2 oder mehr Systeme auf Ihrem Computer installieren, ist es besser, Ihre Festplatte zu partitionieren, bevor Sie sie aktivieren
3. Starten Sie Bitlocker
4. Schalten Sie den Bitlocker ein
- Bei Windows 11 kann das Passwort separat eingegeben werden, bei Windows 10 wurde bei der Aktivierung ein neues Passwort eingegeben
6. Notieren, speichern und drucken Sie Ihren Wiederherstellungsschlüssel
- Dieser Schlüssel ist sehr wichtig, um Ihr System wiederherzustellen, wenn Sie Ihr Passwort vergessen
8. Starten Sie das System neu
- Die Verschlüsselung beginnt nach dem Systemneustart. Oder Sie können, wie im ersten Teil, hineingehen und nachsehen, wohin es führt
10. Aktivieren Sie Passwortkriterien beim Systemstart
- Nur Windows 11
12. Geben Sie das Bitlocker-Passwort ein
- Nur Windows 11
- Meiner Meinung nach ist das beste Passwort das Passwort selbst. Aber wenn Sie nicht zu einfache Passwörter wie 1234 oder Passphrase verwenden müssen, wird es einfacher, erneut zu hacken.
- Starten Sie Powershell oder CMD mit dem folgenden Befehl wie im Bild gezeigt und geben Sie das neue Passwort zweimal ein. Bei Erfolg sieht es genauso aus wie auf dem Bild. Ich habe vergessen, den Laufwerksbuchstaben auf den zu ändern, der dem Jahr des Systems entspricht. Das System hat immer c:.
	```
    manage-bde -protectors -add c: -TPMAndPIN
    ```
[gallery descEnabled="true" margins=10 lastRow="justify" captions="false" border=0]
![1. Computersteuerung](bitlocker-1.jpg "1. Computersteuerung")
![1. Computersteuerung](bitlocker-2.jpg "1. Computersteuerung")
![3. Starten Sie Bitlocker](bitlocker-3.jpg "3. Битлокер (bitlocker)Start")
![4. Schalten Sie den Bitlocker ein](bitlocker-4.jpg "4. Битлокер идэвхжүүлэх (turn bitlocker on)")
![6. Notieren, speichern und drucken Sie Ihren Wiederherstellungsschlüssel](bitlocker-5.jpg "6. Notieren, speichern und drucken Sie Ihren Wiederherstellungsschlüssel")
![8. Starten Sie das System neu](bitlocker-6.jpg "8. Starten Sie das System neu")
![Das ist ein wunderschönes Bild](bitlocker-7.jpg "Das ist ein wunderschönes Bild")
![10. Aktivieren Sie Passwortkriterien beim Systemstart](bitlocker-8.jpg "10. Aktivieren Sie Passwortkriterien beim Systemstart")
![10. Aktivieren Sie Passwortkriterien beim Systemstart](bitlocker-9.jpg "10. Aktivieren Sie Passwortkriterien beim Systemstart")
![10. Aktivieren Sie Passwortkriterien beim Systemstart](bitlocker-10.jpg "10. Aktivieren Sie Passwortkriterien beim Systemstart")
![10. Aktivieren Sie Passwortkriterien beim Systemstart](bitlocker-11.jpg "10. Aktivieren Sie Passwortkriterien beim Systemstart")
![Geben Sie das Bitlocker-Passwort ein](bitlocker-12.jpg "Geben Sie das Bitlocker-Passwort ein")
![Geben Sie das Bitlocker-Passwort ein](bitlocker-13.jpg "Geben Sie das Bitlocker-Passwort ein")
[/gallery]

### Abschluss
Daher haben wir einige grundlegende Möglichkeiten kennengelernt, wie Sie Ihre personenbezogenen Daten in jedem Fall vor Dritten schützen können. Es ist in Ordnung, wenn Sie gelernt haben, damit umzugehen, oder selbst wenn Sie eine ähnliche Technologie verwenden, ist es das Recht und die Verantwortung eines jeden in der Umgebung, sich selbst und die Daten anderer Menschen auf einfachste Weise zu schützen. Im nächsten Artikel werde ich schreiben, wie man Windows und Linux 2 auf einem Computer installiert (Dual-Boot-System).