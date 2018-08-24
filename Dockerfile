FROM openshift/base-centos7

RUN yum install -y rpmdevtools         \
                   git gcc gcc-c++     \
                   openssl-devel       \
                   libicu-devel        \
                   python-devel        \
                   systemtap-sdt-devel \
                   make

USER root

ENV RPMBUILD_DIR="/opt/app-root/src/rpmbuild"
WORKDIR ${RPMBUILD_DIR}/SPECS/

COPY nodejs.spec run.sh create_node_tarball.sh ${RPMBUILD_DIR}/SPECS/

COPY license_xml.js                                            \
     license_html.js                                           \
     licenses.css                                              \
     parse_target_arch.py                                      \
     nodejs_native.attr ${RPMBUILD_DIR}/SOURCES/

CMD ["./run.sh"]
