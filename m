Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5BD4C043F
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717108; cv=none; b=DvaOWIfvVp1gEaV+NWMj+/fwX9EknILZSusFWQedjTYijhrW84Tmh1mbgUzGP9V4tMQAHQWCH8CkjpMPsC35ZEnEUoG0M6CXGDZ1fkYYdvB+swcWc+sxNL1SeJxBJ7XFUTWer9ut7sStGQZhfVQfioKvdcQ6bRxuvSMsIfw0xyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717108; c=relaxed/simple;
	bh=QQT3OC+PO4dp5xRpO+VpIN5+Tzr3zhDq6ZaX/k4d9X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRLJvb45INXvxlpqxnxmoHk0bjbp/vUPbWjoginZ1a+7LIxboP5nvkJJZf1Qa+Jh44rAaUfN/FrXVEo1eh2xP74d2l+/kwGQ2PIBGe6UHaneEHBABj3ExHXmtPjrM1UNRSlL6PUksg9duiBXuda1oW32CcqV4DvpO7MGk6zTXy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfwk2U8B; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfwk2U8B"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso45780905e9.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 03:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784717104; x=1785321904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p9/hW0W+ine2CffOgO3rdDWM4kKlQ7iv+sb7lIONVQg=;
        b=bfwk2U8Bsl4bDHu62MRBrLUTrmhHa9GkRWRDAi1gd33VZlDw9yJSGYkZMLCvHKhJYz
         X11YsIjnRvm5p+ia0L1dVMNDG0zwzzY3zH5YN01L963MjcJPiYlA4i6fLwqOoPtb61xo
         cnLqL9U4KWpZJz6QSbIRSuv9bPWR7Xju2o7uwpEok0+ggvFy6vwLkDnNEf/ZuIvSQLPi
         g/4yx4Lu6d0kFTZjyH4hukMVtBkpMRNwk2mYOCD4ipRdBZOXbaslVJm1X+fvy6z9EkPM
         nmhUHr/jmX011lmob6Csf3HUMj8y2r9Qs1wb9RXPFqfxw/k2qIBYdDYMV3kLeB99TmGu
         QHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717104; x=1785321904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p9/hW0W+ine2CffOgO3rdDWM4kKlQ7iv+sb7lIONVQg=;
        b=KPdcN3PZzj+JepfF2pZ4vRVDh0bSbieoZyYAzVFW8zoL4L6QMzT0Vr3yCP1PrAjd2C
         WhkmraAfthdQ9Hu5lNvRhMDR4xqzPQrCQ7FVSTGXfTm891GKFS9HaxaB635XojfTEyYl
         Fythu8yjCZghB6rJFAGvmMi9lHd5CeEpAYLRLF6/ttQusLJqblt2QcxBaD2wcSa9r7lj
         Xf3NYl1oA3q6ZwHR+0981aIhvbEpHazm9UOut718PR5060aA6jD1VZtQP/vKMBmiulwd
         afE0+DtD2fUu8z1bh55HVwzhtHn7+e4R0862sDcutoQcakrZHb1l5wvg7Mn7P1TlxE2D
         18fA==
X-Gm-Message-State: AOJu0Yz+liykR9u8LffK2GEbxjCLwXSPYdw7C6Kv2h+017AGVszTaf5a
	uhGz9Ft1644d0TfE8LanRRFwL0Ha8WCjSQrWNdDCKKvkJ4wmUkI7dcZolzVTD2BS7Vo=
X-Gm-Gg: AR+sD10+FII9OUQt8+jftptp5LPmGnomJeaTll0TdjjJlkkNoYkCSibxtqzZTNOBcwu
	bwZigl89qyMQuj2RCtBoCIEURkaptZzO4TEZWFhHtrb9xdNSs8ploNZqiH5f+Rn2NJ1XRFtdxrA
	gi3AoPLik/UPvIMsv8PNOtLyNNUnkChgATuMwueD0BwecRpRtW9vZazkRrPnQgJsDAD8nLLxW9B
	wpIKHNUqaASy6QwZfnJNm/qwvff+lHrsaXZpgaeZL/6VvK5K2eYyxpq8n1DkkplXf7i8zXIj7vf
	m2W7z0szELfbsCvhg2knaFDrEQdg4ac++AWitLTmg8LmVwwA6GaaiAbp/q9f2OojLh41gkJNzTt
	aCaFdqWsGaDfO5O29GwKRMEQ1CbI1+c8K6SgNlDFuOMwcM4sPX773/9ze3Gf+vnjXLUAER+g794
	8gS+yuC+SUd4F3yWcmbpZMqXp4BYgEhGa/yIs7E6A633O4Sc8=
