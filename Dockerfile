FROM alpine:3.6
ADD ./version.txt .

ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.url="https://nxfilter.org/p3/" \
      org.label-schema.vendor="Jahastech" \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF
RUN apk -U add openjdk8-jre curl unzip
RUN curl $(printf ' -O http://pub.nxfilter.org/nxfilter-%s.zip' $(cat version.txt)) && \
    cd / && \
    unzip $(printf 'nxfilter-%s.zip' $(cat version.txt)) -d /nxfilter && \
    rm -f $(printf 'nxfilter-%s.zip' $(cat version.txt)) && \
    chmod +x /nxfilter/bin/startup.sh
EXPOSE 53/udp 80 443 19001 19002 19003
CMD ["/nxfilter/bin/startup.sh","2>&1"]
