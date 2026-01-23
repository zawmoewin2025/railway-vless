FROM alpine:latest

# လိုအပ်တဲ့ Tools များ သွင်းခြင်း
RUN apk add --no-cache --update wget unzip ca-certificates

# V2Ray တင်ခြင်း
RUN wget https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    unzip v2ray-linux-64.zip && \
    chmod +x v2ray && \
    rm v2ray-linux-64.zip

# Cloudflared တင်ခြင်း
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

COPY config.json /etc/v2ray/config.json

# Token ကို ဒီထဲမှာပဲ တိုက်ရိုက်ထည့်ထားပါတယ်
CMD ./v2ray run -c /etc/v2ray/config.json & cloudflared tunnel --no-autoupdate run --token eyJhIjoiNTBlNjY3NDA4YTBjMWQ1MmVmNTBhZmIyNGViNmViOGEiLCJ0IjoiZWEwMWY1MzAtMDBjNy00MTAxLWFlM2EtNjNhYmY1MGZlMmRhIiwicyI6Ik4ySXlPR00yTTJZdE1XTm1OUzAwTXpFMUxXRXdObVl0TVRRd01qYzJNalJsT1dSbSJ9
