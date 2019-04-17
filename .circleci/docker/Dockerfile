ARG BUILD_IMAGE
FROM ${BUILD_IMAGE} as build
WORKDIR /vpp
ARG BOOTSTRAP_CMD
RUN eval "${BOOTSTRAP_CMD}"
ADD [".","/vpp"]
RUN make UNATTENDED=yes install-dep
RUN make UNATTENDED=yes install-ext-deps
RUN make -C build-root PLATFORM=vpp TAG=vpp wipe-all install-packages
RUN make -C build-root PLATFORM=vpp TAG=vpp sample-plugin-install
RUN make -C build-root PLATFORM=vpp TAG=vpp libmemif-install
RUN make -C build-root PLATFORM=vpp TAG=vpp vom-install 
RUN make pkg-${PKG_TYPE}
RUN mkdir -p /vpp/pkg;cp /vpp/build-root/*.deb /vpp/pkg;cp /vpp/build-root/*.buildinfo /vpp/pkg