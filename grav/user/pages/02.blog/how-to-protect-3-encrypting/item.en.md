---
title: Essential Protections - Privacy 3
published: true
aura:
  pagetype: article
  description: Security Essentials - Privacy 3 - How to protect your hard drive?
  image: bitlocker-7.jpg
feed:
  limit: 10
metadata:
  description: Security Essentials - Privacy 3 - How to protect your hard drive?
  og:url: https://blog.tsengel.de/mn/blog/how-to-protect-encrypting-3
  og:type: article
  og:title: Essential Security - Privacy 3 | Tsengels Blog
  og:description: Security Essentials - Privacy 3 - How to protect your hard drive?
  og:image: https://blog.tsengel.de/user/pages/02.blog/how-to-protect-encrypting-3/bitlocker-7.jpg
  og:image:type: image/jpeg
  og:image:width: 1920
  og:image:height: 1080
  og:author: Tsengel😁
  twitter:card: summary_large_image
  twitter:title: Essential Security - Privacy 3 | Tsengels Blog
  twitter:description: Security Essentials - Privacy 3 - How to protect your hard
    drive?
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
  - Nurture
  - Computer
  - Windows
show_breadcrumbs: false
process:
  html: true
---


In part 3 of this series, let's dive a little deeper into systems security. In other words, how to protect your Windows 11 system hard drive. If you don't do it yourself, it's better to understand it by the foreign name and picture.

===

Because if somehow your computer or laptop is lost, you will have less need to worry about your personal or business secrets. After many years, Microsoft managed to introduce this encryption function to Windows, starting with Windows 10.

### Hard disk encryption on Windows ...

!!! Attention! If you have a wireless keyboard (wireless keyboard), check that it is connected immediately when the computer is turned on before the system starts! Or use a wired keyboard and keep it nearby.

You can enable it on all hard drives connected to your system by the following sequence.
1. Check the size of your hard drive in computer management
- If you install 2 or more systems on your computer, it is better to partition your hard disk before activating it
3. Start bitlocker
4. Turn bitlocker on
- In Windows 11, the password can be entered separately, in Windows 10, a new password was entered during activation
6. Write down, save and print your recovery key
- This key is very important to restore your system when you forget your password
8. Reboot the system
- Encryption will start after system restart. Or, as in the first part, you can go in and check where it is going
10. Enable password criteria at system startup
- Windows 11 only
12. Enter Bitlocker password
- Windows 11 only
- In my opinion, the best password is the password itself. But not having to use too easy passwords like 1234 or passphrase will make it easier to hack again.
- Start Powershell or CMD with the following command as shown in the picture and enter the new password twice. If successful, it will look exactly like the picture. I forgot to change the drive letter to the one that matches the year of the system. System always has c:.
	```
    manage-bde -protectors -add c: -TPMAndPIN
    ```
[gallery descEnabled="true" margins=10 lastRow="justify" captions="false" border=0]
![1. Computer control](bitlocker-1.jpg "1. Computer control")
![1. Computer control](bitlocker-2.jpg "1. Computer control")
![3. Start bitlocker](bitlocker-3.jpg "3. Битлокер (bitlocker)start")
![4. Turn bitlocker on](bitlocker-4.jpg "4. Битлокер идэвхжүүлэх (turn bitlocker on)")
![6. Write down, save and print your recovery key](bitlocker-5.jpg "6. Write down, save and print your recovery key")
![8. Reboot the system](bitlocker-6.jpg "8. Reboot the system")
![This is a beautiful picture](bitlocker-7.jpg "This is a beautiful picture")
![10. Enable password criteria at system startup](bitlocker-8.jpg "10. Enable password criteria at system startup")
![10. Enable password criteria at system startup](bitlocker-9.jpg "10. Enable password criteria at system startup")
![10. Enable password criteria at system startup](bitlocker-10.jpg "10. Enable password criteria at system startup")
![10. Enable password criteria at system startup](bitlocker-11.jpg "10. Enable password criteria at system startup")
![Enter the Bitlocker password](bitlocker-12.jpg "Enter the Bitlocker password")
![Enter the Bitlocker password](bitlocker-13.jpg "Enter the Bitlocker password")
[/gallery]

### Conclusion
Thus, we have learned some basic ways to protect your personal data from third parties in any case. It's fine when you've learned to use it, or even if you use similar technology, protecting yourself and other people's data in the simplest way is everyone's right and responsibility in the environment. In the next article, I will write how to install Windows and Linux 2 on one computer (dual boot system).