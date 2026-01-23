Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80C330667;
	Fri, 23 Jan 2026 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157814; cv=none; b=SYlucM/Wu4/HwydsguxJP7oY9uvvrbwJ7YEEmnF6V+HCdXPt7lJih4u19H4xOndR6XsRbx2j5MXGwU6jUwhP/1u7Q5UoD1vIrV/G/41INMu9qZ23B//BNUaW8iKsFchJ6av3skLTtXLm38zlQiXYdowUsMxLjBs6DxUde0eIga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157814; c=relaxed/simple;
	bh=2v5meYzri1t7UAmFUiDyqkq4lZPsVw8Aj3KqgoRP3JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGDjWioQ7X+VcxDekyx8eqBozTji0LAaH5eecgHc8TGsHd4A1kkAzgpQ//iGa8L9oN5G3UfVJYr5DB5OBcdUWOENAu8uev6fRbVpsJ2VbFQPhRz2JEVOj3Xa+n9J2NGfjjIj5ocUOmaIKI7d4GJ/YNkhWv57E6l27fPIjqOxKG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TvOcYYo0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TvOcYYo0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=H25gfTD6SGj8Et+cZUgXMMu8x6DlPO1yFi8tCGTyu8g=; b=TvOcYYo0uKfkN+Ar1y+0gM3qJo
	Z/9ebmg//6daHO4+ooaSHoz6olyzF41UGQ7M+BnSEQyJMSIHabDILi9G3paxQAb4m+RyuhGb9OsAS
	tV/Zm0YnsldqCGOUlDDV5eN7Jw77OPI3wzkpiuh7nit5Ijt1ULuoBjrafBV3MjR4rUlSwDPvenORg
	4PhJyFbg0ytXbBUIfq1+jYVlAGO0yW72P6/IdsUF2dZvaiFwHiuKKAZkeKsZDMnmzv6hlaNPuycT0
	wRa3X7u+q3LYM/btBV3+m6c+lEZLlOUStdHZF04JGjmK1B6Cd7YtW5ERxzwREUi+dTyI8AICZ+s8U
	D0FlTvNQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vjClE-008nSZ-OU; Fri, 23 Jan 2026 09:43:21 +0100
From: Changwoo Min <changwoo@igalia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	kernel-dev@igalia.com,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for execution context kfuncs
Date: Fri, 23 Jan 2026 17:42:48 +0900
Message-ID: <20260123084248.259278-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123084248.259278-1-changwoo@igalia.com>
References: <20260123084248.259278-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new selftest suite `ctx_kfunc` to verify the accuracy of the
bpf_in_task(), bpf_in_hardirq(), and bpf_in_serving_softirq() kfuncs.

Testing these execution contexts deterministically requires crossing
context boundaries within a single CPU. To achieve this, the test
implements a "Trigger-Observer" pattern using bpf_testmod:

1. Trigger: A BPF syscall program calls a new bpf_testmod kfunc
   bpf_kfunc_trigger_ctx_check().
2. Task to HardIRQ: The kfunc uses irq_work_queue() to trigger a
   self-IPI on the local CPU.
3. HardIRQ to SoftIRQ: The irq_work handler calls a dummy function
   (observed by BPF fentry) and then schedules a tasklet to
   transition into SoftIRQ context.

The user-space runner ensures determinism by pinning itself to CPU 0
before execution, forcing the entire interrupt chain to remain on a
single core. Dummy noinline functions with compiler barriers are
added to bpf_testmod.c to serve as stable attachment points for
fentry programs. A retry loop is used in user-space to wait for the
asynchronous SoftIRQ to complete.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 .../selftests/bpf/prog_tests/ctx_kfunc.c      | 59 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_ctx.c  | 51 ++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 32 ++++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  4 ++
 4 files changed, 146 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ctx_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_ctx.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ctx_kfunc.c b/tools/testing/selftests/bpf/prog_tests/ctx_kfunc.c
