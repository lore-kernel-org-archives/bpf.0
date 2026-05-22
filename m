Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01A37C11D;
	Fri, 22 May 2026 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470551; cv=none; b=SUCtVvhGizvMFcKBgZPfm7aUNWR4QcEK1dUHWb+ur2vNZ6+bVJKlhduOtUbrorO+czOMgiagRHh0xr7oHZj3wbgTDLh2LB/u1h33G/1zJc4MdkfEJIHrp1FY7kc9IcKQrKv7BgKRZwQE3xOh101VPVfk7N6xahAM12dcf7VqxR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470551; c=relaxed/simple;
	bh=oRzrnvy2BsPVeG5NZvqzAzgKqVyKYyV2DA+1SsP2Vpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDCioh0KBw7ubx9xc0u/0GMlSmN0G0vJjd5AiaMbg5zRnthX1y+Kxu97FOuqVJk04b5h4d43LHQj4XKFbc8RGQGi5W7vyYPNVmTxWIhYt5gclA+B4r2I1LilJT/1iEjQsH69q7wKZQTlr24VgXVwkX9V07zFOBptxPSwTf+lUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3sn00kP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3sn00kP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27791F00A3F;
	Fri, 22 May 2026 17:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470547;
	bh=eX0Mxlx1n6AwVGSB1X8Y1otXtKX0cegACAfNOUMD+j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M3sn00kPfnYp6fE1gGLPv/h1VIy9g2pURe2Jpw3twBNUcNRpIyFQj7Y6Hkpjdengy
	 D6OhOuIU8sTcjA3WC5lEVdWFcLRZokaEnCKxrfZeKx3NkZ3lcd/yFhs3K4wabzpZKI
	 y7kD+UiLJGsou+kSioRuvxcpMc22Z18oF3d1cuZg3CV0mkcWebD7iCjpWTHVjTPj9/
	 M68qrDqANsf+jVp3h0QB10D14m3Mr8mza144wa03yEyXzHPFFsJc1TfM4YFHUFnV4+
	 zbpbTS4KZligU+2AkAIc3AcLkIf1u1TSpOf4kgMfdtdnaWvjsEa6EEIFL/2tEbKeZF
	 zpEkCyQ9q1kXw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 8/8] sched_ext: Convert ops.set_cmask() to arena-resident cmask
Date: Fri, 22 May 2026 07:22:19 -1000
Message-ID: <20260522172219.1423324-9-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522172219.1423324-1-tj@kernel.org>
References: <20260522172219.1423324-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ops_cid.set_cmask() expects a cmask. The kernel couldn't write into the
arena, so it translated cpumask -> cmask in kernel memory and passed the
result as a trusted pointer. The BPF cmask helpers all operate on arena
cmasks though, so the BPF side had to word-by-word probe-read the kernel
cmask into an arena cmask via cmask_copy_from_kernel() before any helper
could touch it. It works, but is clumsy.

With direct kernel-side arena access now in place, build the cmask in the
arena. The kernel writes to it through the kern_va side of the dual mapping.
BPF directly dereferences it via an __arena pointer like any other arena
struct.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/sched/ext.c                    | 68 +++++++++++++++++++++++++--
 kernel/sched/ext_cid.c                | 20 +-------
 kernel/sched/ext_internal.h           | 10 +++-
 tools/sched_ext/include/scx/cid.bpf.h | 52 --------------------
 tools/sched_ext/scx_qmap.bpf.c        |  5 +-
 5 files changed, 75 insertions(+), 80 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fb91079c1244..94562e3350c6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -621,11 +621,16 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 		update_locked_rq(rq);
 
 	if (scx_is_cid_type()) {
-		struct scx_cmask *cmask = this_cpu_ptr(scx_set_cmask_scratch);
-
-		lockdep_assert_irqs_disabled();
-		scx_cpumask_to_cmask(cpumask, cmask);
-		sch->ops_cid.set_cmask(task, cmask);
+		struct scx_cmask *kern_va = *this_cpu_ptr(sch->set_cmask_scratch);
+		unsigned long uaddr = (unsigned long)kern_va -
+			bpf_arena_map_kern_vm_start(sch->arena_map);
+		/*
+		 * Build the per-CPU arena cmask and hand BPF the uaddr. Caller
+		 * holds the rq lock with IRQs disabled, which makes us the sole
+		 * user of the scratch area.
+		 */
+		scx_cpumask_to_cmask(cpumask, kern_va);
+		sch->ops_cid.set_cmask(task, (struct scx_cmask *)uaddr);
 	} else {
 		sch->ops.set_cpumask(task, cpumask);
 	}
