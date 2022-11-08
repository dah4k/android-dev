COMMANDLINETOOLS_ZIP := commandlinetools-linux-7583922_latest.zip
M2REPOSITORY_ZIP := android_m2repository_r47.zip
GRADLE_ZIP := gradle-7.5.1-all.zip
CODEQL_TGZ := codeql-bundle-linux64.tar.gz

SIGNAL_VERSIONS := 5.43.7 6.0.1

all: $(CODEQL_TGZ) $(SIGNAL_VERSIONS)

$(SIGNAL_VERSIONS):
	docker build . \
		--build-arg SIGNAL_VERSION=$@ \
		--tag local/android-dev:signal-v$@ \
		--file Dockerfile

$(COMMANDLINETOOLS_ZIP) $(M2REPOSITORY_ZIP):
	curl -L -O -C - https://dl.google.android/repository/$@

$(GRADLE_ZIP):
	curl -L -O -C - https://services.gradle.org/distributions/$@

$(CODEQL_TGZ):
	curl -L -O -C - https://github.com/github/codeql-action/releases/download/codeql-bundle-20221024/$@

clean:
	docker image prune --force

distclean:
	docker system prune --force

.PHONY: $(SIGNAL_VERSIONS)
.PHONY: all clean distclean
