# Google Ads API version
# This only needs changing for major versions e.g. v6 -> v7
GOOGLE_ADS_VERSION=v6

BUNDLE=googleads-nodejs.tar.gz
PACKAGE_BUILD=/package/googleads-nodejs
PACKAGE_OUT=${PWD}/package/

protos: clean build copy

copy:
	docker create --name gads opteo/google-ads-temp
	docker cp gads:${PACKAGE_BUILD} ${PACKAGE_OUT}
	docker rm gads
	chmod 700 ${PACKAGE_OUT}
	@echo "Bazel compiled protos output at ${PACKAGE_OUT}"

build:
	docker build \
		--no-cache \
		--build-arg GOOGLE_ADS_VERSION=${GOOGLE_ADS_VERSION} \
		-t opteo/google-ads-temp .

clean:
	rm -rf bazel && mkdir bazel

.PHONY: protos clean build copy