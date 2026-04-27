Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108B83B9608;
	Mon, 27 Apr 2026 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287082; cv=none; b=uawRobQbuSOgExpkrNndThwkSekUgpYf1EsA8p/bAtsNr8kbEj5i3UbFsHMlI1oLWxLrIdla3V5hwYfDNewMR91AbS0BpVbLDl8C9fKTSsMu9E4PwUTkp2TbJwxDPDL0bUz3+LrPG+jQ5J80EajlbYZ2+y6hKJMYqPOUXXxMU4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287082; c=relaxed/simple;
	bh=2ZpV0alVxlrJpaIDiKopdAvfpQ7g9ALHv5ZoVBbxnWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FijF2gdJsqf5lDAu72g8cRIqjIyErZHETvxu4NJTXYFeH4e7uOA2JLSZrkEtvKm3WUO8s3mjKWnNPbdGO9FNhDbdUY44gqPDsa+5fhChFskMGVP2RD9SLGfiurF3vO/qNTywbouAuZDUqrXx8n1hy2Ny9vWMdBRUdlUk5c3YBSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gi9aaji5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi9aaji5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D53AC19425;
	Mon, 27 Apr 2026 10:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777287081;
	bh=2ZpV0alVxlrJpaIDiKopdAvfpQ7g9ALHv5ZoVBbxnWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gi9aaji5cJpeSWCTQoBjewPo2XDLM6Ph8obOFRm8tQNP7rgJP9U/WRoxfkN8fcgrt
	 x+Vh65rFmqUy1wjo2Jj8Ek2ksrqgErRdhFKuMPcnPOOVXg/bHUlwwe33qbek2d3hnD
	 SAABPP++3itL+viKXPO6Ugppgx6tGF14wyHXzMC42dX+SIPr5aYb04/pfHa1rKNkh2
	 byKKFX9qSZqyQosUDprhrThy1qqLXIOfYtKrX/NSxq8S5vKLt0+IK+7/g52mI1ZcyG
	 KKpRH++nV5qJ45ldFzTzbPBNqHr9HHYJL3FsY+c3GHDLUglDpJxsGR6wtvf16QQokg
	 s1lmEpH2HWNaw==
From: Tejun Heo <tj@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 9/9] sched_ext: Convert ops.set_cmask() to arena-resident cmask
Date: Mon, 27 Apr 2026 00:51:09 -1000
Message-ID: <20260427105109.2554518-10-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427105109.2554518-1-tj@kernel.org>
References: <20260427105109.2554518-1-tj@kernel.org>
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
arena. The kernel writes to it through the kern_va side of the dual mapping;
BPF directly dereferences it via an __arena pointer like any other arena
struct.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                    | 67 +++++++++++++++++++++++++--
 kernel/sched/ext_cid.c                | 16 +------
 kernel/sched/ext_internal.h           | 10 +++-
 kernel/sched/ext_types.h              | 10 ++++
 tools/sched_ext/include/scx/cid.bpf.h | 44 ------------------
 tools/sched_ext/scx_qmap.bpf.c        |  6 ++-
 6 files changed, 86 insertions(+), 67 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 27c2b4df79d5..30e29853edd0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -622,11 +622,15 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 		update_locked_rq(rq);
 
 	if (scx_is_cid_type()) {
-		struct scx_cmask *cmask = this_cpu_ptr(scx_set_cmask_scratch);
+		struct scx_cmask_scratch *s = this_cpu_ptr(sch->set_cmask_scratch);
 
-		lockdep_assert_irqs_disabled();
-		scx_cpumask_to_cmask(cpumask, cmask);
-		sch->ops_cid.set_cmask(task, cmask);
+		/*
+		 * Build the per-CPU arena cmask and hand BPF the uaddr. Caller
+		 * holds the rq lock with IRQs disabled, which makes us the sole
+		 * user of the scratch area.
+		 */
+		scx_cpumask_to_cmask(cpumask, s->kern_va);
+		sch->ops_cid.set_cmask(task, (struct scx_cmask *)(unsigned long)s->uaddr);
 	} else {
 		sch->ops.set_cpumask(task, cpumask);
 	}
