Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A18F43B6C3
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330550; cv=none; b=mJeW3B9luErYNW7s41qHIR3MExKgPV242aik5iu4pVHJf9I6X5YEKuJzedjL838qNIh5junZJ6XQ23yeKctyKh/OQu+G1+tgwI0U5C2n/4Ek9EVHzbpUEfGvuhrWkwOleJBJjXmEHBbEtFKFgkIHDMjlkTNqYoiwj+DZqhTaIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330550; c=relaxed/simple;
	bh=XfNrypmuBMSHhelOYnrwXTVhWErDX5uLjd7qFzom3QM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFGtKROXiCtTZfdXwxovMW7Z6HLJWZt4OQKyAk1HtPKNUy0NaGXd6wg4ZlzaJPjvT23ka+WwB9T/n73+k4DZj6e1aoQDyh93XGzr/s8bwSn5+BG+EjQYN9iuWrjIt3nTJjuBrCv8D37sAyrhgTjFuvoLy4RFNhij5ofeusTz0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcL0eyt/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcL0eyt/"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4629051c9d1so1309309f8f.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 02:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783330544; x=1783935344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLMlNoR+vLs2pg7PpRikYiE5J8mE4fMgaMGZcRJFNx8=;
        b=GcL0eyt/rJM5EkfMbKDKIkYqrfgxBHA6VlS6ro6Oi0dwkIEoqtWpGawtGOY7ki4iWV
         +rbiAz04KPo9DQf5aFhdUOLmd6QULlO55q7mMhUEcxSXVurMQfRnKAfoqHpp4j+T55Y8
         2U0GAu60jyBsDs3fLn7esjlLtXUPXJw1AKEuygyCBjVkG+pqCEyRZX/pwthjZqZ47MTx
         I5Q/oBl1Qr+J0D5EWl6QSv0VKbdpNJUzKnxFiys9kBREbfsfePgh2k4DrW35XSnlG9eK
         1nlhgyyY7eVMOkPAa+VlSh0qJ6OLSEtG2q04e4VhlXKeYsaKhCl/8wd6xB2QlO5T4qVB
         6eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330544; x=1783935344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OLMlNoR+vLs2pg7PpRikYiE5J8mE4fMgaMGZcRJFNx8=;
        b=Bg4BBQQEFv9d+sokGvrapy2pyviA1cRJCyJ1dAloCWautMC0sE7Z56fT6BNt8xlNXX
         AZpChx44Jofw+qLL7tgOI7Rs1/yFSFpkhThJ2IbcjwGymbhJqE/tRX2/Gm9BnxqaAxhd
         /amzASbIDiLhwf7u3wo1F5MslJ7KVazWVIVs05E8+mXhGWdkUTcf8BQb7Il9ta253Rev
         5TRXe3VO8kjpj6lqeb8WW9A2KqyimnTK9IvMaYUdmgUUrSFxlg/uy1e6eWde98PvIC/K
         zWzLwPlTy6/lu2hjUwZBISlJgPRIU79WPidwlvs2uSL0RBQuMKM1H96Wl9Et6s5u8goo
         IPGA==
X-Gm-Message-State: AOJu0YxitMVp7LGC1Slfi5K+Tm5ulpv1s0Q2At6Lb1AZoCoKZBmmNzxN
	dL4T3QnvlvTo8w9KEMCyzjVECCnI+X5rbkL87aXQ1govj7XhVWKRiy//661S8s0kaBsUug==
X-Gm-Gg: AfdE7cmHTn4JG3iLeSGKp342fBzkZDUi5qLAjeMiTia0MNn4scMceY6rhbzvjitOv80
	58mnpq4grR0Ljn4eherLlBCHHlB9V9InJ3YKPfV/TB7JNYD2xCF7C1MHxCFva91flghNVVsOMH+
	penQArmKv50NffHiLRExqnK/I0EO1ImgPKH2AxbwbcGTsh9VpK24X0EVlLXGWTmOFcjFptEUsw2
	HcWbxYxCf4Oy+/+yvcir2x/PgdKru+xwaXvAdaRNs8W1KmCas7czyDr8iyzAKP9dwpxv0jt5SVq
	s1815ctMAv6rju4AV2tFSfOP/Ti+093GiSup3o6sqOs2UMNfDnMtX4JsxYRLcgtROjL7Vs62UBW
	ILhe7tu+ZQhJAwOtNsrxlFz6MA63YkJ4Z95Vojorc8pTs3MZGeiMGJetxe/jWzGG6HeG2PUrZop
	nVsvSpZ1WCvZdYYE+9
X-Received: by 2002:a05:6000:70c:b0:475:f0f0:9ecb with SMTP id ffacd0b85a97d-47aad54b70amr10859613f8f.54.1783330544298;
        Mon, 06 Jul 2026 02:35:44 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm24282530f8f.25.2026.07.06.02.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:35:43 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 3/6] selftests/bpf: Add ksock kfunc test
Date: Mon,  6 Jul 2026 09:35:22 +0000
Message-Id: <20260706093525.13030-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706093525.13030-1-mahe.tardy@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that exercises the ksock kfuncs end-to-end. One sycall
bpf setup program creates a ksock context and connect the socket.
Another syscall bpf program lookup the context and send test data.
The userspace harness create a network namespace and a new socket on
loopback, run the setup and send syscall bpf progs then check that the
userspace socket received the data from bpf.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  | 165 ++++++++++++++++++
 .../testing/selftests/bpf/progs/ksock_basic.c |  68 ++++++++
 .../selftests/bpf/progs/ksock_common.h        |  73 ++++++++
 3 files changed, 306 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_basic.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_common.h

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
new file mode 100644
index 000000000000..085ddb59067e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -0,0 +1,165 @@
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
+	if (!ASSERT_OK_FD(pfd, "ksock_setup fd"))
+		return false;
+
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
+	if (!ASSERT_OK_FD(pfd, "ksock_send fd"))
+		goto fail;
+
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
index 000000000000..87d92372d28d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -0,0 +1,73 @@
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
+int bpf_ksock_bind(struct bpf_ksock *ks,
+		   const struct bpf_ksock_addr_opts *opts, u32 opts__sz) __ksym;
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
+	struct __ksock_ctx_value local, *v;
+	struct bpf_ksock *old;
+	u32 key = 0;
+	int err;
+
+	local.ctx = NULL;
+	err = bpf_map_update_elem(&__ksock_ctx_map, &key, &local, 0);
+	if (err) {
+		bpf_ksock_release(ctx);
+		return err;
+	}
+
+	v = bpf_map_lookup_elem(&__ksock_ctx_map, &key);
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

