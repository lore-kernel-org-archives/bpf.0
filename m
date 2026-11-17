Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934093;
	b=HeiJIiDwdQRxQmtaS/51s0pZoVv5klVOxaRK1scQcoWEH3LvOU1IX0dtHL3L2G/Tm/70
	 idwwfE9XFF0DwY7fuj349MXh1DC7SY7zJCCZOgjX6+8LnZE8sm8idKUWCSFySlr2plbyX
	 YDsMkMN72VSg5Vk1+UcFJsnj90hfrKzOzxBhvFENFGFn4//3FqdHMEXjOkX+dBrWPJFf6
	 Rea2ET6Bzl7m9G3XYuQXTxqslfVJgPDGvI006juNMFg9Ja21P8iWuoXgIcR93tbWvjdfI
	 g8HYB8fGj4nPWCVTr5JiVfw7fhea7FFytU2eAQ7tqtA/iU2MRXuCkaBz7LKekAWfEYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934093;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pO8LGfui6hWcFh5oGwyEpBVOvHaOj/DZuFuUFk+k6Rk=;
	b=lseA2d0QK/+ZG3A9umODFZSqDTtN00ZdwQEe/OJtkzVqX7QYsSdiU/xQZfmgT+6T6XI2
	 ddQ96i4xwM5ukCcjcE9lHvq+HyPavrG5NujbC8601M3KsfgM3WzVoTYLTg1j1SgkvwGGA
	 qNfhn/Qb7LYE5OyVzMDSuC1PyB72gDEwNG+5h+AP2JHoMmiDs0blOLOaJc/OBII3NAsEu
	 gB1mCzJKUNycE1YirAjIZHv8lvTa2GSAjzexVf3JTU5xTzSfI+PJZ4kHmxkaLwkeKdXbk
	 2z+4PIEHZoU6owd+rlpmMIEBoH8Lrq0TW4A+GIeTZea2LiXgDVZrsyyoBacg2dENgkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n/Arpwg4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D00606A31C;
	Tue, 17 Nov 2026 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n/Arpwg4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9831F000C8;
	Tue, 17 Nov 2026 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794934093;
	bh=pO8LGfui6hWcFh5oGwyEpBVOvHaOj/DZuFuUFk+k6Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n/Arpwg4ZGjXZ7x/ILlujGerOzN381ylFnGsOoW/XaBeZctwjCzuQqZlMNGygAZeZ
	 pCVkSzWP9ELDtJmLhU+j5wEhYLX/ttgSZU+Fz38YaZJgNUUiDyTo9HPFd6b0dnKMQl
	 2zC83uZepZ7Z1GHn+eGS28/32xFh62wnhhuEG/SVFCpAiISyWnrPgMrz43udTgcXPv
	 MF+J4JGLiZCdcm6+2h/Mas4QLzcQGrVzQ7BF/0NJ3ChI3Jl9HIfzTWTdhXTSx2QP2W
	 fBVvtl8+RxVT2dYfIMvo1OxofceipWVtGU7PIppdAQpVkFJiHt3GLjg++QwkhQBayD
	 ZPQfdzVqvvZzA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	kernel-team@meta.com,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Weiming Shi <bestswngs@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Wei <dw@davidwei.uk>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 7/7] selftests: net: Test XDP on io_uring RX
Date: Tue, 17 Nov 2026 17:46:58 +0100
Message-ID: <20261117164700.2157816-8-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117164700.2157816-1-bjorn@kernel.org>
References: <20261117164700.2157816-1-bjorn@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Native XDP must not access io_uring payload through normal packet
helpers. Compare ordinary page-backed RX with an io_uring RX queue.
Check header, fragment and boundary access, and verify the received
bytes through recv() and RECV_ZC.

Probe support by binding io_uring first and attaching a frags-aware
XDP_PASS program. Skip unsupported combinations, but fail later
attach, verifier and data-path checks. Require non-linear packets on
the selected queue. Use XDP links so the test cannot replace another
program, and restore header split, RSS and the flow rule.

An AI review found that ignoring io_uring setup errors could turn them
into capability skips. A process-local seccomp filter returning EPERM
reproduced this. The new XDP test now treats setup errors as failures.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 MAINTAINERS                                   |   2 +
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |  10 +-
 tools/testing/selftests/drivers/net/hw/config |   5 +
 .../selftests/drivers/net/hw/iou-zcrx.c       | 242 +++++++++++++++++-
 .../selftests/drivers/net/hw/iou-zcrx.py      | 108 +++++++-
 .../selftests/drivers/net/hw/iou_zcrx.bpf.c   | 111 ++++++++
 .../selftests/drivers/net/hw/iou_zcrx.h       |  34 +++
 8 files changed, 492 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/iou_zcrx.bpf.c
 create mode 100644 tools/testing/selftests/drivers/net/hw/iou_zcrx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 32e218c0fe68..ea383dd81668 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14076,6 +14076,8 @@ T:	git https://github.com/isilence/linux.git zcrx/for-next
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
 S:	Maintained
 F:	io_uring/zcrx.*
