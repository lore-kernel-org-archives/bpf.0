Received: from mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA64411F8D
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042211; cv=none; b=djBQIDMouBAzz/2o2p/LIl76t3ln7NRanqK5sshrkABMeFZB/ofc3FFBrWlT33CJoVWxLf1S4LPRONZ/7kSxVXKiVF3hGhwqdYI7CZHHxhe6cI06yQ5Lk52GcpcZ3vI7gMPOtRSDT14dQTDlFxiHlMz011tG+GBBpWWOJJ/iEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042211; c=relaxed/simple;
	bh=GReinsz2jYAS8LuTZNxhDAjdV+gzaBJE35QjgXUsYGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4e+ZuZJ22KQSoxpCcKas8YpwBiRT8xM+gn3FN1h+fUCdILG+twtnQ7xGiXfoHPvC8GfVQS6ZwV430ZfRzGwJB759e/dKe2WOwwJjA2hzDnHLgXUh1dFKQwcWS8o3+1EC0I0dekkjhpBDp9W5FudZY2Fg7uTnRZuMnogTgiJG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AxS2nSI5; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AxS2nSI5"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GReinsz2jYAS8LuTZNxhDAjdV+gzaBJE35QjgXUsYGo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787042207; v=1; x=1787647007;
 b=AxS2nSI5T8MCMdlY4J0xF1udO87vv2cvYoZxK572h8blAIFgw+OVEhqQaZdFZNuL8pmbXHHq
 GlGxa9gerpVRAkodzse4ToWFbEsFfxN5sqT7IVVzWAcYa8oL0JQKOTYjmqtkk2XRlYpwVVgvCoQ
 I/7cOIyFN7v/h94oNiLdPA2M=
X-Envelope-To: bpf@vger.kernel.org
Received: from teawater-KVM-Virtual-Machine (39.156.73.13)
	by smtp.migadu.com with ESMTPS id f63cb70c360e837f;
	Tue, 18 Aug 2026 08:36:47 +0000
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
Subject: [PATCH bpf-next v2 1/2] mm/bpf: Add bpf_proactive_reclaim kfuncs
Date: Tue, 18 Aug 2026 16:36:09 +0800
Message-ID: <ea02caf3118cfc34cb9845f75ac655abf04b7b9f.1787040082.git.zhuhui@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787040082.git.zhuhui@kylinos.cn>
References: <cover.1787040082.git.zhuhui@kylinos.cn>
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
plus SWAPPINESS_ANON_ONLY. Both delegate to
try_to_free_mem_cgroup_pages() with GFP_KERNEL and
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
 mm/bpf_memcontrol.c | 95 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 716df49d7647..92272f9a5825 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/memcontrol.h>
+#include <linux/swap.h>
 #include <linux/bpf.h>
 
 __bpf_kfunc_start_defs();
@@ -159,6 +160,97 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
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
+	unsigned long nr_pages = size / PAGE_SIZE;
+
+	if (!nr_pages || unlikely(bpf_in_reclaim_context()))
+		return 0;
+
+	return try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
+					    MEMCG_RECLAIM_MAY_SWAP |
+					    MEMCG_RECLAIM_PROACTIVE, NULL);
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
+	unsigned long nr_pages = size / PAGE_SIZE;
+
+	if (!nr_pages || swappiness < MIN_SWAPPINESS ||
+	    swappiness > SWAPPINESS_ANON_ONLY ||
+	    unlikely(bpf_in_reclaim_context()))
+		return 0;
+
+	return try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
+					    MEMCG_RECLAIM_MAY_SWAP |
+					    MEMCG_RECLAIM_PROACTIVE,
+					    &swappiness);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_memcontrol_kfuncs)
@@ -172,6 +264,9 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
 BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
 BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
 
+BTF_ID_FLAGS(func, bpf_proactive_reclaim, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_proactive_reclaim_swappiness, KF_SLEEPABLE)
+
 BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
 
 static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
-- 
2.53.0

