Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC65478E45
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432465; cv=none; b=cjsUHG+0yGnRJ1+KiNSIOqmcP+yyKB6uYAzd3I/EJA7WaFD+lGgjb8CnfglBMCgiGHrnVyu9foJtzw4feIpWJ5xZLNlTvpqpwL6xbDeKeo0HCPbGIMppSb35T4yyF6HQM0OvowGobVPGvOxF/4ITtswB6VwDCSEzjrXkGUxKvGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432465; c=relaxed/simple;
	bh=k0q8lpg2QXqc0PFfnZMOAW22vMSpwuDpI1l9yFWn2S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZE5V59jLFXw1fUVjqWe/3q+U26sThM3WzGKL8mWAdMPUiy1yVXs6boqfBkZ6avlLt2tcxG9FpKRCcjfXzT9i9BNtsw64+QjqD9iLaRB1OtEYw70V81e+4IsXMpxkulmsQ3vqz15P69hhd/wC4Rhem7K40folIeiq+sbQ6DUDaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LB0fNJ0+; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB0fNJ0+"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0eeda3e03so108078a91.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432463; x=1791037263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B09sZ6/5e7iNDSvsRsm+A2uCi1o4MAXCjfthBMoYKOY=;
        b=LB0fNJ0+g0WMUjpCLcRY0gyy9LkwWeOBVNzOfWyJkZNpsBHYtEoL8kD4e4tX+6ut69
         FhIwiYg66NxPeUoDnBwi1KNkGhOO7z7su9X/N4ncEInMAaf4Y7XHDejvJBDnfPsXk6Th
         qA1+KuuouGP7Wt6ZzJYi+hTRMDHMNOodAjRIHYaI65s9WdbLRaDrzRL1UqOiGsMID4Pj
         NEMU/1TiRBAjcekmgcYmAS9oKMq5Pbpa1fgQGoQItvRUlKdZpalrgNOaBSSWJZ1yGTPP
         J1XswLe3oPVKjUtThmawGmWcWtA/ItaaPiXSYlDRY1ylXLe1G356jtm9GFNqsJvChqry
         UdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432463; x=1791037263;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B09sZ6/5e7iNDSvsRsm+A2uCi1o4MAXCjfthBMoYKOY=;
        b=ffDcT9sjvS1SoUxACx97CiYZJKISeKHdTLKJEVT+cdgcr6notYG4iDB8WsUXGV5izs
         qeCIC0Aa0kDBWx/Ao/mnfnPlCDZ2F3zYnvmKmB7IHsmDhWOVv1P88UBg6pj75SxkSlpr
         sMtQqA+DzRedw1xq56/piQ6zhj9bWTtWvNvoTyPuGPqSD8OgkcBlGc/qIr5ZmwbGep52
         P+6lbnkrasFjypGlUG/nwjKW5SkLnLJJp2a7LMXEgYHdFfwJkD9LpGT2ccovDMVcecaQ
         j5uFMqtbAS7BMgVUQ9dp67sGAmgZY3JMl2QfD++8SDOmPBDcJ0TTYos+1dFfZ9dpIsgC
         j7bQ==
X-Gm-Message-State: AFq9FYIeBhehBRMiV1Bb9XpMpM0k8QUWVKprZ8cMKnjIQX9H9lNO/lzt
	sFLvKd4cUyBKUt9xS278RMLo0TBeFIzSEb3B8XgU1U+gkFO/u+Ig1nBZyqswYd2Hpz4=
X-Gm-Gg: AYBFou0yKHpgAyf0qAkgN0n6Jj5j8PqBrY4Q9U2ouOo7kqQ26TOHANgwJir1bK7WhsW
	UTHlq/ThELofUS0pxuQm8kkFfenfdBW4bXAZEhofwMo5hRakvO8r3ugA7aNCVBik0oK6/V3aASj
	L98WgXF4vk38iEG7qLjM5+Llt2bbNAUOegGqEvwG6Y7UUF+OeHV8iekJEyk4Pw4lSJzOnphBagV
	XKEEjTsQCenqFkfpMYIdjMgsCYrB5FYbIseBKq8s1955cSSHDoYkvqU/d9JmHTgmFzYIfo6Y2Cb
	sLBOx5sH0/iyRlXtC/ka9iZk2Vdl/9AFyOxLE88XjuOgSfdKKlooNrzZB/rErkyR94ziETGQMdr
	PB5lqm7bpkA82hXtVHHogrvh41Pbsh02S8I+DjG9Lvdehvdz7NLWB8K7wqnPK+yIF0A7rKzC6lN
	dGGsInQEHC6eN1PBqkxnO3PY0EuArgxriAJYRASxvbjnoL/54kxuFzE84zu921kBvmnSBMQP3b3
	ShhVa4b/OeQzbre8cgFwFTPtQQ7za8i3Of7NNqW0w==
X-Received: by 2002:a17:90b:5807:b0:3a0:8050:2ec5 with SMTP id 98e67ed59e1d1-3a0985be2fcmr6247574a91.12.1790432462926;
        Sat, 26 Sep 2026 07:21:02 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:02 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 18/36] bpf: compute immediate dominators
Date: Sat, 26 Sep 2026 07:20:16 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-18-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
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
 kernel/bpf/loops.c           | 143 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   8 ++-
 4 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6a8157e607ee..5e6fa41a1353 100644
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
@@ -1109,6 +1114,7 @@ struct bpf_verifier_env {
 	u32 scc_cnt;
 	struct bpf_iarray *succ;
 	struct bpf_iarray *gotox_tmp_buf;
+	int *idoms;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
@@ -1869,4 +1875,6 @@ int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
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
index 000000000000..e7ff02e9ab3a
--- /dev/null
+++ b/kernel/bpf/loops.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/slab.h>
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
+static void compute_subprog_idoms(struct bpf_verifier_env *env, struct bpf_iarray **preds, int subprog_idx)
+{
+	struct bpf_subprog_info *subprog = &env->subprog_info[subprog_idx];
+	int start = subprog->start;
+	int po_first = subprog->postorder_start;
+	int po_last = (subprog + 1)->postorder_start - 1;
+	int *idoms = env->idoms;
+	int po_num, pred;
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
+}
+
+int bpf_compute_idoms(struct bpf_verifier_env *env)
+{
+	struct bpf_iarray **preds;
+	u32 len = env->prog->len;
+	int *idoms, i;
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
+	for (i = 0; i < env->subprog_cnt; i++)
+		compute_subprog_idoms(env, preds, i);
+
+	kvfree(preds);
+	return 0;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 474caf8696fd..93100541475a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22589,13 +22589,14 @@ static void log_program(struct bpf_verifier_env *env)
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
@@ -22815,6 +22816,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = bpf_compute_idoms(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = bpf_compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -22978,6 +22983,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	kvfree(env->callx_edges);
 	kvfree(env->func_ptrs);
 	bpf_diag_free(env);
+	kvfree(env->idoms);
 	kvfree(env);
 	return ret;
 }

-- 
2.55.0