+F:	tools/testing/selftests/drivers/net/hw/iou-zcrx.*
+F:	tools/testing/selftests/drivers/net/hw/iou_zcrx.*
 
 IO_URING BPF-OPS
 M:	Pavel Begunkov <asml.silence@gmail.com>
diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
index 911a9bfeaf41..085aa8b17afc 100644
--- a/tools/testing/selftests/drivers/net/hw/.gitignore
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iou-zcrx
+iou_zcrx.skel.h
 ncdevmem
 tls_hw_offload
 toeplitz
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 429cb545a4f0..d7a1fea08ea7 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -10,7 +10,8 @@ HAS_IOURING_ZCRX := $(shell \
 	echo -e '#include <liburing.h>\n' \
 	     'void *func = (void *)io_uring_register_ifq;\n' \
 	     'int main() {return 0;}' | \
-	$(CC) -luring -x c - -o /dev/null 2>&1 && echo y)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(USERCFLAGS) $(LDFLAGS) \
+	$(USERLDFLAGS) -x c - -o /dev/null -luring 2>&1 && echo y)
 
 ifeq ($(HAS_IOURING_ZCRX),y)
 COND_GEN_FILES += iou-zcrx
@@ -98,5 +99,10 @@ include ../../../net/ynl.mk
 include ../../../net/bpf.mk
 
 ifeq ($(HAS_IOURING_ZCRX),y)
-$(OUTPUT)/iou-zcrx: LDLIBS += -luring -lpthread
+$(OUTPUT)/iou-zcrx: CFLAGS += -I$(OUTPUT) -I$(SCRATCH_DIR)/include
+$(OUTPUT)/iou-zcrx: LDLIBS += -luring -lpthread -lelf -lz
+$(OUTPUT)/iou-zcrx: LOCAL_HDRS += iou_zcrx.h $(OUTPUT)/iou_zcrx.skel.h
+$(OUTPUT)/iou-zcrx: iou_zcrx.h $(OUTPUT)/iou_zcrx.skel.h $(BPFOBJ)
 endif
+
+$(OUTPUT)/iou_zcrx.bpf.o: iou_zcrx.h $(selfdir)/bpf/bpf_kfuncs.h
diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index 081155bf7847..ef77543b567f 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -1,4 +1,6 @@
+CONFIG_BPF_JIT=y
 CONFIG_BPF_SYSCALL=y
+CONFIG_DEBUG_INFO_BTF=y
 CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
@@ -9,6 +11,7 @@ CONFIG_INET6_ESP_OFFLOAD=y
 CONFIG_INET_ESP=y
 CONFIG_INET_ESP_OFFLOAD=y
 CONFIG_IO_URING=y
+CONFIG_IO_URING_ZCRX=y
 CONFIG_IPV6=y
 CONFIG_IPV6_GRE=y
 CONFIG_IPV6_SIT=y
@@ -20,7 +23,9 @@ CONFIG_NET_IPGRE=y
 CONFIG_NET_IPGRE_DEMUX=y
 CONFIG_NET_IPIP=y
 CONFIG_NETKIT=y
+CONFIG_NET_RX_BUSY_POLL=y
 CONFIG_NET_SCH_INGRESS=y
+CONFIG_PAGE_POOL=y
 CONFIG_SYNC_FILE=y
 CONFIG_TLS=y
 CONFIG_TLS_DEVICE=y
diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 91b025a8771e..f7e909fd6840 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -16,6 +16,7 @@
 #include <linux/mman.h>
 #include <linux/errqueue.h>
 #include <linux/if_packet.h>
+#include <linux/if_link.h>
 #include <linux/ipv6.h>
 #include <linux/socket.h>
 #include <linux/sockios.h>
@@ -37,9 +38,13 @@
 #include <sys/un.h>
 #include <sys/wait.h>
 
+#include <bpf/bpf.h>
 #include <liburing.h>
 #include <ynl.h>
+#include "kselftest.h"
 #include "netdev-user.h"
+#include "iou_zcrx.h"
+#include "iou_zcrx.skel.h"
 
 #define SKIP_CODE	42
 