X-Received: by 2002:a05:600c:3143:b0:492:7142:f46e with SMTP id 5b1f17b1804b1-4954a3d0cd7mr270542105e9.2.1784717104022;
        Wed, 22 Jul 2026 03:45:04 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4956a509901sm111090575e9.8.2026.07.22.03.45.03
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
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Add ksock LSM recursion test
Date: Wed, 22 Jul 2026 10:44:53 +0000
Message-Id: <20260722104454.165911-5-mahe.tardy@gmail.com>
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

The bpf_ksock_send() kfunc triggers the security_socket_sendmsg() LSM
hook via kernel_sendmsg(), thus attaching an LSM program triggering that
kfunc on the same hook would provoke recursion. This test exercises that
path and make sure that recursion is guarded and prevented.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  | 84 +++++++++++++++++--
 .../testing/selftests/bpf/progs/ksock_basic.c | 33 +-------
 .../selftests/bpf/progs/ksock_common.h        | 37 ++++++++
 .../selftests/bpf/progs/ksock_recursion.c     | 69 +++++++++++++++
 4 files changed, 186 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_recursion.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
index 5b22ece4be4e..f66660fc191d 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -6,8 +6,10 @@
 #include "test_progs.h"
 #include "network_helpers.h"
 #include "ksock_basic.skel.h"
+#include "ksock_recursion.skel.h"

 #define NS_TEST "ksock_basic_ns"
+#define NS_LSM_RECURSION_TEST "ksock_lsm_recursion_ns"
 #define LOOPBACK_IP "127.0.0.1"
 #define RECV_PORT 7777
 #define RECV_TIMEOUT_SEC 5
@@ -98,15 +100,16 @@ static void ksock_assert_recv(struct ksock_test_env *env, const char *data,
 	ASSERT_MEMEQ(env->buf, data, data_sz, "payload match");
 }

-static bool ksock_setup_ctx(struct ksock_basic *skel)
+static bool ksock_setup_ctx(struct bpf_program *prog, __be32 *ipv4_remote,
+			    __u16 *remote_port)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	int err, pfd;

-	skel->bss->ipv4_remote = inet_addr(LOOPBACK_IP);
-	skel->bss->remote_port = RECV_PORT;
+	*ipv4_remote = inet_addr(LOOPBACK_IP);
+	*remote_port = RECV_PORT;

-	pfd = bpf_program__fd(skel->progs.ksock_setup);
+	pfd = bpf_program__fd(prog);
 	err = bpf_prog_test_run_opts(pfd, &opts);
 	if (!ASSERT_OK(err, "ksock_setup run"))
 		return false;
@@ -137,7 +140,9 @@ void test_ksock_basic(void)
 		goto fail;

 	/* Step 1: Run the setup SYSCALL prog to create ksock */
-	if (!ksock_setup_ctx(skel))
+	if (!ksock_setup_ctx(skel->progs.ksock_setup,
+			     &skel->bss->ipv4_remote,
+			     &skel->bss->remote_port))
 		goto fail;

 	/* Step 2: Run the send SYSCALL prog */
@@ -157,3 +162,72 @@ void test_ksock_basic(void)
 	ksock_test_env_cleanup(&env);
 	ksock_basic__destroy(skel);
 }
