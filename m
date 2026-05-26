Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5B3D7A01
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787827; cv=none; b=bmaiSFfhs52IdNdR73aQbSsSzfiGeWMuNMCdoZW4XZKLTpeT3OUyQ4qPaqnyGXgsD1xbFxN7lrWlsycTYPxuHInD0ANI6uqWC08hxdWOUFPS/bGlPnxHalnX8muyh/ZGu9aMXMLmqMq4ode91MIXUaxR7t/sYkkx8WH2rhfXpUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787827; c=relaxed/simple;
	bh=zKBoNwluCp3XZTnwlSQQHEAv276ZIZlYsxUBwA8GNFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJXBG7RpruOsELPlwXhBeUeIEz0ikpx97gaB/3229p8WJep3n8RnWjqbRMEKmqsskJy3cR2C/sB1q0ddFRREAg+qLZ+qL2k4BsQqkhhdgJymg7NI/ZIXxC5dZKLAVfQmQknOBQT6tY64fEPyAnVslzQ3nMByGm2nPYI9FQcRbBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWRiSVsC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWRiSVsC"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-83ea84df1d0so3416184b3a.2
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779787825; x=1780392625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SBwrdpK2cTYJ51vqZjyJ468JQl4MNxlwo9RTZOZAJ0=;
        b=OWRiSVsCi0oCzqnXBYuClpnWqDbbP8MVlhs5GaxJqIdw0j3TctRiDpEjGpTSlCEVMY
         MCaYvdVC86kQmFWPBs0wr2l4hYyfMEKQtEyFI4lUZyLQ96tL56VkA+S/QHPq//JKyHat
         xeTigNHE+rjLu0fhD6LLnzcADw/NpPMD8y7TIE2fOVsAuez/7ZTCLsvgwHsx316dpY6I
         taiEswZzVIU+Tlclosvu+8NPtymMKuAKdek9WR+SIh0go3BmdQXPd6wNwOzsCxGpwQL+
         ay8zD+OL2LJP8sHFAcHWtJl+fw82+Oc6eM4p+XkFkDch8wmyowFZIp0Zn/1clh/mgNAA
         Bofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779787825; x=1780392625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1SBwrdpK2cTYJ51vqZjyJ468JQl4MNxlwo9RTZOZAJ0=;
        b=Vcq1nrf3M9b3EJ1/DoUujqjOht1Ub4icz+vBBGpEo7HgT/3oJMXL8rRuOvVKcd4XhT
         Ap5XdKLzau3Y/VEd63KV6DsHrfnv2atxYfvfXyxmEegh4rWNE17r0GL79P3ue31nMXUd
         n1z6id16jrl7A2fMbTH9/0ZcE79ndnQaCUihy0nSc6w9aqD0S3Bg9kHg0agWln0AwPt9
         wEjz+CtOGViRrle8OjhUEv5IHZz4UEpqYaSgTOVbaisuhgZv8BK9sXPzzmQf7FN8Ag5P
         WTKQd+A+hzvtd/eW7lXLsFughDMfEmrbbY1R3JOYAtWEy318dXjIA7NTewaTPRz2xIZo
         JB9w==
X-Gm-Message-State: AOJu0Yy+89Gw2LFVYRiqKsANeQbeCrwWOnGISXTyP1ko5HSkcS+6zsZN
	k6SVx6NgDW7kfOvLYznE+zEoosVvS32qvGU2ZCZZkwqEdT4d0r73uCXz9XcMiXt7lZo=
X-Gm-Gg: Acq92OFM9fCtFmVT39QeSaaM8cjy9jy/eNOIDNR2SW8UJGsmmcr1pi3Olxo9EJ0NJxb
	2ikGLfwRHtFdXyQEpJkHyFuHcuLmjPuMI2/OXPJrTQUgierq4/c7j0/tRIEBK8VttgXNymUZ4WQ
	CQFtmGexw5xjws5/r3pHR2uVlyTT3qxRV1TQwsfrBYrwg/tHdJ+De7Gn/X302P2OLx2Zg/5jme9
	1Iz2U7QCMLyvYnMVGXfqh4yGzmFnUlDHwINQyIg4rYAtZzQaN6FPVZlo1UC5NPpsNbFq/fzd1QO
	2YyE6h5eyu6elp+IsdOTq8s+ddyWfYLVrRa1DdM1vEXZI/pr2OCK/sSA1/7DKK3aGoyT6lEngB6
	FyF0LxJOJu5OefQbbrtphZBWAjVUeCGlX44ltyOIXD5MTJavnkjf8Dr8iTyj5rZzlYNEUUeph+F
	58YmArBjY3TaYi1iZjNxOwXc2kdDOKFpqfrxvtJzeG
