Received: from mta0.migadu.com (out-142.mta0.migadu.com [91.218.175.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288A226FDAC
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789960166; cv=none; b=f1WSVJ/8UaE3P4IGJ+rjZfuwkJ2CEhLarp50HB2Q8mgI1rgE53fP7lC9d5es5Kx5mN8GlvEWNVlTuqVSWxCILBcmwhPZO+Rp2YH8J2KqvsHu7Igd0aGpx6YWgcLkHgxy3pGNidxDvzgaCrQuhXwPrHwHBboUfcicoZ177T2tnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789960166; c=relaxed/simple;
	bh=Pr36zQGGDXb1592EAcgXlxtVmVxsnSiLjuYzQo3Q1fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rp3Di80Cgp1rfUVexleGkGGR+QSTMNxQtGNYy3fhYZZEvYPF82Et88ad0uZ3C8hO0q/ez1CJe5VUA3WlmjSoF/n5650xVSvqnjJ6IJEsCzHWU3GClWCpQyDamV0xoO1OKWz5akE6fq41SHoksjkBSuKUoDJ2SVM/ODHgolG6LWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kEiHRa+q; arc=none smtp.client-ip=91.218.175.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kEiHRa+q"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Pr36zQGGDXb1592EAcgXlxtVmVxsnSiLjuYzQo3Q1fw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789960160; v=1; x=1790564960;
 b=kEiHRa+qoL98GI3nIEwcIfue06kr2PGmVv1FnhhNYcSh8vFWgkpFD9S/O+J6O8a/+drDPVD6
 nUI7X2NJQXISXebWcprF4XdC/wgmNbpmRw7uczi0lXu9P0GJsRmKIxseBTv2bWETJIsNMLbMcxd
 3bUaQ+k/bpTWfUgbaDx6ff2Y=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 33f18758b0cca24e;
	Mon, 21 Sep 2026 03:09:19 +0000
X-Mizu-Trace-ID: 33f18758b0cca24e
X-Migadu-Flow: FLOW_OUT
From: Hui Zhu <hui.zhu@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	JP Kobryn <jp.kobryn@linux.dev>
Subject: [PATCH v13] mm/bpf: Add bpf_proactive_reclaim kfunc
Date: Mon, 21 Sep 2026 11:08:54 +0800
Message-ID: <20260921030854.17858-1-hui.zhu@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Zhu <zhuhui@kylinos.cn>

BPF programs can observe memory pressure on a cgroup, e.g. refault
stats via bpf_mem_cgroup_page_state(), but cannot act on it:
triggering reclaim requires writing to memory.reclaim, which BPF
cannot do.

Add bpf_proactive_reclaim(), a sleepable kfunc performing one
proactive reclaim pass on a memcg, like a write to memory.reclaim
but without retrying until the target is reached, so that when and
how hard to reclaim is BPF policy rather than hard-coded thresholds.
The reclaim target of a single call is capped at MEMCG_CHARGE_BATCH,
as high_work_func() does for memory.high; reclaiming more is left to
the program, which can call the kfunc once per bpf_wq callback and
stop at any point. It is limited to BPF_PROG_TYPE_SYSCALL, because
other sleepable programs may run with filesystem locks held, on
which the reclaim path could deadlock via filesystem shrinkers.

Convert MIN_SWAPPINESS, MAX_SWAPPINESS and SWAPPINESS_ANON_ONLY from
macros to an enum so that they are emitted into BTF and usable from
BPF programs via vmlinux.h.

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: JP Kobryn <jp.kobryn@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
---
Changelog:
v13:
According to the comment of Shakeel, send this patch alone.
According to the comment of JP, document
@swappiness as [MIN_SWAPPINESS, MAX_SWAPPINESS] with -1 and
SWAPPINESS_ANON_ONLY as special modes; validate -1 and
SWAPPINESS_ANON_ONLY as special values instead of range endpoints, so
the check no longer depends on the enum layout. No change in accepted
values.
v12:
Redo performance tests and update performance data.
According to the comments of Barry, fix comments issue.
Based on the AI review and my re-examination of selftests, updated the
contents below.
Express RECLAIM_SIZE in bytes so it is right on non-4K page kernels.
Drop the local PAGE_SIZE macro, RECLAIM_SIZE is now a byte count.
Remove the unused bpf_helpers.h, bpf_tracing.h and bpf_core_read.h.
Rename CLOCK_MONOTONIC_ID to CLOCK_MONOTONIC to match the kernel.
Drop the CSS_DYING test, it is never set on a cgroup's own css.
Document that the lookup fails inside rmdir(), not at last put.
Count bpf_timer_start() failures so a stalled loop is visible.
Record the kfunc errno so failure is not read as an idle cgroup.
Note that an idle tick discards the refault delta.
Reject tmpfs for /tmp and the working dir, else the workload OOMs.
Pass the mkstemp() fds to the children so no stale path is reopened.
Read the timing file with lseek() and read() on the shared fd.
Write the timing with snprintf() and write(), checking truncation.
Close the data and time fds on every cleanup path.
Remove fcntl.h, nothing calls open() any more.
Factor disable_swap() out of the two cgroup setups.
Recreate the cgroups between bench runs so both start cold.
Guard the speedup calculation against a zero baseline.
Drop the non-bench timing printf, it was noise on passing runs.
Assert only TARGET_GONE, the outcome rmdir() actually guarantees.
End the wait loop only on target_gone so later events are seen.
Compare reclaimed_bytes against 0, a check that can now fail.
Poll the keepalive reader with WNOHANG and report its exit code.
Clear reader_pid after reaping so cleanup cannot kill a new PID.
Rename the ring_buffer__poll() result to n, it counts events.
Print timer_failures and last_reclaim_err when an assert fails.
Explain why bench_printf() needs the stdout fallback and no # prefix.
v11:
According to the comments of Kumar, fix reclaim_cgroup() to not treat
a negative bpf_proactive_reclaim() return as reclaimed bytes.
According to the comments of Shakeel, shorten the commit message.
v10:
According to the comments of JP, drop redundant swap.h include, turn
swappiness macros into a BTF-visible enum, and clarify the -1 swappiness
semantics in docs and code in code patch.
report each reclaim outcome via ringbuf and wait for events with timeout
instead of sleep-polling, log workload timings instead of failing on
them, drop a debug printf, and add a TEST_MEMCG_ASYNC_RECLAIM_BENCH
baseline-comparison mode in the selftests patch.
Include the benchmark numbers in the cover letter.
v9:
According to the comments of JP, copy the motivation from the cover
letter to the commit message, restructure the kfunc documentation
to separate the direct and asynchronous calling contexts, fold the
fs-lock warning into the SYSCALL-only rationale, soften the "bounded
unit of work" wording (only the reclaim target is capped), and drop
the redundant comment above the reclaim kfunc set registration.
v8:
According to the comments of Andrew, Kumar and Shakeel, drop the
bpf_in_reclaim_context() check because the SYSCALL-only restriction
already rules out reentrancy.
According to the comments of Kumar, Add the swappiness argument to
bpf_proactive_reclaim().
v7:
According to the comments of JP, clamp the reclaim target of one
bpf_proactive_reclaim() call to MEMCG_CHARGE_BATCH so each call is
a bounded unit of work, and document the batching policy in the kfunc.
selftest: check the target cgroup for dying state before reclaiming
from it, and add the memcg_async_reclaim_dying test covering target
removal while reclaim is running.
v6:
According to the comments of Kumar and Shakeel, Restrict
bpf_proactive_reclaim() to BPF_PROG_TYPE_SYSCALL by moving it
to a dedicated kfunc set registered for that program type only, and
document the clean-process-context requirement in its kerneldoc.
v5:
According to the comments of Andrii, Kumar and Shakeel, remove
bpf_proactive_reclaim_swappiness.
v4:
According to the comments of bot+bpf-ci and sashiko, also check
current->reclaim_state to close the fentry-on-trace-iter recursion
window in bpf_in_reclaim_context.
Return bytes instead of pages ( nr * PAGE_SIZE ) in
bpf_proactive_reclaim_pages and bpf_proactive_reclaim_swappiness.
Return (unsigned long)-1 on out-of-range swappiness (was 0).
Kdoc of both kfuncs: updated Return descriptions; added FS-lock deadlock
warning to bpf_proactive_reclaim.
Fix potential child process leak in selftests.
Use _exit() instead of exit() in forked children in selftests.
Rename reclaimed_pages to reclaimed_bytes in selftests.
Fix comments issues in selftests.
v3:
According to the comments of bot+bpf-ci, add a shared helper
bpf_proactive_reclaim_pages() that is called by bpf_proactive_reclaim
and bpf_proactive_reclaim_swappiness.
According to the comments of sashiko and bot+bpf-ci, fix the issues of
selftests.
v2:
According to the comments of Shakeel Butt, replace
bpf_try_to_free_mem_cgroup_pages() with
bpf_proactive_reclaim(memcg, size) and
bpf_proactive_reclaim_swappiness(memcg, size, swappiness).
According to the comments of Kumar Kartikeya Dwivedi, drop patch 2
and patch 3.
Remove bpf_thread_wq code in patch 4.
According to the comments of sashiko-bot, fix the issues of selftests.

 mm/bpf_memcontrol.c | 65 ++++++++++++++++++++++++++++++++++++++++++++-
 mm/internal.h       | 10 ++++---
 2 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 716df49d7647..d8f579c28560 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -8,6 +8,8 @@
 #include <linux/memcontrol.h>
 #include <linux/bpf.h>
 
+#include "internal.h"
+
 __bpf_kfunc_start_defs();
 
 /**
@@ -159,6 +161,51 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 	mem_cgroup_flush_stats(memcg);
 }
 
+/**
+ * bpf_proactive_reclaim - proactively reclaim memory from a memory cgroup
+ * @memcg: the target memory cgroup to reclaim from.
+ * @size: the amount of memory to reclaim, in bytes, clamped to
+ *        MEMCG_CHARGE_BATCH.
+ * @swappiness: the reclaim swappiness, in the range [MIN_SWAPPINESS,
+ *              MAX_SWAPPINESS], or one of the special modes: -1 to use
+ *              the memcg's own swappiness, or SWAPPINESS_ANON_ONLY to
+ *              reclaim only anon folios.
+ *
+ * Performs one proactive reclaim pass on @memcg, like a write to
+ * memory.reclaim but without retrying until @size is reached. Call it
+ * repeatedly to reclaim more than one batch.
+ *
+ * Only available to BPF_PROG_TYPE_SYSCALL, because other sleepable programs
+ * may run with filesystem locks held, which the reclaim path can deadlock
+ * on via filesystem shrinkers.
+ *
+ * Return: The amount of memory reclaimed, in bytes, or a negative error.
+ */
+__bpf_kfunc long bpf_proactive_reclaim(struct mem_cgroup *memcg,
+				       unsigned long size,
+				       int swappiness)
+{
+	unsigned long nr_reclaimed;
+	unsigned long nr_pages;
+
+	if (swappiness != -1 && swappiness != SWAPPINESS_ANON_ONLY) {
+		if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
+			return -EINVAL;
+	}
+
+	if (size < PAGE_SIZE)
+		return -EINVAL;
+
+	nr_pages = min(size / PAGE_SIZE, (unsigned long)MEMCG_CHARGE_BATCH);
+
+	nr_reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
+						    MEMCG_RECLAIM_MAY_SWAP |
+						    MEMCG_RECLAIM_PROACTIVE,
+						    swappiness == -1 ? NULL : &swappiness);
+
+	return nr_reclaimed * PAGE_SIZE;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
@@ -174,19 +221,35 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
 
 BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
 
+BTF_KFUNCS_START(bpf_memcontrol_reclaim_kfuncs)
+BTF_ID_FLAGS(func, bpf_proactive_reclaim, KF_SLEEPABLE)
+BTF_KFUNCS_END(bpf_memcontrol_reclaim_kfuncs)
+
 static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
 	.owner          = THIS_MODULE,
 	.set            = &bpf_memcontrol_kfuncs,
 };
 
+static const struct btf_kfunc_id_set bpf_memcontrol_reclaim_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_memcontrol_reclaim_kfuncs,
+};
+
 static int __init bpf_memcontrol_init(void)
 {
 	int err;
 
 	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
 					&bpf_memcontrol_kfunc_set);
-	if (err)
+	if (err) {
 		pr_warn("error while registering bpf memcontrol kfuncs: %d", err);
+		return err;
+	}
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
+					&bpf_memcontrol_reclaim_kfunc_set);
+	if (err)
+		pr_warn("error registering bpf reclaim kfuncs: %d\n", err);
 
 	return err;
 }
diff --git a/mm/internal.h b/mm/internal.h
index 7c326965a94f..9e3be236f18c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -77,11 +77,13 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
 
 #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
 #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
-#define MIN_SWAPPINESS 0
-#define MAX_SWAPPINESS 200
+enum {
+	MIN_SWAPPINESS = 0,
+	MAX_SWAPPINESS = 200,
 
-/* Just reclaim from anon folios in proactive memory reclaim */
-#define SWAPPINESS_ANON_ONLY (MAX_SWAPPINESS + 1)
+	/* Just reclaim from anon folios in proactive memory reclaim */
+	SWAPPINESS_ANON_ONLY = MAX_SWAPPINESS + 1,
+};
 
 unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 					   unsigned long nr_pages,
-- 
2.43.0

