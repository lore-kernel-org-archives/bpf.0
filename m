Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E504A43B6E0
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330551; cv=none; b=EVi4xe0JvzbmNMAAPC6lGQx9I3Jll25k0UWGuNrMt4HIcApRWFwoQozThdjizJfJHVDT/P8LkERK1JtaSlMj0cqEgV9glqox6hLHunKGXCwy1DX1cH8mYcClg/gH6hnQVwQuzcBolGqZ1PymLetvl7GUhYQGf9aDHIsdHWCz4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330551; c=relaxed/simple;
	bh=Owlv3Pn7iDMp3sRvCF+cHhA3DX9b4neQJiEvYZhmH8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xb3/+EXuOpGVF6j6QReqb4rnQ060qdCXwi7bjI5UnvFVi7/is72qxTepnX9q/sNiIzKy0+thmGuD1jgf+Xz+2jQIA6/VhbVVLcwd2e1sSH9ri/98+nG/wn3kqTsjY3O+NsvKDFn1vyT6xmu6cPc51q9LRHn5UD1A8e0qtAZK6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ7mBZDR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ7mBZDR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493d3135f62so8579715e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783330545; x=1783935345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gnyqqb4vN38TSMYaH8/uoLkD+UAO3YWEF8wR2ROxN5U=;
        b=CZ7mBZDRJFa5dId+Fwqzt39ZboQCQTkNT6LhY7ct6/cfSvSZTBWcDovH4ujWTjHyxf
         +wn0xMpFDtrfG27C019wuigyUMdnrTqKiLouD0FrSpiUrr2AdV1Sgr7eX17WRIW1mIO1
         j+1CzBiRAiW1e8UK2P4aGyu7xFBFLUhza1jIBpu2jcFkxBQbTeXRC/qjJfWs6t9hIQCW
         2y4P/6kxeBbjFt6M+5Atzus3wan3PlGptfjDmrogXG7Qz5nk291mre1YZR8xmOcxPGTb
         vwghztSXpYS94jSu92eJDL5nMY3iOt/tvoKlH8uAqZSl/5VD5AGjQk7vMhtDxyy7n87V
         eY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330545; x=1783935345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gnyqqb4vN38TSMYaH8/uoLkD+UAO3YWEF8wR2ROxN5U=;
        b=C/glC81ILlCh/M98OWOwSLiTSpuQtkr9BX5wzS6kX0jU9v1/xcKWQiD/RJOkfE68++
         G4WkqSFZWXOxNt4CILj7XKqdwAet/myjTd1I4p2zPIazBFojgj18pApbWPTWs4/xHOIf
         0sr8RSP+2N01H9crJbetBD62ev6iLaI2hMpKD70BP2Y/bCuNzCGS3GZfBAg0ca1D3VSx
         Zyc9eFW+EWS9N82LMoNEZ4XIQS1YeK5QCwen8AxR4PSG7wpmKRmHboetaYiyS+HNe6XL
         JCX6dGU/VvTvjS5BHCiTJQY8LlwDpmRQSzmsslyB75QcJQ8aj3sbehYp6V77aM517H0I
         JaFg==
X-Gm-Message-State: AOJu0Yx1AE/kaJFyTPiQp+zIOtGHJeAUhxtup/uvFek15PTv09DwLjEn
	lub2bwd0L21CTslsClkXleohjo/cRgVBDD2Oi7kxIpM3Yso9qWKFpdSxiJb8Oqyx8Llnbw==
X-Gm-Gg: AfdE7ck62xH8j4juFsk3RWLeIjpqpmEt7qADBVhDun5UT2oVoR8/dZ8XklT6ExgWBoP
	xWhVlBhcCRsM9LVx+dfHw9WiUHzLY6F/Ex44U7Js61KOSXz3bsKDlGU85sPrLn7AQolpIHHwbuW
	KXtyj1cSowj6w6pK98m9YNZbKqTPCLi9mZo5frIZ6oW5uOdmC5uUsxvZo7tc6Rb1/h9+mkxseEs
	vAmdjZaLbWx6BO3CWouYeIQbY8lPhu7tkc42MJnRBhuDBlZVpFSma9vyMYP965nY9Tb1+tla3h7
	4Hk74NeN2JPPPSwJ+qgOjHUm0YKgvrmlEE+kao1W4GazDlLM3OnxJ26wn159G4vrMDCIxdUd9wY
	AuTWV/d5YFoe028RMTTRj9v71fkfyrsuZbiV05Ig/Ij+fUU4vXJOPf8sHhaj4fIKHGOtaNA1taM
	li5LZaLIoGCyLAgjT5
X-Received: by 2002:a05:600c:3e8c:b0:493:a5da:e5d2 with SMTP id 5b1f17b1804b1-493d11f8082mr103263855e9.26.1783330545068;
        Mon, 06 Jul 2026 02:35:45 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47aa09608d4sm24282530f8f.25.2026.07.06.02.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:35:44 -0700 (PDT)
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
Subject: [PATCH bpf-next 4/6] selftests/bpf: Add ksock LSM recursion test
Date: Mon,  6 Jul 2026 09:35:23 +0000
Message-Id: <20260706093525.13030-5-mahe.tardy@gmail.com>
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
index 085ddb59067e..8b14fd98d410 100644
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
 	if (!ASSERT_OK_FD(pfd, "ksock_setup fd"))
 		return false;

@@ -140,7 +143,9 @@ void test_ksock_basic(void)
 		goto fail;

 	/* Step 1: Run the setup SYSCALL prog to create ksock */
-	if (!ksock_setup_ctx(skel))
+	if (!ksock_setup_ctx(skel->progs.ksock_setup,
+			     &skel->bss->ipv4_remote,
+			     &skel->bss->remote_port))
 		goto fail;

 	/* Step 2: Run the send SYSCALL prog */
@@ -163,3 +168,72 @@ void test_ksock_basic(void)
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
index 87d92372d28d..7cf64319b901 100644
--- a/tools/testing/selftests/bpf/progs/ksock_common.h
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -70,4 +70,41 @@ static inline int ksock_ctx_insert(struct bpf_ksock *ctx)
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

