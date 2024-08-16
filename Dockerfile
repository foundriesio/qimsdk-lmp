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
		openssh-client \
		openssh-server \
		sshpass \
		strace \
		sudo \
		vim \
		wget && \
	rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

RUN \
	addgroup --gid 1000 fio && \
	adduser --uid 1000 --gid 1000 fio && \
	adduser fio sudo && \
	echo "fio:fio" | chpasswd

#######################################################################
FROM debian:bullseye as apt-updated
RUN apt update

#######################################################################
FROM apt-updated as gst-sample-apps
COPY gst-sample-apps.diff /src/

RUN apt install -y git

RUN \
	cd /src && \
	git clone https://git.codelinaro.org/clo/le/platform/vendor/qcom-opensource/gst-plugins-qti-oss.git && \
	cd gst-plugins-qti-oss && \
	git checkout imsdk.lnx.2.0.0.r1-rel && \
	patch -p1 < /src/gst-sample-apps.diff && \
	chown -R 1000:1000 /src

#######################################################################
FROM apt-updated as ai-hub-models

RUN apt install -y wget

RUN wget -O- https://cdn.foundries.io/aihub-models/models1.tar.gz | tar -xz
RUN chown 1000:1000 models/*

#######################################################################
FROM base
COPY --from=gst-sample-apps /src /src
COPY --from=ai-hub-models /models /src/models

WORKDIR /src/gst-plugins-qti-oss/gst-sample-apps
COPY dev-shell gst-configure-env run-on-host.sh /usr/local/bin/
