FROM alpine:3.5

RUN apk add --no-cache curl

RUN mkdir -p /app
COPY poll.sh /app/poll.sh

CMD [ "/app/poll.sh" ]