@@ -89,7 +94,11 @@ static struct sockaddr_in6 cfg_addr;
 static unsigned int cfg_rx_buf_len;
 static bool cfg_dry_run;
 static int cfg_num_threads = 1;
+static bool cfg_xdp;
+static bool cfg_pages;
 
+static struct iou_zcrx *xdp_skel;
+static int xdp_link = -1;
 static char *payload;
 
 #define MAX_CONNS_PER_THREAD	64
@@ -154,6 +163,139 @@ static inline size_t get_refill_ring_size(unsigned int rq_entries)
 	return ALIGN_UP(size, page_size);
 }
 
+static int probe_xdp(void)
+{
+	const struct bpf_insn insns[] = {
+		{
+			.code = BPF_ALU64 | BPF_MOV | BPF_K,
+			.dst_reg = BPF_REG_0,
+			.imm = XDP_PASS,
+		},
+		{ .code = BPF_JMP | BPF_EXIT },
+	};
+	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
+		    .prog_flags = BPF_F_XDP_HAS_FRAGS);
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts,
+		    .flags = XDP_FLAGS_DRV_MODE);
+	unsigned int ifindex;
+	int prog_fd, link_fd;
+
+	ifindex = if_nametoindex(cfg_ifname);
+	if (!ifindex) {
+		error(0, errno, "if_nametoindex()");
+		return EXIT_FAILURE;
+	}
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, "zcrx_probe", "GPL",
+				insns, ARRAY_SIZE(insns), &load_opts);
+	if (prog_fd < 0) {
+		error(0, -prog_fd, "load XDP probe");
+		return EXIT_FAILURE;
+	}
+
+	/* The io_uring queue is already registered; never replace a program. */
+	link_fd = bpf_link_create(prog_fd, ifindex, BPF_XDP, &link_opts);
+	close(prog_fd);
+	if (link_fd >= 0) {
+		close(link_fd);
+		return 0;
+	}
+	if (link_fd == -EBUSY || link_fd == -EOPNOTSUPP) {
+		printf("Native XDP with ZCRX is not supported: %s\n",
+		       strerror(-link_fd));
+		return SKIP_CODE;
+	}
+	error(0, -link_fd, "attach XDP probe");
+	return EXIT_FAILURE;
+}
+
+static void setup_xdp(void)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, opts,
+		    .flags = XDP_FLAGS_DRV_MODE);
+	unsigned int ifindex;
+	int prog_fd;
+
+	ifindex = if_nametoindex(cfg_ifname);
+	if (!ifindex)
+		error(1, errno, "if_nametoindex()");
+	xdp_skel = iou_zcrx__open();
+	if (!xdp_skel)
+		error(1, errno, "iou_zcrx__open()");
+	xdp_skel->bss->port = cfg_port;
+	xdp_skel->bss->queue_id = cfg_queue_id;
+	xdp_skel->bss->unreadable = !cfg_pages;
+	if (iou_zcrx__load(xdp_skel))
+		error(1, errno, "iou_zcrx__load()");
+
+	/* A link cannot replace another program and closes with the process. */
+	prog_fd = bpf_program__fd(xdp_skel->progs.iou_zcrx);
+	xdp_link = bpf_link_create(prog_fd, ifindex, BPF_XDP, &opts);
+	if (xdp_link < 0)
+		error(1, errno, "attach native XDP");
+}
+
+static void check_xdp(void)
+{
+	static const char * const locations[] = {
+		"header", "fragment", "boundary",
+	};
+	static const char * const ops[] = {
+		"load", "store", "dynptr read", "dynptr write",
+		"slice", "slice rdwr",
+	};
+	struct xdp_zcrx_stats sum = {}, *all, *s;
+	int ncpus, cpu, loc, op;
+	__u32 key = 0;
+	bool failed;
+
+	close(xdp_link);
+	xdp_link = -1;
+	ncpus = libbpf_num_possible_cpus();
+	if (ncpus < 0)
+		error(1, 0, "libbpf_num_possible_cpus(): %d", ncpus);
+	all = calloc(ncpus, sizeof(*all));
+	if (!all)
+		error(1, errno, "calloc XDP statistics");
+	if (bpf_map_lookup_elem(bpf_map__fd(xdp_skel->maps.stats), &key, all))
+		error(1, errno, "read XDP statistics");
+
+	for (cpu = 0; cpu < ncpus; cpu++) {
+		s = &all[cpu];
+		sum.packets += s->packets;
+		sum.tested += s->tested;
+		sum.wrong_queue += s->wrong_queue;
+		sum.bad_headers += s->bad_headers;
+		sum.linear_bytes += s->linear_bytes;
+		sum.frag_bytes += s->frag_bytes;
+		for (loc = 0; loc < XDP_ZCRX_LOCATIONS; loc++) {
+			for (op = 0; op < XDP_ZCRX_OPS; op++)
+				sum.errors[loc][op] += s->errors[loc][op];
+		}
+	}
+	free(all);
+
+	printf("XDP %s: queue=%d packets=%llu tested=%llu\n",
+	       cfg_pages ? "pages" : "io_uring", cfg_queue_id,
+	       sum.packets, sum.tested);
+	printf("XDP geometry: linear=%llu frags=%llu\n",
+	       sum.linear_bytes, sum.frag_bytes);
+	printf("XDP errors: wrong_queue=%llu bad_headers=%llu\n",
+	       sum.wrong_queue, sum.bad_headers);
+	failed = !sum.tested || sum.wrong_queue || sum.bad_headers;
+	for (loc = 0; loc < XDP_ZCRX_LOCATIONS; loc++) {
+		for (op = 0; op < XDP_ZCRX_OPS; op++) {
+			if (!sum.errors[loc][op])
+				continue;
+			fprintf(stderr, "%s %s: %llu failures\n",
+				locations[loc], ops[op], sum.errors[loc][op]);
+			failed = true;
+		}
+	}
+	iou_zcrx__destroy(xdp_skel);
+	if (failed)
+		error(1, 0, "XDP access checks failed");
+}
+
 static void setup_zcrx(struct thread_ctx *ctx)
 {
 	unsigned int rq_entries = AREA_SIZE / page_size;
@@ -217,6 +359,10 @@ static void setup_zcrx(struct thread_ctx *ctx)
 	};
 
 	ret = io_uring_register_ifq(&ctx->ring, (void *)&reg);
