FROM cimg/android:2022.09

ARG SIGNAL_VERSION=6.0.1

WORKDIR /home/circleci
RUN curl -L -O https://github.com/signalapp/Signal-Android/archive/refs/tags/v${SIGNAL_VERSION}.tar.gz \
    && tar -xzf v${SIGNAL_VERSION}.tar.gz --transform "s|Signal-Android-${SIGNAL_VERSION}|project|"

WORKDIR /home/circleci/project
RUN ./gradlew clean assemblePlayProdRelease qa
