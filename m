Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE144E04A
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971878; cv=none; b=D45RM3yyJ6JDvngLaNFWyR15u04aaGD80rDvA5NlV6f9H6n76w9vd3jeT7RN1N9GYCH4ij2S3vgoXG/Qu69ncfc4h7l/8G5KI0XMgF0OXB4EIwxLfYqzQ3XyXXxDUCe5r1DclfV9K+tWQ5EFWBg1L3OldTREaokcYTJEKMuAECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971878; c=relaxed/simple;
	bh=V8tm/yPwj2YfH8yitEElP9S7tiU4qwIG0oriSlLL44w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L21pjx9K5O6rGsyHjiQnl60ct2oqjwG8MZWTGxFNE4yknnZqeEALI3sTqiojeamu0sfKNSfqC101WFRsnATEOMZlq1zrDyCf7sXwTxXccj1r7/MS3jf+9KufddZEAAekobOIYbrBZhEVXyedl5XMnG3+oyyHW0deK5viHrEId8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ec2N/78S; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec2N/78S"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c45111bebso2345896f8f.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791971874; x=1792576674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ACPPyK0+gqe+ycEjjJs2TTLvtTPVz+VEJs6WV9i3hg0=;
        b=ec2N/78Sq6U7DEjMXWnTBBla2qEiGNPeea/LE0/J5MMmwX6yBI/UbOfmNYtQFCbXhZ
         tXkbIKiIwdp58u9CWhJn5XIRdAiwDnr9ZHxmt8oOWvfMZeN24jgAwC6WRss8CjDBcwXA
         ji6NfV9pPt/EnswjJBqEs/KsoIJ7cbmJjTYjpy6nfzcAvvZQdo2Vcu7RW1AQQ1KK4Pd9
         6SnT7Uh5SQKIP/f2b0HAFCL38l4rRYRWOpVJnnEK11AbSgtrC8gP6ie3aVPCkmJXcOTN
         6nk+OsUjhkaSLL+hW1RNGWubuQEXK4MolxoO8OZOqvnyjkU0qqtd8eltQJmZ1Vgs23oY
         g9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971874; x=1792576674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACPPyK0+gqe+ycEjjJs2TTLvtTPVz+VEJs6WV9i3hg0=;
        b=J0KsvCK2djCaCrGVUa6emZpclRO6YJcPO6ZRzHYKy/lQ0mnzTi8FsM8sLhl01MLV7s
         T4WJqMYnt+RakdeQEPcE9ePglMvWxip50+JHL7AVFt53lvyRty0MZHXVEkn3lYQKztN9
         sqO6nf9Qhj13ZRXMNH4s2BHNLl1P1cK+QvX5sVpXi0xVYGCEZ/V7/1MHMqzKJlJSLLGx
         C0p95bAQ6gdmnxwG1RNOaQHklQGXfDYfqLhMXa7MqQSTHTJvlg5T5wEmUCxzcbxBmY+9
         IzBwcHvS9yGNrerfAByLnVjd1im21ZECg63nObw0n1KFegIJvZZK9D7g4qUUIuYdPeaI
         dFyA==
X-Gm-Message-State: AFq9FYKEdn1gGGvnkT23T7826i2rTujGPO17otCcqvDeVABtc/Y5KUls
	9EIApvx99+ETNzBsMXobzouCzk+s01FALstjeQ3R906AF3SDpsat2a1F0MX10Wekc3N4tQ==
