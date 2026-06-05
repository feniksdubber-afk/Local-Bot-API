FROM aiogram/telegram-bot-api:latest

# Railway PORT env ni ishlatadi
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
