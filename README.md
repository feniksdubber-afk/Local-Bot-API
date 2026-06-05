# Railway — Local Bot API Sozlash

## Nima uchun kerak?
Telegram Bot API oddiy holatda faylni **50MB** gacha qabul qiladi.
Local Bot API server orqali bu limit **2GB** ga ko'tariladi.

---

## 1-qadam — Local Bot API servisini yaratish

1. Railway dashboard → **New Service → Empty Service**
2. Servis nomini `local-bot-api` deb nomlang
3. **Settings → Source** → GitHub repo yoki **Deploy → Dockerfile** yuklang

Dockerfile (yangi repo yoki papkada):
```dockerfile
FROM aiogram/telegram-bot-api:latest
ENV PORT=8081
CMD ["sh", "-c", \
  "telegram-bot-api \
  --api-id=${API_ID} \
  --api-hash=${API_HASH} \
  --local \
  --port=${PORT} \
  --dir=/tmp/telegram-bot-api \
  --temp-dir=/tmp/telegram-bot-api-tmp \
  --log=/dev/stdout"]
```

4. **Variables** qo'shing:
```
API_ID      = (Telegram API ID — my.telegram.org dan olinadi)
API_HASH    = (Telegram API Hash)
PORT        = 8081
```

5. Deploy qiling — 1-2 daqiqada ishga tushadi

---

## 2-qadam — Internal URL ni olish

Servis deploy bo'lgandan keyin:

**Settings → Networking → Private Networking**

U yerda shunday ko'rinadi:
```
local-bot-api.railway.internal
```

---

## 3-qadam — Botingizga ulash

Botingiz servisiga (Video-converter) faqat bitta environment variable qo'shing:

```
LOCAL_BOT_API_URL = http://local-bot-api.railway.internal:8081/bot
```

Bot avtomatik ravishda Local API orqali ishlaydi — boshqa hech narsa o'zgartirish shart emas.

---

## Tekshirish

Bot loglarida shu qator ko'rinishi kerak:
```
✅ Local Bot API: http://local-bot-api.railway.internal:8081/bot
```

Agar ko'rinmasa — `LOCAL_BOT_API_URL` variable to'g'ri kiritilganini tekshiring.

---

## Muhim eslatma

Local Bot API `--local` rejimida ishlaydi — bu degani fayllar
Telegram serveriga emas, to'g'ridan-to'g'ri sizning serveringizga yuklanadi.
`/tmp/telegram-bot-api` papkasida saqlanadi (vaqtinchalik).