X-Gm-Gg: AYBFou23/zcMQcInwzuMqg1kBZbNwYgA7z9ebYnXee3wUnpfHINdbTacVZc6z7OvDqi
	qzbbiEFBDwzvnSFnslOzNL11OYbfnBvYvUpa24geogpdN90rcI9lJWCoN7ZnCmmjrFZ2GL6SbAq
	HFz9uPyojCSxXZNGdGqAE/PcOCdXarKr+4RZ5g31QYUMXqI4ly8pLpyNU4ylbhTcOmC7DsGNMgH
	UiJh5XD37pfO14fgK1DHsZW5/yKs6QZ2obpPniTzQarHSoHlzTrmPTy2z5H2ykjs6VwaoGmAypo
	UfV8M0VEEBfYL3FYN2hkLSdDZZT9vRa5k7hrYKCLcj2667lQ6fywx4apQhR8JLQghZqwnXZ2CwI
	KSVxNW1/selYZ8AIMNLqYvaNe8oNKXdsm7hVwV6ZtVUa9vtlkMH80U2aQVHvSNhgzkWdCNMkd+H
	tsyjIVb2ll/QPf/Bu8aWDMc59pWNYPG5LgvfNV2EXBK2LIgtbPLzpWRWciybxoheCbhrB9aCA9D
	ndsOhA9HNPXfqqaAqbZffE+R510JVqXZp2w22BF+Xvso0tXW20b58L3
X-Received: by 2002:a05:6000:184e:b0:48b:174:eab1 with SMTP id ffacd0b85a97d-48dbaceb3f2mr26874342f8f.36.1791971874377;
        Wed, 14 Oct 2026 02:57:54 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48de77b35b5sm4162746f8f.21.2026.10.14.02.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:57:53 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
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
	alan.maguire@oracle.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v4] bpf: allow ksock connect/send calls from wq
Date: Wed, 14 Oct 2026 09:57:43 +0000
Message-ID: <20261014095743.35891-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the initial implementation in '7ae4eb14c5f9 ("bpf: Add ksock
kfuncs")', it was decided to let the ksock kfuncs go through the LSM
hooks instead of by-passing them, and thus to disallow the use of the
kfuncs from asynchronous workqueues as the credentials would be
different than the task context that triggered the kfuncs.

After some discussions, in particular at Plumbers 2026 at the
presentation introducing this new ksock API[^1], it was agreed that
by-passing the LSM from socket created by BPF programs should be okay
and thus that the process context switch from kthread executing the
workqueues wouldn't be an issue.

For now, the ksock kfuncs still trigger the LSM hooks but we relax the
constraint on not using the workqueues as it will be useful for users
triggering connect() or send() from non-sleepable programs (like
tracing, support will be extended in future patches).

Also adapt test_ksock_wq() added in 'c93cbdb13f99 ("selftests/bpf: Add
ksock test for async callback guard")' to test that the connect() and
send() kfuncs are now allowed and work when called from workqueues.

Note that bpf_ksock_create() still checks for workqueue context
execution and makes sure the current->nsproxy is defined as we rely on
the network namespace to be defined (could be NULL in the case do_exit()
was called on the task before the wq was scheduled) and to be the one
from the task that triggered the SYSCALL bpf prog.

[^1]: https://lpc.events/event/20/contributions/2430/

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
I resent v2 as v3 instead of this fix by mistake, ignore v3.
v3: https://lore.kernel.org/bpf/20261014091450.19107-1-mahe.tardy@gmail.com/

 net/core/bpf_ksock.c                          | 27 +------
 .../selftests/bpf/prog_tests/ksock_wq.c       | 29 +++++--
 tools/testing/selftests/bpf/progs/ksock_wq.c  | 77 +++++++++++++++----
 3 files changed, 92 insertions(+), 41 deletions(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index e9943aeeadd3..f74968397798 100644
--- a/net/core/bpf_ksock.c
+++ b/net/core/bpf_ksock.c
@@ -37,15 +37,6 @@ static void ksock_release_work_fn(struct work_struct *work)
 	kfree(ks);
 }

