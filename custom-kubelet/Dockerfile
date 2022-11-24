FROM quay.io/fedora/fedora:37 as builder
ARG KUBERNETES_REPO https://github.com/vrutkovs/kubernetes
ARG KUBERNETES_REPO_COMMIT 872e5269135
RUN dnf install -y git-core make gcc golang rsync \
    && dnf clean all
WORKDIR /go/src/k8s.io/kubernetes
RUN git init \
    && git remote add origin ${KUBERNETES_REPO} \
    && git fetch origin \
    && git reset ${KUBERNETES_REPO_COMMIT} --hard
RUN make WHAT='cmd/kubelet'

FROM docker.io/kindest/node:v1.25.3
COPY --from=builder /go/src/k8s.io/kubernetes/_output/local/bin/linux/amd64/kubelet /usr/bin/kubelet
