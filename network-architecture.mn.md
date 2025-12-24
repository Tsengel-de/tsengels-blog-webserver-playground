# Сүлжээний Бүтэц (Network Architecture)

```mermaid
graph TB
    subgraph Internet
        Client[Client Browser]
        LetsEncrypt[Let's Encrypt CA]
        IONOS_DNS[IONOS DNS Server]
    end
    
    subgraph Home Network 192.168.88.x
        Router[Mikrotik Chateau 5G AX<br/>Router]
        RaspberryPi[Raspberry Pi<br/>192.168.88.123]
        
        subgraph Services on Pi
            Nginx[Nginx Web Server<br/>:443]
            Grav[Grav CMS<br/>/home/pi/www/grav]
            Certbot[Certbot SSL Manager]
            DDNSScript[DDNS Update Script<br/>check-my-ip-and-update-my-domain.sh]
        end
    end
    
    Client -->|HTTPS| Router
    Router -->|Port 443 NAT| Nginx
    Nginx --> Grav
    
    DDNSScript -->|1. Check WAN IP| OpenDNS[OpenDNSResolver]
    DDNSScript -->|2. Update NAT Rules| Router
    DDNSScript -->|3. Update DNS| IONOS_DNS
    
    Certbot -->|DNS-01 Challenge| LetsEncrypt
    Certbot -->|Create/Delete TXT Records| IONOS_DNS
    LetsEncrypt -->|Verify TXT Records| IONOS_DNS
    Certbot -->|Renew Certificate| Nginx
    
    style RaspberryPi fill:#1976d2,stroke:#0d47a1,stroke-width:2px,color:#fff
    style Router fill:#f57c00,stroke:#e65100,stroke-width:2px,color:#fff
    style Nginx fill:#388e3c,stroke:#1b5e20,stroke-width:2px,color:#fff
    style Certbot fill:#c2185b,stroke:#880e4f,stroke-width:2px,color:#fff
    style DDNSScript fill:#5e35b1,stroke:#311b92,stroke-width:2px,color:#fff
```

## Бүрэлдэхүүн хэсгүүд

### Гадаад үйлчилгээнүүд
- **Let's Encrypt CA**: DNS-01 аргаар SSL/TLS сертификат олгоно
- **IONOS DNS**: Эрх бүхий DNS сервер болон динамик шинэчлэлтийн API
- **OpenDNS**: Одоогийн WAN IP хаягийг олоход ашиглагдана

### Гэрийн сүлжээ
- **Mikrotik Router**: HTTPS (443) траффикийн NAT/Port Forwarding-ийг удирддаг
- **Raspberry Pi** (`192.168.88.123`):
  - **Nginx**: HTTPS хүсэлтийг боловсруулдаг вэб сервер
  - **Grav CMS**: Контент удирдлагын систем
  - **Certbot**: SSL сертификат автоматаар сунгах
  - **DDNS Script**: DNS болон NAT дүрмүүдийг одоогийн WAN IP-тэй зохицуулж байдаг

## Өгөгдлийн урсгал

### 1. Динамик DNS шинэчлэлт
1. Скрипт OpenDNS-рүү хандаж одоогийн WAN IP-г авна
2. Хэрэв IP өөрчлөгдсөн бол: Роутерын NAT дүрмүүдийг SSH-ээр шинэчлэнэ
3. IONOS DNS бичлэгийг API-аар шинэчлэнэ
4. Шинэ IP-г ирээдүйн харьцуулалтад зориулж хадгална

### 2. SSL сертификатын сунгалт
1. Certbot Let's Encrypt-рүү сунгалтыг эхлүүлнэ
2. Certbot IONOS API-аар TXT бичлэг үүсгэнэ (`_acme-challenge`)
3. Let's Encrypt домэйн эзэмшлийг баталгаажуулахаар DNS-рүү хандана
4. Сертификат олгогдож, Nginx дахин ачаална
5. Certbot IONOS API-аар TXT бичлэгийг цэвэрлэнэ

### 3. Хэрэглэгчийн хандалт
1. Хэрэглэгч `https://blog.tsengel.de/mn` хандана
2. DNS одоогийн WAN IP руу чиглүүлнэ (IONOS-оор)
3. Роутер :443 портыг Raspberry Pi руу дамжуулна
4. Nginx Grav CMS-аас контент үзүүлнэ
