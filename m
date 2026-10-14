Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7791FC0
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020900; cv=none; b=PxrPCM44HmBi+hIHnaQccUqRF8WTS88x1cP8tIssSGax9odqs/I6jWb6ONs2w0x/HE3bKQnQ5vtyHIvMBVAEHv2e22SB8XARAP5WqtuVdxJRqJwdrCvmFfGLRb87ePbmVA6KGVJtVWZVEyTp1GJoT2y/vZeUYKvO9my7x4UoMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020900; c=relaxed/simple;
	bh=wCnQK381YJoDxp76XrJtJw2htZlIiCoUCnThGSIDKm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjvSCQk4NnKiYzMRVGvsM6KyZEOUsMy/d5IA9rIFxT4SXXFbEucIbqhyKoF8zMwhzuh7Lxvo/Xl362HJSfpFjWW12GqUU1/FEyXDCTUyqfCzGu159OR2l9KanBNzcrhxjqOuRxBrMoTrpk23JXLU83/lkzfFtnITJxL5XVRzYbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Zm7AWYM1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Zm7AWYM1"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so774914a12.3
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 16:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792020898; x=1792625698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9QgIEGkJdsi/u3vj5rmuCqXgKBULEvPw6UmBty+Ejcw=;
        b=Zm7AWYM1lN+3BLPFc9EyPBZD2zX5+iYc+wLlKiByczsT7FGXUuQtjWnL18Lj5wcB1S
         DZO3CHDYrYlq3jD8qCXD1QdGw8bfoYfTFfIflFc0fZOcA8591l/XISbdkX620dKM5f0h
         gz1pjo3tNAeuUIRcOPerXNzcOoZFqRnjOPrr5OJLj695OjyTWPk6FYhrxb1cC7VWN9cL
         kLDaR2Ez5VhUmhM1fZoKWrNsI62FJgNgEkdlkUGSn3wlNuE07cbUz6pRdkh4HgAUGIDb
         hrweJ2eXVkCq/a056f1xhretvU+aQN8jmcdFPX4X2Mo7/rnx5A+yN2kE47Q0PSjU47fw
         CfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020898; x=1792625698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9QgIEGkJdsi/u3vj5rmuCqXgKBULEvPw6UmBty+Ejcw=;
        b=djZA8xWzvTLFzHAwQontCraZCvD5bQkv8ipsfZ1AIY+iN7/c60eb+W5d0Qp8Eocesy
         mMxg6Shfq7i/keZkSnNbKxS6OAzMoU5/6oZaK7IO87rKrIUW9qTySQgIRChA6LNguEj3
         nnyVRQGqpAhkymp9591oUFFSqafte19krdJLiz9i1YyAKCWu1hEtFxbKBrKa80eqAghQ
         k2gvn9nhLnConNxOxiLK6r/08WfOCh8l7M9IjSwTvDr/267ohZqDZYu54bJaPlaw60dh
         BanMBennzXSXb/vxX0ojFDWL33PSbam97uRt+SHbpJ0wCWUTbebhPIvz+JpcKGVkt0qf
         XXfg==
X-Gm-Message-State: AFq9FYKq2yQjFNr2C4TNa7D0lJ5+mm8CS4C5LhkLazrsgm62FdxJcXgh
	kao562ynqGJv4LhaGE13+MxsTjf5VrNgjESzzIDCPmI1AUhEAWYG9d7Z6IslY2b/HZoDt0CL+xb
	A322o
X-Gm-Gg: AYBFou3dY7xtepHYp3pjctnYY5bLhdUQBDMfLQ6+XfSItUH2UaUkmAay3VQOC5GaxwY
	HAMWQZywyMpAQkTFnROFIQTme60plTA4X1xtHJrmIi3cGnzmY9QRGB5GNCjMr7hZv9DmErRjElY
	7xla2jkq1EkqCfRrDVZvHmvMuBAHVSOE1/2sbsPOEigqxZCXHzWdkS7K8ZuDnJoDJHCDGvMSOcp
	QONHbQTaA8Ttj70GX6u0Hs1iTnj4IpFv+Tqo7Tz15W4iyM2Zp9CV5VSfF1skxv4frsT+wukoqIf
	/YokCE6AfVJs9jHPzNILzAVDaJQ3czwZhCk/Q64+p1bmY4sOuprqdIJYWZl0wscc8waxQfOpnrC
	/IZ1wsNYZ5gS6M7AK2BiVb1oSaWWu7BCN578j2e0cJxoO5hqOGtzrnMmqgP3hxvYBK9jJNlqaBJ
	SraPpHt+Bjt72D+euJAdAPm89e8ncwxrW2hDwlD7fZv5P4x8HvfyoTKhLiETyP6yCBOoLTNBWiS
	6rBmh8rYRIMZi/lDdKGoK5TfaIZH+GwFz1o
