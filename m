Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B774BE438
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061162; cv=none; b=G27ZBSAD2lG9jURg+eQxWUDpShdOkBbEtTDBqVbpse2u4VDR/t/RW2TPtF1cDRotHsyrZNK8UnEzgh+mkVsQagsfcrnGNKhNNLs1atP0qMNZG0OpjksZvkmU5lnCl1fZ6FpSJ4palYdT2z57u707h3sd9jAjhTCv7lCye7jb31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061162; c=relaxed/simple;
	bh=k7QDT6NnlB7rWKICRk+7mIO1VS6G9FM7Y7AwTNT4tU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGxPAx4FtS3P8tw1eN/iVrz4PWkF7MBSvhCbdPJQ3PwpfTioLmD5NqGhsn62Z38PPteh307zFMMKi7HsMSAAAtEATm4bJLdZjZ38+I9r9AfiWye/nkPf18ukjUPvnwWgaQcUzcUjE5Zqq2YEeMLjApCVjxJyePQCXgq9dNYcqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laavuJbh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laavuJbh"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so40193615e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792061158; x=1792665958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3MaUR3ahf69j5SB863h/YY4nVIv7Zhjr4nu2XcO6kUo=;
        b=laavuJbhXt4/XYJP/HRB+IumwKysVKF3PVizR63sDjY5rX1AGRTuXWKyLsNhXFRgTO
         CcOF4xVFXWojEXjiMyrzf/3OWnSQfhohbBVRq7D/lNW1o75EO0pD3/lmYRuAmJcxHtMq
         FMV1XqwtU+B6zbEMX8gqy2lm9syvTV4cFN3rCFB+PQpt34EOsr16yaPostEIjs5rMXyT
         KfC4YehN/kaxPooJGPtZ0MkcKuvfXCToVDarPAoQ+wz6bFtFsyI7ciM09m/1tSvnKDJ4
         Vm3J91u8ByQmxANMCl4Log+Ms6FFx3RDOlVliHM+D+04oEm8wCLbwIpcH48e5SlcxIPw
         khbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061158; x=1792665958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3MaUR3ahf69j5SB863h/YY4nVIv7Zhjr4nu2XcO6kUo=;
        b=Fz2Yx62MDZXyI9BaYrEkKOKqI5IQcOy1tYt3BgVtAyCRh3khGHNm1OiNN/HjzX97hB
         KpMNFxxMrRDoYLovhLIwqoglbrcYMmcUiaq4tZajxzAKudMxp7ht3kKZaJptjmS6q3z2
         EaepSo9++jQ+U/SvRrvAWzFrqsqT3SroZKqDn56lI9NiV3SnBme3fwnPtH3+yopn+yI+
         02Ixr5z+fU4nf19er34a0skgEG0U3nX3+fm3AVYD87BZuyRDDA0UbQJ+sMCwOmO/miky
         5Q0+DiwIC61g/QkrrjE+trgrQzserp/Dl7RIcCPQHGJtkDtppegDf66S8igZY2lp52VJ
         WtiQ==
X-Gm-Message-State: AFq9FYKXSuO5jvt1VUHqnCnEFaUdYa0TJ8WOfDTICkT6WL72+1pH2JBB
	96V097VNp4wa/6MCyeCeRWYc95RYAQh7pkQZkNLHBdYRiBPEnMJwvZyPE8K7Z+tQS68=
X-Gm-Gg: AYBFou3w1TF7/mk1so+mk57z36rvzn/PzEGmJiW8r6nya42go9Ft5At9afJiF8gVAQd
	e7tyTGkH1ym1STOaSXTxiHW1vWaLtTHuoegPS4OG5oqZ0WEjs3H8XXK/DdkKh+CY+m3szN/2RDX
	uQra0/2aoe0iSi7BYDXlk1l1iCdOEtONv0Bvfcj1568np1VVNEN+awU/X8HOS6pPj0/g6qwt3Hp
	LXP7HJ6Es/hDG1JvD1PfUNvokkaNTVKUlx9lLgoIdEfYnUcJDwgNwxzbGVSssMH/t0zFWOVVlRx
	3W6XMib2dJu44oB9vI56CnqKrUaXfagCIXZ97af/lWw2pvD6QTQjqZ6p7+Wx0xwLMHadI9UgrsA
	iIfaFbVHY8/dY/j+Vh1HKzKeCNvEaiob7YOBlBOP3ILic4mrZWcRepVTkxtJClHNbC3T0v1mHqY
	tct4TOn8aleDcEXOH1Bc54y4UK+yS2Q965r3tl0aQoeobhCRtsgVDFKIzcDWoevjWFkADIjsLVQ
	44VB1e1/QZhayoF8iQObzgR6hfTdvGC1MZeinm5gUSKfQ==
