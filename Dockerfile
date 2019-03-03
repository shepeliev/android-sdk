FROM ubuntu:18.04

ENV ANDROID_HOME /opt/android
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

ADD start-default-emulator.sh /opt

RUN mkdir /opt/android

RUN apt update \
  && apt install openjdk-8-jdk wget unzip -y \
  && chmod a+x /opt/start-default-emulator.sh \
  && wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -qO android-sdk.zip \
  && unzip android-sdk.zip -d /opt/android \
  && rm android-sdk.zip \
  && echo "y" | sdkmanager "tools" \
  && echo "y" | sdkmanager "platform-tools" \
  && echo "y" | sdkmanager "build-tools;28.0.3" \
  && echo "y" | sdkmanager "extras;android;m2repository" \
  && echo "y" | sdkmanager "extras;google;m2repository" \
  && echo "y" | sdkmanager "emulator" \
  && echo "y" | sdkmanager "platforms;android-28" \
  && echo "y" | sdkmanager "system-images;android-28;google_apis;x86" \
  && echo "y" | sdkmanager --update \
  && echo "no" | avdmanager create avd -n default -k "system-images;android-28;google_apis;x86" -d 17 \
  && rm -rf /var/lib/apt/lists/* 
