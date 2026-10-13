Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE01517BA2
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916054; cv=none; b=KPiNpGRdQDSJsLGslbMf4wlemTKekA4vFS1ttaVfoE50WZk/dKsFalHBMHf3Gaon1rl6NxZ/6wN713Xxd2SoNg4l8VA4Cj9er0NyWxkeTJbXnJ5v9ypXe/hOPx+dp1kFyii9wU2FF6GJ0fBDDIF9LrrDZZFsYoxU2B7//Vi7hiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916054; c=relaxed/simple;
	bh=KgfLtkjemoJDRzRz79tgx72By9fLqPq7ZnG/aHJCE6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hjyxvf/IYo5yvSWWkn/wJIKUZZf5ckw0I6mgTMs5sVUw0BjbWDcINiRnDMPESoEt246xQKNKW8x0tSg9MDaHypOe3GMBcAwySKXlq3hKCOIsPdY4iZhl2OoXnaLf2p+m3HDreeMz9h92g0s+BDFmOtkqWuvdgE6C16OYQ8Vd8Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mek/oxSs; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mek/oxSs"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b02b1b4cfso3429775f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791916050; x=1792520850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=El7V+Nu/0GblZkWD/bQdXseCG+PWhlkrTXZyM5KkrnQ=;
        b=mek/oxSsIWYwYRqDFeEf+B9A+RrhbrRRcpFEzlFnbCwUWncDAhxZv48ftvitJ67BMS
         Ti+bPX8oQixzpvGxDjtmWXE40knyISuJYoBEuIp9CM1H4pWL9kxZfvy8OX+C6hedABbf
         1jBxbz+gA//vNltyMwOuvYfvq05Wavz2dDYriVy5xOxNwsrBDiDB/uO0HGMkDvv2gKXI
         BYztNEHgSt38UB6wQmi1opP2tPvM/OiDj0yvJZdDcxPAMvgPksWi/BMbfoTKOCj85iAS
         rR9zfXjtqAJttlc+BSnWF/3UIqritThaOf/CPLP2NiED6eN//xf/ScEtHs2eIr0mlq+H
         S3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791916050; x=1792520850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=El7V+Nu/0GblZkWD/bQdXseCG+PWhlkrTXZyM5KkrnQ=;
        b=F6LQCjvf4BTs8qE4C92h3C1+XIMIRYngPvbTIpwrbon3SplAZ5T5vBx9And6EITKP1
         txZ6CWJEVFybNwbgvrR5GRJKEOuqJC+7Dznkokd+3ucRMafQ1XsV7UEZuekm/4v++Ry3
         QNIRUfR54eh+/4S5eFlxopKhvILyzGct+RIjdcJ8Ge3VuoUX7YEsrk6liX90TmmFaEui
         aXeMsCsv+np2of+SwILfmBqruC6z4aOa2Jtc/5cyKIv6BrQElitGvvgHn6whd8uZAP+k
         0Kk34Jn+X0NsLQ37RAil4kOrDjmE0IqIVg6ihX2ylHLeEVF0DLyzkLkJqbfcilW2MS3y
         bG6Q==
X-Gm-Message-State: AFq9FYJSv9xYcHkDFMGAp59Ys98gqisVtXjzZMkhQG1sNJaUu56caBLi
	jrSVA8EML0PATHhhkBmWyMizElpSsR/HhRIXbCMxbJd0drvyItmMdbuBif0R1lj6d9XSYQ==
X-Gm-Gg: AYBFou3JWH8UBYCQLCzSI4B+ZI/UCC+nFZXDclrygypHeiyz+liB4rsQ7m/jVpG8g6A
	h193OVfixkqjNnf7up+V4OGrrcKHlinnUuPu1AvQdsBTo88Acf7yk1qUMzNXznjbqHXLEFQ3clu
	fG8bEkIDuPozZIAk24/gWnAH5EtyYV9/s8j4OIRFJDifPT5c8MqPMfyIEDMKT4G5jL5kiKmc88q
	G2sw4L6VYgQ6zflpzwVAXOsl8MWzVYzmioRVAobWovnd9+YzyV/VSw1HXnON2IB6dCiJWfzhbN9
	e5XsIpOi7/tp06ZpQfOmrToauQ139OgMi6I0YthEyvR3RO+WYVLjaxh0b6g4chtihtYgJf4A3ep
	kEjPAqT30+gyafeQG7GDOz295naEFP/HDwdonLSOrXR+c/qLf5fpfEpdAbRF5TI6+BpXUb76pIY
	QJXw9Pe5CR6zOuyxKEFlFHYE9Sfz+KaTop7uINdxRaIGFObE8VNXbAup7hS3mUVLIMU4fuY2+N1
	xA73B05axPS4hoyr18+wgtm7PV7AB1FfYA18561Qznbfg==
X-Received: by 2002:a05:600c:5254:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a18e4aa11dmr275071405e9.16.1791916049899;
        Tue, 13 Oct 2026 11:27:29 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a195002123sm395882095e9.1.2026.10.13.11.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:27:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v2] bpf: allow ksock connect/send calls from wq
Date: Tue, 13 Oct 2026 18:27:26 +0000
Message-ID: <20261013182726.276372-1-mahe.tardy@gmail.com>
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
v1: https://lore.kernel.org/bpf/20261013163101.205638-1-mahe.tardy@gmail.com/

 net/core/bpf_ksock.c                          | 27 +------
 .../selftests/bpf/prog_tests/ksock_wq.c       | 29 +++++--
 tools/testing/selftests/bpf/progs/ksock_wq.c  | 76 +++++++++++++++----
 3 files changed, 91 insertions(+), 41 deletions(-)

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
index 16a1873d132e..290736e219e1 100644
--- a/tools/testing/selftests/bpf/progs/ksock_wq.c
+++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 Isovalent */

 #include "vmlinux.h"
+#include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_experimental.h"
 #include "bpf_tracing_net.h"
@@ -14,15 +15,19 @@ struct ksock_wq_value {

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
@@ -35,7 +40,32 @@ static int ksock_wq_callback(void *map, int *key, void *value)
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
@@ -43,20 +73,40 @@ static int ksock_wq_callback(void *map, int *key, void *value)
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
+	struct bpf_ksock *ks;
+	u64 key = 0;
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