+	if (cfg_xdp && cfg_dry_run && ret == -EOPNOTSUPP) {
+		puts("Interface-bound ZCRX is not supported");
+		exit(SKIP_CODE);
+	}
 	if (cfg_rx_buf_len && (ret == -EINVAL || ret == -EOPNOTSUPP ||
 			       ret == -ERANGE)) {
 		printf("Large chunks are not supported %i\n", ret);
@@ -258,6 +404,34 @@ static void add_recvzc_oneshot(struct thread_ctx *ctx, int conn_idx, size_t len)
 	sqe->user_data = conn_idx;
 }
 
+static void verify_data(struct thread_ctx *ctx, int conn_idx,
+			const char *data, size_t len)
+{
+	size_t offset = ctx->received[conn_idx];
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (data[i] != payload[offset + i])
+			error(1, 0, "payload mismatch at %zu", i);
+	}
+	ctx->received[conn_idx] += len;
+}
+
+static void recv_pages(struct thread_ctx *ctx)
+{
+	char buf[8192];
+	ssize_t ret;
+
+	while ((ret = recv(ctx->connfds[0], buf, sizeof(buf), 0)) > 0) {
+		if ((size_t)ret > (size_t)cfg_send_size - ctx->received[0])
+			error(1, 0, "received too much data");
+		verify_data(ctx, 0, buf, ret);
+	}
+	if (ret < 0)
+		error(1, errno, "recv()");
+	ctx->nr_conns--;
+}
+
 static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe,
 			   int conn_idx)
 {
@@ -267,7 +441,6 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe,
 	uint64_t mask;
 	char *data;
 	ssize_t n;
-	int i;
 
 	if (cqe->res == 0 && cqe->flags == 0 &&
 	    ctx->oneshot_recvs[conn_idx] == 0) {
@@ -295,11 +468,7 @@ static void process_recvzc(struct thread_ctx *ctx, struct io_uring_cqe *cqe,
 	mask = (1ULL << IORING_ZCRX_AREA_SHIFT) - 1;
 	data = (char *)ctx->area_ptr + (rcqe->off & mask);
 
-	for (i = 0; i < n; i++) {
-		if (*(data + i) != payload[(ctx->received[conn_idx] + i)])
-			error(1, 0, "payload mismatch at %d", i);
-	}
-	ctx->received[conn_idx] += n;
+	verify_data(ctx, conn_idx, data, n);
 
 	rqe = &ctx->rq_ring.rqes[(ctx->rq_ring.rq_tail & rq_mask)];
 	rqe->off = (rcqe->off & ~IORING_ZCRX_AREA_MASK) | ctx->area_token;
@@ -328,7 +497,10 @@ static void *server_worker(void *arg)
 	struct thread_ctx *ctx = arg;
 	uint64_t tstop;
 	int nr_conns;
-	int i;
+	int ret, i;
+
+	if (cfg_pages)
+		goto ready;
 
 	params.flags |= IORING_SETUP_COOP_TASKRUN;
 	params.flags |= IORING_SETUP_SINGLE_ISSUER;
@@ -338,16 +510,23 @@ static void *server_worker(void *arg)
 	params.flags |= IORING_SETUP_CQSIZE;
 	params.cq_entries = AREA_SIZE / page_size;
 
-	io_uring_queue_init_params(512, &ctx->ring, &params);
+	ret = io_uring_queue_init_params(512, &ctx->ring, &params);
+	if (cfg_xdp && ret)
+		error(1, 0, "io_uring_queue_init_params(): %d", ret);
 	setup_zcrx(ctx);
 
 	if (cfg_dry_run)
 		return NULL;
 
+ready:
 	pthread_barrier_wait(ctx->setup_done);
 	pthread_barrier_wait(ctx->dispatch_done);
 
 	nr_conns = ctx->nr_conns;
+	if (cfg_pages) {
+		recv_pages(ctx);
+		goto check_received;
+	}
 
 	for (i = 0; i < ctx->nr_conns; i++) {
 		if (cfg_oneshot) {
@@ -366,6 +545,7 @@ static void *server_worker(void *arg)
 		error(1, 0, "test failed: %d connections incomplete",
 		      ctx->nr_conns);
 
+check_received:
 	for (i = 0; i < nr_conns; i++) {
 		if (cfg_oneshot) {
 			if (!ctx->received[i])
@@ -374,8 +554,11 @@ static void *server_worker(void *arg)
 			error(1, 0, "connection %d received %zu of %d bytes",
 			      i, ctx->received[i], cfg_send_size);
 		}
+		close(ctx->connfds[i]);
 	}
-
+	if (cfg_xdp)
+		printf("Verified %zu bytes through %s\n", ctx->received[0],
+		       cfg_pages ? "recv" : "RECV_ZC");
 	return NULL;
 }
 
@@ -434,11 +617,14 @@ static void run_server(void)
 {
 	pthread_barrier_t setup_done, dispatch_done;
 	int total_conns, accepted = 0, connfd;
+	int fd, ret, enable, i, result = 0;
 	struct thread_ctx *ctxs;
-	int fd, ret, enable, i;
 	unsigned int ifindex;
 	pthread_t *threads;
 
+	if (cfg_xdp && !cfg_dry_run)
+		setup_xdp();
+
 	ctxs = calloc(cfg_num_threads, sizeof(*ctxs));
 	threads = calloc(cfg_num_threads, sizeof(*threads));
 	if (!ctxs || !threads)
@@ -514,11 +700,26 @@ static void run_server(void)
 	for (i = 0; i < cfg_num_threads; i++)
 		pthread_join(threads[i], NULL);
 
+	if (cfg_xdp) {
+		if (cfg_dry_run)
+			result = probe_xdp();
+		else
+			check_xdp();
+	}
+	if (!cfg_pages) {
+		for (i = 0; i < cfg_num_threads; i++) {
+			io_uring_queue_exit(&ctxs[i].ring);
+			munmap(ctxs[i].ring_ptr, ctxs[i].ring_size);
+			munmap(ctxs[i].area_ptr, AREA_SIZE);
+		}
+	}
 	pthread_barrier_destroy(&setup_done);
 	pthread_barrier_destroy(&dispatch_done);
 	close(fd);
 	free(threads);
 	free(ctxs);
+	if (result)
+		exit(result);
 }
 
 static void *client_worker(void *arg)
@@ -574,8 +775,9 @@ static void run_client(void)
 
 static void usage(const char *filepath)
 {
-	error(1, 0, "Usage: %s (-4|-6) (-s|-c) -h<server_ip> -p<port> "
-		    "-l<payload_size> -i<ifname> -q<rxq_id> -t<num_threads>",
+	error(1, 0, "Usage: %s (-s|-c) -h<server_ip> -p<port>\n"
+		    "  -l<payload_size> -i<ifname> -q<rxq_id>\n"
+		    "  -t<num_threads> -z<total_size> -X (XDP) -P (pages)",
 		    filepath);
 }
 
@@ -594,7 +796,7 @@ static void parse_opts(int argc, char **argv)
 		usage(argv[0]);
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:dt:")) != -1) {
+	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:dt:XP")) != -1) {
 		switch (c) {
 		case 's':
 			if (cfg_client)
@@ -638,9 +840,23 @@ static void parse_opts(int argc, char **argv)
 		case 't':
 			cfg_num_threads = strtoul(optarg, NULL, 0);
 			break;
+		case 'X':
+			cfg_xdp = true;
+			break;
+		case 'P':
+			cfg_pages = true;
+			break;
 		}
 	}
 
+	if ((cfg_xdp || cfg_pages) &&
+	    (!cfg_server || cfg_num_threads != 1 || cfg_oneshot ||
+	     !cfg_ifname || cfg_queue_id < 0 || (cfg_pages && cfg_dry_run)))
+		error(1, 0, "-X/-P need one server connection and an RX queue");
+	if ((cfg_xdp || cfg_pages) &&
+	    (cfg_send_size <= 0 || cfg_send_size > SEND_SIZE))
+		error(1, 0, "-X/-P: invalid total size");
+
 	if (cfg_server && addr)
 		error(1, 0, "Receiver cannot have -h specified");
 
diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index 5047fdb56005..e6b765c523ed 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -1,24 +1,34 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
+import errno
 import re
 import resource
 import time
+from enum import Enum
 from os import path
 from lib.py import ksft_run, ksft_exit, KsftSkipEx, ksft_variants, KsftNamedVariant
+from lib.py import ksft_disruptive, ksft_pr, KsftFailEx
 from lib.py import NetDrvEpEnv
-from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen
-from lib.py import EthtoolFamily, NetdevFamily
+from lib.py import bkg, cmd, defer, ethtool, ip, rand_port, wait_port_listen
+from lib.py import EthtoolFamily, NetdevFamily, NlError
 
 SKIP_CODE = 42
 
 
-def mp_clear_wait(cfg):
-    """Wait for io_uring memory providers to clear from all device queues."""
+class RxMode(Enum):
+    """Receive modes used by the XDP access test."""
+    PAGES = '-P'
+    ZCRX = ''
+
+
+def mp_clear_wait(cfg, queue_id=None):
+    """Wait for io_uring memory providers to clear from device queues."""
     deadline = time.time() + 5
     while time.time() < deadline:
         queues = cfg.netnl.queue_get({'ifindex': cfg.ifindex}, dump=True)
-        if not any('io-uring' in q for q in queues):
+        if not any('io-uring' in q for q in queues
+                   if queue_id is None or q['id'] == queue_id):
             return
         time.sleep(0.1)
     raise TimeoutError("Timed out waiting for memory provider to clear")
@@ -243,6 +253,91 @@ def test_zcrx_large_chunks(cfg) -> None:
         cmd(tx_cmd, host=cfg.remote)
 
 
+def xdp_setup(cfg):
+    """Reserve one RX queue without changing unrelated RSS contexts."""
+    cfg.require_ipver('6')
+    dev = cfg.netnl.dev_get({'ifindex': cfg.ifindex})
+    if not {'basic', 'rx-sg'} <= set(dev.get('xdp-features', [])):
+        raise KsftSkipEx('Device lacks native multi-buffer XDP')
+    if 'xdp' in ip(f"-d link show dev {cfg.ifname}", json=True)[0]:
+        raise KsftSkipEx('An XDP program is already attached')
+
+    queues = cfg.netnl.queue_get({'ifindex': cfg.ifindex}, dump=True)
+    if any(key in q for q in queues
+           for key in ('io-uring', 'dmabuf', 'xsk', 'lease')):
+        raise KsftSkipEx('Device has an active queue provider or lease')
+
+    header = {'dev-index': cfg.ifindex}
+    try:
+        channels = cfg.ethnl.channels_get({'header': header})
+        rings = cfg.ethnl.rings_get({'header': header})
+        indir = cfg.ethnl.rss_get({'header': header})['indir']
+    except NlError as error:
+        if error.error != errno.EOPNOTSUPP:
+            raise
+        raise KsftSkipEx('Device lacks channels, rings or RSS support') from error
+    count = channels.get('combined-count', 0)
+    if count < 2:
+        raise KsftSkipEx('Test requires at least two combined channels')
+    if rings.get('tcp-data-split', 'unknown') == 'unknown':
+        raise KsftSkipEx('Device lacks TCP header/data split')
+
+    _require_ntuple(cfg)
+    cfg.target = count - 1
+    old_rings = {'header': header,
+                 'tcp-data-split': rings['tcp-data-split']}
+    new_rings = {'header': header, 'tcp-data-split': 'enabled'}
+    if 'hds-thresh' in rings:
+        old_rings['hds-thresh'] = rings['hds-thresh']
+        new_rings['hds-thresh'] = 0
+    cfg.ethnl.rings_set(new_rings)
+    defer(cfg.ethnl.rings_set, old_rings)
+
+    cfg.ethnl.rss_set({'header': header,
+                      'indir': [q if q != cfg.target else 0 for q in indir]})
+    defer(cfg.ethnl.rss_set, {'header': header, 'indir': indir})
+    flow_rule_id = set_flow_rule(cfg)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+    defer(mp_clear_wait, cfg, cfg.target)
+
+
+def xdp_exchange(cfg, mode):
+    """Receive verified TCP data with the XDP access checks enabled."""
+    size = 64 * 1024
+    rx_cmd = (f"{cfg.bin_local} -s -X -p {cfg.port} -i {cfg.ifname} "
+              f"-q {cfg.target} -z {size} {mode.value}")
+    tx_cmd = (f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} "
+              f"-l 4096 -z {size}")
+    with bkg(rx_cmd, exit_wait=True) as receiver:
+        wait_port_listen(cfg.port, proto='tcp')
+        queue = cfg.netnl.queue_get({'ifindex': cfg.ifindex, 'type': 'rx',
+                                     'id': cfg.target})
+        if ('io-uring' in queue) != (mode is RxMode.ZCRX):
+            raise KsftFailEx(f'Unexpected RX queue binding: {queue}')
+        ksft_pr(f'RX queue: {queue}')
+        cmd(tx_cmd, host=cfg.remote)
+    ksft_pr(receiver.stdout.strip())
+
+
+@ksft_disruptive
+def test_zcrx_xdp(cfg):
+    """Compare page-backed and io_uring-backed native XDP fragments."""
+    xdp_setup(cfg)
+
+    # Bind ZCRX first, then probe native XDP with a harmless frags program.
+    probe = cmd(f"{cfg.bin_local} -s -d -X -i {cfg.ifname} "
+                f"-q {cfg.target} -p {cfg.port}", fail=False)
+    if probe.ret == SKIP_CODE:
+        raise KsftSkipEx(probe.stdout.strip())
+    if probe.ret:
+        raise KsftFailEx(str(probe))
+    mp_clear_wait(cfg, cfg.target)
+
+    # After a successful probe, both attach orders must work.
+    xdp_exchange(cfg, RxMode.PAGES)
+    xdp_exchange(cfg, RxMode.ZCRX)
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../drivers/net/hw/iou-zcrx")
@@ -252,7 +347,8 @@ def main() -> None:
         cfg.netnl = NetdevFamily()
         cfg.port = rand_port()
         ksft_run(globs=globals(), cases=[test_zcrx, test_zcrx_oneshot,
-                                        test_zcrx_large_chunks], args=(cfg, ))
+                                        test_zcrx_large_chunks,
+                                        test_zcrx_xdp], args=(cfg, ))
     ksft_exit()
 
 
diff --git a/tools/testing/selftests/drivers/net/hw/iou_zcrx.bpf.c b/tools/testing/selftests/drivers/net/hw/iou_zcrx.bpf.c
new file mode 100644
index 000000000000..4d22ca8b87b0
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/iou_zcrx.bpf.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bpf.h>
+#include <linux/errno.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ipv6.h>
+#include <linux/tcp.h>
+#include <stdbool.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_kfuncs.h"
+#include "iou_zcrx.h"
+
+__u32 port;
+__u32 queue_id;
+int unreadable;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct xdp_zcrx_stats);
+} stats SEC(".maps");
+
+static __always_inline void
+check_access(struct xdp_md *ctx, const struct bpf_dynptr *ptr,
+	     struct xdp_zcrx_stats *s, enum xdp_zcrx_location loc,
+	     __u32 offset, int expected)
+{
+	__u32 value = 0;
+	int ret;
+
+	ret = bpf_xdp_load_bytes(ctx, offset, &value, sizeof(value));
+	s->errors[loc][XDP_ZCRX_LOAD] += ret != expected;
+	/* Successful stores put the original bytes back. */
+	ret = bpf_xdp_store_bytes(ctx, offset, &value, sizeof(value));
+	s->errors[loc][XDP_ZCRX_STORE] += ret != expected;
+
+	ret = bpf_dynptr_read(&value, sizeof(value), ptr, offset, 0);
+	s->errors[loc][XDP_ZCRX_DYN_READ] += ret != expected;
+	ret = bpf_dynptr_write(ptr, offset, &value, sizeof(value), 0);
+	s->errors[loc][XDP_ZCRX_DYN_WRITE] += ret != expected;
+
+	ret = bpf_dynptr_slice(ptr, offset, &value, sizeof(value)) ?
+	      0 : -EFAULT;
+	s->errors[loc][XDP_ZCRX_SLICE] += ret != expected;
+	ret = bpf_dynptr_slice_rdwr(ptr, offset, &value, sizeof(value)) ?
+	      0 : -EFAULT;
+	s->errors[loc][XDP_ZCRX_SLICE_RDWR] += ret != expected;
+}
+
+SEC("xdp.frags")
+int iou_zcrx(struct xdp_md *ctx)
+{
+	void *end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct ipv6hdr *ip6 = data + ETH_HLEN;
+	struct tcphdr *tcp = (void *)(ip6 + 1);
+	struct ethhdr *eth = data;
+	__u32 linear, total, hdr_len, wire_len;
+	struct xdp_zcrx_stats *s;
+	struct bpf_dynptr ptr;
+	__u32 key = 0;
+	int expected;
+
+	/* The traffic generator sends IPv6/TCP without extension headers. */
+	if ((void *)(tcp + 1) > end || eth->h_proto != bpf_htons(ETH_P_IPV6) ||
+	    ip6->nexthdr != IPPROTO_TCP || tcp->dest != bpf_htons(port))
+		return XDP_PASS;
+
+	hdr_len = ETH_HLEN + sizeof(*ip6) + tcp->doff * 4;
+	wire_len = ETH_HLEN + sizeof(*ip6) + bpf_ntohs(ip6->payload_len);
+	if (wire_len <= hdr_len)
+		return XDP_PASS;
+
+	s = bpf_map_lookup_elem(&stats, &key);
+	if (!s)
+		return XDP_PASS;
+	s->packets++;
+	if (ctx->rx_queue_index != queue_id) {
+		s->wrong_queue++;
+		return XDP_PASS;
+	}
+
+	linear = end - data;
+	total = bpf_xdp_get_buff_len(ctx);
+	if (tcp->doff < sizeof(*tcp) / 4 || hdr_len > linear ||
+	    wire_len > total || linear > 0xffff - sizeof(__u32)) {
+		s->bad_headers++;
+		return XDP_PASS;
+	}
+	/* Both accesses must be in the packet, not Ethernet padding. */
+	if (linear + sizeof(__u32) > wire_len)
+		return XDP_PASS;
+
+	if (bpf_dynptr_from_xdp(ctx, 0, &ptr)) {
+		s->bad_headers++;
+		return XDP_PASS;
+	}
+	s->tested++;
+	s->linear_bytes += linear;
+	s->frag_bytes += total - linear;
+	expected = unreadable ? -EFAULT : 0;
+	check_access(ctx, &ptr, s, XDP_ZCRX_HEADER,
+		     ETH_HLEN + sizeof(*ip6), 0);
+	check_access(ctx, &ptr, s, XDP_ZCRX_FRAG, linear, expected);
+	check_access(ctx, &ptr, s, XDP_ZCRX_BOUNDARY, linear - 2, expected);
+	return XDP_PASS;
+}
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/hw/iou_zcrx.h b/tools/testing/selftests/drivers/net/hw/iou_zcrx.h
new file mode 100644
index 000000000000..c9749bc9a0a6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/iou_zcrx.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef IOU_ZCRX_XDP_H
+#define IOU_ZCRX_XDP_H
+
+#include <linux/types.h>
+
+enum xdp_zcrx_location {
+	XDP_ZCRX_HEADER,
+	XDP_ZCRX_FRAG,
+	XDP_ZCRX_BOUNDARY,
+	XDP_ZCRX_LOCATIONS,
+};
+
+enum xdp_zcrx_op {
+	XDP_ZCRX_LOAD,
+	XDP_ZCRX_STORE,
+	XDP_ZCRX_DYN_READ,
+	XDP_ZCRX_DYN_WRITE,
+	XDP_ZCRX_SLICE,
+	XDP_ZCRX_SLICE_RDWR,
+	XDP_ZCRX_OPS,
+};
+
+struct xdp_zcrx_stats {
+	__u64 packets;
+	__u64 tested;
+	__u64 wrong_queue;
+	__u64 bad_headers;
+	__u64 linear_bytes;
+	__u64 frag_bytes;
+	__u64 errors[XDP_ZCRX_LOCATIONS][XDP_ZCRX_OPS];
+};
+
+#endif
-- 
2.56.1

