---
title: 'Цэнгэлийн блогийг хэрхэн Raspi4 дээр GravCMS-тай суулгасан нь ...'
published: true
sitemap:
    ignore: false
    changefreq: daily
    lastmod: '2024-08-11 21:36'
aura:
    pagetype: website
    description: 'Цэнгэлийн блогийг хэрхэн Raspi4 дээр GravCMS-тай суулгасан нь ...'
    image: Build-faster-Websites.png
feed:
    limit: 10
metadata:
    description: 'Цэнгэлийн блогийг хэрхэн Raspi4 дээр GravCMS-тай суулгасан нь ...'
    'og:url': 'https://blog.tsengel.de/mn/blog/how-to-setup-blog-with-gravcms-on-raspi4'
    'og:type': website
    'og:title': 'Цэнгэлийн блогийг хэрхэн Raspi4 дээр GravCMS-тай суулгасан нь ... | Tsengels Blog'
    'og:description': 'Цэнгэлийн блогийг хэрхэн Raspi4 дээр GravCMS-тай суулгасан нь ...'
    'og:image': 'https://blog.tsengel.de/user/pages/02.blog/how-to-setup-blog-with-gravcms-on-raspi4/Build-faster-Websites.png'
    'og:image:type': image/png
    'og:image:width': 1435
    'og:image:height': 792
    'og:author': Цэнгэл😁
    'twitter:card': summary_large_image
    'twitter:title': 'Цэнгэлийн блогийг хэрхэн Raspi4 дээр GravCMS-тай суулгасан нь ... | Tsengels Blog'
    'twitter:description': 'Цэнгэлийн блогийг хэрхэн Raspi4 дээр GravCMS-тай суулгасан нь ...'
    'twitter:site': '@@Bachka_Mongol'
    'twitter:creator': '@@Bachka_Mongol'
    'twitter:image': 'https://blog.tsengel.de/user/pages/02.blog/how-to-setup-blog-with-gravcms-on-raspi4/Build-faster-Websites.png'
    'article:published_time': '2022-01-30T17:54:00+00:00'
    'article:modified_time': '2022-01-31T21:40:46+00:00'
    'article:author': Цэнгэл😁
body_classes: 'header-dark header-transparent'
hero_classes: 'text-dark title-h1h2 overlay-light hero-large parallax'
media_order: 'grav-content-management-2 (1).jpg,20220130_220905.jpg,20220130_220948.jpg,20220130_221032.jpg,Build-faster-Websites.png'
date: '2022-01-30 17:54'
publish_date: '2022-01-30 17:54'
hero_image: 'grav-content-management-2 (1).jpg'
taxonomy:
    category:
        - blog
    tag:
        - Вэб
        - Блог
        - Компьютер
        - Линукс
show_breadcrumbs: false
---

Энэ блог нь миний гэрт Raspberry Pie 4 дээр ажиллаж байгаа блог болно. Юу болон ямар технологи хэрэглэгдсэн бэ гэдгийг энэ нийтлэлдээ товчхон дурьдая ... Убунту суулгацын талаархи англи зааварчлагуудыг дэлгэрүүлэн орчуулж тэр талаархи үгийнхээ баялгийг сайжруулсан байхаа гэж найдаж байна,🤓😎.

===

