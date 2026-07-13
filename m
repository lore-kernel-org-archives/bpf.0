Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001B3749EE;
	Mon, 13 Jul 2026 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910668; cv=none; b=SPhtv1wGH7FrnLDnbgiHvPGbZ4VmjeDZ+1bd4/lpGF6auQCcIWbQPAmCM6omZuQkgJsqhvsRIKFPhkT7UAcK/+06jXXKF3WcHl34cOZ1FThdCL/LSi6doFlsXT1T4o1zdEyh91z4MGpM89LFumSas/H9hCGLiHEawB9RUxbh2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910668; c=relaxed/simple;
	bh=CBKN/vIJkik/NCshPrweB5B3z/nZRf/LL7xyjVWJs8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLNm53zbs6CbE0MonZLMw4s+0buZLxw9d6dmMqMsrOQA9IrQjRQpqSIlOAoSczDhmY21rXKJGcemErQ98c7Cl18npI7lU0FvztFnE9felADGtkBS9ghG7+Qz+2/ItixYUJMh9Kiw3XpWDPQptVpQcfQeq49mcGL/WEgeZ8GpZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgEznwUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgEznwUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691FD1F00A3A;
	Mon, 13 Jul 2026 02:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783910662;
	bh=6gsSLeWdlBEt6VLVr/FElPNMEYeTgT09BD00BynCXE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kgEznwUOZHU9mL7wWtq33S1o9e1HDJecu4/vnoXoInof1U5qg04oVdjEsTA0YQDpU
	 6JXfOL+v+S7smcONVreOPkWsuBvzm14debSoRdVgCc/JxLQkJAskOxMMmS9uiS6eLt
	 5cUXtJpdRJSXeM32LeB3UOvg/YKnRtx42t7jAcJUHNP592ZBfhP58hYh/JGje4rPjZ
	 57Y8bpBrVjz1NSy70L8mva5wmQU5NywveaHz54OgmLTkJxyHYsNLYxhdmAXoVzkXvH
	 ml/8zLgrACG0B81hfJmAhd2lux9VB2njOyuCVrHVsP/2pQlm+w3fdVwJh6HRXj1+iz
	 wIG9o6zj0WwyA==
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
Subject: [PATCHSET SLOP RFC 6/6] sched_ext: Convert scx_bpf_cid_override() to take an arena pointer
Date: Sun, 12 Jul 2026 16:44:14 -1000
Message-ID: <20260713024414.3759854-7-tj@kernel.org>
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

The mem+size signature requires a verifier-visible buffer, which forces
scx_qmap to keep the cpu_to_cid array in writable bss even though nothing
writes it after load. Take the array as an __arena argument instead, with
the count passed in entries. The verifier hands the kfunc a
dereferenceable kernel address and nr_cpu_ids * sizeof(s32) stays within
the guard region covered by arena fault recovery, so the kfunc needs no
bounds check beyond the entry count validation.

scx_qmap moves the array into struct qmap_arena. As the arena is mmapped
at load, the loader now populates it between load and attach instead of
before load.

NOT_SIGNED_OFF: to be reworked after bpf-next is pulled into sched_ext
---
 kernel/sched/ext/cid.c                   | 24 ++++++++++----
 tools/sched_ext/include/scx/compat.bpf.h |  8 +++--
 tools/sched_ext/scx_qmap.bpf.c           | 13 ++------
 tools/sched_ext/scx_qmap.c               | 41 +++++++++++++++---------
 tools/sched_ext/scx_qmap.h               |  3 ++
 5 files changed, 53 insertions(+), 36 deletions(-)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index af83084ec740..872f699cb1ac 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -278,8 +278,8 @@ __bpf_kfunc_start_defs();
 
 /**
  * scx_bpf_cid_override - Install an explicit cpu->cid mapping
- * @cpu_to_cid: array of nr_cpu_ids s32 entries (cid for each cpu)
- * @cpu_to_cid__sz: must be nr_cpu_ids * sizeof(s32) bytes
+ * @cpu_to_cid__arena: arena array of nr_cpu_ids s32 entries (cid for each cpu)
+ * @cnt: number of entries, must be nr_cpu_ids
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * May only be called from ops.init() of the root scheduler. Replace the
@@ -287,7 +287,7 @@ __bpf_kfunc_start_defs();
  * must map to a unique cid in [0, num_possible_cpus()). Topo info is cleared.
  * On invalid input, trigger scx_error() to abort the scheduler.
  */
