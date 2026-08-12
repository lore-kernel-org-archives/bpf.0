Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B928CF4A
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549427; cv=none; b=ou4xhNwUHy7B1sGWypsdTxjt8eJtDI4Xa9yWGbkrOITio6uMuHsaAUdsrckxJWGuLRS+Lp3gvKXjjYa4p0yOFVkXpXsJprgy4b4jVYgD5wA7OJRvH3+tvvVNq0aFdER3zG8kIyK5px0hX0JZhi4NIleS4NlZzL3f7eoiu6ycJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549427; c=relaxed/simple;
	bh=G5jCGbk3yQEtYvKf+qNIBYcU7PfCcq/mncsa69r1YPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6h/0VvZM1Jmr+wg0u29Qg6jwF7acs0L7LFMbeWdnglJ6Zn5CX/R/rkPRYRemKmwvzQzhTu7OanB7C3FCiu//rzKQ5byKLq77jjOzQX+xk696G+vHJ+DnneN+SNVImrWBPmPt3TGaT1HMsCLg8i6wMQXVA7bRS+5kQeizgkgI64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpJqLMrT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpJqLMrT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so10812455e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786549423; x=1787154223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MAZIuEO4f2tcvLFLAUTjzIAF0JQKtMaUELNiBlb3lmg=;
        b=DpJqLMrT0V8NHLGyJen2gyEu6uzF28RflQS66fBL7fAL79nJilIZuFYQtmfDLkRhi1
         BMpGKNDJ0vgmu27IDXRgnIzEsGEYVW9WS+RbKaSAZv9tBl9m5TgxLumKnlpTSWeiJt4w
         j0PvReZFvrsrF9mIPkZLyc5lPh9s7sAFbcQeOBm4uYY9bbmXlCRlYJvFqLLNPgREWhAI
         Ac5+GK2IGYMDOqeQoTtw31f6D2iQafMlKADqJlEELXBRXP4mZUlP9pFD79vj/AjbetDt
         USHBIie0pDjGRz8SA/aMMQ5LArjAXNw8PbG1s3vBRnb6kwUEtEy7QKPvJkU7aMGVMCqA
         rTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549423; x=1787154223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MAZIuEO4f2tcvLFLAUTjzIAF0JQKtMaUELNiBlb3lmg=;
        b=snfe3nPfzYdNAtBdrZsEEmyH/5WdxjUAGGaX+8EbNBpyWWWvnIZg744aToqr3BGsiA
         zpBYnmfFF70yc0Ij0ZyXbGpEYuIX2qsnsXjd//lxFykPVjCQN2gI2TmoRVY8QVvWDI7y
         gB8ieBg+EI0OeN1ClG8EK6vyOKznLVp5KRyDokrs2thY/bpDAXvDeifBD9AzBWR858lu
         Yof2Jwi2glZ1T244aHtTAGvbdSJmhudARhCIt+hnvjYe8eUY6XJQ9Z7xfLFcFyRMANr9
         KW0kIDLBgpaW8Vj02bC5dBCCC8GJ/J6MbwdcJlBLUGG2ag+RJJLi+q1A8tH2MBlCDySF
         fojQ==
X-Gm-Message-State: AOJu0YznFfpNQCySnzGVyPGdsDpgq+5ayBo+sPrz17ONF3Q4eufdN+7i
	Ujka9YFUCILh+QlpXdd8fP9eE7f1z7I2J/Ohv92qH2pfaaah44IXXIv461wHy09V6tgyhw==
X-Gm-Gg: AR+sD121o1jKgTG7pGT/OCxHjQ2GnKi3EDfHb7V4xN/lI1DiBK/17vjQSCVEZX4QJRV
	q61Icu22EumRykgmVzQ7jCBKx82pYtevpcAPnJTcFdbOEB1oFmzA23hWZWhxQTd7OHCtIZk6rlh
	kkAAXBG9qAHcXi+ABEG+RsEDhwnK9DssMWmW0opVXAoyKydiRNbRpuuwhNBSFw2Sni3C2mqcWZ8
	011q43Cb/dv7GkTyAWyJMnBnMb7AeQeg7APUMvMKfX3cd3Q3S7KP+s9PT5GwPdFghSySxHHxqCa
	XnBcYTCEx4rbMuhVCzzqrwWagqicPDGMLabosLWg2Sra4l5q3emhJYrwbrLbZTm4M1j07VjSRn1
	ERh5GGMQHEdujhhoTvqpXwTXat4bXpj0W+Os6cm5QtVf6VOYe7SjM6Bbcn317/adxOdC+HqLotG
	5H2oNog3qC3ukNURtz1G8JByU3ROzoAhmV1i9i1QU5oI8FRRuRebiRSIApMRAhwz7pMXICi2gmf
	CIKYCegiBoGvn2U0ntXQG8oUkk1Aammtw==
