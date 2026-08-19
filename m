Received: from mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF093D25A2
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121366; cv=none; b=CTcQWTQA/fzW6qPkKlZBanymVw7zEXW4P/UNRlUCW+MWcuiSuPt1ms4D8H3Z19VbCNgbGt8JF7+X8xiFelYvVZJfpiJ1ezTyaA0/iKaxHoJnoRBQ6dlYGhuDzp1T+XRy+HE8BvMDKo1LU1QHlp3+hnSxIt3KN/2dQESN2IweNNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121366; c=relaxed/simple;
	bh=OCyFphCtNGo59EIP+zqGbTU7uKKjAFjnRoVLUS82u0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiN/DQI76KS+G+N789yZaUawOqOGvzEe/lYSQ2dguAGFZMnyMEjPqPjKbXve1ZwXT3hJasDFval5ahK2lJ/EZ8jP4ngCmd6Jcr4Jpbrq/aW6yUtW0hoPm9DBMs2mlG4iXJDlrgEMtCPe/YXH7A8ZdJCzfJuwx4i9OcCVII7PVC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UTEpmTvb; arc=none smtp.client-ip=91.218.175.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UTEpmTvb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OCyFphCtNGo59EIP+zqGbTU7uKKjAFjnRoVLUS82u0k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787121360; v=1; x=1787726160;
 b=UTEpmTvbQGZsqLK7z96qIls76dcbHZO+9yzzvr1NAKbqrrBylTQfKXOq7HTOglyWxGPZgISd
 jOrf1C0IMoC6IB4uSqJ5ppVG+No4vrfO6RZC2UqDgP2xjyRn0ttt0OyxrCl4Ci0bzNJJymHIR6f
 8rIe+kZYVVQYVicvQb8SW2Hk=
X-Envelope-To: bpf@vger.kernel.org
Received: from teawater-KVM-Virtual-Machine (39.156.73.13)
	by smtp.migadu.com with ESMTPS id 231faae9ec5b32d1;
	Wed, 19 Aug 2026 06:36:00 +0000
X-Migadu-Flow: FLOW_OUT
From: "Hui Zhu" <hui.zhu@linux.dev>
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
	Barry Song <baohua@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v3 1/2] mm/bpf: Add bpf_proactive_reclaim kfuncs
Date: Wed, 19 Aug 2026 14:35:43 +0800
Message-ID: <0a2355a169c0900427b6e3c0d73ca6ae1be56f13.1787120833.git.zhuhui@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787120833.git.zhuhui@kylinos.cn>
References: <cover.1787120833.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Zhu <zhuhui@kylinos.cn>

Expose memcg proactive reclaim to sleepable BPF programs:
unsigned long bpf_proactive_reclaim(memcg, size);
unsigned long bpf_proactive_reclaim_swappiness(memcg, size, swappiness);

They perform one reclaim pass on @memcg, like a write to memory.reclaim:
swap is allowed, and the anon/file balance follows the cgroup's
swappiness or an explicit override in [MIN_SWAPPINESS, MAX_SWAPPINESS]
plus SWAPPINESS_ANON_ONLY. Both go through a shared helper,
bpf_proactive_reclaim_pages(), which guards against reclaim recursion
and calls try_to_free_mem_cgroup_pages() with GFP_KERNEL and
MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE, the same parameters
user_proactive_reclaim() uses, and unlike memory.reclaim they do not
retry until @size is reached.

Reclaim must not recurse: try_to_free_mem_cgroup_pages() overwrites
current->reclaim_state on entry and NULLs it on exit, so a nested call
from an in-flight reclaim would corrupt the outer reclaim state (e.g.
MGLRU dereferences current->reclaim_state->mm_walk). Both kfuncs
therefore refuse to reclaim when PF_MEMALLOC is set, mirroring the
guards in the memcg charging path and node_reclaim().

Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 mm/bpf_memcontrol.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 716df49d7647..b0a0d4c55dc4 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/memcontrol.h>
+#include <linux/swap.h>
 #include <linux/bpf.h>
 
 __bpf_kfunc_start_defs();
@@ -159,6 +160,103 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 	mem_cgroup_flush_stats(memcg);
 }
 
