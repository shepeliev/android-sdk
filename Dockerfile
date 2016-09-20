FROM ubuntu:16.04

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

COPY android-accept-licenses.sh /opt

RUN apt-get update \
  && apt-get install default-jdk wget expect git -y \
  && dpkg --add-architecture i386 \
  && apt-get -qqy update \
  && apt-get -qqy install libncurses5:i386 libstdc++6:i386 zlib1g:i386 \
  && wget -qO- https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz | tar xz -C /opt \
  && rm -rf /var/lib/apt/lists/*

RUN /opt/android-accept-licenses.sh "/opt/android-sdk-linux/tools/android update sdk -a -u -t tools,platform-tools,build-tools-24.0.2,android-23,extra-android-m2repository,extra-google-m2repository" \
  && rm -rf /var/lib/apt/lists/*
