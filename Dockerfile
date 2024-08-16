FROM debian:bullseye as base

RUN \
	apt update && \
	apt install -y \
		build-essential \
		cmake \
		gdb \
		git \
		gstreamer1.0-tools \
		libglib2.0-dev \
		libgstreamer1.0-dev \
		libgstreamer-plugins-base1.0-dev \
		strace \
		vim \
		wget && \
	rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

COPY gst-sample-apps.diff /src/
RUN \
	cd /src && \
	wget -O- https://cdn.foundries.io/aihub-models/models1.tar.gz | tar -xz && \
	git clone https://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss.git && \
	cd gst-plugins-qti-oss && \
	git checkout imsdk.lnx.2.0.0.r1-rel && \
	patch -p1 < /src/gst-sample-apps.diff

WORKDIR /src/gst-plugins-qti-oss/gst-sample-apps
COPY dev-shell gst-configure-env /usr/local/bin