@@ -4949,6 +4954,48 @@ static const struct attribute_group scx_global_attr_group = {
 static void free_pnode(struct scx_sched_pnode *pnode);
 static void free_exit_info(struct scx_exit_info *ei);
 
+static s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch)
+{
+	size_t size = struct_size_t(struct scx_cmask, bits,
+				    SCX_CMASK_NR_WORDS(num_possible_cpus()));
+	int cpu;
+
+	if (!sch->is_cid_type || !sch->arena_pool)
+		return 0;
+
+	sch->set_cmask_scratch = alloc_percpu(struct scx_cmask *);
+	if (!sch->set_cmask_scratch)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct scx_cmask **slot = per_cpu_ptr(sch->set_cmask_scratch, cpu);
+
+		*slot = scx_arena_alloc(sch, size);
+		if (!*slot)
+			return -ENOMEM;
+		scx_cmask_init(*slot, 0, num_possible_cpus());
+	}
+	return 0;
+}
+
+static void scx_set_cmask_scratch_free(struct scx_sched *sch)
+{
+	size_t size = struct_size_t(struct scx_cmask, bits,
+				    SCX_CMASK_NR_WORDS(num_possible_cpus()));
+	int cpu;
+
+	if (!sch->set_cmask_scratch)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct scx_cmask **slot = per_cpu_ptr(sch->set_cmask_scratch, cpu);
+
+		scx_arena_free(sch, *slot, size);
+	}
+	free_percpu(sch->set_cmask_scratch);
+	sch->set_cmask_scratch = NULL;
+}
+
 static void scx_sched_free_rcu_work(struct work_struct *work)
 {
 	struct rcu_work *rcu_work = to_rcu_work(work);
@@ -5003,6 +5050,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 
 	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
 	free_exit_info(sch->exit_info);
+	scx_set_cmask_scratch_free(sch);
 	scx_arena_pool_destroy(sch);
 	if (sch->arena_map)
 		bpf_map_put(sch->arena_map);
@@ -7162,6 +7210,12 @@ static void scx_root_enable_workfn(struct kthread_work *work)
 		goto err_disable;
 	}
 
+	ret = scx_set_cmask_scratch_alloc(sch);
+	if (ret) {
+		cpus_read_unlock();
+		goto err_disable;
+	}
+
 	for (i = SCX_OPI_CPU_HOTPLUG_BEGIN; i < SCX_OPI_CPU_HOTPLUG_END; i++)
 		if (((void (**)(void))ops)[i])
 			set_bit(i, sch->has_op);
@@ -7484,6 +7538,10 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_disable;
 
+	ret = scx_set_cmask_scratch_alloc(sch);
+	if (ret)
+		goto err_disable;
+
 	if (validate_ops(sch, ops))
 		goto err_disable;
 
diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
index 0c91b951fd33..808c6390da5a 100644
--- a/kernel/sched/ext_cid.c
+++ b/kernel/sched/ext_cid.c
@@ -7,14 +7,6 @@
  */
 #include <linux/cacheinfo.h>
 
