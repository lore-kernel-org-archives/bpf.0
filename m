Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627947A88A
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862049; cv=none; b=YuhrTsTh0A8JYbTUQzJRKa2jU+3pzUgn3lYSdl8K/RZfTav/EsQZNd+rl9EEbkh7Xb9pd/z/ukmTlX323DUARp1O5+j4md95W+NAB7soT4sW9ZbPF3dy8GqAESWo1/GHX2xIlpcrAIdZu+T1yaN558AgC+9c3LOMOGDHaioYclM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862049; c=relaxed/simple;
	bh=DZKWqPUe8rp0preIxSd9+SZ2NDa0Nv/CCVQVG3K6GM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qp925VG5ad8VJ1jS1ydhbHFK0wed7L6tulSZKyFCGv9FhlPTAcxelOFH9yduqk44eNEM5qIa8qE2kGetIvkCzLF8/7/EIOwM+LaOY5p25KM3nqmJHXep6c5+n6+fi4/lkSXCtSIbSFWRkNRMV2eFMlP6GivJIb/19HnstM6nNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=day3UncB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="day3UncB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so57505e9.2
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862027; x=1786466827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gn/YPTWqyUKI7vml1SFF967j/xyYu4XxUNdG4z3EXqc=;
        b=day3UncBlr1B3NA5xwL2maSJLGqPs0o6kHzoG/vEhAWhoo+znKppZmNk8exhY6emfc
         ouhC61g+Z8NC0dwcsJefO205hv45uArvUTOmX28OhHCiKAJnLWXajQmwnbyof6ydKCmL
         jag4Eb65jAnmGh3W+crEd+yyx7O4fS9CEOyL2CZJwuHKIS97IzPFXRBaSWhHTykeQfUc
         wXkFVKUMf1nVYPbI9AxQi+Tf/vbmceSicE0oKVY74nARcczellTLYrxTYee6gc5+VXu9
         /izc4h/gBNVam8rSHTKT9tuaG0f9DoSgYOiMHRrd9wDknck/EcUcrsO+VpcillN4jO4m
         VoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862027; x=1786466827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gn/YPTWqyUKI7vml1SFF967j/xyYu4XxUNdG4z3EXqc=;
        b=TwQJF1l4SV/uLff+hFGcabbG1geWDepXS7A5KA7qb/keMlkzaPV082dwejgtav+r7C
         hBfrTbn7TX4i1gn7h6wCvDDEGXF6oOdaVIW91Pc6DD6jC1y2tb/Jufygh0ZEcGmavXn6
         iqUjCGlErdgNdR7xQ9D9vemjbjXxHtpdy+8Bbl1wCTvm9CO2qIcWAjxYJFBaBsz2Njow
         JcSG1LrYxYcJM3RFl4k9PnWgGZPv9RW8jJ21QE+jfC16Ow1wuCDXfTLFwiOX0CYye2Ua
         /JWKLp2Ax/gQ/slCMJ1S/4WS+CqKHAU+CBtKN0oL9xSaV/5RY0Y+LXxcZqWx4j5lhYLS
         qiFw==
X-Gm-Message-State: AOJu0YwKBUYjZfVfJERL8/56RsJ9tfujlnIfoEga9YTps3HOH6Y1sHUv
	Scp875UlRdEdXBLjnsdY/2CdclULIP0MXpO/trd0mwgNWUuLte3ah/byCufs8Om32Za9UA==
X-Gm-Gg: AR+sD11is1umARWB7Tx3sG1lHphJOND97umFvZho2i6Rfx7p8pwSJxb4aN06Q8VBxiL
	c/dKmOq0wLRsRGoP1trn/qdMYM4N1TIwgLCl0pMrGJnEGYMey1uYx6i1UVoBm0ES4erdrhxbTFQ
	pt/Yi2J4D89wjf6eYZGWk/04VOtCtPTsm2dcODfibyo2c3XPujWsDjKjF5b1RPyv5NQf4d0qv2n
	cz+Z4bQfwOReeyv6cGI8aGZIVmeJKorb2CyXop+PULKrQVObDAUycpEEBqQNNbf2EFQD6bBczFs
	Ksv1JQI7tHqqb00vwbczRIxLOa/CVzMFUZmc5W1mhJja6UheaNui7L4GdCiFuXYnNABe8ORJw5o
	QOL6xdk3q1uZrtwETCX7bQlPx0Sm/V8Jt3Bu0uNvfpWzTy0nuGCrO+5Ej4ng9lFcgcpBE8QZhQV
	ewT8edgDbz6OaLb4hmKA6txtG+QHS8+1yg0KmDs3KQ4OSW/UxcVYHbxQE993fu3SeTU1nA7kdL2
	GOuARzJaFnL8ilsxnYGUtuKmPjsow87eQ==
