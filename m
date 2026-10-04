Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138B43991E
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121136; cv=none; b=MfjuknZ4b3uya7pZuAdIKMqXQZcuohtr5AH0tFEI9p2R6vcMEhPGr9Ye09DTNdvxglCk+G7bjKY53qNcxUY+CWJG/5PFQOS/64i8nhWaQe6T8e89f4FnksNtq6OEucH/wW2zjg2JNYsYcoX1zSaW34y4vI5BAz/805v2F7+1ejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121136; c=relaxed/simple;
	bh=64nmXOAgUT/7/IKrtKV1xTfBLR58Ygj5744kGCqX4jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjyPrJcVxM3LsGs6vZ7ek8hpt+mrmAND3rg41+b10L6eip3Zs2uDIBQI+/SBk8qYHfz+4U/RU3a859nZoHce4TkItpaInHrhK6xbsKLlvAlEH45UI1D39Ir5PY/G64sm9IKsQsZp6qmb73KBCIxQbEk+0vOCDyImxF7B0HLQT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTSTZOdl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTSTZOdl"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so296665a12.2
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121134; x=1791725934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2njTcQz5rNaQiS/3dE4XYj51fGkkzwB5HaKG+WzBFw0=;
        b=GTSTZOdlF0wnUfO8GQMEoWHDqv41Kgjngd5UBR2r/pYA6DN8r843d5O3KzRTGAdbjL
         mdV1Q4+xLmmAvFEVAaR39+aIg4yikSrwT2LyTzes55SRP7oWYhM9y4GycWLtrqMMMh1p
         97ds4P9Zqtd87Yn+bHjX4Ea4/J9Cxs4PtykIblegC9U+b73nKVP3pXtackv/RZQT7vkY
         AOSY/BtSq+tS4WEDfLKh3k5YObAQhFW3sGDIphDRiUfNwuZZXpbvmNkWxUqtHgxJtVu5
         MbYZWHeGpHHQsKX04uM1ibNAamCDdeQ/6lJdRS3OmCH66E5745LE8ISBb/ZpAOnvkbfc
         8viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121134; x=1791725934;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2njTcQz5rNaQiS/3dE4XYj51fGkkzwB5HaKG+WzBFw0=;
        b=uW8HaGL/pqa6kIJkqwB4CuOILHaY+UHYi+7+IGHSUScVLxpZZFF1GIcV9JV+aapDIF
         0iOMXpMrcuIpRDJArMn5mBCDQ7pA1nsOPuU92tW5ADivDo8FrR64PmEu4avUiGjwg/q6
         C2Psnq9CLV9U6gcyJ5V/ohiyefoKRVVBEHhUG4mIone/RM9Uedm4ZxmFj522PPeZuxIz
         iq7HR6z3mJ++GSktgboXmeuIKr6BEIXFPGxpRvNBea49y/ayDp8EM3SRUKazWNgghXzt
         8wOUWegtGUxO4bwO+MB84XYtG1v7HvQm5A/XF4b6WBGBCqFDJQzkvnZ6yz9SLWPrWODt
         ua2g==
X-Gm-Message-State: AFuF++k9vwSbfHTQYE74kaipvNfSye4rbrXQUzuxT+5796mMa8FM765K
	KmSwtEp2xLZUFnPimmTKPn0OWNvkNOifQrUP86FH2KDVBJr6nriJTv5eBevSPA==
X-Gm-Gg: AYBFou0tTqnBwjJ1mvXEcPirxB9u5Z0v4rdRON0l0H/Nkbw/yNa6oFxYJhyJZD8pSMF
	Bo4QXe+9fSgXLc40/pP3ys6gKKK0MneAX4HtZvPI5PV+gQbkebrX5gy9P3iB8RF4An95ia9P+Z7
	Nc/DNDgZ9CXIGKX/MtYhraGDrNpW6mQtVhwTtXQepc48Ah/ihkzteYuiD5YuMSbT0tjBnxqAiz1
	s9YtHnLTRZaNL3UxaSbOcyh6+AKY1S5nwlv6qAMA7OPLV+JZYwfPOLHJeZ1PgdodGT04GVwqWkG
	oFz2P65nJQmAm6xMEvL+jLkDeZ9qiGK/2iJu8f6pvUN+mseQzC5GhzSEum0857C1XbsyYi5egwo
	0EYehNPZ/TwqNEEbjiWP6N/GcNgEe7N2/03EdUHrFQOriKXYoYU06wTmIotOmOx061aJ2FdP0Ya
	TgAgMP5SbkgTWEqXnKHF+t82G2/I1RxsLnRbTgMBLtWT2k2Vq9IjnOoHsyS/e1Rh9kWJP7SqPFS
	EkT8bPqe+sF6w0=