new file mode 100644
index 000000000000..64c3d61b92b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ctx_kfunc.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Valve Corporation.
+ * Author: Changwoo Min <changwoo@igalia.com>
+ */
+
+#include <test_progs.h>
+#include <sys/syscall.h>
+#include "test_ctx.skel.h"
+
+void test_ctx_kfunc(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	cpu_set_t old_cpuset, target_cpuset;
+	struct test_ctx *skel;
+	int err, prog_fd;
+
+	/* 1. Pin the current process to CPU 0. */
+	if (sched_getaffinity(0, sizeof(old_cpuset), &old_cpuset) == 0) {
+		CPU_ZERO(&target_cpuset);
+		CPU_SET(0, &target_cpuset);
+		ASSERT_OK(sched_setaffinity(0, sizeof(target_cpuset),
+					    &target_cpuset), "setaffinity");
+	}
+
+	skel = test_ctx__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto restore_affinity;
+
+	err = test_ctx__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* 2. When we run this, the kernel will execute the BPF prog on CPU 0. */
+	prog_fd = bpf_program__fd(skel->progs.trigger_all_contexts);
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	ASSERT_OK(err, "test_run_trigger");
+
+	/* 3. Wait for the local CPU's softirq/tasklet to finish. */
+	for (int i = 0; i < 1000; i++) {
+		if (skel->bss->count_task > 0 &&
+		    skel->bss->count_hardirq > 0 &&
+		    skel->bss->count_softirq > 0)
+			break;
+		usleep(1000); /* Wait 1ms per iteration, up to 1 sec total */
+	}
+
+	/* On CPU 0, these should now all be non-zero. */
+	ASSERT_GT(skel->bss->count_task, 0, "task_ok");
+	ASSERT_GT(skel->bss->count_hardirq, 0, "hardirq_ok");
+	ASSERT_GT(skel->bss->count_softirq, 0, "softirq_ok");
+
+cleanup:
+	test_ctx__destroy(skel);
+
+restore_affinity:
+	ASSERT_OK(sched_setaffinity(0, sizeof(old_cpuset), &old_cpuset),
+		  "restore_affinity");
+}
diff --git a/tools/testing/selftests/bpf/progs/test_ctx.c b/tools/testing/selftests/bpf/progs/test_ctx.c
new file mode 100644
index 000000000000..b962b3b263e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ctx.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Valve Corporation.
+ * Author: Changwoo Min <changwoo@igalia.com>
+ */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+extern bool bpf_in_nmi(void) __ksym;
+extern bool bpf_in_hardirq(void) __ksym;
+extern bool bpf_in_serving_softirq(void) __ksym;
+extern bool bpf_in_task(void) __ksym;
+extern void bpf_kfunc_trigger_ctx_check(void) __ksym;
+
+int count_hardirq;
+int count_softirq;
+int count_task;
+
+/* Triggered via bpf_prog_test_run from user-space */
+SEC("syscall")
+int trigger_all_contexts(void *ctx)
+{
+	if (bpf_in_task())
+		__sync_fetch_and_add(&count_task, 1);
+
+	/* Trigger the firing of a hardirq and softirq for test. */
+	bpf_kfunc_trigger_ctx_check();
+	return 0;
+}
+
+/* Observer for HardIRQ */
+SEC("fentry/bpf_testmod_test_hardirq_fn")
+int BPF_PROG(on_hardirq)
+{
+	if (bpf_in_hardirq())
+		__sync_fetch_and_add(&count_hardirq, 1);
+	return 0;
+}
+
+/* Observer for SoftIRQ */
+SEC("fentry/bpf_testmod_test_softirq_fn")
+int BPF_PROG(on_softirq)
+{
+	if (bpf_in_serving_softirq())
+		__sync_fetch_and_add(&count_softirq, 1);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index d425034b72d3..29eaf5596f8a 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1164,6 +1164,33 @@ __bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
 __bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux);
 __bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux);
 
+/* hook targets */
+noinline void bpf_testmod_test_hardirq_fn(void) { barrier(); }
+noinline void bpf_testmod_test_softirq_fn(void) { barrier(); }
+
+/* Tasklet for SoftIRQ context */
+static void ctx_check_tasklet_fn(struct tasklet_struct *t)
+{
+	bpf_testmod_test_softirq_fn();
+}
+
+DECLARE_TASKLET(ctx_check_tasklet, ctx_check_tasklet_fn);
+
+/* IRQ Work for HardIRQ context */
+static void ctx_check_irq_fn(struct irq_work *work)
+{
+	bpf_testmod_test_hardirq_fn();
+	tasklet_schedule(&ctx_check_tasklet);
+}
+
+static struct irq_work ctx_check_irq = IRQ_WORK_INIT_HARD(ctx_check_irq_fn);
+
+/* The kfunc trigger */
+__bpf_kfunc void bpf_kfunc_trigger_ctx_check(void)
+{
+	irq_work_queue(&ctx_check_irq);
+}
+
 BTF_KFUNCS_START(bpf_testmod_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_testmod_test_mod_kfunc)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test1)
@@ -1209,6 +1236,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_assoc, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)
+BTF_ID_FLAGS(func, bpf_kfunc_trigger_ctx_check)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -1840,6 +1868,10 @@ static void bpf_testmod_exit(void)
 	while (refcount_read(&prog_test_struct.cnt) > 1)
 		msleep(20);
 
+	/* Clean up tasklet and irqwork */
+	tasklet_kill(&ctx_check_tasklet);
+	irq_work_sync(&ctx_check_irq);
+
 	bpf_kfunc_close_sock();
 	sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
 	unregister_bpf_testmod_uprobe();
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 10f89f06245f..d5c5454e257e 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -169,4 +169,8 @@ extern int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args) __weak
 struct prog_test_member *bpf_kfunc_get_default_trusted_ptr_test(void) __ksym;
 void bpf_kfunc_put_default_trusted_ptr_test(struct prog_test_member *trusted_ptr) __ksym;
 
+void bpf_testmod_test_hardirq_fn(void);
+void bpf_testmod_test_softirq_fn(void);
+void bpf_kfunc_trigger_ctx_check(void) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.52.0

