Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E1E3C3449
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909084; cv=none; b=ULrL33e4yZ6mU0BA8UcQVWQFTcW4Vnqy2JMZbEwo6J/RI2pW8hCnVxfkY2jIFyR2XQgJzYLteKwnG32+DeJPKjw6cItjRZ6Jyvc8UJTo+IP/dmf5wVDuHCQAeczsipXyndXfkTmo2gG1TA8gRaPumqjM46r1wLb3pTUD1wvMB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909084; c=relaxed/simple;
	bh=oAX3A44Mk4sRd4MJWUHQrnEmkYfaoUhDnCFfhk2S3H8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSW59BDUICNyqoxc3rwQoHcMrWNdEwBC5KxsgeV5/puMR/wJhPFYdhR8ewWMCrqNWjEYAAYT/UCuV07ju+ci3hoTdyWu7Lz0ceE/b4X6xf8h6Cqsl3d2ufW/4VNDf/oL+y3+A52gzIOdTdinwrDpjCJe1oNthcrrnWmHbycD1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YabNtB4r; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YabNtB4r"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so19789825e9.2
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791909081; x=1792513881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+eviUeF31yAbmG9I9BhDWC16fJ5//H+HFd2nuFsGCTA=;
        b=YabNtB4rKp7Obs6XaOY99orlk1PDh7jtlDQwiSAwwPn488c3yY7x6Breuie8g9y/gd
         NU7KWnu+0or4PWdyWeiKrqmtFO+yMw8bHZsg9Yh43Ftz1cF29bPtgTEWLXhxOgw/wmu+
         DbLC27bgnygKHplSLd16goUTmK6lf2KzPfcs+oVolFrXBkIuwz+rrkAl+hat7tZyGrWn
         kp8Vp5SczW8f8ubV/jPYr/QWmF63sFUOOd1fUOtC/u2VrtAS98jzB3n7Pr+SSXJtFtDj
         bRFYLLONvRDkGomjXrLHIGBHBWwf6j3p5AU1xBf+UsAIr9xjRHmiuhhxK4c+AEUL19lV
         FwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909081; x=1792513881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+eviUeF31yAbmG9I9BhDWC16fJ5//H+HFd2nuFsGCTA=;
        b=1t/Zjl2f7L/tyJmzDJgwCwI+Vi9ChrLz4gAnL/wMVUU/TWjcJyCRgs6ujw6cOVYWsb
         48F34QqdXGWuO5o82/EVS6DbBMPUZZU1IqSIo0hdYdvCWHGJwrmIHC/3WQ+7aRB35+Iq
         IMniGb7xrnxoAx4jlDiENM0cTE1ofECA4zSSE+PUwr0uLSJ8TABcBLKrLeJTwnTb1JJ4
         Vuj1Zz/Pnc0foCmZXwmk92xcHWxQHUVOb8HoZGvJxM0nahgxQCmW2I3L17OIHQ2toCrx
         UW1da131hr4+py78XdvKnvNh58b8RBzdDaEFRyZlXgF1NmJcPtCkZM8cnzySX7wxxFV5
         X1sw==
X-Gm-Message-State: AFq9FYKhKggxme+Y9lLy64yVvJQ1RF5uU55RyNhMQWRXZ/4cEVT8jJBw
	pFJnZMoCj1e1jAHTVfb32+05KiS8gMJwjhCeuhjU7uA10iEWiBLYJPFOr7xWcmT3gNaDjQ==
X-Gm-Gg: AYBFou2htQO/eJ5hEV0xupIg1CB0fZDWvYXQaYj6i6rU0VNZN4Fph+iCJ1hHrzIr/cv
	7CazKwBB4dDxdfgkBydquHfONSYi6lw604FvAD1/2HseV9iFVYw7GMNTr7Z40Qg75ec4xL+8XHK
	B9iP8j0fD58cOuCHPJUu57FMFR5zKegO2/7Q1TWb7Mzr9zsrLyR7cUlb+KOHzZjOcGJ9pMmKuQr
	H29V6HD+a+2oDHy2+LnCWGSY71KUauAbDolrlsqPHE6ElGal9gE6EiaWjHb/Xe/65w7WgjVt99W
	4sw/V660NNeHgH+s7I0m1vfwlmQWRDnRBVNs/tW5X5QpJHeMY8psmhTE8CLFBg4GLB79djv2psD
	ohJdaCwMmvo71NV1nfM2Gon71INjqvVhoeOO4Bg2IBXMiaYfOxlXG2UVeL7fR4/+ay/v+05WGFY
	DzuO7mL0GbtMJee/20DxT/oXxEY1v+hvxtfsBHvOxQ1T3VY+Ckn10YDMoezgJ9aC6c/bVp+iMQX
	1LrFI7E5RiomNlMndaEX9UQyhR1QMmJVI1HRmILasmyERqw8yzTSq4i
