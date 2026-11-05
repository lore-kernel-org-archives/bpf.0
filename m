Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881029;
	b=Z5BMEtH/92+JL9WLVppGLhG62oisAsUJCIOPUVubC8mrc97YRUS51Bf2WY2f2Xa5F5Rn
	 UFrnGP2ray7TqY4h2u5J98po+O/RxJTpLCKn9vjO/11sExtuX8XfOFePUCuit3727ZNEH
	 I53aoSB8yb338dI60Fle20okeY1x6oxhh3oAAYr11lqWeZRJvgZYel/AVDDeb8pf3HXDP
	 pgqrkTzsEOB/bUJdji9Dm1bUyjr01d0zsnQmhKDnQ03uoRo9wrQpdKz/t+NOTwGP58Hfo
	 07URSSGV1fFsw9k3frWDclXBtFasJ3eP9HmcS+BQip4cUhjSCYs3650+bxrLMBliNWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=f96Pxu+FTpHnnidUC9kHsSvMST/qKtUp9MInF1FSebU=;
	b=RwlYZagDB+a64u5H5phdDyGytoFlYpeBdhYQD9wZb6u/It7o0lkJuO0JY8jEge/WMHUM
	 KY/1jgiyrFapKuD8yrT5bGM0QmqUSdPqWdmxwah26x6S4OtuanRIFrltO1h5ZGSocwz3t
	 LQ+OP4euDcig659NuXZdSF/q08Ujz+1nVqxsw03k6UdbBQPuhBpw+OXvTySnD3LPBb1ey
	 sTg7rEp74CRTOTKBRO9txXtYoswrbE1yhqXlRnmobnxzhDrRcG1CUn5Owe4QpA6DQy3mf
	 oI1tvEMerWKcyLc/aI+U9DyMpS4OiXRpgbItrWUhnFL8yY8K9gK9b5zjUB6cO0ht2Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PubjUOZF;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D90606EEB9
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 12:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D90606EEB9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PubjUOZF
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36dbde64409so1417471eec.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 04:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793881028; x=1794485828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f96Pxu+FTpHnnidUC9kHsSvMST/qKtUp9MInF1FSebU=;
        b=PubjUOZFIn6TfI8TFWd91gu5q+QFWOqi+Jh7QZAj/WHj8T1Fc4B9ftZue814hmpVB2
         oxctTwvoS51/bTaBj3/EWaP7m2u/u6UFlfuao4p0OrG8NtvD1Y93AprVwSg/28QFyb1S
         BgAoXwHkNHdiKh4po2KJOXc4m7Q1xHBfUio0wfleIEojSi0hWJpsSv/f5TgneiRzwOQO
         EppY0eds20AbNdCpYqlxBJFLuXjdTjqyIunAR7bbwGRTYuEATbNkP1RLt7nBN7hajp5W
         vZzLjuci5xFVsMslBiUpFYfhUljoERnRf8PrBNxlzdLmisrl5trDcDgWNyqszM01wzd3
         WXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793881028; x=1794485828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f96Pxu+FTpHnnidUC9kHsSvMST/qKtUp9MInF1FSebU=;
        b=Fq0sRIH6epKmUzH0d0gkMZQidyF6r6UssXHhUI5z0kIn37tdUxfeGuiPeehVY76O0p
         aVzyTngjFbu6tgoDMjZEbBkK4F3h6ScU+ZclgMTjZ2OGssYI6Awp72+RUazap1kj3cmg
         C/q5IuYtH/Je24k00VqXM57xickN6k41nlNCbMR/ftFEvG1RTO9KjlBXGx7IR/EwfTNJ
         +MhtHmOMGyhr39AHiYGLIvOJAnvDgwPuURBPMNaMaMhOIIFekZ5xlkylDxt5MRxJozxY
         U0bnGwvEomkeQTIdftjKrZbhRWt7SFrHuUpll1q3/BzV9GirFyuQITBfyCkXJtm+GIDB
         En3g==