X-Received: by 2002:a17:90b:3c08:b0:3ac:7116:434a with SMTP id 98e67ed59e1d1-3ac71164429mr2963854a91.15.1792020897921;
        Wed, 14 Oct 2026 16:34:57 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7a98sm1385177a91.6.2026.10.14.16.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 16:34:57 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 8/8] selftests/bpf: Add arena allocation race tests
Date: Wed, 14 Oct 2026 23:34:42 +0000
Message-ID: <20261014233442.8392-9-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014233442.8392-1-emil@etsalapatis.com>
References: <20261014233442.8392-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for arena allocation, teardown and fault races.

Cover unavailable ranges and kernel/user mapping coherence during
synchronous and deferred frees and concurrent faults.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/arena_race.c     | 285 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_race.c  | 159 ++++++++++
 2 files changed, 444 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_race.c b/tools/testing/selftests/bpf/prog_tests/arena_race.c
new file mode 100644
index 000000000000..301f4dff28f9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_race.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <sys/syscall.h>
+#include <test_progs.h>
+
+#include "arena_race.skel.h"
+
+struct free_thread_ctx {
+	struct arena_race *skel;
+	int err;
+	__u32 retval;
+};
+
+struct fault_thread_ctx {
+	__u64 *addr;
+	int stop;
+};
+
+static int run_prog(struct bpf_program *prog, const char *name)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &opts);
+	return ASSERT_OK(err, name) && ASSERT_OK(opts.retval, name) ? 0 : -1;
+}
+
+/* Trigger the sleepable free page path. */
+static void *run_free_thread(void *arg)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct free_thread_ctx *ctx = arg;
+
+	ctx->skel->bss->target_tid = sys_gettid();
+	ctx->err = bpf_prog_test_run_opts(
+		bpf_program__fd(ctx->skel->progs.free_page), &opts);
+	ctx->retval = opts.retval;
+	return NULL;
+}
+
+/* Continuously fault in the address. */
+static void *fault_reader_thread(void *arg)
+{
+	struct fault_thread_ctx *ctx = arg;
+	__u64 *addr;
+
+	while (!READ_ONCE(ctx->stop)) {
+		addr = __atomic_load_n(&ctx->addr, __ATOMIC_ACQUIRE);
+		(void)READ_ONCE(*addr);
+	}
+	return NULL;
+}
+
+static int wait_for(int *p)
+{
+	__u64 deadline = get_time_ns() + 5ULL * 1000 * 1000 * 1000;
+
+	while (!READ_ONCE(*p)) {
+		if (get_time_ns() > deadline)
+			return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static struct arena_race *setup_arena(__u64 **addr, bool trace_flush)
+{
+	struct arena_race *skel;
+	size_t arena_sz;
+	char *base;
+	int err;
+
+	skel = arena_race__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return NULL;
+	err = bpf_program__set_autoload(skel->progs.trace_flush, trace_flush);
+	if (!ASSERT_OK(err, "trace_flush_autoload"))
+		goto err_out;
+
+	err = arena_race__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto err_out;
+	err = arena_race__attach(skel);
+	if (!ASSERT_OK(err, "attach"))
+		goto err_out;
+
+	if (run_prog(skel->progs.alloc_old, "alloc_old"))
+		goto err_out;
+	if (skel->bss->skip) {
+		test__skip();
+		goto err_out;
+	}
+
+	base = bpf_map__initial_value(skel->maps.arena, &arena_sz);
+	if (!ASSERT_OK_PTR(base, "arena_base"))
+		goto err_out;
+	*addr = (__u64 *)(base + getpagesize());
+	if (!ASSERT_EQ((unsigned long)skel->bss->ptr, (unsigned long)*addr,
+		       "arena_ptr"))
+		goto err_out;
+	return skel;
+
+err_out:
+	arena_race__destroy(skel);
+	return NULL;
+}
+
+static void test_free_before_flush(bool deferred)
+{
+	struct free_thread_ctx ctx = {};
+	struct arena_race *skel;
+	pthread_t thread;
+	__u64 *addr;
+	bool thread_created = false, flush_seen = false, completed = false;
+	int err;
+
+	if (libbpf_find_vmlinux_btf_id("flush_tlb_kernel_range",
+					BPF_TRACE_FENTRY) <= 0) {
+		printf("%s:SKIP: flush_tlb_kernel_range is not an fentry target\n",
+		       __func__);
+		test__skip();
+		return;
+	}
+
+	skel = setup_arena(&addr, true);
+	if (!skel)
+		return;
+
+	/* Pause during a TLB flush to widen the race window. */
+	skel->bss->pause_on_flush = 1;
+
+	if (deferred) {
+		/*
+		 * Test the nonsleepable free path that gets
+		 * deferred to a worker in the kernel. We do
+		 * so by triggering the arena operation from
+		 * a nonsleepable tracepoint context.
+		 */
+		skel->bss->trigger_pid_tgid =
+			((__u64)getpid() << 32) | (__u32)sys_gettid();
+		skel->bss->trigger_syscall = SYS_getpgid;
+		skel->bss->deferred_free = 1;
+		if (!ASSERT_GE(syscall(SYS_getpgid, 0), 0, "deferred_free"))
+			goto release;
+	} else {
+		/*
+		 * Test the sleepable arena free path through a
+		 * syscall test prog.
+		 */
+		ctx.skel = skel;
+		err = pthread_create(&thread, NULL, run_free_thread, &ctx);
+		if (!ASSERT_OK(err, "pthread_create")) {
+			skel->bss->release = 1;
+			goto out;
+		}
+		thread_created = true;
+	}
+
+	/* Wait until the worker thread triggers a flush. */
+	err = wait_for(&skel->bss->flush_entered);
+	if (!ASSERT_OK(err, "flush_entered"))
+		goto release;
+
+	flush_seen = true;
+
+	/* Force a reallocation during the flush. */
+	run_prog(skel->progs.try_realloc, "realloc_before_flush");
+	ASSERT_NULL(skel->bss->realloc_ptr, "realloc_before_flush");
+
+release:
+	skel->bss->release = 1;
+	if (thread_created) {
+		ASSERT_OK(pthread_join(thread, NULL), "pthread_join");
+		thread_created = false;
+		completed = ASSERT_OK(ctx.err, "free_run") &&
+			    ASSERT_OK(ctx.retval, "free_retval");
+	} else if (skel->bss->target_tid) {
+		err = wait_for(&skel->bss->worker_exited);
+		completed = ASSERT_OK(err, "worker_exited");
+	}
+	ASSERT_FALSE(skel->bss->timed_out, "flush_timed_out");
+
+	if (flush_seen && completed &&
+	    !run_prog(skel->progs.try_realloc, "realloc_after_flush")) {
+		ASSERT_EQ((unsigned long)skel->bss->realloc_ptr,
+			  (unsigned long)addr, "realloc_after_flush");
+		ASSERT_EQ(*addr, skel->rodata->new_marker, "new_marker");
+	}
+out:
+	arena_race__destroy(skel);
+}
+
+/*
+ * Force a race between a faulting thread in userspace and a
+ * free operation on the arena.
+ */
+static void test_fault_free_realloc(void)
+{
+	struct fault_thread_ctx fault = {};
+	struct arena_race *skel;
+	pthread_t fault_thread;
+	bool fault_created = false;
+	__u64 *addr;
+	__u64 expected, value;
+	int err, i;
+
+	skel = setup_arena(&addr, false);
+	if (!skel)
+		return;
+
+	skel->bss->realloc_after_free = 1;
+
+	fault.addr = addr;
+	err = pthread_create(&fault_thread, NULL, fault_reader_thread, &fault);
+	if (!ASSERT_OK(err, "pthread_create_fault"))
+		goto out;
+	fault_created = true;
+
+	for (i = 0; i < 1000; i++) {
+		LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+		/* Keep deferred frees from earlier iterations on separate slots. */
+		if (i) {
+			skel->bss->page_idx = i;
+			if (run_prog(skel->progs.alloc_old, "alloc_next"))
+				goto out;
+			addr = (__u64 *)(unsigned long)skel->bss->ptr;
+			__atomic_store_n(&fault.addr, addr, __ATOMIC_RELEASE);
+		}
+
+		err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.free_page),
+					     &opts);
+		if (err) {
+			ASSERT_OK(err, "free_realloc");
+			break;
+		}
+		if (opts.retval) {
+			ASSERT_OK(opts.retval, "free_realloc");
+			break;
+		}
+		/* The reader may populate the slot first, or free may defer. */
+		if (!skel->bss->realloc_ptr)
+			continue;
+		value = *addr;
+		expected = skel->bss->current_marker;
+		if (value != expected) {
+			ASSERT_EQ(value, expected, "marker_after_realloc");
+			break;
+		}
+	}
+
+	WRITE_ONCE(fault.stop, 1);
+	if (fault_created) {
+		ASSERT_OK(pthread_join(fault_thread, NULL), "pthread_join_fault");
+		fault_created = false;
+	}
+out:
+	WRITE_ONCE(fault.stop, 1);
+	if (fault_created)
+		pthread_join(fault_thread, NULL);
+	arena_race__destroy(skel);
+}
+
+void serial_test_arena_race(void)
+{
+	cpu_set_t cpuset;
+	int err;
+
+	err = sched_getaffinity(0, sizeof(cpuset), &cpuset);
+	if (!ASSERT_OK(err, "sched_getaffinity"))
+		return;
+	if (CPU_COUNT(&cpuset) < 2) {
+		printf("%s:SKIP: at least two runnable CPUs are required\n", __func__);
+		test__skip();
+		return;
+	}
+
+	if (test__start_subtest("free_before_flush"))
+		test_free_before_flush(false);
+	if (test__start_subtest("deferred_free_before_flush"))
+		test_free_before_flush(true);
+	if (test__start_subtest("fault_free_realloc"))
+		test_fault_free_realloc();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_race.c b/tools/testing/selftests/bpf/progs/arena_race.c
new file mode 100644
index 000000000000..6d1675ba2395
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_race.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+
+const volatile __u64 old_marker = 0x1111222233334444ULL;
+const volatile __u64 new_marker = 0x5555666677778888ULL;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1024);
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32);
+#else
+	__ulong(map_extra, 0x1ull << 44);
+#endif
+} arena SEC(".maps");
+
+bool skip;
+int page_idx;
+
+void __arena *ptr;
+void __arena *realloc_ptr;
+bool realloc_after_free;
+__u64 current_marker;
+__u64 marker_seq;
+
+int target_tid;
+int pause_on_flush;
+int flush_entered;
+int release;
+int timed_out;
+
+__u64 trigger_pid_tgid;
+long trigger_syscall;
+int deferred_free;
+int worker_armed;
+int worker_exited;
+
+static __always_inline void wait_for_release(void)
+{
+	while (!*(volatile int *)&release && can_loop)
+		;
+	if (!*(volatile int *)&release)
+		timed_out = 1;
+}
+
+SEC("syscall")
+int alloc_old(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_ASM)
+	__u64 __arena *p;
+	char __arena *base = arena_base(&arena);
+
+	realloc_ptr = NULL;
+	ptr = bpf_arena_alloc_pages(&arena, base + (page_idx + 1) * __PAGE_SIZE, 1,
+				    NUMA_NO_NODE, 0);
+	if (!ptr)
+		return 1;
+	p = (__u64 __arena *)ptr;
+	*p = old_marker;
+	current_marker = old_marker;
+#else
+	skip = true;
+#endif
+	return 0;
+}
+
+SEC("syscall")
+int free_page(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_ASM)
+	__u64 __arena *p;
+	__u64 marker;
+
+	if (!ptr)
+		return 1;
+	bpf_arena_free_pages(&arena, ptr, 1);
+	if (!realloc_after_free)
+		return 0;
+
+	marker = new_marker + ++marker_seq;
+	realloc_ptr = bpf_arena_alloc_pages(&arena, ptr, 1, NUMA_NO_NODE, 0);
+	if (!realloc_ptr)
+		return 0;
+	ptr = realloc_ptr;
+	p = (__u64 __arena *)ptr;
+	*p = marker;
+	current_marker = marker;
+#endif
+	return 0;
+}
+
+SEC("syscall")
+int try_realloc(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_ASM)
+	__u64 __arena *p;
+
+	realloc_ptr = bpf_arena_alloc_pages(&arena, ptr, 1, NUMA_NO_NODE, 0);
+	if (realloc_ptr) {
+		ptr = realloc_ptr;
+		p = (__u64 __arena *)realloc_ptr;
+		*p = new_marker;
+		current_marker = new_marker;
+	}
+#endif
+	return 0;
+}
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(deferred_free_prog, struct pt_regs *regs, long id)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_ASM)
+	if (!deferred_free || bpf_get_current_pid_tgid() != trigger_pid_tgid ||
+	    id != trigger_syscall)
+		return 0;
+
+	deferred_free = 0;
+	/* The worker can run on another CPU before the kfunc returns. */
+	worker_armed = 1;
+	bpf_arena_free_pages(&arena, ptr, 1);
+#endif
+	return 0;
+}
+
+SEC("fentry/arena_free_worker")
+int BPF_PROG(trace_free_worker, struct work_struct *work)
+{
+	if (worker_armed && !target_tid)
+		target_tid = (__u32)bpf_get_current_pid_tgid();
+	return 0;
+}
+
+SEC("fexit/arena_free_worker")
+int BPF_PROG(trace_free_worker_ret, struct work_struct *work)
+{
+	if ((__u32)bpf_get_current_pid_tgid() == target_tid)
+		worker_exited = 1;
+	return 0;
+}
+
+SEC("?fentry/flush_tlb_kernel_range")
+int BPF_PROG(trace_flush, unsigned long start, unsigned long end)
+{
+	if (!pause_on_flush ||
+	    (__u32)bpf_get_current_pid_tgid() != target_tid)
+		return 0;
+	flush_entered = 1;
+	wait_for_release();
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