X-Received: by 2002:a05:6a00:12da:b0:824:9bc5:e946 with SMTP id d2e1a72fcca58-8415f6e80ffmr17017601b3a.46.1779787824936;
        Tue, 26 May 2026 02:30:24 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff3e00sm13729505b3a.54.2026.05.26.02.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:30:24 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next 2/6] bpf: compute loops hierarchy
Date: Tue, 26 May 2026 02:30:03 -0700
Message-ID: <20260526-better-1m-reporting-v1-2-51e4f2c59780@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526-better-1m-reporting-v1-0-51e4f2c59780@gmail.com>
References: <20260526-better-1m-reporting-v1-0-51e4f2c59780@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add an analysis phase computing the loops hierarchy to the bpf
verifier. The algorithm is based on the paper:
"A New Algorithm for Identifying Loops in Decompilation" by Wei et al,
adapted to be non-recursive.

Record the loops hierarchy per instruction:
- The field insn_aux_data->loop_header records the innermost loop
  header containing it.
- The field insn_aux_data->loop records additional information about
  the loop if this instruction is a loop header (at the moment it only
  tracks irreduciblity of the loop, additional information will be
  added later).

Subsequent patches use loop header entries as sampling points for
callchain profiling, for better error reports when the 1M instruction
budget is exhausted.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  10 +++
 kernel/bpf/Makefile          |   2 +-
 kernel/bpf/fixups.c          |   5 ++
 kernel/bpf/loops.c           | 184 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  10 ++-
 5 files changed, 209 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5cbad3b64130..d0a1fb135cbf 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -656,6 +656,10 @@ struct bpf_iarray {
 	u32 items[];
 };
 