-static bool bpf_ksock_has_user_task_context(void)
-{
-	/*
-	 * Task work can run from do_exit() after exit_nsproxy_namespaces()
-	 * cleared current->nsproxy, while current is still not a kthread.
-	 */
-	return !(current->flags & PF_KTHREAD) && current->nsproxy;
-}
-
 __bpf_kfunc_start_defs();

 /**
@@ -59,7 +50,7 @@ __bpf_kfunc_start_defs();
  * This function may sleep (sock_create), so it can only be used
  * in sleepable BPF programs (SYSCALL).
  * It cannot be called from a BPF workqueue callback because that callback
- * does not retain the invoking task's namespace or security context.
+ * does not retain the invoking task's namespace.
  *
  * @opts:	Pointer to struct bpf_ksock_create_opts with socket parameters.
  * @opts__sz:	Size of the opts struct.
@@ -73,13 +64,9 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
 	struct bpf_ksock *ks;
 	int err;

-	/*
-	 * sock_create() derives the network namespace, credentials, and cgroup
-	 * from current. Kernel threads, including BPF workqueue callbacks, do
-	 * not carry the context of the task that invoked the BPF program.
-	 */
-	if (!bpf_ksock_has_user_task_context()) {
-		err = -EOPNOTSUPP;
+	/* sock_create() derives the network namespace from current. */
+	if ((current->flags & PF_KTHREAD) || !current->nsproxy) {
+		err = -EPERM;
 		goto err_out;
 	}

@@ -165,9 +152,6 @@ __bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
 	struct sockaddr_storage sa;
 	int addrlen;

-	if (!bpf_ksock_has_user_task_context())
-		return -EOPNOTSUPP;
-
 	if (!addr || addr__sz != sizeof(*addr))
 		return -EINVAL;

@@ -247,9 +231,6 @@ __bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
 	};
 	int ret;

-	if (!bpf_ksock_has_user_task_context())
-		return -EOPNOTSUPP;
-
 	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);

 	return ret;
diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
index d6dc20b8f95b..cb50f9a1be2e 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
@@ -4,6 +4,7 @@
 #include <unistd.h>

 #include "test_progs.h"
+#include "network_helpers.h"
 #include "ksock_wq.skel.h"

 #define CALLBACK_WAIT_RETRIES 1000
@@ -13,13 +14,22 @@ void test_ksock_wq(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	struct ksock_wq *skel;
+	char recv_data[sizeof(skel->data->send_data)];
 	u32 callback_done;
-	int err, i;
+	int err, i, port, rfd;

 	skel = ksock_wq__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "ksock_wq open and load"))
 		return;

+	rfd = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 1000);
+	if (!ASSERT_OK_FD(rfd, "receiver socket"))
+		goto out;
+	port = get_socket_local_port(rfd);
+	if (!ASSERT_GE(port, 0, "receiver port"))
+		goto out;
+	skel->bss->remote_port = port;
+
 	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_wq_start),
 				     &opts);
 	if (!ASSERT_OK(err, "run ksock_wq_start"))
@@ -28,18 +38,27 @@ void test_ksock_wq(void)
 		goto out;

 	for (i = 0; i < CALLBACK_WAIT_RETRIES; i++) {
-		if (__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE))
+		if (__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE) == 2)
 			break;
 		usleep(CALLBACK_WAIT_US);
 	}
 	callback_done = __atomic_load_n(&skel->bss->callback_done,
 					__ATOMIC_ACQUIRE);
-	if (!ASSERT_EQ(callback_done, 1, "workqueue callback completed"))
+	if (!ASSERT_EQ(callback_done, 2, "workqueue callbacks completed"))
 		goto out;

-	ASSERT_EQ(skel->bss->create_err, -EOPNOTSUPP,
-		  "workqueue create rejected");
+	ASSERT_EQ(skel->bss->create_ret, -EPERM, "workqueue create rejected");
+
+	if (!ASSERT_EQ(skel->bss->connect_send_ret, sizeof(recv_data),
+		       "workqueue send bytes"))
+		goto out;
+	err = recv(rfd, recv_data, sizeof(recv_data), 0);
+	if (ASSERT_EQ(err, sizeof(recv_data), "recv len"))
+		ASSERT_MEMEQ(recv_data, skel->data->send_data, sizeof(recv_data),
+			     "payload match");

 out:
