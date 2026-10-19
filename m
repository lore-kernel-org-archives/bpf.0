Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440675;
	b=TjAmkkHXqId0l1N59wf5efyDpBCA9ZpaP76mhMqrEbCR/GEPHgAWHjNT4ngID5Zdt8Uo
	 6K4aA7P9vjfD12DNVWUb6/sVkMCwqmd+7WZml9L6UKQpjE5lHSFgeKvCuQhvtQZ+Adt5M
	 4cXlKbjmfeMdusuWnExUmH3xVlo5L2QaPLg4LGoKudKlDL7QEKPTajSw8iSEisEnKnRae
	 or+lW4V3y5Kg5K7bofbYv5LZ+OBuzWl5ftteLjTlD0dCzABIfvCez9vXpjhZZITfKdhtz
	 QxCOa0uUIT9Evfy2KB3XUN7iTWCqzFM+d9KEu1FUkKoVlvmIi9+XsjWEoH4RJkUbxcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PiWD2V7RBAT6W4UF4okilwpy/RhBQgXKW9zIhcL3U0A=;
	b=A1vGsz6NKPJE5BWlEKJo5YOva7l7LuTe8rLISKhtryxB1RnrykhxbCuCGKk8OMNiMPXM
	 IDzypsHD0EUo/l95IxnDI2cmIrE/ME0rmgWG1YdXDpt/wSusIP6z4hDdnSygvfJUqhAvj
	 oqgaBq+8vdHI+tpDCZ6V9FbhlxBynkOU2FfJANN6hCSle4bGMMW5eiKWMPbHW7azYfoeG
	 Sz4WUZb5UD5fGULYjHKK7Xf3mx14X9kblTQ/6vmzr6gGLAD7o4G/nrtLfGZMLR6I58u+5
	 4ciaCo6iaCvU3OAaJ2rrdKt1HaYmTnOdugeRuE7yXXzn5Tm7ZeNzmLJiHWt/OkON5+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=iXFcgVZH;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F592606A320
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 20:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F592606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=iXFcgVZH
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e831e86ebfso11873495ad.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792440674; x=1793045474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PiWD2V7RBAT6W4UF4okilwpy/RhBQgXKW9zIhcL3U0A=;
        b=iXFcgVZHwEp6GjozEglYEqyrdIAxxdgpbMcIL2qt2rFvMK8Y80DiYu7HWPNmi6r7Ml
         ceHUTjxM8iUpROcDo0SStbdZ3joQ8X5qIlpZkG4wotoppM825K+Dpq7lpWVupG8Ef1+4
         XsWMzflyTAqlVCpqf+posogNRVAs/2QcTVHiza2kBdNcLWxsvkWd1m/AW9eEpABhraz/
         PQtDhuLEPhFIYRK9s9ep4ngtgH3AX/5D7S3L9v0FT/GkLhvT2YVf4iELTmdMPZJhLGfj
         sCySzzzoaU5Yx/AKpWQPCGJxjZzZO/RsghKTR3qJZvSlLKJVij5RNNE7LgCUB4mFcBk0
         WjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440674; x=1793045474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PiWD2V7RBAT6W4UF4okilwpy/RhBQgXKW9zIhcL3U0A=;
        b=UVDpAQdMYmw9IkVMOSsuMI8W1kuDbwOcUohNyvLSYQKsF6XUmU39HqFsGwdzLlcYQK
         gcH+w1uSUf/iQtCQAywY0/c4qTAO5xUMcuQz+2TKspRnxeZfsrFzzmgOMGmnwFgfwsXK
         zL9ddcIR1S6blShZx8pION2Kl3dEjHf4+uNKgS7SFGPpsyQjZh/iEJo/aOrQyPx75jeA
         l0Em0CAcdYeTFgI4VaC7npii6P2g0NbYHVdEONG6CTebKGso7iPF6yFpMlwRWvfS+V8q
         PafPXan3O3OtaUxUqdJi7ac4pPzgSm9+2H/nPYVdl9d46pRZMKctVKY648wYNPD0/2Mp
         1wWw==
X-Gm-Message-State: AFq9FYIkETcuhax6S9DcrA/tU13Yf3gCxXEOircE+J1fJudD6e/sF8O/
	cCNbyU8p5HVqJugk25E1aOM1gFdqUzu7xQM7VUacuW5DZ7cLmtQHoI0MWPI0YQ0XxRKn9Gag5jq
	D2CEme1s=
