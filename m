Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC743B8921
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179451; cv=none; b=cha0sMN9KQG60fGsAZ/glbpptNnjHOOy06/L0Qxkl3Th0VtPVnwEAoFUna5BPWxs9aDDqOMHENv+MCvk7lT+w7skpUzFj0J9zZj2+2UuK5ZIYTJh84/qiuWqvWqUvEktRMvrc2gK1M42SoNAMEVlr5f67TnoRFDPtSUlNPG1/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179451; c=relaxed/simple;
	bh=P3T7yVZCfw010pVSsNaymFOtCBiBgYqS+NH4ltZ6GfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rmr+VOeeyfIVoWimO5xT+jbpZa6d5vTzZP+qNEAcmIBkCgZSzmZnvk9E2ZIpQp6XrWnvW6UCyzy9zM9W6ucEF2NzlYyumf5LxDEo8PSZPRsMKi+1NesniTBNdVoSxofbJSXPAPNB73sdjKg9zj0xGORiz0ZdziqrTbmuxspMzi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Pgwu1Knq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Pgwu1Knq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9995ce866so1506665ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792179433; x=1792784233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aTPtWymi9zdwDJM+3urHno8w3H1cvHLVIpkldRRaktc=;
        b=Pgwu1KnqrKKJcqPgbgBs+lPS8n+0FBPp+8lg8yK3qjhnGI6tc+S6SAIL8xmzci54U+
         i2Zwnwb31kJ52icJ9WNU8JoafmwY1kjcnFmZYOcCGA1A3QX0Mex8UuD7ysSqV3llOPTW
         QHiFndWJiWvs8jmGPCY9STqRruZWb/h+kco5+lSr7A7Me+XwNZgAqlOs7L1oiI/f1RC4
         AwScwUD/IMbY/cvbPAhyJifXBekDlsFgMGRqLeDkhkOrzT9GiR2vB+A4xNM4gQ9sgftB
         fquRsszfAN+3ctc834TOcJLSv1+UOtNM5FocQfX2oO3vc286DuyE91ed4NuNva5RBr4G
         4GuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179433; x=1792784233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aTPtWymi9zdwDJM+3urHno8w3H1cvHLVIpkldRRaktc=;
        b=IoFZW6zKfj8tnKRnjZ+mIztAOrweLhgnwQm/YQHQSB/f4M1HxtP71ziiD7NuN9i+IL
         FSaw785PfZeWH55PCmi9/3N0q96b7/3pVs2O/uCbCjC/vm565sdS/RMhiBNJS40bogUF
         FkV1FeUUejZBZD4CtLAPZwbgc/9UahXMI6nqgZpRtjD3pWNDBsxCS74EPIbhYoiVX77A
         mn6bpIXZEldmziTPz8rB+0+P9xIKw/mex9wkhpJee9ZUXmC8j5br6vv6hFNqnD93knub
         6Fi5UrheQZEqxyYjQiXpRJq5/+WcwsSargL+jzLlA8NpJisRChX2shUtsrrqTRHEhwMC
         A/oQ==
X-Gm-Message-State: AFq9FYLLxdifdkKuiInrwyZ4tBGscD9YsQM07NoH9JNV918XWUjBKxHx
	186sm77ngpREnPJNt0I/oskJ7n6EHr2kwiV1ZnMHBHluOEjmC/vc1I/oChkvNdtR7rnmzY6sIpu
	oGHTeiZwuGQ==
X-Gm-Gg: AYBFou3y8W3BDLoxDnu3aXfwVRiOWC9XAS3pjq2ONnvIAyf8WfdUhIny9dluCZjoZyY
	9OeOwjFBcqcOpQjZAWBPorvXK1pZFHd5AYQP4vCWalQMO9DtdwDIqNFaCB8QpOiDtCP1Af9dgUk
	haOZEn12LhQZkPL5nM8f1ni3SCPVZRgPDSGspk8ycEDnwo9kvxdgBytkODXXk0OitNF0sZ8RIs6
	64Zlk9x6ws8MaryWydekOOJqULBwuegsUbhqqhJ5WAnlIpwTOL6TCLhqE6uGZ7zWCRm8dGBhj05
	8BW7SEpRx5YsVGh+xo5YWJYpmHSS4b//HfMFLbaJCFwlsKsPPuHKQ4rXd/Mi+6Cw9v1CAp8elTS
	LJwZ3SgF+sGsjTp2mHyn+WM6S83QtD4L4OvYzGh0eaHC7Q6DPtdqEWgirQj2o7pDpXactUOBkaj
	C+vtC8XGHQ1e+bfqlkkjXGOkdewr86S0VKE0QLPBiEa57elY16GtQ1N927CF6PADsfseAfQj+6g
	uHNa2kJwDa7FioGFy0VOtMOAWMaMn3x+uIZ
