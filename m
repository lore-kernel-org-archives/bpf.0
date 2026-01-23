Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002B1FE46D;
	Fri, 23 Jan 2026 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184996; cv=none; b=LLZKRI6+oGLqVO0TkWC9k8gVg9l6vhuTycpkfLPpybGcDqus79oV/IIefR8HptEMSULfnzPQjlAW14CGiCN/yxs8q5bSTWUS1TEx6Heguq0mCK/QONrmB6T/i9fmIZvol4x+0F/klddhOo0cktPTUPrjPBdli9MYPby7gc3Lnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184996; c=relaxed/simple;
	bh=McB92jSt11DpDF35uWoqS1QPPccssZOOaLBl71Ro0hE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+nckTD0VUiuKeLD48YFvWZ6K46jeiGTk/zoRNGaRMSn6iPitR6cn5mCpA2EOyxDfxvXEHrthKeSJ/gn0RB/5Tw/YnuL4CAIWQztaD6ZSDKuf5iVSCnA2M8mcdsFMpe8/aTuAHfKiMdWbyqJey/Y9sR775EvTeU4Mc2ZHDhJtzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=moRJErHv; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="moRJErHv"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vjJpY-00EzLO-HC; Fri, 23 Jan 2026 17:16:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=rkHvptgSl6R4ALGlkK99yhLu9IYjfuuepCjZEWpPAUk=; b=moRJErHvEmOjrMw0QFUfiuViTA
	CAkgHGZQJtDyajek6VIud56SXbIVNX+IsdxkK7g475iQwXua2StpUIQvNxfA5FxDIDZD5Ni0vZT9+
	Xk80BYhTwU2Vztc1bnTxfb7oHtnxxnMgzEHZ/x2ldaM6D5jWpNDhRmIDgPAZTVTxzNdvIQdnaA57X
	V0GgFMs9uHBQ7oo1LqoEqJ+YyTTO9YMLsGxzusR7ltLYzmHXiwxKqkPEEji3V4dS2n3pQwV7hsQe5
	J+Z0+Ji/RaEKxt2ZKujtYoLyf3ksK3u3u8Rz/nhql2CE7a2kCAZTImN/L7UYFr3GmepdEKLxaTT1j
	uAxzHufg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vjJpX-0004qZ-Uc; Fri, 23 Jan 2026 17:16:16 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vjJpL-003pZ3-R8; Fri, 23 Jan 2026 17:16:03 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 23 Jan 2026 17:15:57 +0100
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for connect() racing
 sockmap update and signal
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-selftest-signal-on-connect-v1-2-b0256e7025b6@rbox.co>
References: <20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co>
In-Reply-To: <20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

Attempt to trigger warnings/crashes by racing connect() against sockmap
updates and signals.

Follow-up to the discussion regarding af_vsock connect():
https://lore.kernel.org/netdev/20250311155601.eui5j2lta3q46i6u@gmail.com/