X-Gm-Gg: AYBFou3ejahkQ5EyzXGNbpCZtDDZUL4YVZC76OU+HtUDHyoNiTFSXH+JLUv5bYUfGVt
	pv5MnCqABAk/5ag3smZVJZkpPWU5ZYdOlA45pzb9FbJEQAjociNuYXwOQ1zjEFbLC4rNrjSW30X
	hz1uU21koFwTPeGosGhZCJ1XK8GSD50myRGzio+XqvZPVIu2QYFzhryMdOAmRn6r/V4x/nvgxw7
	MOGaR3ygSBJl+pNZkeSP/NJJHU7Js2X0+vojXnr2G8UYqimWwKX3TJV38aC8ykJdI0WclWozwAH
	gV1zHv8qfmRTO1d3Epl3291Y0fuwsAphDJ7MtD8zS1NenVyDqVNCqou8qh0lgLFMVQM6E9zT3/g
	Pm4S7fe5aec98OyldEvh/wWs40k9GtS7I1pfJZABBlKYzMcXThHUr1pM2ZloK2J4scaCREa6drU
	tVWVQMFl2E8RqXBcCg2Jhy85UahEbnT8t7jpE8/y+CTj2eY3Y1/8X3tDQyrNt3y8FS8y2Q+K1DU
	ppwVhOclsZbQbWmshk5AFVvFA8wvyomwfRk
X-Received: by 2002:a17:902:e547:b0:2e8:93b5:c555 with SMTP id d9443c01a7336-2e9a6e5296emr70722575ad.61.1792440674147;
        Mon, 19 Oct 2026 13:11:14 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151818f0sm5102585ad.65.2026.10.19.13.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:11:13 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 3/3] selftests/bpf: Add arena allocation race tests
Date: Mon, 19 Oct 2026 20:11:08 +0000
Message-ID: <20261019201108.4552-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019201108.4552-1-emil@etsalapatis.com>
References: <20261019201108.4552-1-emil@etsalapatis.com>
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

Add selftests for races between arena frees, reallocation and user
faults:

- realloc_during_free, realloc_during_deferred_free: a synchronous
  or deferred free keeps its range allocated until it completes.
- fault_free_realloc: user and BPF views of a page stay coherent
  while it is repeatedly faulted, freed and reallocated.

Pause frees in zap_vma_range(), after the range's kernel mappings are
gone. Unlike flush_tlb_kernel_range(), which is inline on arm64, it is
generic MM code that fentry can attach to. Map the page into user space
first, so that the free has to zap it. Print why a subtest is skipped
when a tracing target is missing. The reader in fault_free_realloc skips
reads that raise SIGBUS, which a fault on a page that is being freed
does.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/prog_tests/arena_race.c     | 320 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_race.c  | 166 +++++++++
 2 files changed, 486 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_race.c b/tools/testing/selftests/bpf/prog_tests/arena_race.c
new file mode 100644
index 000000000000..f9d0e9c3a006
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_race.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <sched.h>
+#include <setjmp.h>
+#include <signal.h>
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
+static __thread sigjmp_buf reader_env;
+static __thread bool reader_armed;
+
+/* Only the reader expects SIGBUS; anywhere else it keeps its default action. */
+static void reader_sigbus(int sig)
+{
+	if (!reader_armed) {
+		signal(sig, SIG_DFL);
+		raise(sig);
+		return;
+	}
+	siglongjmp(reader_env, 1);
+}
+
+/* Continuously fault in the address. */
+static void *fault_reader_thread(void *arg)
+{
+	struct fault_thread_ctx *ctx = arg;
+	__u64 *addr;
+
+	/* Touching a page while BPF frees it raises SIGBUS; skip that read. */
+	sigsetjmp(reader_env, 1);
+	reader_armed = true;
+	while (!READ_ONCE(ctx->stop)) {
+		addr = __atomic_load_n(&ctx->addr, __ATOMIC_ACQUIRE);
+		(void)READ_ONCE(*addr);
+	}
+	reader_armed = false;
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
+	/* Map the page into user space, so that the free has to zap it. */
+	if (!ASSERT_EQ(READ_ONCE(*addr), skel->rodata->old_marker, "old_marker"))
+		goto out;
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
+	struct sigaction sigbus = { .sa_handler = reader_sigbus }, old_sigbus;
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
+	if (!ASSERT_OK(sigaction(SIGBUS, &sigbus, &old_sigbus), "sigaction_sigbus"))
+		goto out_destroy;
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
+	sigaction(SIGBUS, &old_sigbus, NULL);
+out_destroy:
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