+struct bpf_loop {
+	bool irreducible;
+};
+
 struct bpf_insn_aux_data {
 	union {
 		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
@@ -742,6 +746,10 @@ struct bpf_insn_aux_data {
 	u16 const_reg_map_mask;
 	u16 const_reg_subprog_mask;
 	u32 const_reg_vals[10];
+	/* index of a loop header of the innermost loop containing this instruction, -1 if none */
+	s32 loop_header;
+	/* additional information about the loop if this instruction is a loop header */
+	struct bpf_loop *loop;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
@@ -1608,4 +1616,6 @@ int bpf_jit_subprogs(struct bpf_verifier_env *env);
 int bpf_fixup_call_args(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
 
+int bpf_compute_loops(struct bpf_verifier_env *env);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 4dc41bf5780c..787d183ba5b4 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o cnum.o log.o token.o liveness.o const_fold.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o cnum.o log.o token.o liveness.o const_fold.o loops.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 12739add2dda..57294524dab8 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -450,6 +450,11 @@ void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 			aux_data[i].jt = NULL;
 		}
 
+		if (aux_data[i].loop) {
+			kvfree(aux_data[i].loop);
+			aux_data[i].loop = NULL;
+		}
+
 		if (bpf_is_ldimm64(&insns[i]))
 			i++;
 	}
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
new file mode 100644
index 000000000000..4bbcd923e960
--- /dev/null
+++ b/kernel/bpf/loops.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/slab.h>
+#include <linux/bpf_verifier.h>
+
+struct dfs_state {
+	u32 traversed:1;
+	u32 next_succ:31;
+};
+
+struct loops_dfs {
+	struct dfs_state *state;
+	int *dfs_pos;
+	int *stack;
+};
+
+static void mark_irreducible(struct bpf_verifier_env *env, int h)
+{
+	env->insn_aux_data[h].loop->irreducible = true;
+}
+
+static int mark_header(struct bpf_verifier_env *env, int h)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+
+	if (!aux[h].loop) {
+		aux[h].loop = kvzalloc_obj(struct bpf_loop, GFP_KERNEL_ACCOUNT);
+		if (!aux[h].loop)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static int assign_header(struct bpf_verifier_env *env, struct loops_dfs *dfs, int n, int h)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int *dfs_pos = dfs->dfs_pos;
+	int err, nh;
+
+	err = mark_header(env, h);
+	if (err)
+		return err;
+
+	/* Don't encode self-loops, otherwise can't reflect loops nesting structure. */
+	if (n == h)
+		return 0;
+
+	/* Make sure that loop headers up the chain are sorted by dfs_pos. */
+	while (aux[n].loop_header != -1) {
+		nh = aux[n].loop_header;
+		if (nh == h)
+			return 0;
+		if (dfs_pos[nh] < dfs_pos[h]) {
+			aux[n].loop_header = h;
+			n = h;
+			h = nh;
+		} else {
+			n = nh;
+		}
+	}
+	aux[n].loop_header = h;
+	return 0;
+}
+
+/*
+ * As described in "A New Algorithm for Identifying Loops in Decompilation" by Wei et al,
+ * adapted to be non-recursive.
+ */
+static int compute_loops_in_subprog(struct bpf_verifier_env *env, struct loops_dfs *dfs,
+				    int subprog_idx)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct dfs_state *state = dfs->state;
+	int start = env->subprog_info[subprog_idx].start;
+	int *dfs_pos = dfs->dfs_pos;
+	int *stack = dfs->stack;
+	int err, s, h, cur, stack_sz;
+	struct bpf_iarray *succ;
+
+	stack[0] = start;
+	state[start].traversed = true;
+	state[start].next_succ = 0;
+	dfs_pos[start] = 1;
+	stack_sz = 1;
+	do {
+		cur = stack[stack_sz - 1];
+		succ = bpf_insn_successors(env, cur);
+		if (state[cur].next_succ == succ->cnt) {
+			dfs_pos[cur] = 0;
+			stack_sz--;
+			continue;
+		}
+		s = succ->items[state[cur].next_succ];
+		if (!state[s].traversed) {
+			/* Case A:  start -> ... -> cur -> s [unxplored] */
+			state[s].traversed = true;
+			state[s].next_succ = 0;
+			stack[stack_sz] = s;
+			dfs_pos[s] = stack_sz + 1;
+			stack_sz++;
+			continue;
+		}
+		/* 's' is fully explored at this point */
+		if (dfs_pos[s]) {
+			/*
+			 * start -> ... -> s -> cur --.
+			 *                 ^          |
+			 *                 '----------'
+			 * Case B: 's' is in the current DFS path.
+			 */
+			err = assign_header(env, dfs, cur, s);
+			if (err)
+				return err;
+		} else if (aux[s].loop_header == -1) {
+			/*
+			 * start -> ... -> ... -> s -> ... -> end
+			 *           |            ^
+			 *           '---> cur ---'
+			 * Case C: 's' is explored, not in the current DFS path,
+			 * and not a part of any loop.
+			 */
+		} else if (dfs_pos[aux[s].loop_header]) {
+			/*
+			 *                 .----------------------.
+			 *                 v                      |
+			 * start -> ... -> h -> ... -> ... -> s --'
+			 *                       |            ^
+			 *	                 '---> cur ---'
+			 * Case D: 's' is explored, not in current DFS path,
+			 * but it's innermost loop header is.
+			 */
+			err = assign_header(env, dfs, cur, aux[s].loop_header);
+			if (err)
+				return err;
+		} else {
+			/* case E */
+			h = aux[s].loop_header;
+			mark_irreducible(env, h);
+			/* can also mark 's' as reentry, but no need for now */
+			while (aux[h].loop_header != -1) {
+				h = aux[h].loop_header;
+				if (dfs_pos[h]) {
+					err = assign_header(env, dfs, cur, h);
+					if (err)
+						return err;
+					break;
+				}
+				mark_irreducible(env, h);
+			}
+		}
+		state[cur].next_succ++;
+	} while (stack_sz);
+
+	return 0;
+}
+
+int bpf_compute_loops(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int i, err = 0, len = env->prog->len;
+	struct loops_dfs dfs = {};
+
+	dfs.dfs_pos = kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
+	dfs.state = kvcalloc(len, sizeof(struct dfs_state), GFP_KERNEL_ACCOUNT);
+	dfs.stack = kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
+	if (!dfs.dfs_pos || !dfs.state || !dfs.stack) {
+		err = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < len; i++)
+		aux[i].loop_header = -1;
+	for (i = 0; i < env->subprog_cnt; i++) {
+		err = compute_loops_in_subprog(env, &dfs, i);
+		if (err)
+			goto out;
+	}
+
+out:
+	kfree(dfs.dfs_pos);
+	kfree(dfs.stack);
+	kfree(dfs.state);
+	return err;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d569e36128c..2b3584712ad2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19627,13 +19627,17 @@ static void log_program(struct bpf_verifier_env *env)
 	u32 insn_cnt = env->prog->len;
 	u32 i, j;
 
-	verbose(env, "Program dump (scc? insn#: live_regs_before):\n");
+	verbose(env, "Program dump (scc? loop_header? insn#: live_regs_before):\n");
 	for (i = 0; i < insn_cnt; ++i) {
 		verbose_linfo(env, i, "    ; ");
 		if (env->insn_aux_data[i].scc)
 			verbose(env, "%3d ", env->insn_aux_data[i].scc);
 		else
 			verbose(env, "    ");
+		if (env->insn_aux_data[i].loop_header >= 0)
+			verbose(env, "%3d ", env->insn_aux_data[i].loop_header);
+		else
+			verbose(env, "    ");
 		verbose(env, "%3d: ", i);
 		for (j = BPF_REG_0; j < BPF_REG_10; ++j)
 			if (insn_aux[i].live_regs_before & BIT(j))
@@ -19791,6 +19795,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	ret = bpf_compute_loops(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = bpf_compute_scc(env);
 	if (ret < 0)
 		goto skip_full_check;

-- 
2.53.0
