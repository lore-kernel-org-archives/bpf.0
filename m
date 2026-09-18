Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0A381E83
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714769; cv=none; b=thn7QNQ+ojtoxkTX3RAiutzxKEZzW0Kk5AhVSVOmgr/ebf+MT8H2Oq58j8df7rNb19PBK+WwxtB3gCNWnOQVGJQ1hyEVaGe17kfn91+29NHb0RpKBMtQUWLJSAHvWzBAzwfRcjnsbBghdavYgXFEDvyCie9OT8KnJ2C7aOMbQo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714769; c=relaxed/simple;
	bh=W0yWpOmoDzib5Rm1x8YliOd+9RxKMkDx4q1dFk81TOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBUTZ+NSFPQ7UqMLaGq/Pio+sU5ErOxnmngIz3vNi+IwoAelRwxZGL5l3wAZm1lwj4wlXDGODy//ZxYjxhm/blEcZESYk8Wnh4dV/m065ow5x8XTXr6z1VRLak2/3PNzQzIqa55i4FUlK2sguiki2Gq8smjuS6oXK0B7Wu9iWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YdFtWTw2; arc=none smtp.client-ip=91.218.175.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YdFtWTw2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=W0yWpOmoDzib5Rm1x8YliOd+9RxKMkDx4q1dFk81TOc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789714765; v=1; x=1790319565;
 b=YdFtWTw2KSolwL7n3FG0tP8R1bXskkQ90ZjBrqY2J9FpC/AxdhZphSFGlqPeUdEL5QNRQimU
 1CJH2kItItgFJ45CSSN5s21NYLksERMhH3C982Onk45FE9EcDv3E5OyJudeUPwdKEHdu/QSm3Ti
 3HyGJu5k/U9I8XKz3ZwnO/c0=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 06b45d8891529b42;
	Fri, 18 Sep 2026 06:59:25 +0000
X-Mizu-Trace-ID: 06b45d8891529b42
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
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v12 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
Date: Fri, 18 Sep 2026 14:58:53 +0800
Message-ID: <02f0a8dc45a840d7801ec17e0c1168f7dacf9b73.1789714023.git.zhuhui@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789714023.git.zhuhui@kylinos.cn>
References: <cover.1789714023.git.zhuhui@kylinos.cn>
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
---
 mm/bpf_memcontrol.c | 62 ++++++++++++++++++++++++++++++++++++++++++++-
 mm/internal.h       | 10 +++++---
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 716df49d7647..c5d7f29ade85 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -8,6 +8,8 @@
 #include <linux/memcontrol.h>
 #include <linux/bpf.h>
 
+#include "internal.h"
+
 __bpf_kfunc_start_defs();
 
 /**
@@ -159,6 +161,48 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 	mem_cgroup_flush_stats(memcg);
 }
 
+/**
+ * bpf_proactive_reclaim - proactively reclaim memory from a memory cgroup
+ * @memcg: the target memory cgroup to reclaim from.
+ * @size: the amount of memory to reclaim, in bytes, clamped to
+ *        MEMCG_CHARGE_BATCH.
+ * @swappiness: the reclaim swappiness, in the range [MIN_SWAPPINESS,
+ *              SWAPPINESS_ANON_ONLY], or -1 to use the memcg's own
+ *              swappiness.
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
+	if (swappiness < -1 || swappiness > SWAPPINESS_ANON_ONLY)
+		return -EINVAL;
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
@@ -174,19 +218,35 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
 
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
index 38b1165212c9..44e95e87e3cd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -74,11 +74,13 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
 
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