X-Gm-Message-State: APuU4Z+34xBsIK/xKzmneDxrStAGBx0S/36mxLSB7NDGbmwNNQUdDaI2
	4wrdd9yBVGeq3us0uXaAdeTlI6vxWR/gLtOHk+1HF99VN/s7CUY5P8Ts+QHJ/oz/o6w=
X-Gm-Gg: AYBFou33MXZCgV5XOIujmeLn1ZmIX9a7KZ0HBKdNd8UX/j29NijQBhimK43mO95/pa7
	rodFA026Nj7lihBITnPGfRU5VypKC8UNmogqSDX/43mYpyuEz+g60+gfpAn9aA3nvdT/Nk0aAL8
	YsEfLZJ4xyJVFfVe+FjNFgRbFF8P54SixWrF1psGcG7+cAObAlrN9MzItnBMyNX0UtfajWpbhMN
	UN/CyfChnNbSgSN1rNsmdDGQkxXv7bEvkbuFaRtQelMjyuy9I2Dar3j+hcUrx9PUBnlbdtl9wEA
	qL7/ccVRMkUQdaPNhSx7yGt09LUPkHrHQ8WkZVXTBN7tmszpsWccd0bcS8V3CGx22Xi6eIRrZUq
	EBi1W5X0CjnwCc+vkjGIXhmwAWtpELnwT4dDnu3GsxuMMeHGh3TvQOJKiaavPi1ORwStNeedxV2
	okv17zON7AaKlVg2cUMboQGecZBwsTEazQi/brLnIUR4phG8ad1pYsotq/4DqUL3Rr+IahuvNg/
	CPD9kM0mry8haHXjaxEidocL7IPvuore5yVOEbKq1/7gmc/6o/3RCd5TVhPkJrCjSmX2OrjEqBj
	OFyMcULJglc+ELv/hFVJS9Mv/9/6C8i9Ne+/G+PcrbRUZSzaH8AyLDe6WQ9M8SBg2/k=
X-Received: by 2002:a05:7300:ec89:b0:36e:97b4:1071 with SMTP id 5a478bee46e88-36e97b4317emr1464294eec.14.1793881027670;
        Thu, 05 Nov 2026 04:17:07 -0800 (PST)