X-Received: by 2002:a05:600c:4688:b0:4a1:7d3d:10a4 with SMTP id 5b1f17b1804b1-4a18e49c3dbmr379950675e9.17.1792061157503;
        Thu, 15 Oct 2026 03:45:57 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1bd98690asm63066645e9.9.2026.10.15.03.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:45:56 -0700 (PDT)
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
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v5] bpf: allow ksock connect/send calls from wq
Date: Thu, 15 Oct 2026 10:45:53 +0000
Message-ID: <20261015104553.17509-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial ksock implementation, commit 7ae4eb14c5f9 ("bpf: Add ksock
kfuncs"), kept LSM checks from the kfunc calls and disallowed
asynchronous workqueues because worker credentials differ from those of
the triggering task. However, discussions at Plumbers 2026[^1] revealed
that bypassing LSM checks for BPF-created sockets could be acceptable.

This patch allows workqueue use while retaining LSM checks for now,
paving the way to call bpf_ksock_connect() and bpf_ksock_send() from
non-sleepable programs, such as tracing programs, in future patches.

Also adapt test_ksock_wq() added in 'c93cbdb13f99 ("selftests/bpf: Add
ksock test for async callback guard")' to test that the connect() and
send() kfuncs are now allowed and work when called from workqueues.

Note that bpf_ksock_create() still checks:
* for current to not be a kernel thread (thus excluding bpf workqueue
  callbacks) because the socket is created within a userspace task
  network namespace. It should, most of the time, be the process that
  triggered the SYSCALL program, but could be another task when called
  from bpf_task_work callbacks.
* for current->nsproxy to be non-NULL since when called from a
  bpf_task_work callback and the task is in the do_exit() phase, nsproxy
  is torn down just before the remaining task work is executed.

[^1]: https://lpc.events/event/20/contributions/2430/

Tested-by: Alan Maguire (Oracle) <almagui@kernel.org>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c                          | 24 +-----
 .../selftests/bpf/prog_tests/ksock_wq.c       | 29 +++++--
 tools/testing/selftests/bpf/progs/ksock_wq.c  | 77 +++++++++++++++----
 3 files changed, 92 insertions(+), 38 deletions(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index e9943aeeadd3..7bf796193ab6 100644
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
@@ -74,11 +65,10 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
 	int err;

 	/*
-	 * sock_create() derives the network namespace, credentials, and cgroup
-	 * from current. Kernel threads, including BPF workqueue callbacks, do
-	 * not carry the context of the task that invoked the BPF program.
+	 * sock_create() derives the network namespace from current and task
+	 * work can run from do_exit() after exit_nsproxy_namespaces()
 	 */
-	if (!bpf_ksock_has_user_task_context()) {
+	if ((current->flags & PF_KTHREAD) || !current->nsproxy) {
 		err = -EOPNOTSUPP;
 		goto err_out;
 	}
@@ -165,9 +155,6 @@ __bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
 	struct sockaddr_storage sa;
 	int addrlen;

-	if (!bpf_ksock_has_user_task_context())
-		return -EOPNOTSUPP;
-
 	if (!addr || addr__sz != sizeof(*addr))
 		return -EINVAL;

@@ -247,9 +234,6 @@ __bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
 	};
 	int ret;

-	if (!bpf_ksock_has_user_task_context())
-		return -EOPNOTSUPP;
-
 	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);

 	return ret;
diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
index d6dc20b8f95b..12c2275e8177 100644
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
+	ASSERT_EQ(skel->bss->create_ret, -EOPNOTSUPP, "workqueue create rejected");
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