**Энэ блогийг бүтээхэд ямар техник ба технологи хэрэглэгдсэн бэ:**
1. [Raspberry Pie 4 Model B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)
2. [Raspberry Pi OS Lite](https://www.raspberrypi.com/software/operating-systems/)
3. Систем суулгахад - Sandisk microSDHC 32GB Class10
4. [Raspberry Pi дээр GravCMS хэрхэн Nginx + PHP7-тай суулгах вэ?](https://getgrav.org/blog/raspberrypi-nginx-php7-dev)

![Grav-Teaser](Build-faster-Websites.png "Build-faster-Websites")

##### 1. [Raspberry Pie 4 Model B](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/)

Энэхүү мини (mini) компъютер сүүлийн үед миний туршилтуудад их тустай үүрэг гүйцэтгэж байгаа. Нийтдээ 5 ширхэгийг би хувьдаа хэрэглэдэг бөгөөд нэг дээр нь түрүү жил зун блогдоо зориулсан хувийн CMS (content management system) суулгац гэртээ ашиглахаар шийдэн суулгаж тохируулсан болно. Raspberry Pie 3 Model B-г эхлэж ашигласан боловч дэндүү их халахаас гадна Вэбхуудас ачаалагдах хурд нь Raspberry Pie 4 Model B-г бодвол мэдэгдэхүйц удаан байсан болно.
Худалдан авахдаа яаж, юунд ашиглах вэ гэдгээ бодон сайн төлөвлөх хэрэгтэй. Тогны, дэлгэцийн болон интернетийн кабель, гэр ... гээд олон авах эд ангиуд бна.

Raspberry Pi 4 Model B нь ердөө 56 × 17 × 85 мм хэмжээтэй нэг самбарт компьютер бөгөөд энгийн ажил хийхэд тохиромжтой. Тиймээс үүнийг ширээний компьютерийг солих (энгийн оффисын програмууд), NAS консол эсвэл медиа төв болгон ашиглаж болно. Сүүлийнх нь 4K дэлгэцийн дэмжлэг боломжтой болсон.

##### 2. [Raspberry Pi OS Lite](https://www.raspberrypi.com/software/operating-systems/)

Дебиан линукс дээр үндэслэсэн бөгөөд Убунту-тай төстэй гэсэн үг. Тиймээс та Убунту-гаа суулгаж жаахан туршсан бол шууд энэ систем дээр адилхан ажиллах боломжтой. Мэдээж арай ондоо ямар суулгац хаанаас яаж олж суулгах вэ гэх мэтчилэн. Гэхдээ Raspberry Pie нь дэлхий даяар хэрэглэгддэг бөгөөд таньд асуулт болон шинэ санаа байвал англи дээр шууд гүүглэдэхэд ямар ч байсан хариу ба тусламж найдвартай олох болно. Энэ нь би яагаад ихэвчлэн олны ашигладаг техник болон технологи ашигладаг вэ гэдэг асуултад хариулна. Цаг хэмнэх, мэддэг дээрээ нэмж мэдлэгээ өргөжүүлэх амархан боломж. Мэдээж хямдхан бус гэхдээ хятад буюу азид электроник ойролцоо нь хямдхан олдоно гэдэгт би итгэж байна. Заавалчгүй хамгийн үнэтэйг нь хайгаад байхдаа бус өөрийнхөө хэрэгцээний хэмжээг мэдэж хангалттай хөрөнгө оруулж сурах нь маш чухал. Өөрөөр хэлбэл таны сурч мэдэж байгаа болгон тань ирээдүйд оруулж буй хөрөнгө оруулалт гэсэн үг, 🤗.

##### 3. Систем суулгахад - Sandisk microSDHC 32GB Class10

Дор хаяж Class10 байвал зүгээр, яагаад гэвэл энэ хурднаас бас таны системийн хурд хамаарна (harddisk).

##### 4. [Raspberry Pi дээр GravCMS хэрхэн Nginx + PHP7-тай суулгах вэ?](https://getgrav.org/blog/raspberrypi-nginx-php7-dev)

Яагаад [GravCMS](https://getgrav.org/) гэж үү? 3-4 жилийн өмнө нэг найздаа ашиглахад амархан Цэцэрлэгийн үйлчилгээний Вэб хуудас хийхэд нь туслах гэж шалгаруулахад энэ нь хамгийн энгийн амархан шийдэл мэт санагдсан нь, түрүү жил санаанд орж байгаа Raspi дээрээ гэртээ сервер босгохоор шийдсэн билээ.

**Ямар ямар CMS ашиглаж байсан бэ гэвэл :**
- Typo3
- Drupal
- Joomla
- Wordpress
- GramCMS

Хэрвээ та кодлож байсан бол Markdown гэж сонссон байх. Ерөнхийдөө бол энэ нь програмчлалд нэгэн тэмдэглэгээний хэл бөгөөд бүх Кодын төсөл дээр Тайлбар хийх хэл (README.md in every project on Github and Gitlab ...) болж ашиглагддаг. Тэгэхээр миний хувьд олон янзын дүрэм журам судлаад байлгүй амархан ашиглах боломж гэсэн үг. Тэрнээс гадна би үнэгүй хувилбарыг нь ашигласан бөгөөд ганц авсан өргөтгөл нь Зургийн цомог болно ([Lightbox Gallery Premium](https://getgrav.org/premium/lightbox-gallery) = 25 $). Зургийг үнэгүй харуулж болох болон үнэгүй өргөтгөл ашиглах боломж бас байсан, би харин цаг алдалгүйгээр шууд ашиглаж эхлэх сонирхолтой байсан учраас шууд худалдан авсан. Та өөртөө таарсаныг нь хайж олоод эсвэл өөрөө бас өргөтгөл кодлож болно.
Ямар ч байсан миний нийтлэлд зориулах 30 мин-г хэмнэж өгч байгаа, 😊😇.
Тэрнээс гадна нөгөө нэг онцлог нь энэ Кеш (cache) ашигладаг бөгөөд Өгөгдлийн сантай орооцолдох өндөр шаардлага нь шууд хасагдана, 🤩🥳. Мхм, цаг хэмнэх, бага асуудалтай байх гэдэг нь чухал, ямар ч байсан миний хэрэгцээнд...

!!! Тэгэхээр та хамгийн түрүүнд бас сурцан байвал зүгээр нэг нь Markdown, 😎. 

Ихэнх Програм хөгжүүлэгч програмууд Markdown-г хэрэглэгч талаас харуулж чаддаг. Хэрвээ та Chrome Browser ашигладаг бол бас энийг харуулдаг энэ хөтөчдөө өргөтгөл суулгаж болно (https://chrome.google.com/webstore/detail/markdown-viewer/ckkdlimhmcjmikdlpkmbgfkaikojcbjk?hl=en).

Хэрхэн Raspi-гаа бэлдэх талаар маш дэлгэрэнгүй энэ доорхи линк дээрхи нийтлэл дээр бичсэн байна. Мэдээж Линукс ашиглаж сурсан байх ёстой. Заавал хийх сонирхолтой бөгөөд туршлага дутаж байвал хэлээрэй, эсвэл алдааг нь явуулаарай.

[https://getgrav.org/blog/raspberrypi-nginx-php7-dev](https://getgrav.org/blog/raspberrypi-nginx-php7-dev)

[gallery descEnabled="true" margins=10 lastRow="justify" captions="false" border=0]
![Webserver on Raspi 4](20220130_220948.jpg "Webserver on Raspi 4")
![Webserver on Raspi 4](20220130_221032.jpg "Webserver on Raspi 4")
![Raspi-Farm](20220130_220905.jpg "Raspi-Farm")
[/gallery]

Жаахан тоосонд дарагдчихаж, тэгж байгаад нэг үлээлгэгчээр сойзтой цэвэрлэнэ дээ,😅😂.


!!! Дараагийн нийтлэл дээр энэ босгосон серверээ хэрхэн Домайн нэртэй холбох болон шифрлэлтийг Letsencrypt ашиглан идэвхжүүлэхийг товч бичнэ ээ. Энэ нийтлэлийг дэндүү товчилсон тул зав гарах болгонд эсвэл дэлгэрүүлэх санал төрвөл сайжруулна!