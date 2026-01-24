FROM alpine:latest

RUN apk add --no-cache wget unzip ca-certificates

# V2Ray တင်ခြင်း
RUN wget https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    unzip v2ray-linux-64.zip && \
    chmod +x v2ray && \
    rm v2ray-linux-64.zip

# Cloudflared တင်ခြင်း
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

COPY config.json /etc/v2ray/config.json

# wap tunnel ရဲ့ token ကို ဒီမှာ အစားထိုးပါ
CMD ./v2ray run -c /etc/v2ray/config.json & cloudflared tunnel --no-autoupdate run --token eyJhIjoiNTBlNjY3NDA4YTBjMWQ1MmVmNTBhZmIyNGViNmViOGEiLCJ0IjoiYTI3MTY1YjYtMzdkYy00MmJhLThmM2UtNGFkYzk0YWI5MGE3IiwicyI6Ik5UTXdPR0l3WTJRdFpqWTVaaTAwTldKbExXSTFOelF0WXpNeVlqVmlPV0ZrTkdSbSJ9
