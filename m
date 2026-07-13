Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408335839E;
	Mon, 13 Jul 2026 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910667; cv=none; b=iMuZQ63J2ZoTbn+2UqWKeKKGFgtShB3I+L72aP6iRZ8vLMXYA7NYjfCr5OG9/rpptYq0DJ9q8P6+0fh3qRDewqDQ5u/P9YKJl3IyQrP1XPiOZMbcoE9ldmQmah8eIhBE+efQD8SsRPVkwthQzlJyiuGcpDZeVVOReYVCpbI73xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910667; c=relaxed/simple;
	bh=FbpYoFh9G9VSzEc+Y/xpfoSwukry1AwKLR+QtxmshNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhqG1WxoqOd3Jk5Yhkx4+s8bhcD0XyaKPrINAL0QAzBknay7hge0REBvEYiMpw32R4vmMAGZLHtsIvRpz+EWn79YepIEvD2JIOAWZ/jmbByDgYMRzhrUY5rMFgInRRWP/9glDk/L0lFmWL48w3SCRd+52245kfQRJYgqjbeXtqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrVr7T9p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrVr7T9p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533BE1F00A3D;
	Mon, 13 Jul 2026 02:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783910661;
	bh=zRcmOIyp+566PtKrOBLOLXjFc150jF/pYMntl7ewiTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZrVr7T9pupfrrYmyFA2JPj5uWf1DsD427vZUnZGHURWpVz6MhEn4Tx9JtP9/QTC3n
	 w3BZivFRXcZOsDFQ7RGElncGEpeOpM5Bovsx5l/kTyQCY7F0yTXbDuISbyNlcnrZQn
	 0s9fknnuhZqkbQzZ/yMFpZ2LWrGTYmvyn5JgE0heAECcsPJhGhTM0al6wqWrVZNQC9
	 IGz9pL/ATE2yRNdYjLErVpdJ5nB4v31r3raC+R8ZbG06c8T2HIFZgLacMX5QT/BkuJ
	 U0Xwwx6x6amdtX7U1PWAD1AhgIU1DlYNg972MIymKWl0iaYcIUiDY2zxjLh3Rk40a1
	 8lt+RKGffSDiA==
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET SLOP RFC 5/6] sched_ext: Pass a kernel arena pointer to ops_cid.set_cmask()
Date: Sun, 12 Jul 2026 16:44:13 -1000
Message-ID: <20260713024414.3759854-6-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713024414.3759854-1-tj@kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cid-form set_cmask() callback receives a per-CPU cmask that the kernel
builds in the arena. Without an __arena tag the callback would receive the
argument as a trusted scx_cmask BTF pointer, and the kernel had to convert
the kernel address to the arena pointer form by hand before the call.

Tag the stub argument __arena and pass the kernel arena address directly.
The struct_ops entry prologue rebases it to the program's arena pointer,
so the manual scx_kaddr_to_arena() conversion and its now-unused helper
are removed.

NOT_SIGNED_OFF: to be reworked after bpf-next is pulled into sched_ext
---
 kernel/sched/ext/ext.c      | 11 ++++++-----
 kernel/sched/ext/internal.h | 16 +++-------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 691d53fe0f64..c38a0e62534a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -508,12 +508,13 @@ static inline void scx_call_op_set_cpumask(struct scx_sched *sch, struct rq *rq,
 	if (scx_is_cid_type()) {
 		struct scx_cmask *kern_va = *this_cpu_ptr(sch->set_cmask_scratch);
 		/*
-		 * Build the per-CPU arena cmask and hand BPF its arena address.
-		 * Caller holds the rq lock with IRQs disabled, which makes us
-		 * the sole user of the scratch area.
+		 * Build the per-CPU arena cmask and pass its kernel address.
+		 * The BPF side translates it to an arena pointer. Caller holds
+		 * the rq lock with IRQs disabled, which makes us the sole user
+		 * of the scratch area.
 		 */
 		scx_cpumask_to_cmask(cpumask, kern_va);
-		sch->ops_cid.set_cmask(task, scx_kaddr_to_arena(sch, kern_va));
+		sch->ops_cid.set_cmask(task, kern_va);
 	} else {
 		sch->ops.set_cpumask(task, cpumask);
 	}
@@ -8130,7 +8131,7 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
  * set_cmask needs a fresh stub since the second argument type differs.
  */
 static void sched_ext_ops_cid__set_cmask(struct task_struct *p,
-					 const struct scx_cmask *cmask) {}
+					 const struct scx_cmask *cmask__arena) {}
 
 static struct sched_ext_ops_cid __bpf_ops_sched_ext_ops_cid = {
 	.select_cid		= sched_ext_ops__select_cpu,
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 145272cb4d8a..a2db2e1a78d5 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -1125,8 +1125,7 @@ struct scx_sched {
 	 *
 	 * @arena_pool sub-allocates @arena_map. Each gen_pool chunk is added
 	 * at the kernel-side mapping address. @arena_kern_base is the start
-	 * of the arena's kern_vm range. See scx_arena_to_kaddr() and
-	 * scx_kaddr_to_arena().
+	 * of the arena's kern_vm range. See scx_arena_to_kaddr().
 	 */
 	struct bpf_map		*arena_map;
 	struct gen_pool		*arena_pool;
@@ -1135,7 +1134,8 @@ struct scx_sched {
 	/*
 	 * Per-CPU arena cmask used by scx_call_op_set_cpumask() to hand a cmask
 	 * to ops_cid.set_cmask(). The kernel writes through the stored kern_va
-	 * and hands BPF its arena pointer via scx_kaddr_to_arena().
+	 * and passes it as the callback argument; the struct_ops entry prologue
+	 * rebases it to the program's arena pointer.
 	 */
 	struct scx_cmask * __percpu *set_cmask_scratch;
 
@@ -1227,16 +1227,6 @@ static inline void *scx_arena_to_kaddr(struct scx_sched *sch, const void *bpf_pt
 	return (void *)(sch->arena_kern_base + (u32)(uintptr_t)bpf_ptr);
 }
 
-/**
- * scx_kaddr_to_arena - Translate a kernel arena address to its BPF form
- * @sch: scheduler whose arena hosts @kaddr
- * @kaddr: kernel-side arena address, supplied by trusted kernel code
- */
-static inline void *scx_kaddr_to_arena(struct scx_sched *sch, const void *kaddr)
-{
-	return (void *)((uintptr_t)kaddr - sch->arena_kern_base);
-}
-
 enum scx_wake_flags {
 	/* expose select WF_* flags as enums */
 	SCX_WAKE_FORK		= WF_FORK,
-- 
2.55.0

