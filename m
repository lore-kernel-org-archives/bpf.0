Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0533BCD16
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151348; cv=none; b=dul6+W77RaRuXauLiSWOKpexQp//PqtRrtOZbkQGEAzRA/72IxWEE85awzLVu6THPPlvWdPse1ivV1l2kijQt9nh/u/tDflA+w9A0xfa/SUKwXzALLmF24RqpxiCXNi9ADpb6P6ZIqFOolG3H+qYaG8quM8Oc7LX6rHPj6VQSwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151348; c=relaxed/simple;
	bh=ZKOMyDoJ6g3UwcacRyDOPkw2zOY/wvzrMIe3bKIhxug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg/Gq0EH8LbRHkg8HENxDHZx2QkJUzMwvAt+DAMs2d1PrVGLF59SZyHdGs8imaLRpnNbV8jKgfglVyJKOysRH/hM6RjUSXFCZmnYie9Oj3+1mKLbjLRFuX4xN50o+x3z8MsyQJgts3gTLSd6/HeefglhRB29NyGNq2w9s/21+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ado/EjOg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ado/EjOg"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4758bd3731bso2017330f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 14:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784151345; x=1784756145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d9ZjibRHTP77IoV3000xMUSYR9VstJ4TVfh1m4URAq8=;
        b=Ado/EjOgWZzQuANP9zpARr+/kKxBNOGbgArkCA9cha9oejwFCPz6s325rv5/AUCfwt
         ff7iaoSqQ19w/DzYBHNyHlUbSI/S4GaBQ3ICgzJJOw/e7G46zwzv4bRAR+Rj4fZ/ygqx
         0aXAsp4VElWyin/uNOK4flAIbcvyf6+2eyVzr7NqLmb953KPKf3lHu+FMlwLIDO5bJE7
         Nu/CBGLkRJzN9UMzers2zBtH9yRFW7QHt+twCfcJ9akO6KvuvWcTygtfqB3joldB3LFg
         jEjdlXU9txhNFSwKXEXDWMuJTkK0VvA2kGsXiDFLUG6ks8lKQUhY7nKgx++f76SeeL7o
         2W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784151345; x=1784756145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d9ZjibRHTP77IoV3000xMUSYR9VstJ4TVfh1m4URAq8=;
        b=Ma8bged8BnHLFTkda2laUC16NUeuDLlt3N8dm0c7VtUewt+lOXwFhbq4KUtuNj3PU1
         4tLdLa0qDTn9oNAYPJ6Bt7gbfg+zWcrIBvOXPBdnj61wmbGiDu3um2pqDu+IpMNq6wWk
         CsaDidjXJ07NclkU0CMO+ta8fLqc7UKovhaofMjNDByO/NllQE2YfXVtz4HilPLZBuJ/
         V8XkmU9KBMYgQ2Scb0dDyrio4Dkm9hMYkXeY2mPRT3Urvx0MSvCKWmU9R2M57PjydWSY
         opWhWy63ekbDGNr9kDXOG4AWu7U32zPripToHuVRmxlC1/K3llbdL+ESqQwXACOHGhxq
         eAFw==
X-Gm-Message-State: AOJu0Yyw8y5UXeLtJc5RpOqLqerFH+qGtPOuWJCIbttgBoz67JlTT7Uw
	ZNT3sEBD0FEIYY6DKrW5ShU59z8NDYgFZJHzc/5q8J04Z9GtkXSTonqM
X-Gm-Gg: AfdE7ckGufVOOVclFkD/Low557d3XU1C6nH8BYvQWVRkj3nhgNrOEg2IbXtvirSOJAv
	3WSTos73db99ashziafQqrlRqqVxnNFcIueDMpgefa2q/9vqb+DYi36uhEw5bWFZ/fB7639aevq
	KX7sKpWDa1VRrUF99WZ/JZUY4qcBmMqLo0dg5yovp0TTcGwYqe28+wd9OigYXHJvCFOOhzikV0i
	K3HhIxrIUfRcaOy7PpyIyvj58KA538n4MYJ3hfwXpvGB42JPf/iMa4k2kJTURQ9+jPuVL5RTf5z
	FG24cLlPP8PiK5tO8/a69hY/BYYMW72DI7WBJqi8SzvNUcIOmHFTZr7Y0eN1jchbp24nPnCfW35
	PhZ51nqeHy/S51ErIEORu8frzVOoDcUHhcmOHRS6ECMu0NhFMuf2bkfZkFH7mdP3mWPkNjbuEPo
	ryQN/jXweFsfMPMpeXpR7bqKsiyj8EVK0Ewt6cNaHovKay7Dym2vpOmW8J52D4E1qcAA==
