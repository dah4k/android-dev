FROM cimg/android:2022.09

ARG SIGNAL_VERSION=6.0.1

WORKDIR /home/circleci
RUN curl -L -O https://github.com/signalapp/Signal-Android/archive/refs/tags/v${SIGNAL_VERSION}.tar.gz \
    && tar -xzf v${SIGNAL_VERSION}.tar.gz --transform "s|Signal-Android-${SIGNAL_VERSION}|project|"

WORKDIR /home/circleci/project
RUN ./gradlew clean assemblePlayProdRelease qa

RUN tar -czf lint-v${SIGNAL_VERSION}.tgz $(find . -name "lint*.html")

WORKDIR /home/circleci
COPY codeql-bundle-linux64.tar.gz .
RUN tar -xzf codeql-bundle-linux64.tar.gz \
    && rm codeql-bundle-linux64.tar.gz

RUN codeql/codeql database create codeql-db --language=java --command="./gradlew clean assemblePlayProdRelease" --no-run-unnecessary-builds --source-root="/home/circleci/project"

RUN codeql/codeql database analyze --format=csv --output="codeql-v${SIGNAL_VERSION}.csv" codeql-db codeql/java-queries