Received: from boogieman ([2409:40c0:28:cf7f:a8e0:3d30:1c1a:630f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3966daasm21534841eec.23.2026.11.05.04.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:17:07 -0800 (PST)
From: Abhishek Khade <abhishekkhade69@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Abhishek Khade <abhishekkhade69@gmail.com>
Subject: [PATCH] bpf: Add network namespace boundary inspection kfuncs
Date: Thu,  5 Nov 2026 17:46:42 +0530
Message-ID: <20261105121642.38019-1-abhishekkhade69@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eBPF tracing and networking programs frequently need to determine whether
an execution event originates from the initial host network namespace
(init_net) or an isolated container namespace, as well as extract the
namespace inode identifier for correlation.

Currently, dereferencing task->nsproxy->net_ns directly via BPF CO-RE
presents safety and architectural challenges:
1. nsproxy can be NULL during concurrent unshare or task exit teardown.
2. Direct comparison against &init_net exposes host kernel addresses,
   complicating verification and KASLR safety.
3. Reading deep pointer chains without RCU synchronization can trigger
   verifier rejections or race against namespace cleanup.

Introduce three BPF kfuncs to safely inspect network namespace boundaries:
- bpf_task_is_init_net(struct task_struct *task): Returns 1 if the task
  belongs to the initial host network namespace, 0 otherwise.
- bpf_task_get_netns_inum(struct task_struct *task): Returns the inode
  number of the task's network namespace, or 0 on failure.
- bpf_sock_is_init_net(struct sock *sk): Returns 1 if the socket belongs
  to init_net, 0 otherwise.

These helpers are registered under generic_btf_ids with the KF_RCU flag,
allowing safe invocation within RCU read-side critical sections across
tracing, LSM, and socket programs.

Add automated selftests under tools/testing/selftests/bpf validating host
detection and container isolation via unshare(CLONE_NEWNET).

Signed-off-by: Abhishek Khade <abhishekkhade69@gmail.com>
---
 kernel/bpf/helpers.c                          |  79 +++++++++++++
 .../selftests/bpf/prog_tests/netns_kfunc.c    | 104 ++++++++++++++++++
 .../selftests/bpf/progs/test_netns_kfunc.c    |  32 ++++++
 3 files changed, 215 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/netns_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_netns_kfunc.c

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6788489a2..3584703d1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -18,6 +18,9 @@
 #include <linux/pid_namespace.h>
 #include <linux/poison.h>
 #include <linux/proc_ns.h>
+#include <linux/nsproxy.h>
+#include <net/net_namespace.h>
+#include <net/sock.h>
 #include <linux/sched/task.h>
 #include <linux/security.h>
 #include <linux/btf_ids.h>
@@ -2991,6 +2994,77 @@ __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
 	return ret;
 }
 
+#ifdef CONFIG_NET
+/**
+ * bpf_task_is_init_net - check whether task belongs to initial network namespace
+ * @task: the task to be tested
+ *
+ * Returns true if @task belongs to the initial network namespace (init_net),
+ * or false otherwise (or if @task or its nsproxy is NULL).
+ */
+__bpf_kfunc bool bpf_task_is_init_net(const struct task_struct *task)
+{
+	struct nsproxy *nsproxy;
+	struct net *net;
+	bool ret = false;
+
+	if (!task)
+		return false;
+
+	rcu_read_lock();
+	nsproxy = rcu_dereference(task->nsproxy);
+	if (nsproxy) {
+		net = READ_ONCE(nsproxy->net_ns);
+		ret = (net == &init_net);
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+/**
+ * bpf_task_get_netns_inum - get inode number of task's network namespace
+ * @task: the task to inspect
+ *
+ * Returns the inode number (inum) of @task's network namespace, or 0 if
+ * @task, its nsproxy, or net_ns is NULL.
+ */
+__bpf_kfunc u32 bpf_task_get_netns_inum(const struct task_struct *task)
+{
+	struct nsproxy *nsproxy;
+	struct net *net;
+	u32 inum = 0;
+
+	if (!task)
+		return 0;
+
+	rcu_read_lock();
+	nsproxy = rcu_dereference(task->nsproxy);
+	if (nsproxy) {
+		net = READ_ONCE(nsproxy->net_ns);
+		if (net)
+			inum = net->ns.inum;
+	}
+	rcu_read_unlock();
+
+	return inum;
+}
+
+/**
+ * bpf_sock_is_init_net - check whether socket belongs to initial network namespace
+ * @sk: the socket to be tested
+ *
+ * Returns true if @sk belongs to init_net, or false otherwise (or if @sk is NULL).
+ */
+__bpf_kfunc bool bpf_sock_is_init_net(const struct sock *sk)
+{
+	if (!sk)
+		return false;
+
+	return net_eq(sock_net(sk), &init_net);
+}
+#endif /* CONFIG_NET */
+
 BPF_CALL_2(bpf_current_task_under_cgroup, struct bpf_map *, map, u32, idx)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
@@ -5151,6 +5225,11 @@ BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
 BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 #endif
+#ifdef CONFIG_NET
+BTF_ID_FLAGS(func, bpf_task_is_init_net, KF_RCU)
+BTF_ID_FLAGS(func, bpf_task_get_netns_inum, KF_RCU)
+BTF_ID_FLAGS(func, bpf_sock_is_init_net, KF_RCU)
+#endif
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
diff --git a/tools/testing/selftests/bpf/prog_tests/netns_kfunc.c b/tools/testing/selftests/bpf/prog_tests/netns_kfunc.c
new file mode 100644
index 000000000..3072f7ede
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/netns_kfunc.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Abhishek Khade */
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <test_progs.h>
+#include "test_netns_kfunc.skel.h"
+
+void test_netns_kfunc(void)
+{
+	struct test_netns_kfunc *skel;
+	int pipefd[2];
+	pid_t pid;
+	int status = 0;
+	u32 host_inum;
+
+	skel = test_netns_kfunc__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (!ASSERT_OK(test_netns_kfunc__attach(skel), "attach"))
+		goto cleanup;
+
+	/* Test 1: Process running in initial network namespace */
+	if (!ASSERT_OK(pipe(pipefd), "pipe_init"))
+		goto cleanup;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork_host")) {
+		close(pipefd[0]);
+		close(pipefd[1]);
+		goto cleanup;
+	}
+
+	if (pid == 0) {
+		close(pipefd[1]);
+		if (read(pipefd[0], &status, sizeof(status)) < 0)
+			exit(1);
+		close(pipefd[0]);
+		execlp("true", "true", NULL);
+		exit(1);
+	}
+
+	skel->bss->target_pid = pid;
+	close(pipefd[0]);
+	if (write(pipefd[1], &status, sizeof(status)) < 0) {
+		close(pipefd[1]);
+		waitpid(pid, NULL, 0);
+		goto cleanup;
+	}
+	close(pipefd[1]);
+	waitpid(pid, &status, 0);
+
+	ASSERT_EQ(skel->bss->inv_is_init_net, 1, "host_task_is_init_net");
+	ASSERT_GT(skel->bss->inv_netns_inum, 0, "host_netns_inum_valid");
+	host_inum = skel->bss->inv_netns_inum;
+
+	/* Reset state */
+	skel->bss->inv_is_init_net = -1;
+	skel->bss->inv_netns_inum = 0;
+
+	/* Test 2: Process running in a new network namespace */
+	if (!ASSERT_OK(pipe(pipefd), "pipe_netns"))
+		goto cleanup;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork_netns")) {
+		close(pipefd[0]);
+		close(pipefd[1]);
+		goto cleanup;
+	}
+
+	if (pid == 0) {
+		close(pipefd[1]);
+		if (read(pipefd[0], &status, sizeof(status)) < 0)
+			exit(1);
+		close(pipefd[0]);
+
+		if (unshare(CLONE_NEWNET) != 0)
+			exit(1);
+
+		execlp("true", "true", NULL);
+		exit(1);
+	}
+
+	skel->bss->target_pid = pid;
+	close(pipefd[0]);
+	if (write(pipefd[1], &status, sizeof(status)) < 0) {
+		close(pipefd[1]);
+		waitpid(pid, NULL, 0);
+		goto cleanup;
+	}
+	close(pipefd[1]);
+	waitpid(pid, &status, 0);
+
+	ASSERT_EQ(skel->bss->inv_is_init_net, 0, "netns_task_not_init_net");
+	ASSERT_GT(skel->bss->inv_netns_inum, 0, "child_netns_inum_valid");
+	ASSERT_NEQ(skel->bss->inv_netns_inum, host_inum, "netns_inum_different");
+
+cleanup:
+	test_netns_kfunc__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_netns_kfunc.c b/tools/testing/selftests/bpf/progs/test_netns_kfunc.c
new file mode 100644
index 000000000..3ad49f8ba
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_netns_kfunc.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Abhishek Khade */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+
+bool bpf_task_is_init_net(const struct task_struct *task) __ksym;
+u32 bpf_task_get_netns_inum(const struct task_struct *task) __ksym;
+
+pid_t target_pid;
+int inv_is_init_net = -1;
+u32 inv_netns_inum;
+
+SEC("tp_btf/sched_process_exec")
+int BPF_PROG(on_exec, struct task_struct *task, u64 old_pid,
+	     struct linux_binprm *bprm)
+{
+	pid_t pid = task->tgid;
+
+	if (pid != target_pid)
+		return 0;
+
+	inv_is_init_net = bpf_task_is_init_net(task) ? 1 : 0;
+	inv_netns_inum = bpf_task_get_netns_inum(task);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

