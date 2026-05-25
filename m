Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27563988E4
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779748816; cv=none; b=NEQJxoXfNW+Q7qLrxOAeNV2oes/ZCI61chiw6qIeG83/bxpKpTLXaX8lisG73TSyPVjIB3zqCvqeVos11l2sO8qfxim6/aPDIhhVSLLKCzPf+XhloFxqEmmqedlISLN7KnZfYE2cNU6FzrpO0O2EWknb4mDsD1LihdX8X7l2pmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779748816; c=relaxed/simple;
	bh=0YxIYaIYYnT/g9UM/SJ3S5sI7yCNoyHyvzipRRE+GKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epMCL9elLesD8ERJbNIF5ni+WoEbtYQDoGt6mm2viSPU8Xzzb/PtIe/q+74346T//aSjFv5eC5PPq5ctSQV+zOPNVKXfWkoP+QGleBXkYOl0IbFQxBhx4bq+WeX9Pzx4pRbkFg42IY3YR9ot6Dt8BX3io9U/r1dlhP9VqWY+Hxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f8szRBMV; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f8szRBMV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779748810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sj231GwwXetFfO9VdtBuFvxQvVdoCH2+jkbLl3qudLo=;
	b=f8szRBMVLgiMt7jMsZBoZaeZu9G7V2W8islqQiazGuMFwbCQuGkpWsNthR2awrAtd3M+Qh
	wDaOeZhwSZuBlyqGAq2SPjpZtu8eZXOvE4ZMeaf2H6aJCIeMzPOQbZIs9sbw5Md+Xw9B6j
	ODWHJpm9b27xFCZsWU39DwQkHz5aI2o=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 2/3] bpf: Avoid faultable build ID reads under mm locks
Date: Mon, 25 May 2026 15:39:47 -0700
Message-ID: <20260525223948.1920986-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260525223948.1920986-1-ihor.solodrai@linux.dev>
References: <20260525223948.1920986-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Sleepable build ID parsing can block in __kernel_read() [1], so the
stackmap sleepable path must not call it while holding mmap_lock or a
per-VMA read lock.

The issue and the fix are conceptually similar to a recent procfs
patch [2]. A similar VMA locking pattern has already been used in
PROCMAP_QUERY [3].

Resolve each covered VMA with a stable read-side reference, preferring
lock_vma_under_rcu() and falling back to mmap_read_trylock() only long
enough to acquire the VMA read lock. Take a reference to the backing
file, drop the VMA lock, and then parse the build ID through
(sleepable) build_id_parse_file().

We have to use mmap_read_trylock() (and give up on failure) in this
context because taking mmap_read_lock() is generally unsafe on code
paths reachable from BPF programs [4], and may lead to deadlocks.

[1] https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
[2] https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/
[3] https://lore.kernel.org/all/20250808152850.2580887-1-surenb@google.com/
[4] https://lore.kernel.org/bpf/2895ecd8-df1e-4cc0-b9f9-aef893dc2360@linux.dev/

Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack() helpers")
Suggested-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/stackmap.c | 109 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index e23be7d44503..c53cfd9a67cf 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -9,6 +9,7 @@
 #include <linux/perf_event.h>
 #include <linux/btf_ids.h>
 #include <linux/buildid.h>
+#include <linux/mmap_lock.h>
 #include "percpu_freelist.h"
 #include "mmap_unlock_work.h"
 
@@ -174,6 +175,109 @@ static inline void stack_map_build_id_set_valid(struct bpf_stack_build_id *id,
 		memcpy(id->build_id, build_id, BUILD_ID_SIZE_MAX);
 }
 
+struct stack_map_vma_lock {
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+};
+
+/*
+ * Acquire a stable read-side reference on the VMA covering @ip.
+ *
+ * With CONFIG_PER_VMA_LOCK=y this returns a VMA with its per-VMA read
+ * lock held and mmap_lock dropped, so the caller may sleep.
+ *
+ * With CONFIG_PER_VMA_LOCK=n it returns a VMA with mmap_lock still
+ * held; the caller must snapshot any fields it needs and pin vm_file
+ * with get_file() before stack_map_unlock_vma() drops mmap_lock, as
+ * the VMA may be split, merged, or freed after that.
+ *
+ * Returns NULL on failure, in which case no lock is held.
+ */
+static struct vm_area_struct *
+stack_map_lock_vma(struct stack_map_vma_lock *lock, unsigned long ip)
+{
+	struct mm_struct *mm = lock->mm;
+	struct vm_area_struct *vma;
+
+	/* noop under !CONFIG_PER_VMA_LOCK */
+	vma = lock_vma_under_rcu(mm, ip);
+	if (vma) {
+		lock->vma = vma;
+		return vma;
+	}
+
+	/*
+	 * Taking mmap_read_lock() is unsafe here, because the caller BPF
+	 * program might already hold it, causing a deadlock.
+	 */
+	if (!mmap_read_trylock(mm))
+		return NULL;
+
+	vma = vma_lookup(mm, ip);
+	if (!vma) {
+		mmap_read_unlock(mm);
+		return NULL;
+	}
+
+#ifdef CONFIG_PER_VMA_LOCK
+	if (!vma_start_read_locked(vma)) {
+		mmap_read_unlock(mm);
+		return NULL;
+	}
+	mmap_read_unlock(mm);
+#endif
+
+	lock->vma = vma;
+	return vma;
+}
+
+static void stack_map_unlock_vma(struct stack_map_vma_lock *lock)
+{
+#ifdef CONFIG_PER_VMA_LOCK
+	vma_end_read(lock->vma);
+#else
+	mmap_read_unlock(lock->mm);
+#endif
+	lock->vma = NULL;
+}
+
+static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *id_offs,
+						    u32 trace_nr)
+{
+	struct mm_struct *mm = current->mm;
+	struct stack_map_vma_lock lock = { .mm = mm };
+	struct vm_area_struct *vma;
+	struct file *file;
+	u64 offset;
+	u64 ip;
+
+	for (u32 i = 0; i < trace_nr; i++) {
+		ip = READ_ONCE(id_offs[i].ip);
+
+		vma = stack_map_lock_vma(&lock, ip);
+		if (!vma) {
+			stack_map_build_id_set_ip(&id_offs[i]);
+			continue;
+		}
+		if (vma_is_anonymous(vma) || !vma->vm_file) {
+			stack_map_build_id_set_ip(&id_offs[i]);
+			stack_map_unlock_vma(&lock);
+			continue;
+		}
+
+		file = get_file(vma->vm_file);
+		offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
+		stack_map_unlock_vma(&lock);
+
+		/* build_id_parse_file() may block on filesystem reads */
+		if (build_id_parse_file(file, id_offs[i].build_id, NULL))
+			stack_map_build_id_set_ip(&id_offs[i]);
+		else
+			stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
+		fput(file);
+	}
+}
+
 /*
  * Expects all id_offs[i].ip values to be set to correct initial IPs.
  * They will be subsequently:
@@ -194,6 +298,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	const unsigned char *prev_build_id = NULL;
 	int i;
 
+	if (may_fault && has_user_ctx) {
+		stack_map_get_build_id_offset_sleepable(id_offs, trace_nr);
+		return;
+	}
+
 	/* If the irq_work is in use, fall back to report ips. Same
 	 * fallback is used for kernel stack (!user) on a stackmap with
 	 * build_id.
-- 
2.54.0