+	if (rfd >= 0)
+		close(rfd);
 	ksock_wq__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing/selftests/bpf/progs/ksock_wq.c
index 16a1873d132e..6ec6103e2518 100644
--- a/tools/testing/selftests/bpf/progs/ksock_wq.c
+++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
@@ -2,9 +2,11 @@
 /* Copyright (c) 2026 Isovalent */

 #include "vmlinux.h"
+#include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_experimental.h"
 #include "bpf_tracing_net.h"
+#include "bpf_misc.h"
 #include "errno.h"
 #include "ksock_common.h"

@@ -14,15 +16,19 @@ struct ksock_wq_value {

 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
+	__uint(max_entries, 2);
 	__type(key, u32);
 	__type(value, struct ksock_wq_value);
 } work_map SEC(".maps");

-int create_err;
+char send_data[] = "hello from bpf workqueue";
+
+__be16 remote_port;
+int connect_send_ret;
+int create_ret;
 u32 callback_done;

-static int ksock_wq_callback(void *map, int *key, void *value)
+static int ksock_wq_create(void *map, int *key, void *value)
 {
 	struct bpf_ksock_create_opts opts = {
 		.family = AF_INET,
@@ -35,7 +41,32 @@ static int ksock_wq_callback(void *map, int *key, void *value)
 	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
 	if (ks)
 		bpf_ksock_release(ks);
-	create_err = err;
+	create_ret = err;
+	__sync_fetch_and_add(&callback_done, 1);
+	return 0;
+}
+
+static int ksock_wq_connect_send(void *map, int *key, void *value)
+{
+	union bpf_ksock_addr addr = {
+		.sin = {
+			.sin_family = AF_INET,
+			.sin_port = remote_port,
+			.sin_addr.s_addr = bpf_htonl(0x7f000001),
+		},
+	};
+	struct bpf_ksock *ks;
+	int err = -ENOENT;
+
+	ks = ksock_ctx_get();
+	if (!ks)
+		goto out;
+	err = bpf_ksock_connect(ks, &addr, sizeof(addr));
+	if (!err)
+		err = bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+out:
+	connect_send_ret = err;
 	__sync_fetch_and_add(&callback_done, 1);
 	return 0;
 }
@@ -43,20 +74,40 @@ static int ksock_wq_callback(void *map, int *key, void *value)
 SEC("syscall")
 int ksock_wq_start(void *ctx)
 {
+	struct bpf_ksock_create_opts opts = {
+		.family = AF_INET,
+		.type = SOCK_DGRAM,
+		.protocol = IPPROTO_UDP,
+	};
 	struct ksock_wq_value *value;
-	u32 key = 0;
-	int err;
+	u32 key __aligned(8) = 0;
+	struct bpf_ksock *ks;
+	int err = 0;

-	value = bpf_map_lookup_elem(&work_map, &key);
-	if (!value)
-		return -ENOENT;
-	err = bpf_wq_init(&value->work, &work_map, 0);
-	if (err)
+	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
+	if (!ks)
 		return err;
-	err = bpf_wq_set_callback(&value->work, ksock_wq_callback, 0);
+	err = ksock_ctx_insert(ks);
 	if (err)
 		return err;
-	return bpf_wq_start(&value->work, 0);
+	for (key = 0; key < 2; key++) {
+		value = bpf_map_lookup_elem(&work_map, &key);
+		if (!value)
+			return -ENOENT;
+		err = bpf_wq_init(&value->work, &work_map, 0);
+		if (err)
+			return err;
+		if (key)
+			err = bpf_wq_set_callback(&value->work, ksock_wq_create, 0);
+		else
+			err = bpf_wq_set_callback(&value->work, ksock_wq_connect_send, 0);
+		if (err)
+			return err;
+		err = bpf_wq_start(&value->work, 0);
+		if (err)
+			return err;
+	}
+	return 0;
 }

 char __license[] SEC("license") = "GPL";
--
2.43.0

