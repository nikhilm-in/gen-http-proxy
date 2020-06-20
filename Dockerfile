FROM node:14.4.0-slim

# Proxy source and target related environment variables.
ENV PROXY_HOST="0.0.0.0"
ENV PROXY_PORT="80"
ENV TARGET_HOST=""
ENV TARGET_PORT=""
# For using custom auth token, set this variable to specify the token that the proxy uses. By default it creates one when started.
# ENV token=""
# For tls, set "secure" to true and pass variables specifying the path to the TLS key and certificate
ENV secure="false"
ENV key="./server.key"
ENV cert="./server.crt"
# For servers that drop the token sent as part of the URL, use cookies to transmit the token. it is on by deafult. Increase the "sessiontimeout" if needed.
ENV usecookies="true"
ENV sessiontimeout="60"
# To disable/modify the login page used by the proxy, set "staticserver" to false or point "staticfolder" to the path where the login page is available. If disabled, the proxy issues a 401
ENV staticserver="true"
ENV staticfolder="./static"

WORKDIR /opt/gen-http-proxy
COPY . .

RUN npm install

EXPOSE 80
EXPOSE 443

CMD ./gen-http-proxy.js $PROXY_HOST:$PROXY_PORT $TARGET_HOST:$TARGET_PORT