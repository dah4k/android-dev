COMMANDLINETOOLS_ZIP := commandlinetools-linux-7583922_latest.zip
M2REPOSITORY_ZIP := android_m2repository_r47.zip
GRADLE_ZIP := gradle-7.5.1-all.zip


all:
	docker build . --tag local/android-dev

$(COMMANDLINETOOLS_ZIP) $(M2REPOSITORY_ZIP):
	curl -L -O https://dl.google.android/repository/$@

$(GRADLE_ZIP):
	curl -L -O https://services.gradle.org/distributions/$@

clean:
	docker image prune --force

distclean:
	docker system prune --force

.PHONY: all clean distclean