@@ -4864,6 +4868,47 @@ static const struct attribute_group scx_global_attr_group = {
 static void free_pnode(struct scx_sched_pnode *pnode);
 static void free_exit_info(struct scx_exit_info *ei);
 
+/* Byte size of a struct scx_cmask covering num_possible_cpus(). Set at boot. */
+static size_t scx_possible_cmask_size;
+
+static s32 scx_set_cmask_scratch_alloc(struct scx_sched *sch)
+{
+	int cpu;
+
+	if (!sch->is_cid_type || !sch->arena_pool)
+		return 0;
+
+	sch->set_cmask_scratch = alloc_percpu(struct scx_cmask_scratch);
+	if (!sch->set_cmask_scratch)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct scx_cmask_scratch *s = per_cpu_ptr(sch->set_cmask_scratch, cpu);
+
+		s->kern_va = scx_arena_alloc(sch, scx_possible_cmask_size, &s->uaddr);
+		if (!s->kern_va)
+			return -ENOMEM;
+		scx_cmask_init(s->kern_va, 0, num_possible_cpus());
+	}
+	return 0;
+}
+
+static void scx_set_cmask_scratch_free(struct scx_sched *sch)
+{
+	int cpu;
+
+	if (!sch->set_cmask_scratch)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct scx_cmask_scratch *s = per_cpu_ptr(sch->set_cmask_scratch, cpu);
+
+		scx_arena_free(sch, s->kern_va, scx_possible_cmask_size);
+	}
+	free_percpu(sch->set_cmask_scratch);
+	sch->set_cmask_scratch = NULL;
+}
+
 static void scx_sched_free_rcu_work(struct work_struct *work)
 {
 	struct rcu_work *rcu_work = to_rcu_work(work);
@@ -4916,6 +4961,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 
 	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
 	free_exit_info(sch->exit_info);
+	scx_set_cmask_scratch_free(sch);
 	scx_arena_pool_destroy(sch);
 	if (sch->arena_map)
 		bpf_map_put(sch->arena_map);
@@ -6982,6 +7028,12 @@ static void scx_root_enable_workfn(struct kthread_work *work)
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
@@ -7275,6 +7327,10 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
 	if (ret)
 		goto err_disable;
 
+	ret = scx_set_cmask_scratch_alloc(sch);
+	if (ret)
+		goto err_disable;
+
 	if (validate_ops(sch, ops))
 		goto err_disable;
 
@@ -8202,6 +8258,9 @@ void __init init_sched_ext_class(void)
 	WRITE_ONCE(v, SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP | SCX_KICK_PREEMPT |
 		   SCX_TG_ONLINE);
 
+	scx_possible_cmask_size = struct_size_t(struct scx_cmask, bits,
+						SCX_CMASK_NR_WORDS(num_possible_cpus()));
+
 	scx_idle_init_masks();
 
 	for_each_possible_cpu(cpu) {
diff --git a/kernel/sched/ext_cid.c b/kernel/sched/ext_cid.c
index 71f7ef572eac..7ae251f20a13 100644
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
@@ -54,7 +46,6 @@ static s32 scx_cid_arrays_alloc(void)
 	u32 npossible = num_possible_cpus();
 	s16 *cid_to_cpu, *cpu_to_cid;
 	struct scx_cid_topo *cid_topo;
-	struct scx_cmask __percpu *set_cmask_scratch;
 
 	if (scx_cid_to_cpu_tbl)
 		return 0;
@@ -62,22 +53,17 @@ static s32 scx_cid_arrays_alloc(void)
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
-	WRITE_ONCE(scx_set_cmask_scratch, set_cmask_scratch);
 	return 0;
 }
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 56d99e749c9d..d2ef8a5a3e69 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1117,6 +1117,14 @@ struct scx_sched {
 	struct bpf_map		*arena_map;
 	struct gen_pool		*arena_pool;
 
+	/*
+	 * Per-CPU arena cmask used by scx_call_op_set_cpumask() to hand a cmask
+	 * to ops_cid.set_cmask(). Each entry stashes both the kernel VA (for
+	 * the kernel to write into) and the BPF-arena uaddr (passed to BPF as
+	 * the cmask pointer).
+	 */
+	struct scx_cmask_scratch __percpu *set_cmask_scratch;
+
 	DECLARE_BITMAP(has_op, SCX_OPI_END);
 
 	/*
@@ -1473,8 +1481,6 @@ enum scx_ops_state {
 extern struct scx_sched __rcu *scx_root;
 DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
 
-extern struct scx_cmask __percpu *scx_set_cmask_scratch;
-
 /*
  * True when the currently loaded scheduler hierarchy is cid-form. All scheds
  * in a hierarchy share one form, so this single key tells callsites which
diff --git a/kernel/sched/ext_types.h b/kernel/sched/ext_types.h
index ebb8cdf90612..23edf73a84ae 100644
--- a/kernel/sched/ext_types.h
+++ b/kernel/sched/ext_types.h
@@ -101,4 +101,14 @@ struct scx_cmask {
 #define SCX_CMASK_DEFINE(name, cap_bits)	\
 	DEFINE_RAW_FLEX(struct scx_cmask, name, bits, SCX_CMASK_NR_WORDS(cap_bits))
 
+/*
+ * Stash for one arena-resident cmask. @kern_va points into the kernel's
+ * view of the BPF arena; @uaddr is the matching BPF-arena address to
+ * hand to BPF (cast to struct scx_cmask *).
+ */
+struct scx_cmask_scratch {
+	struct scx_cmask *kern_va;
+	u32 uaddr;
+};
+
 #endif /* _KERNEL_SCHED_EXT_TYPES_H */
diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
index 629c3f078021..4e3c967151fc 100644
--- a/tools/sched_ext/include/scx/cid.bpf.h
+++ b/tools/sched_ext/include/scx/cid.bpf.h
@@ -612,48 +612,4 @@ static __always_inline void cmask_from_cpumask(struct scx_cmask __arena *m,
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
-	u32 nr_bits = 0, nr_words, dst_nr_words, wi;
-
-	if (dst->base != 0) {
-		scx_bpf_error("cmask_copy_from_kernel requires dst->base == 0");
-		return;
-	}
-
-	if (bpf_probe_read_kernel(&nr_bits, sizeof(nr_bits), &src->nr_bits)) {
-		scx_bpf_error("probe-read cmask->nr_bits failed");
-		return;
-	}
-
-	nr_words = CMASK_NR_WORDS(nr_bits);
-	dst_nr_words = CMASK_NR_WORDS(dst->nr_bits);
-	if (nr_words > dst_nr_words) {
-		scx_bpf_error("src cmask nr_bits=%u exceeds dst capacity",
-			      nr_bits);
-		return;
-	}
-
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
index edce734c3019..3412cf0bff13 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -922,14 +922,16 @@ void BPF_STRUCT_OPS(qmap_update_idle, s32 cid, bool idle)
 }
 
 void BPF_STRUCT_OPS(qmap_set_cmask, struct task_struct *p,
-		    const struct scx_cmask *cmask)
+		    const struct scx_cmask *cmask_in)
 {
+	struct scx_cmask __arena *cmask =
+		(struct scx_cmask __arena *)(long)cmask_in;
 	task_ctx_t *taskc;
 
 	taskc = lookup_task_ctx(p);
 	if (!taskc)
 		return;
-	cmask_copy_from_kernel(&taskc->cpus_allowed, cmask);
+	cmask_copy(&taskc->cpus_allowed, cmask);
 }
 
 struct monitor_timer {
-- 
2.53.0

