Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C849690C
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717107; cv=none; b=K4Q/xXmrUbgdr+FgRBzrEbgcekRVvwwkf8tVPR+WNlIa7OcUfkmjhBdy3WbPif7ZrqHs6wv2YR2W2Wh4EgXcwB59U49yUjg1DkdQRlA2gZOwgcuSLpJk75AHgdaPXfRqTkbHtvsgcSj2NZDQdwaYSHnIWH/WwM0j2ZHgF7deTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717107; c=relaxed/simple;
	bh=hAIolvuj91kt88At2bvQIt1nGAK5/C0e6Es/uY3MWDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FRnh8QA0ez1pyhRU+WDGQz1OarbbHyEFsAw8LvZgX1Pj4epuGMigFVboju4cH/PK+5UUytwboIxFM1luvcRiv0XS6kRP0+6L5Xk8Egx6Q1/QEYszIHYrmFtWzFB/BkAqTCwIUfZYkrtt1MH8GuS3wHEEDEmrYwu1GedxtHSl4NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuuZiyZ9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuuZiyZ9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so33476105e9.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784717104; x=1785321904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yO/wSIT4jUK9iIMnJ2wSm3OzLOIhx08Fv0KV8/YcqWw=;
        b=PuuZiyZ95y/Kf37RwN/YKYYLmeIpvkKx3Bnz3hBGRQNVC8ZKmVzmobKr4h+3fizUl6
         RCseRN3sa8XymvRmqsO0EWDesywSq0uqmcswFZByBHGcyFUSqbYq9+gwjO0aZ8SuUcWz
         IGkrSakef8WzSz4zYQSnxMcKjItBePhFOWGrnt58WPzIzvzhqHLgHzAlM8XYl7osncGP
         6iwFVpb6B2LbZ9v7QEXhDQp2/U4WBfqoP/JySOsXlw68Q92C0HB7vP15pyH1MIqETfzo
         JGohzgdNyo7khIp7Z3Lkt+5Mr2uW/FsouevTB/AQz72TEqNDGLWYBnjOQL8dKY4lKMy2
         LoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717104; x=1785321904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yO/wSIT4jUK9iIMnJ2wSm3OzLOIhx08Fv0KV8/YcqWw=;
        b=dF2uuNd8EeReEtt7xfNb0GZ9AgJ/EQrzAJejUrrqz+Y2A1sji2vXGskigXTQfPArks
         SkVNQIIVajcAxQ6hSytUnUajhNALtaV1w5rI7tVqrGBANaV57H7rUhrWTWJgv+MUAxeb
         p4bRuTJRp19Q5kIwvV5ei6KKQPnFMmDFNNyIx5Ml6u9XVwbJMqcRttWIh2MCr7rfUylX
         E5tKcydWEZTsi97RfWMn8L4MTRbsQma8pgzgy5wv/ZlinjwSPTMeHKTsuddRA9ghYUGd
         r9x2lACgleN0MYRaz3/3J1S2t42vJp4PNCHpkwOw/W014FGOektCuUSUWD7GxeCsU5Hv
         UBZg==
X-Gm-Message-State: AOJu0YxFcnRs3L4XZ6ldaLXzX2dde9NvH5fUpy5DNakXXEkqanVi3DMu
	wFBIRztRl/UredTYdhFhGXJ4bv47RC5Vgu9HQilb7qdfm+PUilQLocXk2lnG49jLkS0=
X-Gm-Gg: AR+sD101UpFK8+3JaG2VLDwyoYB+W9gT96Ba1SyHP6J2fRgcYq5sY5zHZ3+AWfhC4PO
	RAe2ISTeeyO7YQXn/KvM0yO8uUW42BUGUbpPROj1qXs3YizsUPUEdPa+l+qa2C3Y5Zzl51OKfFl
	fp5hUh8+/wlUh2nxcO3timiLIsDnywSr9p2apa9UGLnKv3Bfos4AWEH1hoAB+6CLEfOPbG5ZgJ8
	LFDp303/NeFhnx7Bhur1tlJqKWpPurwEQQ15imV7X4sGe7n04PLhAybSKbUiN6+H2/LOLSR+4DZ
	6ogTSOPjh49BUZiPldvYDVOPK9j4o9aOD4vWsp7KhrWxTQZNtpcRL6JvQ4bJ69wDtbUMyoAZsjG
	kCc50Sf5oFCPwrxf0w/vQr+686m7gOc0WspD4wE/D6Lg6BO9uqPcWtqTAdoY1GjsfuqM4RFffbn
	oJLfyhIWLgAjRktNZQs69YQSWbGuUH/AFPfwSSF+r1232yB7SrBOK3U1G751SNW2JECmr3
X-Received: by 2002:a05:600c:4685:b0:495:4aff:5fdf with SMTP id 5b1f17b1804b1-4954aff61f3mr277705325e9.28.1784717103501;
        Wed, 22 Jul 2026 03:45:03 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4956a509901sm111090575e9.8.2026.07.22.03.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:45:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: Add ksock kfunc test
Date: Wed, 22 Jul 2026 10:44:52 +0000
Message-Id: <20260722104454.165911-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722104454.165911-1-mahe.tardy@gmail.com>
References: <20260722104454.165911-1-mahe.tardy@gmail.com>
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
 .../selftests/bpf/progs/ksock_common.h        |  62 +++++++
 3 files changed, 289 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
new file mode 100644
index 000000000000..5b22ece4be4e
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
+	if (!ASSERT_EQ(opts.retval,
+		       sizeof(skel->data->send_data), "sendmsg bytes"))
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
index 000000000000..e8131932d97b
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
+	struct bpf_ksock_addr_opts addr_opts = {};
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
+	addr_opts.family = AF_INET;
+	addr_opts.port = remote_port;
+	addr_opts.ipv4_addr = ipv4_remote;
+
+	err = bpf_ksock_connect(ks, &addr_opts, sizeof(addr_opts));
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
index 000000000000..77f30a42be60
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -0,0 +1,62 @@
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
+int bpf_ksock_connect(struct bpf_ksock *ks,
+		      const struct bpf_ksock_addr_opts *opts, u32 opts__sz) __ksym;
+struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks) __ksym;
+void bpf_ksock_release(struct bpf_ksock *ks) __ksym;
+int bpf_ksock_send(struct bpf_ksock *ks,
+		   const void *data, u32 data__sz) __ksym;
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

