FROM alpine:latest

# လိုအပ်သော Tools များ သွင်းယူခြင်း
RUN apk add --no-cache --update wget unzip cloudflared

# V2Ray Core ကို Install လုပ်ခြင်း
RUN wget https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip && \
    unzip v2ray-linux-64.zip && \
    chmod +x v2ray && \
    rm v2ray-linux-64.zip

# မိမိ၏ Config ဖိုင်ကို ကူးထည့်ခြင်း
COPY config.json /etc/v2ray/config.json

# V2Ray နှင့် Cloudflared Tunnel ကို တစ်ပြိုင်နက် Run ခြင်း
# Railway Variables ထဲတွင် TUNNEL_TOKEN ကို ထည့်ထားပေးရန် လိုအပ်သည်
CMD ./v2ray run -c /etc/v2ray/config.json & cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN}