Suggested-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../bpf/prog_tests/sockmap_interrupted_connect.c   | 200 +++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_interrupted_connect.c b/tools/testing/selftests/bpf/prog_tests/sockmap_interrupted_connect.c
new file mode 100644
index 000000000000..aa48ae483dab
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_interrupted_connect.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <error.h>
+#include <stdio.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include <linux/string.h>
+#include <linux/time64.h>
+#include <linux/vm_sockets.h>
+
+#include "linux/const.h"
+#include "test_progs.h"
+#include "sockmap_helpers.h"
+
+#define STR(s)	#s
+#define XSTR(s)	STR(s)
+
+#define TIMEOUT	5	/* seconds */
+#define INVALID	0x4242
+
+struct socket_spec {
+	int domain;
+	int sotype;
+};
+
+struct context {
+	struct sockaddr_storage addr, bad;
+	struct socket_spec *ss;
+	char str[MAX_TEST_NAME];
+	socklen_t alen;
+	int s, c, map;
+};
+
+static void handler(int signum)
+{
+	/* nop */
+}
+
+static void *racer(void *arg)
+{
+	struct context *ctx = arg;
+	int *map = &ctx->map;
+	pid_t pid = getpid();
+
+	for (;;) {
+		if (kill(pid, SIGUSR1)) {
+			FAIL_ERRNO("kill");
+			break;
+		}
+
+		(void)bpf_map_update_elem(*map, &u32(0), &ctx->c, BPF_ANY);
+		pthread_testcancel();
+	}
+
+	return NULL;
+}
+
+static void test_reconnect(struct context *ctx)
+{
+	struct socket_spec *ss = ctx->ss;
+	__u64 tout;
+
+	tout = get_time_ns() + TIMEOUT * NSEC_PER_SEC;
+	do {
+		int c;
+
+		c = xsocket(ss->domain, ss->sotype, 0);
+		if (c < 0)
+			break;
+		ctx->c = c;
+
+		if ((ss->sotype & SOCK_TYPE_MASK) == SOCK_DGRAM) {
+			struct sockaddr_storage ca;
+			socklen_t len;
+
+			init_addr_loopback(ss->domain, &ca, &len);
+			if (xbind(c, sockaddr(&ca), len)) {
+				xclose(c);
+				break;
+			}
+		}
+
+		(void)connect(c, (struct sockaddr *)&ctx->addr, ctx->alen);
+		(void)connect(c, (struct sockaddr *)&ctx->bad, ctx->alen);
+		(void)recv(c, &(char){}, 1, MSG_DONTWAIT);
+
+		for (;;) {
+			int p = accept(ctx->s, NULL, NULL);
+
+			if (p < 0)
+				break;
+			xclose(p);
+		}
+
+		xclose(c);
+	} while (get_time_ns() < tout);
+}
+
+#define __TEST_RECONNECT_ADDR(addr_struct, mangle, mangle_s)			\
+	({									\
+		char str[MAX_TEST_NAME * 2];					\
+										\
+		memcpy(&ctx->bad, &ctx->addr, ctx->alen);			\
+		((struct addr_struct *)&ctx->bad)->mangle;			\
+										\
+		snprintf(str, sizeof(str), "%s %-24.24s ", ctx->str, mangle_s);	\
+		if (test__start_subtest(str))					\
+			test_reconnect(ctx);					\
+	})
+
+#define TEST_RECONNECT_ADDR(addr_struct, mangle)				\
+	__TEST_RECONNECT_ADDR(addr_struct, mangle, XSTR(mangle))
+
+static void test_socket(struct context *ctx)
+{
+	struct socket_spec *ss = ctx->ss;
+	socklen_t alen;
+	int s;
+
+	s = socket_loopback(ss->domain, ss->sotype | SOCK_NONBLOCK);
+	if (s < 0)
+		return;
+
+	alen = sizeof(ctx->addr);
+	if (xgetsockname(s, sockaddr(&ctx->addr), &alen))
+		goto cleanup;
+
+	ctx->s = s;
+	ctx->alen = alen;
+	sprintf(ctx->str + strlen(ctx->str), "%-5s ", socket_kind_to_str(s));
+
+	switch (ss->domain) {
+	case AF_UNIX:
+		TEST_RECONNECT_ADDR(sockaddr_un, sun_family = AF_UNSPEC);
+		TEST_RECONNECT_ADDR(sockaddr_un, sun_path[0] = (char)INVALID);
+		break;
+	case AF_VSOCK:
+		TEST_RECONNECT_ADDR(sockaddr_vm, svm_cid = INVALID);
+		break;
+	default:
+		FAIL("Unknown socket domain %#x", ss->domain);
+	}
+
+cleanup:
+	xclose(s);
+}
+
+static void test_map(struct context *ctx, enum bpf_map_type type)
+{
+	/* Filter by any `struct proto` that defines psock_update_sk_prot() */
+	struct socket_spec *ss, sockets[] = {
+		{ AF_UNIX, SOCK_STREAM },
+		{ AF_UNIX, SOCK_DGRAM },
+		// { AF_UNIX, SOCK_SEQPACKET },	/* see unix_dgram_bpf_update_proto() */
+		{ AF_VSOCK, SOCK_STREAM },
+		// { AF_VSOCK, SOCK_DGRAM },	/* see vsock_bpf_update_proto() */
+		{ AF_VSOCK, SOCK_SEQPACKET },
+	};
+
+	ctx->map = bpf_map_create(type, NULL, sizeof(int), sizeof(int), 1, NULL);
+	if (!ASSERT_OK_FD(ctx->map, "map"))
+		return;
+
+	for (ss = sockets; ss < sockets + ARRAY_SIZE(sockets); ss++) {
+		sprintf(ctx->str, "%-3s ",
+			type == BPF_MAP_TYPE_SOCKMAP ? "map" : "?");
+		ctx->ss = ss;
+
+		test_socket(ctx);
+	}
+
+	xclose(ctx->map);
+}
+
+void serial_test_sockmap_interrupted_connect(void)
+{
+	sighandler_t orig_handler;
+	struct context ctx = {0};
+	pthread_t tid;
+
+	orig_handler = signal(SIGUSR1, handler);
+	if (!ASSERT_NEQ(orig_handler, SIG_ERR, "signal"))
+		return;
+
+	if (xpthread_create(&tid, NULL, racer, &ctx))
+		goto restore;
+
+	test_map(&ctx, BPF_MAP_TYPE_SOCKMAP);
+
+	if (!xpthread_cancel(tid))
+		xpthread_join(tid, NULL);
+restore:
+	ASSERT_NEQ(signal(SIGUSR1, orig_handler), SIG_ERR, "handler restore");
+}

-- 
2.52.0