X-Received: by 2002:a05:6000:1ac8:b0:47d:f6a5:1fd6 with SMTP id ffacd0b85a97d-47f55f06503mr1044251f8f.26.1784151344632;
        Wed, 15 Jul 2026 14:35:44 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635c86csm19224122f8f.16.2026.07.15.14.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:35:44 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: jiayuan.chen@linux.dev
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	nnamdio@gmail.com,
	pabeni@redhat.com,
	sashiko-reviews@lists.linux.dev
Subject: [PATCH v4 2/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Wed, 15 Jul 2026 22:35:38 +0100
Message-ID: <20260715213538.37229-3-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715213538.37229-1-nnamdio@gmail.com>
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
 <20260715213538.37229-1-nnamdio@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This selftest exercises the tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser()
functions, to ensure that they are properly handling spurious wakeups in
tcp_msg_wait_data().

The expected behaviour is that:

  * Without a timeout - recvfrom() does not return an EAGAIN error.

  * With a timeout - recvfrom() returns EAGAIN, but only after the
    SO_RCVTIMEO timeout has expired.

If the spurious wakeups are not correctly handled, the above assertions
fail.

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
 tools/testing/selftests/net/.gitignore        |   2 +
 tools/testing/selftests/net/Makefile          |   5 +
 .../selftests/net/sockmap_recvfrom.bpf.c      |  31 ++
 .../testing/selftests/net/sockmap_recvfrom.c  | 299 ++++++++++++++++++
 4 files changed, 337 insertions(+)
 create mode 100644 tools/testing/selftests/net/sockmap_recvfrom.bpf.c
 create mode 100644 tools/testing/selftests/net/sockmap_recvfrom.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index c9f46031ac73..a1840a5d45f6 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -39,6 +39,8 @@ sk_connect_zero_addr
 sk_so_peek_off
 skf_net_off
 socket
+sockmap_recvfrom
+sockmap_recvfrom.bpf.o
 so_incoming_cpu
 so_netns_cookie
 so_rcv_listener
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 708d960ae07d..dd04b80725c6 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -191,6 +191,7 @@ TEST_GEN_PROGS := \
 	sk_connect_zero_addr \
 	sk_so_peek_off \
 	so_incoming_cpu \
+	sockmap_recvfrom \
 	tap \
 	tcp_port_share \
 	tls \
@@ -238,3 +239,7 @@ $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
 $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
 
 include bpf.mk
+
+$(OUTPUT)/sockmap_recvfrom: $(BPFOBJ)
+$(OUTPUT)/sockmap_recvfrom: LDLIBS += $(BPFOBJ) -lelf -lz -lpthread
+$(OUTPUT)/sockmap_recvfrom: CFLAGS += -I$(OUTPUT)/tools/include
diff --git a/tools/testing/selftests/net/sockmap_recvfrom.bpf.c b/tools/testing/selftests/net/sockmap_recvfrom.bpf.c
new file mode 100644
index 000000000000..fec470c738f1
--- /dev/null
+++ b/tools/testing/selftests/net/sockmap_recvfrom.bpf.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#define AF_INET 2
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 1024);
+	__type(key, __u64);
+	__type(value, __u64);
+
+} map_socks SEC(".maps");
+
+SEC("sockops") int on_sockops(struct bpf_sock_ops *ctx)
+{
+	if (ctx->family == AF_INET && ctx->op == BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB) {
+		__u64 cookie = bpf_get_socket_cookie(ctx);
+
+		bpf_sock_hash_update(ctx, &map_socks, &cookie, BPF_NOEXIST);
+	}
+
+	return 0;
+}
+
+SEC("sk_skb/stream_verdict") int on_recv(struct __sk_buff *ctx)
+{
+	return SK_PASS;
+}
diff --git a/tools/testing/selftests/net/sockmap_recvfrom.c b/tools/testing/selftests/net/sockmap_recvfrom.c
new file mode 100644
index 000000000000..25657fc3dbcd
--- /dev/null
+++ b/tools/testing/selftests/net/sockmap_recvfrom.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <arpa/inet.h>
+#include <bpf/libbpf.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <stdatomic.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <unistd.h>
+
+#include "kselftest_harness.h"
+
+#define MAX_ITERATIONS 100
+#define PAYLOAD_END 'e'
+
+static int start_listening(struct __test_metadata *_metadata, uint16_t *port)
+{
+	struct sockaddr_in addr;
+	socklen_t addrlen;
+	int fd;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sin_family = AF_INET;
+	addr.sin_addr.s_addr = INADDR_ANY;
+
+	fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+
+	ASSERT_NE(fd, -1);
+	ASSERT_EQ(bind(fd, (struct sockaddr *)&addr, sizeof(addr)), 0);
+	ASSERT_EQ(listen(fd, 5), 0);
+
+	addrlen = sizeof(addr);
+
+	ASSERT_EQ(getsockname(fd, (struct sockaddr *)&addr, &addrlen), 0);
+
+	*port = addr.sin_port;
+
+	return fd;
+}
+
+static void process_client(int fd, atomic_int *running, bool *failed)
+{
+	char buf[1024];
+	struct timeval timeo;
+
+	timeo.tv_sec = 0;
+	timeo.tv_usec = 1000;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo)))
+		*failed = true;
+
+	while (atomic_load(running)) {
+		ssize_t len = recvfrom(fd, buf, sizeof(buf), 0, NULL, NULL);
+
+		if (len == -1) {
+			if (errno != EAGAIN && errno != EINTR)
+				*failed = true;
+			continue;
+		}
+
+		if (len <= 0 || buf[len - 1] == PAYLOAD_END)
+			break;
+	}
+
+	send(fd, "test", 4, MSG_NOSIGNAL);
+
+	close(fd);
+}
+
+struct bpf_t {
+	struct bpf_object *obj;
+	struct bpf_link *on_sockops;
+	struct bpf_link *on_recv;
+};
+
+static void setup_bpf(struct __test_metadata *_metadata, const char *path, bool recv,
+						struct bpf_t *bpf)
+{
+	struct bpf_program *prog;
+	int cgroup;
+
+	memset(bpf, 0, sizeof(*bpf));
+	bpf->obj = bpf_object__open_file(path, NULL);
+
+	ASSERT_NE(bpf->obj, NULL);
+	ASSERT_EQ(bpf_object__load(bpf->obj), 0);
+
+	prog = bpf_object__find_program_by_name(bpf->obj, "on_sockops");
+	ASSERT_NE(prog, NULL);
+
+	cgroup = open("/sys/fs/cgroup", O_RDONLY);
+	ASSERT_NE(cgroup, -1);
+
+	bpf->on_sockops = bpf_program__attach_cgroup(prog, cgroup);
+	close(cgroup);
+
+	ASSERT_NE(bpf->on_sockops, NULL);
+
+	if (recv) {
+		struct bpf_map *map = bpf_object__find_map_by_name(bpf->obj, "map_socks");
+
+		ASSERT_NE(map, NULL);
+
+		prog = bpf_object__find_program_by_name(bpf->obj, "on_recv");
+		ASSERT_NE(prog, NULL);
+
+		bpf->on_recv = bpf_program__attach_sockmap(prog, bpf_map__fd(map));
+		ASSERT_NE(bpf->on_recv, NULL);
+	}
+}
+
+struct server_t {
+	int fd;
+	atomic_int running;
+	pthread_t thread;
+	bool thread_created;
+};
+
+static void *run_server(void *arg)
+{
+	struct server_t *server = arg;
+	bool failed = false;
+
+	while (atomic_load(&server->running)) {
+		int client_fd = accept(server->fd, NULL, NULL);
+
+		if (client_fd == -1) {
+			if (!atomic_load(&server->running))
+				break;
+
+			continue;
+		}
+
+		process_client(client_fd, &server->running, &failed);
+	}
+
+	if (failed)
+		return (void *)1;
+
+	return NULL;
+}
+
+static int send_payload(struct __test_metadata *_metadata, int fd, const char *buf, size_t len)
+{
+	size_t remaining = len;
+
+	do {
+		ssize_t bytes = write(fd, buf + (len - remaining), remaining);
+
+		if (bytes < 0) {
+			if (errno == EINTR)
+				continue;
+
+			return -1;
+		}
+
+		remaining -= bytes;
+	} while (remaining);
+
+	return 0;
+}
+
+FIXTURE(sockmap_recvfrom)
+{
+	struct server_t server;
+	struct sockaddr_in addr;
+	struct bpf_t bpf;
+	char *payload;
+	size_t payload_len;
+};
+
+FIXTURE_VARIANT(sockmap_recvfrom)
+{
+	bool with_recv;
+};
+
+FIXTURE_VARIANT_ADD(sockmap_recvfrom, recvmsg)
+{
+	.with_recv = false
+};
+
+FIXTURE_VARIANT_ADD(sockmap_recvfrom, recvmsg_parser)
+{
+	.with_recv = true
+};
+
+FIXTURE_SETUP(sockmap_recvfrom)
+{
+	memset(&self->server, 0, sizeof(self->server));
+	self->server.fd = -1;
+
+	memset(&self->addr, 0, sizeof(self->addr));
+
+	self->payload_len = 1024 * 1024 * 25;
+	self->payload = malloc(self->payload_len);
+	ASSERT_NE(self->payload, NULL);
+
+	memset(self->payload, 0, self->payload_len);
+	self->payload[self->payload_len - 1] = PAYLOAD_END;
+
+	setup_bpf(_metadata, "sockmap_recvfrom.bpf.o", variant->with_recv, &self->bpf);
+	atomic_store(&self->server.running, 1);
+	self->server.fd = start_listening(_metadata, &self->addr.sin_port);
+
+	self->addr.sin_family = AF_INET;
+	self->addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+
+	ASSERT_EQ(pthread_create(&self->server.thread, NULL, &run_server, &self->server), 0);
+	self->server.thread_created = true;
+}
+
+FIXTURE_TEARDOWN(sockmap_recvfrom)
+{
+	atomic_store(&self->server.running, 0);
+
+	if (self->server.fd != -1)
+		shutdown(self->server.fd, SHUT_RD);
+
+	if (self->server.thread_created) {
+		void *retval = NULL;
+
+		pthread_join(self->server.thread, &retval);
+		EXPECT_EQ(retval, NULL);
+	}
+
+	if (self->server.fd != -1)
+		close(self->server.fd);
+
+	free(self->payload);
+	bpf_link__destroy(self->bpf.on_sockops);
+
+	if (self->bpf.on_recv)
+		bpf_link__destroy(self->bpf.on_recv);
+
+	bpf_object__close(self->bpf.obj);
+}
+
+TEST_F(sockmap_recvfrom, no_timeout)
+{
+	char ignored[128];
+
+	for (int i = 0; i < MAX_ITERATIONS; ++i) {
+		int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+
+		ASSERT_NE(fd, -1);
+		ASSERT_EQ(connect(fd, (struct sockaddr *)&self->addr, sizeof(self->addr)), 0);
+
+		ASSERT_EQ(send_payload(_metadata, fd, self->payload, self->payload_len), 0);
+
+		if (recvfrom(fd, ignored, sizeof(ignored), 0, NULL, NULL) < 0)
+			ASSERT_NE(errno, EAGAIN);
+
+		close(fd);
+	}
+}
+
+static int64_t to_nanos(struct timespec *time)
+{
+	return (time->tv_sec * 1000000000LL) + time->tv_nsec;
+}
+
+TEST_F(sockmap_recvfrom, with_timeout)
+{
+	char ignored[128];
+	struct timeval timeo;
+
+	timeo.tv_sec = 0;
+	timeo.tv_usec = 5000;
+
+	/* remove the payload end delimiter so the server never responds and recvfrom times out. */
+	self->payload[self->payload_len - 1] = 0;
+
+	for (int i = 0; i < MAX_ITERATIONS; ++i) {
+		struct timespec beg;
+		struct timespec end;
+		int err;
+
+		int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+
+		ASSERT_NE(fd, -1);
+		ASSERT_EQ(connect(fd, (struct sockaddr *)&self->addr, sizeof(self->addr)), 0);
+
+		ASSERT_EQ(send_payload(_metadata, fd, self->payload, self->payload_len), 0);
+
+		ASSERT_EQ(setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo)), 0);
+
+		clock_gettime(CLOCK_MONOTONIC, &beg);
+		ASSERT_EQ(recvfrom(fd, ignored, sizeof(ignored), 0, NULL, NULL), -1);
+		err = errno;
+		clock_gettime(CLOCK_MONOTONIC, &end);
+
+		ASSERT_EQ(err, EAGAIN);
+		ASSERT_GE(to_nanos(&end) - to_nanos(&beg), timeo.tv_usec * 1000);
+
+		close(fd);
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.52.0

