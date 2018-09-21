FROM ubuntu:18.04

ENV ANDROID_HOME /opt/android
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

COPY android-accept-licenses.sh /opt

RUN mkdir /opt/android

RUN apt update \
  && apt install openjdk-8-jdk wget unzip expect -y \
  # && dpkg --add-architecture i386 \
  # && apt-get -qqy update \
  # && apt-get -qqy install libncurses5:i386 libstdc++6:i386 zlib1g:i386 \
  && wget -qO- https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip | unzip -d /opt/android \
  && /opt/android-accept-licenses.sh "sdkmanager \"tools\" \"platform-tools\" \"build-tools;28.0.2\" \"extras;android;m2repository\" \"extras;google;m2repository\" \"emulator\" \"platforms;android-28\" \"system-images;android-28;google_apis;x86_64\"" \
  && rm -rf /var/lib/apt/lists/* 
