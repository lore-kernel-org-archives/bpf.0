Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0434C651F
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542930; cv=none; b=Pu/bYRXqmLNiJ2Ynt3EDGs1Wbh+ZrACEmSx69ar0iwp/WWF69Dvm4HqKgxamZ2ln/7UC89r0u7rUBHQSnbtUNIoYk1oB7WI4cvWJmJxBUlEyHqJIV9sNqOop8htRtScfIqiv8JnTkRIzRciksilpqwptnwJoD0BMwZrYHmLYvyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542930; c=relaxed/simple;
	bh=8RkcTkkzpbs1RgRrzvI15oDaHJrDN+nbYAv+EtYsSPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLt0FkDbwB1GVrrIg47wQFPEpY/YBOPb0S1p6yBqcHqWvD29VG2yGVbyD7Cm39zRfp4GjsFUOkQ0XsoS2jtilq47cH68srj3JGwhocK57LRe0XpL08YKe9YHsNQvSCqNgabmAuklpADefV26DfRssx+fjty07RCoYxWCUogW4cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzvW35zu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzvW35zu"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38759bcd877so3256129a91.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542916; x=1792147716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3K6a8350OIcZ3KEI5J78QHAlyKpGUZ98PAhyWCaCkyk=;
        b=IzvW35zuew5jj2AUmkt8NczdnoMcarbt1OlrvH//38OBh1LEfxwWT38VfyWJFL3XGQ
         NC792lGloHuMhYbqDwMao5ZUGpUgXog9T9lfoQS/nmiqDOMfc3+TUYEw07O3rGja65yo
         UA0lTrFeTI0bhhTUTHsaVlSG+OLa00DaelTUUKV0pipPLByAMFlQJMy/aP1V8V7bpvGT
         8bGdMRONSLPvrPT3ZeAU9/1N6HcQsqlda4RFwoW3zITzWrh+GP2Y33LmfxuZngih2/XV
         PF8VCOwBIo4wCfESUHOwfmA1pdWLf1LWOIyymOLkQzLcSjOEn9Ds27yFZrDSybgVMFsC
         Ss/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542916; x=1792147716;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3K6a8350OIcZ3KEI5J78QHAlyKpGUZ98PAhyWCaCkyk=;
        b=StSxbfeUXWP+NcYH5WRNVndYO/wez7US4SmaA4NIP7SwOYzbuYxt+m/SOHhbBIHpIS
         O1VCvXhIdS01HqDTTh0OzOaPLO7N/i+Q45x2a+OjD0RvaW4KSI7nEMqeHYwQDcPxdgHL
         rApq+fwIPTw1UsGdEfBA86trL+E1/uMLnOK8UWTTQCCxC306kZCHcCSDQ2tXA0MZl1mT
         5mcP5e9RrFmxu1z9E4+4I7iVkYIVvGDhUn4kvvPzs8MwVWgFmdFKaWaQJVVDpO1gLHe+
         FPTSvzc8KgtlLJqBBNO45VCj3mUQpLhsE6WcD2CgoTFE6G8c2P5MxucGi1E1rsGiFcuV
         iyUw==
X-Gm-Message-State: AFq9FYKron97ugOnTt/sSj3+9vd1qGrVYy340IRTnNLyh2YLKtU6cYbz
	tzBAR2Y0NgzIqhI1YQlMKKCSQFSHLgx3eINCO0Hn+ZzKYH3BbmlGo6aNWpRzB/ej
X-Gm-Gg: AYBFou39ODI6Q15xTLagC9eLfFRSo9BEooNS4h2jmUht9QIcZhdKEZWk0Fv0PBanRZR
	ZiSEBQFXOuYs+oYS6Djj61SdZTA6hfef4uu7ls+X0OWGhTZh0+AH/Kr2dI3BYLwq2oIS6zJ/h+n
	L5WSjaJZuoLg0fFAI9GO29mGkhp+3OSNBap6piIR7OBZT54iQwEiSLH22lqfgZlS39c0e5e0csk
	3BExFu/d1hFQ1suXiHjXHcRdbTJ18Y1StwAF+ebxY4JZDukC2f9W9GYDV+E7W+p5HfID9z1x1cm
	d4vlYYSGtn4EX7ee2pZ39LloIQsMR8Ok9HwdYckhiQd9KbaVz46nxEwleHkV5jqsYeq7uwz3wHD
	bJvvwBF5rISSMdaVCvNSirBBQ3IDvxDsI9kuM1R5UO73qait4ByXWLCfezKp5/SKiC7SIDhXkRP
	gt/h7D++ttSMSmFCqW6BnqqhUUMbtX0ZgL9KxLKPQ54PLlci/3Yqc3kXbfVf18O+CXn2wqgTRSV
	b7SkPdHxaJDyMQ=
X-Received: by 2002:a17:90b:5403:b0:3a6:fe14:4790 with SMTP id 98e67ed59e1d1-3ab3ac9f78fmr1417167a91.28.1791542916241;
        Fri, 09 Oct 2026 03:48:36 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:36 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 23/51] bpf: compute immediate dominators
Date: Fri,  9 Oct 2026 03:47:41 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-23-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
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

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   8 +++
 kernel/bpf/Makefile          |   2 +-
 kernel/bpf/loops.c           | 158 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   8 ++-
 4 files changed, 174 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bd7733fbe930..59c0670af0e9 100644
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
@@ -1888,4 +1894,6 @@ int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
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
index 000000000000..0db823ee42f7
--- /dev/null
+++ b/kernel/bpf/loops.c
@@ -0,0 +1,158 @@
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
+	u32 *num_preds, i, s, len = prog->len;
+	struct bpf_insn *insn;
+	size_t sz;
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
+	sz = size_mul(len, sizeof(*result) + sizeof(**result));
+	for (i = 0; i < len; i++) {
+		insn = env->prog->insnsi + i;
+		succ = bpf_insn_successors(env, i);
+		sz = size_add(sz, array_size(succ->cnt, sizeof(*succ->items)));
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
+		tmp += struct_size(result[i], items, num_preds[i]);
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
+	idoms[start] = start;
+	changed = true;
+	do {
+		changed = false;
+		/*
+		 * Iterate in reverse postorder, skipping the subprog entry:
+		 * insn_postorder[po_last] is the subprogram entry.
+		 */
+		for (po_num = po_last - 1; po_num >= po_first; po_num--) {
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
index 9260ee290072..5a29d05c523c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22872,13 +22872,14 @@ static void log_program(struct bpf_verifier_env *env)
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
@@ -23103,6 +23104,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 
 	prepare_subprog_args(env);
 
+	ret = bpf_compute_idoms(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = bpf_compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -23266,6 +23271,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->callx_edges);
 	kvfree(env->func_ptrs);
 	bpf_diag_free(env);
+	kvfree(env->idoms);
 	kvfree(env);
 	return ret;
 }

-- 
2.53.0
