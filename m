Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6E33FE33
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824257; cv=none; b=QBOEo6qVewYN9ogpWurKk+yMkbhCT7ChARWf34MjqjR0jPOOv2u1Wkx2m9ZSkhPysG49VhJUIVG00FtmznceBk9aR7BBi9IQSj5B0lgUKSuwCJ7zfvGruXiS7F/sJ2jrhLmdslAX1SqELr6OTfE66YEMHZYEgr67QkO+PHEyG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824257; c=relaxed/simple;
	bh=gjupsk5p0Vg6YsV+/ZTI03Y27beIqbjx6pO9seZS55g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lS3IjLDMBIngf1A+yxSHgK5L7dM+Bn3jxKISJ+aXo6GcZuRBoJmOarwnLj9VbZhf+jscbEN0BCOR2uPKMYX/UPKbOiDzUyI4EPzypmAghQMiEwr9a043vvQK9eOjmjxSXglhhYcNc75yo4ItVfoSPRG3GophGcaGBKP/kXklVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGKdOOoF; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGKdOOoF"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-366375c4076so4750692a91.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779824255; x=1780429055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p99VX1yeeZf2ANnLp0K1bHNizFtrBqv0Q1pV3jdOFNg=;
        b=oGKdOOoFRI/CUMAZ09aQ8zda8lrqQg8t1fcUkK2JSJVB0kfymFiYbScmH/f2oBMz5D
         tZ/FE3lRJKmlCBlPVLUujihqYf1Ua4LpoO6//qfDNT5nbe04NR9EDuDY69g4jb1aYo7l
         RI7yxHpr5D8hvBX3+JAHRb2kYLmUdMP+dKjQx1RgRSLczxBgztSXRo2J1JRPjrw7BQUx
         BTSZyn5b2b57QgPIZhGU6L7umupeRs5BTzZT3xQbiXgsPVNMM9K4pcL2gD9HZM0ITvoc
         G877dpY4e+HupyZ/5B5xc1t3mUDlsP4gJPGITcKPfecxCvK6k7oNhOrGbhASSUyigVhb
         ykWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779824255; x=1780429055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p99VX1yeeZf2ANnLp0K1bHNizFtrBqv0Q1pV3jdOFNg=;
        b=EI25QbTmtmW6oGTWjgf/OGlM7CoFzie9IKyGI1xg7x4p+0V8nqV/gG3ELnYuLr33nA
         wj/CK19QQVR5TMw9Z9EkUmGh8hRVpaVgd3rYg21EEYPV6mhTemOD9sw0tcyGgmNhCHXW
         2E6tEGobh/tsJjq1umIUoLmILnvG6lyZ5SurZcCPRb1yicjlhi/V7GDoOIfNjN8gHzWx
         qZkUyCIx2yM/gXfaZKJ92lN4Z7ZPZTyJciT9lWZdFGGaGnkP3I+4BYvocyL2+UkuuH8r
         8Fj3t0pnHnpwa4b/KCSBzM0o4Kih5mXuVTbJ3rtoymPlEeCpdqgdHPaasbhCCDbxFMoC
         d4ow==
X-Gm-Message-State: AOJu0YylPNNXvn+kvXxYmvfYkNqo8tSSH+0/YK4fLN4BYVietfbFM73i
	tnFiCQOd7/L/rU+xPZ62TVuB3yH3ZMHs7lZ8mh+rdpI1+umV92iw6q1dip/L5QBSNFo=
X-Gm-Gg: Acq92OEWtFaYDP1gLnfY0RbpXZ+kdGYLCwYrrwwwRlrKy6rw39c6fcSyIk3Vb2BD6uU
	SgVYMkaUpgAnBBAFS0pcjcNnKH+fWWGLyslyyFRkUf1tXWlqMcjA4rL6Vw3PFejh0t1sF/wQmrM
	iaVk/b/dkB9ENVjPm9OD+A1f2j9IcCoRpXBybin310194V9LSw8pXnOOQ4Ln0sZZ1aJYkX6dLFT
	9mxkYDGVkVODctGioZ8Q7oDgB0LLVxZTgBu3uqe5tgP0otM0PHIJV8ny+3t9c1iVyhtk0txFBZo
	lVjtW8ZITysBFWd8rpzerM/WzNNcHyaLJLuA4FQVlkno+pc43Oe6kwDzHkztQdjZIupM0uTFIXp
	1y/gpu7HxgXPDWr0DwpYFNqD+KXfnkUs77zN+duTqdn8rRpkEXI8ykzKzSRGLBi39GbJog9h4+2
	aNfp0IXG9aaynmBHMdZL1RA4BCo3Utn5Vi8XVxCz8diZR2qTjIlx0zruZyg/IOQLcbBpq3dexDt
	vTYFA==
X-Received: by 2002:a17:90b:5445:b0:36b:218c:719e with SMTP id 98e67ed59e1d1-36b218c7792mr1210592a91.21.1779824255091;
        Tue, 26 May 2026 12:37:35 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c913a1sm12617283a91.15.2026.05.26.12.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 12:37:34 -0700 (PDT)
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
Subject: [PATCH RFC bpf-next v2 2/6] bpf: compute loops hierarchy
Date: Tue, 26 May 2026 12:37:16 -0700
Message-ID: <20260526-better-1m-reporting-v2-2-e7ec61c45d41@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526-better-1m-reporting-v2-0-e7ec61c45d41@gmail.com>
References: <20260526-better-1m-reporting-v2-0-e7ec61c45d41@gmail.com>
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
index 000000000000..1f0b10c57957
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
+	kvfree(dfs.dfs_pos);
+	kvfree(dfs.stack);
+	kvfree(dfs.state);
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
2.54.0
