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

RUN \
	mkdir /src && \
	cd /src && \
	wget -O- https://cdn.foundries.io/aihub-models/models1.tar.gz | tar -xz && \
	git clone https://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss.git && \
	cd gst-plugins-qti-oss && \
	git checkout imsdk.lnx.2.0.0.r1-rel