X-Received: by 2002:a05:600c:8214:b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-4997c0fe741mr94036715e9.10.1786549423049;
        Wed, 12 Aug 2026 08:43:43 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4997c939574sm51584985e9.1.2026.08.12.08.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:43:42 -0700 (PDT)
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
	memxor@gmail.com,
	jiayuan.chen@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH bpf-next v6 3/5] selftests/bpf: Add ksock kfunc test
Date: Wed, 12 Aug 2026 15:43:26 +0000
Message-Id: <20260812154328.72834-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154328.72834-1-mahe.tardy@gmail.com>
References: <20260812154328.72834-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that exercises the ksock kfuncs end-to-end. One syscall
bpf setup program creates a ksock context and connects the socket.
Another LSM sleepable bpf program looks up the context and send test
data. The userspace harness creates a network namespace and a new socket
on loopback, run the setup and send syscall bpf progs then check that
the userspace socket received the data from bpf.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  | 127 ++++++++++++++++++
 .../selftests/bpf/progs/ksock_common.h        |  78 +++++++++++
 tools/testing/selftests/bpf/progs/ksock_lsm.c |  72 ++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_lsm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
new file mode 100644
index 000000000000..30e89d34d388
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include <arpa/inet.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "ksock_lsm.skel.h"
+
+#define NS_TEST "ksock_lsm_ns"
+#define RECV_PORT 7777
+#define RECV_TIMEOUT_SEC 5
+
+struct ksock_test_env {
+	bool netns_created;
+	struct nstoken *nstoken;
+	int rfd;
+};
+
+static bool ksock_test_env_setup(struct ksock_test_env *env)
+{
+	struct sockaddr_in addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+		.sin_port = htons(RECV_PORT),
+	};
+	struct timeval tv = { .tv_sec = RECV_TIMEOUT_SEC };
+	int err;
+
+	memset(env, 0, sizeof(*env));
+	env->rfd = -1;
+
+	SYS(fail, "ip netns add %s", NS_TEST);
+	env->netns_created = true;
+	SYS(fail, "ip -net %s link set lo up", NS_TEST);
+
+	env->nstoken = open_netns(NS_TEST);
+	if (!ASSERT_OK_PTR(env->nstoken, "open_netns"))
+		goto fail;
+
+	env->rfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (!ASSERT_OK_FD(env->rfd, "receiver socket"))
+		goto fail;
+
+	err = bind(env->rfd, (struct sockaddr *)&addr, sizeof(addr));
+	if (!ASSERT_OK(err, "bind receiver"))
+		goto fail;
+
+	err = setsockopt(env->rfd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+	if (!ASSERT_OK(err, "set rcvtimeo"))
+		goto fail;
+
+	return true;
+
+fail:
+	return false;
+}
+
+void test_ksock_lsm(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ksock_test_env env;
+	struct sockaddr_in trigger_addr = {
+		.sin_family = AF_INET,
+		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
+	};
+	struct ksock_lsm *skel;
+	char recv_data[sizeof(skel->data->send_data)] = {};
+	ssize_t n;
+	int tfd = -1;
+	int err;
+
+	skel = ksock_lsm__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
+		return;
+
+	if (!ksock_test_env_setup(&env))
+		goto fail;
+
+	/* Step 1: Run the setup SYSCALL prog to create the ksock */
+	skel->bss->ipv4_remote = htonl(INADDR_LOOPBACK);
+	skel->bss->remote_port = RECV_PORT;
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_setup),
+				     &opts);
+	if (!ASSERT_OK(err, "ksock_setup run"))
+		goto fail;
+	if (!ASSERT_OK(opts.retval, "ksock_setup retval"))
+		goto fail;
+
+	/* Step 2: Attach LSM prog and trigger socket_bind from userspace */
+	skel->links.ksock_socket_bind =
+		bpf_program__attach_lsm(skel->progs.ksock_socket_bind);
+	if (!ASSERT_OK_PTR(skel->links.ksock_socket_bind,
+			   "attach socket_bind lsm"))
+		goto fail;
+
+	tfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (!ASSERT_OK_FD(tfd, "trigger socket"))
+		goto fail;
+
+	skel->bss->target_pid = getpid();
+	err = bind(tfd, (struct sockaddr *)&trigger_addr, sizeof(trigger_addr));
+	skel->bss->target_pid = 0;
+	if (!ASSERT_OK(err, "trigger bind"))
+		goto fail;
+
+	/* Step 3: Verify the LSM hook sent the notification */
+	if (!ASSERT_EQ(skel->data->send_ret, sizeof(skel->data->send_data),
+		       "LSM send bytes"))
+		goto fail;
+
+	n = recvfrom(env.rfd, recv_data, sizeof(recv_data), 0, NULL, NULL);
+	if (ASSERT_EQ(n, sizeof(recv_data), "recvfrom len"))
+		ASSERT_MEMEQ(recv_data, skel->data->send_data, sizeof(recv_data),
+			     "payload match");
+
+fail:
+	if (tfd >= 0)
+		close(tfd);
+	if (env.rfd >= 0)
+		close(env.rfd);
+	if (env.nstoken)
+		close_netns(env.nstoken);
+	if (env.netns_created)
+		SYS_NOFAIL("ip netns del %s >/dev/null 2>&1", NS_TEST);
+	ksock_lsm__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_common.h b/tools/testing/selftests/bpf/progs/ksock_common.h
new file mode 100644
index 000000000000..01edaeb9fdd4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026 Isovalent */
+
+#ifndef _KSOCK_COMMON_H
+#define _KSOCK_COMMON_H
+
+#include "errno.h"
+
+#define SOCK_DGRAM	2
+#define IPPROTO_UDP	17
+
+struct bpf_ksock *bpf_ksock_create(const struct bpf_ksock_create_opts *opts,
+				   u32 opts__sz, int *err__uninit) __ksym;
+int bpf_ksock_connect(struct bpf_ksock *ks, const union bpf_ksock_addr *addr,
+		      u32 addr__sz) __ksym;
+struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks) __ksym;
+void bpf_ksock_release(struct bpf_ksock *ks) __ksym;
+int bpf_ksock_send(struct bpf_ksock *ks, const void *data, u32 data__sz) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
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
+static inline struct bpf_ksock *ksock_ctx_get(void)
+{
+	struct __ksock_ctx_value *v;
+	struct bpf_ksock *ks = NULL, *tmp;
+
+	v = ksock_ctx_value_lookup();
+	if (!v)
+		return NULL;
+
+	bpf_rcu_read_lock();
+	tmp = v->ctx;
+	if (tmp)
+		ks = bpf_ksock_acquire(tmp);
+	bpf_rcu_read_unlock();
+
+	return ks;
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
diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm.c b/tools/testing/selftests/bpf/progs/ksock_lsm.c
new file mode 100644
index 000000000000..9808451098ef
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm.c
@@ -0,0 +1,72 @@
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
+char send_data[32] = "hello from bpf ksock";
+
+__be32 ipv4_remote;
+__u16 remote_port;
+int target_pid;
+int send_ret = -1;
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
+SEC("lsm.s/socket_bind")
+int BPF_PROG(ksock_socket_bind, struct socket *sock, struct sockaddr *address,
+	     int addrlen, int ret)
+{
+	struct bpf_ksock *ks;
+	u32 pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (ret || pid != target_pid)
+		return ret;
+
+	ks = ksock_ctx_get();
+	if (!ks) {
+		send_ret = -ENOENT;
+		return ret;
+	}
+
+	send_ret = bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+
+	return ret;
+}
+
+char __license[] SEC("license") = "GPL";
--
2.34.1

