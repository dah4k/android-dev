FROM cimg/android:2022.09

WORKDIR /home/circleci
RUN git clone https://github.com/signalapp/Signal-Android project \
    && cd project \
    && git checkout v6.0.1

WORKDIR /home/circleci/project
RUN ./gradlew clean assemblePlayProdRelease qa