+/*
+ * Reclaim must not recurse. try_to_free_mem_cgroup_pages() unconditionally
+ * overwrites current->reclaim_state on entry and resets it to NULL on exit.
+ * So invoking it from an in-flight reclaim would clobber the outer reclaim
+ * state and corrupt its accounting.
+ *
+ * The guard is PF_MEMALLOC. Every reclaim entry point marks the current
+ * task with it for the whole reclaim window: try_to_free_mem_cgroup_pages()
+ * and __perform_reclaim() do so via memalloc_noreclaim_save(), and kswapd
+ * keeps it set for its entire lifetime. A hook inside the reclaim path
+ * (shrink_node, shrink_slab, ...) executes in the context of the
+ * reclaiming task, where current->flags already carries the flag. The page
+ * allocator, the memcg charging path and node_reclaim() rely on the same
+ * flag to avoid reclaim recursion.
+ *
+ * In try_to_free_mem_cgroup_pages(), reclaim_state is set slightly before
+ * PF_MEMALLOC, with only a tracepoint in between, which a sleepable BPF
+ * program cannot attach to.
+ * Also, PF_MEMALLOC is set in some non-reclaim contexts (e.g. direct compaction
+ * and vmalloc), where the kfunc conservatively refuses to reclaim as well.
+ */
+static bool bpf_in_reclaim_context(void)
+{
+	return current->flags & PF_MEMALLOC;
+}
+
+/*
+ * Shared implementation of the proactive reclaim kfuncs: performs one
+ * reclaim pass on @memcg with @nr_pages as the goal, allowing swap, and
+ * @swappiness as the anon/file balance override (NULL to follow the
+ * cgroup's own swappiness setting).
+ */
+static unsigned long
+bpf_proactive_reclaim_pages(struct mem_cgroup *memcg, unsigned long nr_pages,
+			    int *swappiness)
+{
+	if (!nr_pages || unlikely(bpf_in_reclaim_context()))
+		return 0;
+
+	return try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
+					    MEMCG_RECLAIM_MAY_SWAP |
+					    MEMCG_RECLAIM_PROACTIVE,
+					    swappiness);
+}
+
+/**
+ * bpf_proactive_reclaim - proactively reclaim memory from a memory
+ *                         cgroup
+ * @memcg: the target memory cgroup to reclaim from
+ * @size:  the amount of memory to reclaim, in bytes
+ *
+ * Trigger one proactive reclaim pass on @memcg, similar to a write to
+ * the memory.reclaim cgroup file: pages are reclaimed according to the
+ * cgroup's own swappiness setting and swap is allowed. Note that,
+ * unlike memory.reclaim, this does not retry until @size is reached;
+ * callers can invoke it again if needed.
+ *
+ * Return:
+ *   The number of pages actually reclaimed, or 0 if @size is smaller
+ *   than a page or the calling task is already in a reclaim/freeing
+ *   context (PF_MEMALLOC).
+ */
+__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memcg,
+						unsigned long size)
+{
+	return bpf_proactive_reclaim_pages(memcg, size / PAGE_SIZE, NULL);
+}
+
+/**
+ * bpf_proactive_reclaim_swappiness - proactively reclaim memory from a
+ *                                    memory cgroup with an explicit
+ *                                    swappiness
+ * @memcg:      the target memory cgroup to reclaim from
+ * @size:       the amount of memory to reclaim, in bytes
+ * @swappiness: swappiness override for this reclaim pass
+ *
+ * Same as bpf_proactive_reclaim(), except that the anon/file reclaim
+ * balance is controlled by @swappiness instead of the cgroup's
+ * swappiness setting. Valid values are [MIN_SWAPPINESS, MAX_SWAPPINESS]
+ * and SWAPPINESS_ANON_ONLY, which restricts reclaim to anon folios.
+ *
+ * Return:
+ *   The number of pages actually reclaimed, or 0 if @size is smaller
+ *   than a page, @swappiness is out of range, or the calling task is
+ *   already in a reclaim/freeing context (PF_MEMALLOC).
+ */
+__bpf_kfunc unsigned long
+bpf_proactive_reclaim_swappiness(struct mem_cgroup *memcg, unsigned long size,
+				 int swappiness)
+{
+	if (swappiness < MIN_SWAPPINESS || swappiness > SWAPPINESS_ANON_ONLY)
+		return 0;
+
+	return bpf_proactive_reclaim_pages(memcg, size / PAGE_SIZE,
+					   &swappiness);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
@@ -172,6 +270,9 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
 BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
 BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
 
+BTF_ID_FLAGS(func, bpf_proactive_reclaim, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_proactive_reclaim_swappiness, KF_SLEEPABLE)
+
 BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
 
 static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
-- 
2.53.0