X-Received: by 2002:a05:6a20:244a:b0:3da:15a9:a18e with SMTP id adf61e73a8af0-3e0d6bb6615mr4604928637.23.1791121133770;
        Sun, 04 Oct 2026 06:38:53 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 18/43] bpf: compute immediate dominators
Date: Sun,  4 Oct 2026 06:38:00 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-18-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

SCEV needs to find an exit condition that dominates a loop's backedge;
such conditions bound every loop iteration. Compute the immediate
dominator tree as a prerequisite for identifying such conditions.

Use the iterative reverse-postorder algorithm from:
"A Simple, Fast Dominance Algorithm" by Cooper et al.

Analyze each subprogram independently and exclude the second half of
ldimm64 instructions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   8 +++
 kernel/bpf/Makefile          |   2 +-
 kernel/bpf/loops.c           | 156 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   8 ++-
 4 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 14813040df84..0a452de50b46 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -650,6 +650,11 @@ struct bpf_iarray {
 	u32 items[];
 };
 
+#define iarray_for_each(item, arr)						\
+	for (int ___idx = 0;							\
+	     ___idx < (arr)->cnt && ({ item = (arr)->items[___idx]; 1; });	\
+	     ___idx++)
+
 struct bpf_insn_aux_data {
 	union {
 		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
@@ -1112,6 +1117,7 @@ struct bpf_verifier_env {
 	u32 scc_cnt;
 	struct bpf_iarray *succ;
 	struct bpf_iarray *gotox_tmp_buf;
+	int *idoms;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
@@ -1883,4 +1889,6 @@ int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
 int bpf_flip_opcode(u32 opcode);
 u8 bpf_rev_opcode(u8 opcode);
 
+int bpf_compute_idoms(struct bpf_verifier_env *env);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index c1f9b0d3468d..6210601eb40b 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o cnum.o log.o token.o liveness.o const_fold.o diagnostics.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o cnum.o log.o token.o liveness.o const_fold.o diagnostics.o loops.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
new file mode 100644
index 000000000000..0a9e10edca87
--- /dev/null
+++ b/kernel/bpf/loops.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/slab.h>
+#include <linux/sched/signal.h>
+#include <linux/bpf_verifier.h>
+
+static struct bpf_iarray **compute_predecessors(struct bpf_verifier_env *env)
+{
+	struct bpf_iarray *succ, *preds, **result;
+	struct bpf_prog *prog = env->prog;
+	u32 *num_preds, i, s, sz, len = prog->len;
+	struct bpf_insn *insn;
+	void *tmp;
+
+	num_preds = kvcalloc(prog->len, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	if (!num_preds)
+		return NULL;
+
+	/*
+	 * 'result' layout:
+	 *  - array of pointers (struct bpf_iarray *)[len]
+	 *  - struct bpf_iarray one after another
+	 */
+	sz = sizeof(struct bpf_iarray) * len;
+	sz += sizeof(struct bpf_iarray *) * len;
+	for (i = 0; i < len; i++) {
+		insn = env->prog->insnsi + i;
+		succ = bpf_insn_successors(env, i);
+		sz += sizeof(u32) * succ->cnt;
+		iarray_for_each(s, succ) {
+			num_preds[s]++;
+		}
+		if (bpf_is_ldimm64(insn))
+			i++;
+	}
+
+	result = kvzalloc(sz, GFP_KERNEL_ACCOUNT);
+	if (!result) {
+		kvfree(num_preds);
+		return NULL;
+	}
+
+	tmp = (void *)&result[len];
+	for (i = 0; i < len; i++) {
+		result[i] = tmp;
+		tmp += sizeof(struct bpf_iarray);
+		tmp += sizeof(u32) * num_preds[i];
+	}
+
+	for (i = 0; i < len; i++) {
+		insn = env->prog->insnsi + i;
+		succ = bpf_insn_successors(env, i);
+		iarray_for_each(s, succ) {
+			preds = result[s];
+			preds->items[preds->cnt++] = i;
+		}
+		if (bpf_is_ldimm64(insn))
+			i++;
+	}
+
+	kvfree(num_preds);
+	return result;
+}
+
+static int idoms_intersect(struct bpf_verifier_env *env, int a, int b)
+{
+	int *postorder_nums = env->cfg.postorder_nums;
+	int *idoms = env->idoms;
+
+	while (a != b) {
+		while (postorder_nums[a] < postorder_nums[b]) {
+			a = idoms[a];
+		}
+		while (postorder_nums[b] < postorder_nums[a]) {
+			b = idoms[b];
+		}
+	}
+	return a;
+}
+
+/* See "A Simple, Fast Dominance Algorithm" by Cooper et al. for details. */
+static int compute_subprog_idoms(struct bpf_verifier_env *env, struct bpf_iarray **preds,
+				int subprog_idx)
+{
+	struct bpf_subprog_info *subprog = &env->subprog_info[subprog_idx];
+	int start = subprog->start;
+	int po_first = subprog->postorder_start;
+	int po_last = (subprog + 1)->postorder_start - 1;
+	int *idoms = env->idoms;
+	int po_num, pred;
+	u32 work = 0;
+	bool changed;
+
+	idoms[start] = 0;
+	changed = true;
+	do {
+		changed = false;
+		/* iterate in reverse postorder */
+		for (po_num = po_last; po_num >= po_first; po_num--) {
+			int idx = env->cfg.insn_postorder[po_num];
+			int new_idom = -1;
+
+			iarray_for_each(pred, preds[idx]) {
+				if (++work % 1024 == 0) {
+					if (signal_pending(current))
+						return -EAGAIN;
+					cond_resched();
+				}
+
+				if (idoms[pred] == -1)
+					continue;
+				if (new_idom == -1)
+					new_idom = pred;
+				else
+					new_idom = idoms_intersect(env, pred, new_idom);
+			}
+			if (new_idom != -1 && idoms[idx] != new_idom) {
+				idoms[idx] = new_idom;
+				changed = true;
+			}
+		}
+	} while (changed);
+	idoms[start] = -1;
+	return 0;
+}
+
+int bpf_compute_idoms(struct bpf_verifier_env *env)
+{
+	struct bpf_iarray **preds;
+	u32 len = env->prog->len;
+	int *idoms, i, err = 0;
+
+	preds = compute_predecessors(env);
+	if (!preds)
+		return -ENOMEM;
+
+	idoms = kvcalloc(len, sizeof(*idoms), GFP_KERNEL_ACCOUNT);
+	if (!idoms) {
+		kvfree(preds);
+		return -ENOMEM;
+	}
+
+	env->idoms = idoms;
+	for (i = 0; i < len; i++)
+		idoms[i] = -1;
+
+	for (i = 0; i < env->subprog_cnt; i++) {
+		err = compute_subprog_idoms(env, preds, i);
+		if (err)
+			break;
+	}
+
+	kvfree(preds);
+	return err;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c5a3b0f75742..770091306032 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22745,13 +22745,14 @@ static void log_program(struct bpf_verifier_env *env)
 	u64 pos, insn_pos;
 	u32 i, j;
 
-	verbose(env, "Program dump (scc? insn#: live_regs_before):\n");
+	verbose(env, "Program dump (scc? idom insn#: live_regs_before):\n");
 	for (i = 0; i < insn_cnt; ++i) {
 		verbose_linfo(env, i, "    ; ");
 		if (env->insn_aux_data[i].scc)
 			verbose(env, "%3d ", env->insn_aux_data[i].scc);
 		else
 			verbose(env, "    ");
+		verbose(env, "%3d ", env->idoms[i]);
 		verbose(env, "%3d: ", i);
 		for (j = BPF_REG_0; j < BPF_REG_10; ++j)
 			if (insn_aux[i].live_regs_before & BIT(j))
@@ -22974,6 +22975,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = bpf_compute_idoms(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = bpf_compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -23137,6 +23142,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->callx_edges);
 	kvfree(env->func_ptrs);
 	bpf_diag_free(env);
+	kvfree(env->idoms);
 	kvfree(env);
 	return ret;
 }

-- 
2.53.0