+
+void test_ksock_lsm_recursion(void)
+{
+	struct ksock_test_env env;
+	struct ksock_recursion *skel;
+	char trigger = 'x';
+	int tfd = -1;
+	int err;
+	ssize_t n;
+
+	skel = ksock_recursion__open();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		return;
+
+	err = ksock_recursion__load(skel);
+	if (!ASSERT_OK(err, "skel load")) {
+		ksock_recursion__destroy(skel);
+		return;
+	}
+
+	if (!ksock_test_env_setup(&env, NS_LSM_RECURSION_TEST))
+		goto fail;
+
+	/* Step 1: Run the setup SYSCALL prog to create the ksock */
+	if (!ksock_setup_ctx(skel->progs.ksock_setup,
+			     &skel->bss->ipv4_remote,
+			     &skel->bss->remote_port))
+		goto fail;
+
+	/* Step 2: Attach LSM prog and trigger socket_sendmsg from userspace */
+	skel->links.ksock_socket_sendmsg =
+		bpf_program__attach_lsm(skel->progs.ksock_socket_sendmsg);
+	if (!ASSERT_OK_PTR(skel->links.ksock_socket_sendmsg,
+			   "attach socket_sendmsg lsm"))
+		goto fail;
+
+	tfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+	if (!ASSERT_OK_FD(tfd, "trigger socket"))
+		goto fail;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->trigger_send = 1;
+	n = sendto(tfd, &trigger, sizeof(trigger), 0,
+		   (struct sockaddr *)&env.addr, sizeof(env.addr));
+	skel->bss->target_pid = 0;
+	skel->bss->trigger_send = 0;
+	if (!ASSERT_EQ(n, sizeof(trigger), "trigger sendto"))
+		goto fail;
+
+	/* Step 3: The nested bpf_ksock_send() must hit the recursion guard */
+	if (!ASSERT_EQ(skel->bss->rec_count, 2,
+		       "socket_sendmsg recursion count"))
+		goto fail;
+	if (!ASSERT_EQ(skel->data->rec_kfunc_rets[0], -EBUSY,
+		       "recursive send status"))
+		goto fail;
+	if (!ASSERT_EQ(skel->data->rec_kfunc_rets[1],
+		       sizeof(skel->data->send_data), "outer send bytes"))
+		goto fail;
+
+	ksock_assert_recv(&env, skel->data->send_data,
+			  sizeof(skel->data->send_data));
+
+fail:
+	if (tfd >= 0)
+		close(tfd);
+	ksock_test_env_cleanup(&env);
+	ksock_recursion__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_basic.c b/tools/testing/selftests/bpf/progs/ksock_basic.c
index e8131932d97b..189b0fc15770 100644
--- a/tools/testing/selftests/bpf/progs/ksock_basic.c
+++ b/tools/testing/selftests/bpf/progs/ksock_basic.c
@@ -8,41 +8,10 @@
 #include "bpf_tracing_net.h"
 #include "ksock_common.h"

-__be32 ipv4_remote;
-__u16 remote_port;
-
-char send_data[32] = "hello from bpf ksock";
-
 SEC("syscall")
 int ksock_setup(void *ctx)
 {
-	struct bpf_ksock_create_opts create_opts = {};
-	struct bpf_ksock_addr_opts addr_opts = {};
-	struct bpf_ksock *ks;
-	int err = 0;
-
-	create_opts.family = AF_INET;
-	create_opts.type = SOCK_DGRAM;
-	create_opts.protocol = IPPROTO_UDP;
-
-	ks = bpf_ksock_create(&create_opts, sizeof(create_opts), &err);
-	if (!ks)
-		return err;
-
-	addr_opts.family = AF_INET;
-	addr_opts.port = remote_port;
-	addr_opts.ipv4_addr = ipv4_remote;
-
-	err = bpf_ksock_connect(ks, &addr_opts, sizeof(addr_opts));
-	if (err) {
-		bpf_ksock_release(ks);
-		return err;
-	}
-
-	err = ksock_ctx_insert(ks);
-	if (err && err != -EEXIST)
-		return err;
-	return 0;
+	return do_ksock_setup();
 }

 SEC("syscall")
diff --git a/tools/testing/selftests/bpf/progs/ksock_common.h b/tools/testing/selftests/bpf/progs/ksock_common.h
index 77f30a42be60..dc3eed78fb2f 100644
--- a/tools/testing/selftests/bpf/progs/ksock_common.h
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -59,4 +59,41 @@ static inline int ksock_ctx_insert(struct bpf_ksock *ctx)
 	return 0;
 }

+/* Globals for passing config from userspace */
+__be32 ipv4_remote;
+__u16 remote_port;
+
+char send_data[32] = "hello from bpf ksock";
+
+static inline int do_ksock_setup(void)
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
 #endif /* _KSOCK_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/ksock_recursion.c b/tools/testing/selftests/bpf/progs/ksock_recursion.c
new file mode 100644
index 000000000000..52f5200943e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_recursion.c
@@ -0,0 +1,69 @@
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
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+int target_pid;
+int trigger_send;
+
+unsigned int rec_count;
+int rec_kfunc_rets[] = { -1, -1 };
+
+SEC("syscall")
+int ksock_setup(void *ctx)
+{
+	return do_ksock_setup();
+}
+
+SEC("lsm.s/socket_sendmsg")
+int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
+	     int size, int ret)
+{
+	struct __ksock_ctx_value *v;
+	struct bpf_ksock *ks, *tmp;
+	u32 pid = bpf_get_current_pid_tgid() >> 32;
+	int kfunc_ret;
+
+	if (ret || !trigger_send || pid != target_pid)
+		return ret;
+
+	v = ksock_ctx_value_lookup();
+	if (!v) {
+		kfunc_ret = -ENOENT;
+		goto out;
+	}
+
+	ks = NULL;
+	bpf_rcu_read_lock();
+	tmp = v->ctx;
+	if (tmp)
+		ks = bpf_ksock_acquire(tmp);
+	bpf_rcu_read_unlock();
+
+	if (!ks) {
+		kfunc_ret = -ENOENT;
+		goto out;
+	}
+
+	kfunc_ret = bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+
+out:
+	rec_kfunc_rets[rec_count & 1] = kfunc_ret;
+	__sync_fetch_and_add(&rec_count, 1);
+
+	if (kfunc_ret != -EBUSY)
+		trigger_send = 0;
+
+	return ret;
+}
+
+char __license[] SEC("license") = "GPL";
--
2.34.1

