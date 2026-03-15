---
title: 'Цэнгэлийн  Блог хэрхэн шифрлэсэн бэ? - Шифрлэлт шинэчлэх!'
published: true
aura:
    pagetype: website
    description: 'Цэнгэлийн  Блог хэрхэн шифрлэсэн бэ? - Шифрлэлт шинэчлэх!'
    image: letsencrypt.4y3.jpeg
feed:
    limit: 10
metadata:
    description: 'Цэнгэлийн  Блог хэрхэн шифрлэсэн бэ? - Шифрлэлт шинэчлэх!'
    'og:url': 'https://blog.tsengel.de/mn/blog/how-to-use-letsencrypt-in-my-blog'
    'og:type': website
    'og:title': 'Цэнгэлийн  Блог хэрхэн шифрлэсэн бэ? - Шифрлэлт шинэчлэх! | Tsengels Blog'
    'og:description': 'Цэнгэлийн  Блог хэрхэн шифрлэсэн бэ? - Шифрлэлт шинэчлэх!'
    'og:image': 'https://blog.tsengel.de/user/pages/02.blog/how-to-use-letsencrypt-in-my-blog/letsencrypt.4y3.jpeg'
    'og:image:type': image/jpeg
    'og:image:width': 960
    'og:image:height': 720
    'og:author': Цэнгэл😁
    'twitter:card': summary_large_image
    'twitter:title': 'Цэнгэлийн  Блог хэрхэн шифрлэсэн бэ? - Шифрлэлт шинэчлэх! | Tsengels Blog'
    'twitter:description': 'Цэнгэлийн  Блог хэрхэн шифрлэсэн бэ? - Шифрлэлт шинэчлэх!'
    'twitter:site': '@@Bachka_Mongol'
    'twitter:creator': '@@Bachka_Mongol'
    'twitter:image': 'https://blog.tsengel.de/user/pages/02.blog/how-to-use-letsencrypt-in-my-blog/letsencrypt.4y3.jpeg'
    'article:published_time': '2022-03-11T02:24:00+00:00'
    'article:modified_time': '2022-03-22T09:05:12+00:00'
    'article:author': Цэнгэл😁
media_order: 'letsencrypt.4y3.jpeg,letsencryp4.jpeg,letsencrypt.jpg,letsencrypt1.jpeg,letsencrypt2.jpeg,letsencrypt3.jpeg,letsencrypt6.jpeg,letsencrypt7.jpeg,letsencrypt8.jpeg,letsencrypt9.jpeg,letsencrypt-ubuntu.png'
date: '2022-03-11 02:24'
taxonomy:
    category:
        - blog
    tag:
        - Вэб
        - СиМС
        - Компьютер
        - Линукс
sitemap:
    ignore: false
    changefreq: daily
    lastmod: '2024-08-11 21:36'
body_classes: 'header-dark header-transparent'
hero_classes: 'text-dark title-h1h2 overlay-light hero-large parallax'
hero_image: letsencrypt.4y3.jpeg
show_breadcrumbs: false
---

Тайлбар дараагийн удаа бичигдэнэ. Энэ удаа гялс шифрлэлтийг шинэчлэх нь чухал байсан болно. Тиймээс та бүхэнд бас завсраар нь хэдэн зураг хийж амжлаа ... Амласан ёсоор жаахан тайлбар орууллаа. Дараа нь хэрхэн суулгах талаар бичихдээ ондоо нийтлэлд дэлгэрэнгүй ...

===

Ок, угаасаа замд 4 цаг явж 600 км явж Берлин орох төлөвлөгөө галт тэрэгний хоцролтоос болж 1-р нэмэгдсэн тул замд үзэх киногоо дуусгачихаад гэнэт энд юм бичээгүйгээ санаад жаахан ч гэсэн тайлбар оруулахаар шийдлээ.
Ок, шифрлэлт гэдгийг онол практикаар тайлбарлахыг ондоо нийтлэлд оруулъя. Энд зөвхөн Вэб хуудаст хэрхэн үнэгүй шифрлэлт ашигласанаа дурьдая. Энэхүү блог хуудаст би Letsencrypt ашигласаныг та аль хэдийн зурагнууд дээрээс харсан байх.

[Letsencrypt](https://letsencrypt.org/) ашиглалт нь дэлхий даяар үнэгүй бөгөөд 90 хоногийн л хүчинтэй байдаг. Тэгэхээр ашиглахын тулд яах ёстой вэ гэвэл хугацаа нь дуусахаас нь өмнө шинэчлэх. Доорхи зураг дээр дүрслэгдсэнээс бол би хамгийн сүүлчийн өдөр нь шинэчилжээ. Яагаад автоматжуулаагүй юм бэ гэж үү, зүгээр л олдсон хамгийн хямдхан tsengel.de gedeg хаягны (domain name) [бүртгэгч](https://www.ionos.de/) нь автоматжуулсан бүртгэл дэмждэггүй болохоор, хямдрал буюу эхний жил нь 12 € гэсэн болохоор л (2022 оны 7 сараас жилийн 24 € болно)... Хэрвээ автоматжуулсан TXT-өгөгдөл үүсгэхийг дэмждэг байсан бол зураг дээр байгааг скриптлэж 30 юм уу 60 хоногт автоматаар шинэчлэдэг болгож болно.

Хувийн хуудаст болохоор надад таарч л байна. Харин 3 сарынд 10-нд харин мартчихаад бичлэг оруулж амжилгүй 1-2 минутанд гялс дэлгэцний зураг авч шифрлэх цертификатыг л шинэчилсэн болно.

Зураг дээрээс тэгэхдээ бараг шууд хараад ойлгохоор байгаа даа. Линукс ашиглаж сурцгаая, үнэгүй эсвэл хямдхан боломж таньд их олдоно. Энэ мэдлэгээрээ бас жаахан нэмээд мэргэжил болгосон ч болно.

Тэгэхээр яг ямар дэс дараалалаар юу хийсэн бэ
1. Вэб хуудасны хаягаа худалдаж авах хэрэгтэй ([where to buy domain name](https://www.google.com/search?q=where+to+buy+domains&oq=where+to+buy+domains&aqs=chrome..69i57j0i512l2j0i22i30l7.6648j0j7&sourceid=chrome&ie=UTF-8))
2. Вэб сервернийхээ IP хаягийг нь хаягны чиглэл болгож өгөх
3. Вэб сервер дээрээ бас хаяг тань заагдсан байх ёстой (nginx, apache or other web server)
4. letsencrypt суулгасан байх
5. SSL шифрлэлтийн цертификатаа шинэчлэх
6. Вэб сервертээ өөрчлөлтийг мэдрүүлэх буюу шинээр асаах

Voilà! Ингээд л болоо, 😎.

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