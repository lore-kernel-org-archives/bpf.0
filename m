Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC13A4520
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332569; cv=none; b=Eqw+Gwt4tk9EvnrlQbcSiF4k1HrVe9U05i2w/jGQg9D8BnwGBpg0g/oqTqu5jus4ZV20ed2d3iYhW1NiD/P62a5HDBMeYTl6iOCICZBuiScQ6aQ22xKKWjA0TzMvaFADAqoZDjmCm+HtmupNHPkOZT9ynditkLiZeyawArsy/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332569; c=relaxed/simple;
	bh=nZ+xdgTUq3aiU8kQfjrPZjQdEXhtQsABhLL/AcElxns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYcFi2ca1AVrEK2Bd7z2G2yH6Y1JdNwA+fY63a6JYiSJ5QeZEyZyJaJNF5dZyd2sOMBCFoSiR324UOtttqibjc3MlYhZLXazA7lVWXUhSshva5MByipZarQY3eM0jqhhgTBr+wPNVfttxO9EY79ZYgBLoJm40uJLrppWaSBQLio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=nn9gWfTb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="nn9gWfTb"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39927410578so1348990a91.1
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 00:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788332567; x=1788937367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dywoRYfozIalqYd3AJhlK5EW7hrxHok3eUOP/18hgB4=;
        b=nn9gWfTbXcOP8m2fm/xFPio5RWFVro+X01NzOryLmqiyI7kclaNYx3yyHDBgN+Xmov
         AbvkCMXzwTVWU2A2Ip8PEvkGu3jxZq2KrINnHu3schTfujWldyA3QohSQMtwnyd2RBbT
         g5rtqjWld2onSuRO0NiaJXQsaLS9GbQw9SdkJ4iPod5pfvhTRYtN4k0FR0PLQpVUAx/v
         D9p9ys2sHHIpbS+4H2pkMaGkH+//Cef7zyrlLRRvWn4b6e+TTP6ftjOutJ5nufoNqeRF
         CuAnRcUQ00marJjqlHh6GphOtGfbyr/tL2ezugHNEWJbYvlbOGHWDYV5FSN3otMkKSxM
         19+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332567; x=1788937367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dywoRYfozIalqYd3AJhlK5EW7hrxHok3eUOP/18hgB4=;
        b=XX04HHus6/kqz2EgAxeVIlw3MhlzHVdfrRx1rslFMqfv5ZtltstscjQKsxYSxlybcb
         DDbU8KyJ2QivpKg9LxpVvtmAF8DBsSN+HFShltJYSP6oTo6vQZidHQ/qWluA8eak84dB
         QnqmOGtSDXy4GV9Yzt4xga7+Q3o3blNpJQqfRnEjDXN35B65YD6uztdsCbyRN9uEqBhF
         NnqfYbgJiG+3hX38KfvI2r/ZWZRVgfMgfPvrbCpwrjwGuxFDNZD79XVGblH7tRy0ClLw
         qQJ8VjlWdYlyiQ3Xl0fH3AaJ+B3HlkXaNXt2W7+8saIo1n5wTiHMRlSp1dswkcTGx4jb
         aZaw==
X-Gm-Message-State: AFuF++nK2oSPgqFeani7/aMDiHHxMXq8MDIcVWaQ6HYrXFSZMCDf9RGF
	1U9nSvARwWAmeNpNKgN5XM3T2XDUJKf9NJ8iZOCs+l4rJt1VLlKRW67nSEitCOivLiHkyPZ4awT
	SkL2o
X-Gm-Gg: AYBFou1853uGQuIzS3CdeBt7RHid0fn0M5/gA2ctadAQnLh3IhKtbwnERr/A1XQXVTB
	H7k4JZ0RFqL9KFzVitmqzJlt4zYisKXOjJLBoNahcZsSmQyiDlvLkiTjynCX/R5i72hHiXUW1bH
	bZEma9t//JNBqEdTQzmugDGrW8xvca1AaPCFs+F5nemmJFRegA3useyV9DxnwH41OjC8+VOm5Uk
	KFbTUTAbDey680i5tP9VGHXhhaWDGbyBGUz2eCvaoMBZIo4C3zNYuX70eExMf8wmpTYWVUK1z4r
	+G+jPBIT8ijL6IR52qbFUj+R2WM4bX5lwALUyQc0KQrsquUNUSza5b9aUyvkq1V26VqGjA+nHnK
	aBvQ/uprkdD8DqOCgQAiYakx20bNFgXgSWjK2y63N9wHjBUwWXZBEHxAhIEsDO4qC8hdCqg6qvZ
	hg6EbTd2fdu6vVUe94gJ/E9Dkw1NBFtPD23xWgDhKKvPCozapDppsMgR3i+O4gps2dm/kOEWNE/
	uQ4+6m9iDCFWhQw8VL3Pmc=
