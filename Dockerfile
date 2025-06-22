FROM alpine:latest

# 安裝 shadowsocks-libev
RUN apk add --no-cache shadowsocks-libev

# 設置預設環境變數
ENV PASSWORD=your_default_password
ENV METHOD=aes-256-gcm
ENV SERVER_PORT=8388

# 暴露端口
EXPOSE 8388

# 健康檢查
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD netstat -an | grep :8388 || exit 1

# 啟動命令
CMD ss-server -s 0.0.0.0 -p $SERVER_PORT -k $PASSWORD -m $METHOD -t 300 --fast-open -v