X-Received: by 2002:a17:903:110c:b0:2e8:30dd:523d with SMTP id d9443c01a7336-2e9a68e6985mr9267785ad.13.1792179433392;
        Fri, 16 Oct 2026 12:37:13 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1f0asm14970045ad.68.2026.10.16.12.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:37:13 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 5/5] selftests/bpf: Add arena allocation race tests
Date: Fri, 16 Oct 2026 19:37:03 +0000
Message-ID: <20261016193703.9203-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016193703.9203-1-emil@etsalapatis.com>
References: <20261016193703.9203-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for races between arena frees, reallocation and user
faults:

- realloc_during_free, realloc_during_deferred_free: a synchronous
  or deferred free keeps its range allocated until it completes.
- fault_free_realloc: user and BPF views of a page stay coherent
  while it is repeatedly faulted, freed and reallocated.

Pause frees in zap_vma_range(), after the range's kernel mappings are
gone. Unlike flush_tlb_kernel_range(), which is inline on arm64, it is
generic MM code that fentry can attach to. Print why a subtest is
skipped when a tracing target is missing.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/arena_race.c     | 291 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_race.c  | 166 ++++++++++
 2 files changed, 457 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_race.c b/tools/testing/selftests/bpf/prog_tests/arena_race.c
new file mode 100644
index 000000000000..c759211407ef
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_race.c
@@ -0,0 +1,291 @@
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
+/* Skip the subtest, saying why, if @func cannot be traced with fentry. */
+static bool require_fentry_target(const char *test, const char *func)
+{
+	if (libbpf_find_vmlinux_btf_id(func, BPF_TRACE_FENTRY) > 0)
+		return true;
+	printf("%s:SKIP: %s is not an fentry target\n", test, func);
+	test__skip();
+	return false;
+}
+
+static struct arena_race *setup_arena(__u64 **addr, bool trace_zap)
+{
+	struct arena_race *skel;
+	size_t arena_sz;
+	char *base;
+	int err;
+
+	skel = arena_race__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return NULL;
+	err = bpf_program__set_autoload(skel->progs.trace_zap, trace_zap);
+	if (!ASSERT_OK(err, "trace_zap_autoload"))
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
+		printf("%s:SKIP: compiler doesn't support arena_cast\n", __func__);
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
+static void test_realloc_during_free(bool deferred)
+{
+	struct free_thread_ctx ctx = {};
+	struct arena_race *skel;
+	pthread_t thread;
+	__u64 *addr;
+	bool thread_created = false, zap_seen = false, completed = false;
+	int err;
+
+	if (!require_fentry_target(__func__, "zap_vma_range"))
+		return;
+
+	skel = setup_arena(&addr, true);
+	if (!skel)
+		return;
+
+	/* Pause the free after its TLB flush, before it releases the range. */
+	skel->bss->pause_on_zap = 1;
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
+	/* Wait until the free reaches the user zap. */
+	err = wait_for(&skel->bss->zap_entered);
+	if (!ASSERT_OK(err, "zap_entered"))
+		goto release;
+
+	zap_seen = true;
+
+	/* The range must stay allocated until the free completes. */
+	run_prog(skel->progs.try_realloc, "realloc_during_free");
+	ASSERT_NULL(skel->bss->realloc_ptr, "realloc_during_free");
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
+	ASSERT_FALSE(skel->bss->timed_out, "zap_timed_out");
+
+	if (zap_seen && completed &&
+	    !run_prog(skel->progs.try_realloc, "realloc_after_free")) {
+		ASSERT_EQ((unsigned long)skel->bss->realloc_ptr,
+			  (unsigned long)addr, "realloc_after_free");
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
+	if (test__start_subtest("realloc_during_free"))
+		test_realloc_during_free(false);
+	if (test__start_subtest("realloc_during_deferred_free"))
+		test_realloc_during_free(true);
+	if (test__start_subtest("fault_free_realloc"))
+		test_fault_free_realloc();
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_race.c b/tools/testing/selftests/bpf/progs/arena_race.c
new file mode 100644
index 000000000000..54dbd662ca70
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_race.c
@@ -0,0 +1,166 @@
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
+int pause_on_zap;
+int zap_entered;
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
+/*
+ * Pause a free while it zaps user mappings: after it cleared the kernel PTEs
+ * and flushed the TLB, but before it releases the range. zap_vma_range() is
+ * generic MM code, so it is an fentry target even where
+ * flush_tlb_kernel_range() is inline (arm64).
+ */
+SEC("?fentry/zap_vma_range")
+int BPF_PROG(trace_zap, struct vm_area_struct *vma, unsigned long address,
+	     unsigned long size)
+{
+	if ((__u32)bpf_get_current_pid_tgid() != target_tid)
+		return 0;
+	zap_entered = 1;
+	if (pause_on_zap)
+		wait_for_release();
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