-__bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz,
+__bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid__arena, u32 cnt,
 				      const struct bpf_prog_aux *aux)
 {
 	cpumask_var_t seen __free(free_cpumask_var) = CPUMASK_VAR_NULL;
@@ -314,14 +314,24 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz,
 		return;
 	}
 
-	if (cpu_to_cid__sz != nr_cpu_ids * sizeof(s32)) {
-		scx_error(sch, "scx_bpf_cid_override: expected %zu bytes, got %u",
-			  nr_cpu_ids * sizeof(s32), cpu_to_cid__sz);
+	if (!cpu_to_cid__arena) {
+		scx_error(sch, "scx_bpf_cid_override: NULL cpu_to_cid");
 		return;
 	}
 
+	if (cnt != nr_cpu_ids) {
+		scx_error(sch, "scx_bpf_cid_override: expected %u entries, got %u",
+			  nr_cpu_ids, cnt);
+		return;
+	}
+
+	/*
+	 * @cpu_to_cid__arena arrives rebased to the arena kernel mapping.
+	 * nr_cpu_ids * sizeof(s32) stays within the guard region covered by
+	 * arena fault recovery, so no explicit bounds check is needed.
+	 */
 	for_each_possible_cpu(cpu) {
-		s32 c = cpu_to_cid[cpu];
+		s32 c = cpu_to_cid__arena[cpu];
 
 		if (!cid_valid(sch, c))
 			return;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 87f15f296234..f71f843f9ddb 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -7,6 +7,8 @@
 #ifndef __SCX_COMPAT_BPF_H
 #define __SCX_COMPAT_BPF_H
 
+#include "bpf_arena_common.bpf.h"
+
 #define __COMPAT_ENUM_OR_ZERO(__type, __ent)					\
 ({										\
 	__type __ret = 0;							\
@@ -125,12 +127,12 @@ static inline bool scx_bpf_sub_dispatch(u64 cgroup_id)
  * v7.2: scx_bpf_cid_override() for explicit cpu->cid mapping. Ignore if
  * missing.
  */
-void scx_bpf_cid_override___compat(const s32 *cpu_to_cid, u32 cpu_to_cid__sz) __ksym __weak;
+void scx_bpf_cid_override___compat(const s32 __arena *cpu_to_cid, u32 cnt) __ksym __weak;
 
-static inline void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz)
+static inline void scx_bpf_cid_override(const s32 __arena *cpu_to_cid, u32 cnt)
 {
 	if (bpf_ksym_exists(scx_bpf_cid_override___compat))
-		return scx_bpf_cid_override___compat(cpu_to_cid, cpu_to_cid__sz);
+		return scx_bpf_cid_override___compat(cpu_to_cid, cnt);
 }
 
 /**
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index fd9a82a67627..2b4cc55e04ce 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -63,13 +63,6 @@ const volatile u32 max_tasks;
  *   3 = invalid: out-of-range cid
  */
 const volatile u32 cid_override_mode;
-/*
- * Array lives in bss (writable) because scx_bpf_cid_override()'s BPF
- * verifier signature treats its len-paired pointer as read/write - rodata
- * fails verification with "write into map forbidden". Userspace populates
- * it before SCX_OPS_LOAD, same as rodata, and nothing writes it after.
- */
-s32 cid_override_cpu_to_cid[SCX_QMAP_MAX_CPUS];
 
 UEI_DEFINE(uei);
 
@@ -1094,10 +1087,8 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 	 * cid space (scx_bpf_nr_cids, cmask_init, etc.). On invalid input,
 	 * the kfunc calls scx_error() which aborts the scheduler.
 	 */
-	if (cid_override_mode) {
-		scx_bpf_cid_override((const s32 *)cid_override_cpu_to_cid,
-				     nr_cpu_ids * sizeof(s32));
-	}
+	if (cid_override_mode)
+		scx_bpf_cid_override(qa.cid_override_cpu_to_cid, nr_cpu_ids);
 
 	/*
 	 * Allocate the task_ctx slab in arena and thread the entire slab onto
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 67ddd483a4c7..c54f050d9991 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -153,8 +153,7 @@ int main(int argc, char **argv)
 			skel->rodata->immed_stress_nth = strtoul(optarg, NULL, 0);
 			break;
 		case 'C': {
-			u32 nr_cpus = libbpf_num_possible_cpus();
-			u32 mode, i;
+			u32 mode;
 
 			if (!strcmp(optarg, "shuffle"))
 				mode = 1;
@@ -167,18 +166,6 @@ int main(int argc, char **argv)
 				return 1;
 			}
 			skel->rodata->cid_override_mode = mode;
-
-			/* shuffle: reversed cpu_to_cid, bad-dup: dup cid 0, bad-range: identity */
-			for (i = 0; i < nr_cpus; i++) {
-				if (mode == 1)
-					skel->bss->cid_override_cpu_to_cid[i] = nr_cpus - 1 - i;
-				else
-					skel->bss->cid_override_cpu_to_cid[i] = i;
-			}
-			if (mode == 2 && nr_cpus >= 2)
-				skel->bss->cid_override_cpu_to_cid[1] = 0;
-			if (mode == 3)
-				skel->bss->cid_override_cpu_to_cid[0] = (s32)nr_cpus;
 			break;
 		}
 		case 'v':
@@ -191,9 +178,33 @@ int main(int argc, char **argv)
 	}
 
 	SCX_OPS_LOAD(skel, qmap_ops, scx_qmap, uei);
-	link = SCX_OPS_ATTACH(skel, qmap_ops, scx_qmap);
 
 	qa = &skel->arena->qa;
+
+	/*
+	 * The cid-override array lives in the arena, which is mmapped at load.
+	 * Populate it before qmap_init() consumes it at attach.
+	 */
+	if (skel->rodata->cid_override_mode) {
+		u32 mode = skel->rodata->cid_override_mode;
+		u32 nr_cpus = libbpf_num_possible_cpus();
+		u32 i;
+
+		/* shuffle: reversed cpu_to_cid, bad-dup: dup cid 0, bad-range: identity */
+		for (i = 0; i < nr_cpus; i++) {
+			if (mode == 1)
+				qa->cid_override_cpu_to_cid[i] = nr_cpus - 1 - i;
+			else
+				qa->cid_override_cpu_to_cid[i] = i;
+		}
+		if (mode == 2 && nr_cpus >= 2)
+			qa->cid_override_cpu_to_cid[1] = 0;
+		if (mode == 3)
+			qa->cid_override_cpu_to_cid[0] = (s32)nr_cpus;
+	}
+
+	link = SCX_OPS_ATTACH(skel, qmap_ops, scx_qmap);
+
 	qa->test_error_cnt = test_error_cnt;
 
 	while (!exit_req && !UEI_EXITED(skel, uei)) {
diff --git a/tools/sched_ext/scx_qmap.h b/tools/sched_ext/scx_qmap.h
index d15a705d5ac5..3b01570bbde9 100644
--- a/tools/sched_ext/scx_qmap.h
+++ b/tools/sched_ext/scx_qmap.h
@@ -62,6 +62,9 @@ struct qmap_arena {
 
 	struct cpu_ctx cpu_ctxs[SCX_QMAP_MAX_CPUS];
 
+	/* cid-override test input, populated by the loader before attach */
+	__s32 cid_override_cpu_to_cid[SCX_QMAP_MAX_CPUS];
+
 	/* task_ctx slab; allocated and threaded by qmap_init() */
 	struct task_ctx __arena *task_ctxs;
 	struct task_ctx __arena *task_free_head;
-- 
2.55.0