-/*
- * Per-cpu scratch cmask used by scx_call_op_set_cpumask() to synthesize a
- * cmask from a cpumask. Allocated alongside the cid arrays on first enable
- * and never freed. Sized to the full cid space. Caller holds rq lock so
- * this_cpu_ptr is safe.
- */
-struct scx_cmask __percpu *scx_set_cmask_scratch;
-
 /*
  * cid tables.
  *
@@ -54,8 +46,6 @@ static s32 scx_cid_arrays_alloc(void)
 	u32 npossible = num_possible_cpus();
 	s16 *cid_to_cpu, *cpu_to_cid;
 	struct scx_cid_topo *cid_topo;
-	struct scx_cmask __percpu *set_cmask_scratch;
-	s32 cpu;
 
 	if (scx_cid_to_cpu_tbl)
 		return 0;
@@ -63,25 +53,17 @@ static s32 scx_cid_arrays_alloc(void)
 	cid_to_cpu = kzalloc_objs(*scx_cid_to_cpu_tbl, npossible, GFP_KERNEL);
 	cpu_to_cid = kzalloc_objs(*scx_cpu_to_cid_tbl, nr_cpu_ids, GFP_KERNEL);
 	cid_topo = kmalloc_objs(*scx_cid_topo, npossible, GFP_KERNEL);
-	set_cmask_scratch = __alloc_percpu(struct_size(set_cmask_scratch, bits,
-						       SCX_CMASK_NR_WORDS(npossible)),
-					   sizeof(u64));
 
-	if (!cid_to_cpu || !cpu_to_cid || !cid_topo || !set_cmask_scratch) {
+	if (!cid_to_cpu || !cpu_to_cid || !cid_topo) {
 		kfree(cid_to_cpu);
 		kfree(cpu_to_cid);
 		kfree(cid_topo);
-		free_percpu(set_cmask_scratch);
 		return -ENOMEM;
 	}
 
 	WRITE_ONCE(scx_cid_to_cpu_tbl, cid_to_cpu);
 	WRITE_ONCE(scx_cpu_to_cid_tbl, cpu_to_cid);
 	WRITE_ONCE(scx_cid_topo, cid_topo);
-	for_each_possible_cpu(cpu)
-		scx_cmask_init(per_cpu_ptr(set_cmask_scratch, cpu),
-			       0, npossible);
-	WRITE_ONCE(scx_set_cmask_scratch, set_cmask_scratch);
 	return 0;
 }
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index ff7e882bd67a..9bb65367f510 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1124,6 +1124,14 @@ struct scx_sched {
 	struct bpf_map		*arena_map;
 	struct gen_pool		*arena_pool;
 
+	/*
+	 * Per-CPU arena cmask used by scx_call_op_set_cpumask() to hand a cmask
+	 * to ops_cid.set_cmask(). The kernel writes through the stored kern_va;
+	 * the BPF-arena uaddr handed to BPF is recovered by subtracting the
+	 * arena's kern_vm_start.
+	 */
+	struct scx_cmask * __percpu *set_cmask_scratch;
+
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
 
 	/*
@@ -1480,8 +1488,6 @@ enum scx_ops_state {
 extern struct scx_sched __rcu *scx_root;
 DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
 
-extern struct scx_cmask __percpu *scx_set_cmask_scratch;
-
 /*
  * True when the currently loaded scheduler hierarchy is cid-form. All scheds
  * in a hierarchy share one form, so this single key tells callsites which
diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
index e281c88fa824..70f2a3829af4 100644
--- a/tools/sched_ext/include/scx/cid.bpf.h
+++ b/tools/sched_ext/include/scx/cid.bpf.h
@@ -675,56 +675,4 @@ static __always_inline void cmask_from_cpumask(struct scx_cmask __arena *m,
 	}
 }
 
-/**
- * cmask_copy_from_kernel - probe-read a kernel cmask into an arena cmask
- * @dst: arena cmask to fill; must have @dst->base == 0 and be sized for @src.
- * @src: kernel-memory cmask (e.g. ops.set_cmask() arg); @src->base must be 0.
- *
- * Word-for-word copy; @src and @dst must share base 0 alignment. Triggers
- * scx_bpf_error() on probe failure or precondition violation.
- */
-static __always_inline void cmask_copy_from_kernel(struct scx_cmask __arena *dst,
-						   const struct scx_cmask *src)
-{
-	u32 base = 0, nr_cids = 0, nr_words, wi;
-
-	if (dst->base != 0) {
-		scx_bpf_error("cmask_copy_from_kernel requires dst->base == 0");
-		return;
-	}
-
-	if (bpf_probe_read_kernel(&base, sizeof(base), &src->base)) {
-		scx_bpf_error("probe-read cmask->base failed");
-		return;
-	}
-	if (base != 0) {
-		scx_bpf_error("cmask_copy_from_kernel requires src->base == 0");
-		return;
-	}
-
-	if (bpf_probe_read_kernel(&nr_cids, sizeof(nr_cids), &src->nr_cids)) {
-		scx_bpf_error("probe-read cmask->nr_cids failed");
-		return;
-	}
-
-	if (nr_cids > dst->nr_cids) {
-		scx_bpf_error("src cmask nr_cids=%u exceeds dst nr_cids=%u",
-			      nr_cids, dst->nr_cids);
-		return;
-	}
-
-	nr_words = CMASK_NR_WORDS(nr_cids);
-	cmask_zero(dst);
-	bpf_for(wi, 0, CMASK_MAX_WORDS) {
-		u64 word = 0;
-		if (wi >= nr_words)
-			break;
-		if (bpf_probe_read_kernel(&word, sizeof(u64), &src->bits[wi])) {
-			scx_bpf_error("probe-read cmask->bits[%u] failed", wi);
-			return;
-		}
-		dst->bits[wi] = word;
-	}
-}
-
 #endif /* __SCX_CID_BPF_H */
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 7e77f22674ea..8a2d6a8ebd8e 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -919,14 +919,15 @@ void BPF_STRUCT_OPS(qmap_update_idle, s32 cid, bool idle)
 }
 
 void BPF_STRUCT_OPS(qmap_set_cmask, struct task_struct *p,
-		    const struct scx_cmask *cmask)
+		    const struct scx_cmask *cmask_in)
 {
+	struct scx_cmask __arena *cmask = (struct scx_cmask __arena *)(long)cmask_in;
 	task_ctx_t *taskc;
 
 	taskc = lookup_task_ctx(p);
 	if (!taskc)
 		return;
-	cmask_copy_from_kernel(&taskc->cpus_allowed, cmask);
+	cmask_copy(&taskc->cpus_allowed, cmask);
 }
 
 struct monitor_timer {
-- 
2.54.0