X-Received: by 2002:a05:600c:8b64:b0:4a1:7703:e537 with SMTP id 5b1f17b1804b1-4a18e49302emr255108875e9.10.1791909081300;
        Tue, 13 Oct 2026 09:31:21 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a18bf135fasm330250915e9.5.2026.10.13.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:31:19 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next] bpf: allow ksock kfuncs call from wq
Date: Tue, 13 Oct 2026 16:31:01 +0000
Message-ID: <20261013163101.205638-1-mahe.tardy@gmail.com>
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
workqueues wouldn't be an issue. Note also that in some BPF prog
execution context in which we could extend the ksock kfuncs, like
networking executing via softirq, the current task might be some
unrelated kernel thread.

For now, the ksock kfuncs still trigger the LSM hooks but we relax the
constraint on not using the workqueues as it will be useful for users
triggering send() from non-sleepable programs (like tracing, support
will be extended in future patches).

Also adapt test_ksock_wq() added in 'c93cbdb13f99 ("selftests/bpf: Add
ksock test for async callback guard")' to test that the kfuncs are now
allowed and work when called from workqueues.

[^1]: https://lpc.events/event/20/contributions/2430/

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/bpf_ksock.c                          | 25 -------------------
 .../selftests/bpf/prog_tests/ksock_wq.c       | 23 ++++++++++++++---
 tools/testing/selftests/bpf/progs/ksock_wq.c  | 24 +++++++++++++++---
 3 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
index e9943aeeadd3..21d5fd1eb403 100644
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
@@ -73,16 +64,6 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
 	struct bpf_ksock *ks;
 	int err;

-	/*
-	 * sock_create() derives the network namespace, credentials, and cgroup
-	 * from current. Kernel threads, including BPF workqueue callbacks, do
-	 * not carry the context of the task that invoked the BPF program.
-	 */
-	if (!bpf_ksock_has_user_task_context()) {
-		err = -EOPNOTSUPP;
-		goto err_out;
-	}
-
 	if (!opts || opts__sz != sizeof(struct bpf_ksock_create_opts)) {
 		err = -EINVAL;
 		goto err_out;
@@ -165,9 +146,6 @@ __bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
 	struct sockaddr_storage sa;
 	int addrlen;

-	if (!bpf_ksock_has_user_task_context())
-		return -EOPNOTSUPP;
-
 	if (!addr || addr__sz != sizeof(*addr))
 		return -EINVAL;

@@ -247,9 +225,6 @@ __bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
 	};
 	int ret;

-	if (!bpf_ksock_has_user_task_context())
-		return -EOPNOTSUPP;
-
 	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);

 	return ret;
diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
index d6dc20b8f95b..708e42abc57e 100644
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
@@ -37,9 +47,16 @@ void test_ksock_wq(void)
 	if (!ASSERT_EQ(callback_done, 1, "workqueue callback completed"))
 		goto out;

-	ASSERT_EQ(skel->bss->create_err, -EOPNOTSUPP,
-		  "workqueue create rejected");
+	if (!ASSERT_EQ(skel->bss->callback_ret, sizeof(recv_data),
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
index 16a1873d132e..0633ae048518 100644
--- a/tools/testing/selftests/bpf/progs/ksock_wq.c
+++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 Isovalent */

 #include "vmlinux.h"
+#include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_experimental.h"
 #include "bpf_tracing_net.h"
@@ -19,7 +20,10 @@ struct {
 	__type(value, struct ksock_wq_value);
 } work_map SEC(".maps");

-int create_err;
+char send_data[] = "hello from bpf workqueue";
+
+__be16 remote_port;
+int callback_ret;
 u32 callback_done;

 static int ksock_wq_callback(void *map, int *key, void *value)
@@ -29,13 +33,25 @@ static int ksock_wq_callback(void *map, int *key, void *value)
 		.type = SOCK_DGRAM,
 		.protocol = IPPROTO_UDP,
 	};
+	union bpf_ksock_addr addr = {
+		.sin = {
+			.sin_family = AF_INET,
+			.sin_port = remote_port,
+			.sin_addr.s_addr = bpf_htonl(0x7f000001),
+		},
+	};
 	struct bpf_ksock *ks;
 	int err = 0;

 	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
-	if (ks)
-		bpf_ksock_release(ks);
-	create_err = err;
+	if (!ks)
+		goto out;
+	err = bpf_ksock_connect(ks, &addr, sizeof(addr));
+	if (!err)
+		err = bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+out:
+	callback_ret = err;
 	__sync_fetch_and_add(&callback_done, 1);
 	return 0;
 }
--
2.43.0