X-Received: by 2002:a05:600c:46ce:b0:498:ee7:e403 with SMTP id 5b1f17b1804b1-4980ee7e7dfmr289205385e9.19.1785862027104;
        Tue, 04 Aug 2026 09:47:07 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4994e04db3asm14229485e9.15.2026.08.04.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:47:06 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	ameryhung@gmail.com,
	kuniyu@google.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v3 3/5] selftests/bpf: Add ksock kfunc test
Date: Tue,  4 Aug 2026 16:46:50 +0000
Message-Id: <20260804164652.296919-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804164652.296919-1-mahe.tardy@gmail.com>
References: <20260804164652.296919-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that exercises the ksock kfuncs end-to-end. One syscall
bpf setup program creates a ksock context and connects the socket.
Another syscall bpf program looks up the context and send test data.
The userspace harness creates a network namespace and a new socket on
loopback, run the setup and send syscall bpf progs then check that the
userspace socket received the data from bpf.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  | 159 ++++++++++++++++++
 .../testing/selftests/bpf/progs/ksock_basic.c |  68 ++++++++
 .../selftests/bpf/progs/ksock_common.h        |  61 +++++++
 3 files changed, 288 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
new file mode 100644
index 000000000000..fb88eac9eeba
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include <arpa/inet.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "ksock_basic.skel.h"
+
+#define NS_TEST "ksock_basic_ns"
+#define LOOPBACK_IP "127.0.0.1"
+#define RECV_PORT 7777
+#define RECV_TIMEOUT_SEC 5
+
+struct ksock_test_env {
+	const char *netns;
+	bool netns_created;
+	struct nstoken *nstoken;
+	struct sockaddr_in addr;
+	int rfd;
+	char buf[32];
+};
+
+static bool ksock_test_env_setup(struct ksock_test_env *env, const char *netns)
+{
+	struct timeval tv;
+	int err;
+
+	memset(env, 0, sizeof(*env));
+	env->netns = netns;
+	env->rfd = -1;
+
+	SYS(fail, "ip netns add %s", netns);
+	env->netns_created = true;
+	SYS(fail, "ip -net %s link set lo up", netns);
+
+	env->nstoken = open_netns(netns);
+	if (!ASSERT_OK_PTR(env->nstoken, "open_netns"))
+		goto fail;
+
+	env->rfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (!ASSERT_OK_FD(env->rfd, "receiver socket"))
+		goto fail;
+
+	env->addr.sin_family = AF_INET;
+	env->addr.sin_addr.s_addr = inet_addr(LOOPBACK_IP);
+	env->addr.sin_port = htons(RECV_PORT);
+
+	err = bind(env->rfd, (struct sockaddr *)&env->addr, sizeof(env->addr));
+	if (!ASSERT_OK(err, "bind receiver"))
+		goto fail;
+
+	tv.tv_sec = RECV_TIMEOUT_SEC;
+	tv.tv_usec = 0;
+	err = setsockopt(env->rfd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+	if (!ASSERT_OK(err, "set rcvtimeo"))
+		goto fail;
+
+	return true;
+
+fail:
+	if (env->rfd >= 0) {
+		close(env->rfd);
+		env->rfd = -1;
+	}
+	if (env->nstoken) {
+		close_netns(env->nstoken);
+		env->nstoken = NULL;
+	}
+	if (env->netns_created) {
+		SYS_NOFAIL("ip netns del %s >/dev/null 2>&1", netns);
+		env->netns_created = false;
+	}
+	return false;
+}
+
+static void ksock_test_env_cleanup(struct ksock_test_env *env)
+{
+	if (env->rfd >= 0)
+		close(env->rfd);
+	if (env->nstoken)
+		close_netns(env->nstoken);
+	if (env->netns_created) {
+		SYS_NOFAIL("ip netns del %s >/dev/null 2>&1", env->netns);
+		env->netns_created = false;
+	}
+}
+
+static void ksock_assert_recv(struct ksock_test_env *env, const char *data,
+			      size_t data_sz)
+{
+	ssize_t n;
+
+	memset(env->buf, 0, sizeof(env->buf));
+	n = recvfrom(env->rfd, env->buf, sizeof(env->buf), 0, NULL, NULL);
+	if (!ASSERT_EQ(n, data_sz, "recvfrom len"))
+		return;
+	ASSERT_MEMEQ(env->buf, data, data_sz, "payload match");
+}
+
+static bool ksock_setup_ctx(struct ksock_basic *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err, pfd;
+
+	skel->bss->ipv4_remote = inet_addr(LOOPBACK_IP);
+	skel->bss->remote_port = RECV_PORT;
+
+	pfd = bpf_program__fd(skel->progs.ksock_setup);
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "ksock_setup run"))
+		return false;
+	if (!ASSERT_OK(opts.retval, "ksock_setup retval"))
+		return false;
+
+	return true;
+}
+
+void test_ksock_basic(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ksock_test_env env;
+	struct ksock_basic *skel;
+	int err, pfd;
+
+	skel = ksock_basic__open();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		return;
+
+	err = ksock_basic__load(skel);
+	if (!ASSERT_OK(err, "skel load")) {
+		ksock_basic__destroy(skel);
+		return;
+	}
+
+	if (!ksock_test_env_setup(&env, NS_TEST))
+		goto fail;
+
+	/* Step 1: Run the setup SYSCALL prog to create ksock */
+	if (!ksock_setup_ctx(skel))
+		goto fail;
+
+	/* Step 2: Run the send SYSCALL prog */
+	pfd = bpf_program__fd(skel->progs.ksock_send);
+	err = bpf_prog_test_run_opts(pfd, &opts);
+	if (!ASSERT_OK(err, "ksock_send run"))
+		goto fail;
+	if (!ASSERT_EQ(opts.retval, sizeof(skel->data->send_data),
+		       "sendmsg bytes"))
+		goto fail;
+
+	/* Step 3: Receive and verify the data */
+	ksock_assert_recv(&env, skel->data->send_data,
+			  sizeof(skel->data->send_data));
+
+fail:
+	ksock_test_env_cleanup(&env);
+	ksock_basic__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_basic.c b/tools/testing/selftests/bpf/progs/ksock_basic.c
new file mode 100644
index 000000000000..c18dcc2ea37b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_basic.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"
+#include "ksock_common.h"
+
+__be32 ipv4_remote;
+__u16 remote_port;
+
+char send_data[32] = "hello from bpf ksock";
+
+SEC("syscall")
+int ksock_setup(void *ctx)
+{
+	struct bpf_ksock_create_opts create_opts = {};
+	union bpf_ksock_addr addr = {};
+	struct bpf_ksock *ks;
+	int err = 0;
+
+	create_opts.family = AF_INET;
+	create_opts.type = SOCK_DGRAM;
+	create_opts.protocol = IPPROTO_UDP;
+
+	ks = bpf_ksock_create(&create_opts, sizeof(create_opts), &err);
+	if (!ks)
+		return err;
+
+	addr.sin.sin_family = AF_INET;
+	addr.sin.sin_port = bpf_htons(remote_port);
+	addr.sin.sin_addr.s_addr = ipv4_remote;
+
+	err = bpf_ksock_connect(ks, &addr, sizeof(addr));
+	if (err) {
+		bpf_ksock_release(ks);
+		return err;
+	}
+
+	err = ksock_ctx_insert(ks);
+	if (err && err != -EEXIST)
+		return err;
+	return 0;
+}
+
+SEC("syscall")
+int ksock_send(void *ctx)
+{
+	struct __ksock_ctx_value *v;
+	struct bpf_ksock *ks;
+	int send = -1;
+
+	v = ksock_ctx_value_lookup();
+	if (!v)
+		return -ENOENT;
+
+	ks = bpf_kptr_xchg(&v->ctx, NULL);
+	if (!ks)
+		return -ENOENT;
+
+	send = bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+	return send;
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/ksock_common.h b/tools/testing/selftests/bpf/progs/ksock_common.h
new file mode 100644
index 000000000000..6e5b5b089124
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Isovalent */
+
+#ifndef _KSOCK_COMMON_H
+#define _KSOCK_COMMON_H
+
+#include "errno.h"
+#include <stdbool.h>
+
+#define SOCK_STREAM	1
+#define SOCK_DGRAM	2
+#define IPPROTO_TCP	6
+#define IPPROTO_UDP	17
+
+struct bpf_ksock *bpf_ksock_create(const struct bpf_ksock_create_opts *opts,
+				   u32 opts__sz, int *err__uninit) __ksym;
+int bpf_ksock_connect(struct bpf_ksock *ks, const union bpf_ksock_addr *addr,
+		      u32 addr__sz) __ksym;
+struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks) __ksym;
+void bpf_ksock_release(struct bpf_ksock *ks) __ksym;
+int bpf_ksock_send(struct bpf_ksock *ks, const void *data, u32 data__sz) __ksym;
+
+struct __ksock_ctx_value {
+	struct bpf_ksock __kptr * ctx;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct __ksock_ctx_value);
+	__uint(max_entries, 1);
+} __ksock_ctx_map SEC(".maps");
+
+static inline struct __ksock_ctx_value *ksock_ctx_value_lookup(void)
+{
+	u32 key = 0;
+
+	return bpf_map_lookup_elem(&__ksock_ctx_map, &key);
+}
+
+static inline int ksock_ctx_insert(struct bpf_ksock *ctx)
+{
+	struct __ksock_ctx_value *v;
+	struct bpf_ksock *old;
+
+	v = ksock_ctx_value_lookup();
+	if (!v) {
+		bpf_ksock_release(ctx);
+		return -ENOENT;
+	}
+
+	old = bpf_kptr_xchg(&v->ctx, ctx);
+	if (old) {
+		bpf_ksock_release(old);
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+#endif /* _KSOCK_COMMON_H */
--
2.34.1