X-Received: by 2002:a17:90b:3985:b0:398:bc52:825b with SMTP id 98e67ed59e1d1-39aee22218dmr3094908a91.21.1788332566822;
        Wed, 02 Sep 2026 00:02:46 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae05e21bcsm3793352a91.0.2026.09.02.00.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:02:46 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	nickolay.lysenko@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 5/5] selftests/bpf: Add arena allocation race tests
Date: Wed,  2 Sep 2026 03:02:39 -0400
Message-ID: <20260902070239.16968-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902070239.16968-1-emil@etsalapatis.com>
References: <20260902070239.16968-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests to handle arena page allocation-related races.
Ensure that concurrent frees and nonsleepable/sleepable page
allocations, as well as allocations from userspace, do not
lead to inconsistent or lost data.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/arena_race.c     | 251 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_race.c  | 163 ++++++++++++
 2 files changed, 414 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_race.c b/tools/testing/selftests/bpf/prog_tests/arena_race.c
new file mode 100644
index 000000000000..c3a2a4397315
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_race.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
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
+
+	while (!READ_ONCE(ctx->stop))
+		(void)READ_ONCE(*ctx->addr);
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
+static struct arena_race *setup_arena(__u64 **addr)
+{
+	struct arena_race *skel;
+	size_t arena_sz;
+	char *base;
+	int err;
+
+	skel = arena_race__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return NULL;
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
+	skel = setup_arena(&addr);
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
+
+	if (thread_created)
+		pthread_join(thread, NULL);
+
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
+	skel = setup_arena(&addr);
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
+	for (i = 0; i < 1000 && !READ_ONCE(fault.stop); i++) {
+		LIBBPF_OPTS(bpf_test_run_opts, opts);
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
+	ASSERT_GE(i, 1, "race_iterations");
+out:
+	WRITE_ONCE(fault.stop, 1);
+	if (fault_created)
+		pthread_join(fault_thread, NULL);
+	arena_race__destroy(skel);
+}
+
+void serial_test_arena_race(void)
+{
+	if (test__start_subtest("free_before_flush"))
+		test_free_before_flush(false);
+	if (test__start_subtest("deferred_free_before_flush"))
+		test_free_before_flush(true);
+	if (test__start_subtest("fault_free_realloc"))
+		test_fault_free_realloc();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_race.c b/tools/testing/selftests/bpf/progs/arena_race.c
new file mode 100644
index 000000000000..df5b54ef5b4c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_race.c
@@ -0,0 +1,163 @@
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
+	__uint(max_entries, 4);
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32);
+#else
+	__ulong(map_extra, 0x1ull << 44);
+#endif
+} arena SEC(".maps");
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_ASM)
+bool skip;
+#else
+bool skip = true;
+#endif
+
+void __arena *ptr;
+void __arena *realloc_ptr;
+bool realloc_after_free;
+int free_started;
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
+	ptr = bpf_arena_alloc_pages(&arena, base + __PAGE_SIZE, 1,
+				    NUMA_NO_NODE, 0);
+	if (!ptr)
+		return 1;
+	p = (__u64 __arena *)ptr;
+	*p = old_marker;
+	current_marker = old_marker;
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
+	free_started = 1;
+	bpf_arena_free_pages(&arena, ptr, 1);
+	if (!realloc_after_free)
+		return 0;
+
+	marker = new_marker + ++marker_seq;
+	realloc_ptr = bpf_arena_alloc_pages(&arena, ptr, 1, NUMA_NO_NODE, 0);
+	if (realloc_ptr)
+		ptr = realloc_ptr;
+	else
+		realloc_ptr = ptr;
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
+SEC("fentry/flush_tlb_kernel_range")
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
2.55.0

