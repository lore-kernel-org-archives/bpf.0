Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126930567B
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969309; cv=none; b=Mk4umibABxdyAaz2Ovl7J1m74rxI4XlpKtii/mDt1vmftKxqFI45E8M5nLEV7nf06JYmpvIWD3wQvJqXaD/hXL18LIOgRCRxJ/MS86z4XmJCYMUX5zgiSDc8jZgEKiQ7ZnSJjcXaBwELcS0RrwC0/4zDw9TsdhR9b6WKofwSJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969309; c=relaxed/simple;
	bh=n/9RWL+fef8SAhMiLYWfXVdWkCY58HAIxy22NsSosKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjye7cLkVe+3ENbNx70xE2DLIn6U6pXikA5Fy2fLqvIyY+/07G0gXtPdUeWn0ODh+2kpEKg0VUkdiRWdM4zU2qynEsX5dPviaKc1n0vjYplvSUoXJVvu6Rrg2sMnLIhld1DeXZDWDwfyj3gAy3QReACyI5o745or+bZlxawyBUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/kuUkk4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/kuUkk4"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48870973bddso2298948f8f.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791969299; x=1792574099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lGzMW0CtEG0NM6Y2SKTe2qhn9I32+IUrcIo6b1kNe9c=;
        b=c/kuUkk4PEguPMlEXx7u01dPI2FrlB52lfk809vSRl086xK9uQ7ci7ZLy/KFMcLRsd
         XEtX7ArSzZbaNKn7PUlsvQto7Kdg8OeArVNapanyXWh8xgbvcxLjJdMDg26p/K9tix60
         D2e+aym+v860/GnVylRmPghrDxtdADm2bpV2COfZlXGyUr6R+YL/3QpiK7vos6aiOOno
         IyO3tlo9jfHdtrEF2ulklaHftt+p1WTwbr/LtFPTBbaxaS7oM5fK7OhiLBD8jxU+MODQ
         UMcNKw5mnLMZocjJGDGLRM3D4f1CAAUOpvgkew8o7XmoXQ2Y1+HTxWr1+B3olmqaYEmy
         9fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791969299; x=1792574099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lGzMW0CtEG0NM6Y2SKTe2qhn9I32+IUrcIo6b1kNe9c=;
        b=DCwnMC4Iv1aWq3aOke+B3yKWZEplO8Yf/fPB42BganRWZeUKW0lewjvAhdDRzRGdhn
         ZHECMCKvS8m97F7ebfHOXnEbGitG528eQJt7fuCcfIIiI1skVomXT8MIjNQeTs6JONJC
         96tyz0dPqRY2DuFYJcGlhIkT8zBcJXuBkvUib69TIdx/X3aPwen0ngZp4TUEwZ0D/JG3
         QtxAjDxNrsIGc5Gv8pTYKJZVGuqBqrEEgmt9h38uoDhejYgmIC1QQLXagfmDahiRIpSU
         R39nTyfdhRmah5j2H7Ojaa/qtZ3H3Axk2bz6yjp2gm2EYQiU4HV94Tj5MJAU/HtmQwto
         pl2A==
X-Gm-Message-State: AFq9FYJkSC+0lB01kpYB8uQPrvLCXWgDsm0v/zE63YkJW4Zi5vnvL5KY
	T/DP8De9FoDCY1I9goTQ7aPpHJRNZXIdIHHUrjSVoPU66MwVytkh+MjDxK+KE4M4/fvybw==
X-Gm-Gg: AYBFou0hT4hX+rWMSAlKPgW0lqtS+ousWjonsNCbcXFpgWRwnMz0OgWEgdgRLipo6G7
	qMC/aXhs1xPIvhZY65t+D9v50AmXb40S+vbDAG9mrMIWIzWmKzbEZ/ZSn+l/anJehjNPEZCI3n4
	QQeHrbApAq1sMGZ3hMuZq+4+NdiwS9cYQ/7ErwER8iOVi8kAOi9rpM1lvtFIOl2paxClHDDGeUV
	c7SJ2ntVqQHLIAZyLAiTsrBKoULUodHuGpC2VRxPF2dC5P0ysT6Bj0v4CGYs2eskaN7H5Td+zFs
	AvJ9gP7FvLGffC9KTIVqlWK0oi1j1wCGBbvu+xEqCop+158nTkI5ag8ErscTtdbRn+5fv0DyLD5
	tHcZC0e4R4zsqxdDBvHAAt2wkXJllx0PdYavRw9voUSiVpX7F4XYKVrOkJN2BAcKMisfSfsnCea
	WdF25pFJeKtcgfAMIEq0HYetag6VGi9beRm0wNsDwDgxEyl4eMRKgz/R7C3j9pilace1NzhpZAx
	7HSMMcTQgM/PLTul9rhN72yzbDiFSkfljvKjv47s7JEEg==
X-Received: by 2002:a5d:6f08:0:b0:48d:bae5:41c with SMTP id ffacd0b85a97d-48dbae50634mr29150867f8f.17.1791969299086;
        Wed, 14 Oct 2026 02:14:59 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48de0967beasm11592680f8f.7.2026.10.14.02.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:14:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v3] bpf: allow ksock connect/send calls from wq
Date: Wed, 14 Oct 2026 09:14:50 +0000
Message-ID: <20261014091450.19107-1-mahe.tardy@gmail.com>
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
v2: https://lore.kernel.org/bpf/sashiko-outbox-170341@kernel.org/

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

