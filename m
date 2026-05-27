Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87AC3BE623
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867009; cv=none; b=NjxDkifVbWBgl4Uo9HSxCfejpAwTODmBDo0ENChExIHAVGAsVSvs3/XofvDAqx/fJAlNWM1gOVrnp5UyBv9Xi636qeob7q7IGStGuyM6944lYNmCtST8ki+JtgMdzGRF0isla9PPHdxXo8Jb8YKcineKdcIyzJLnB87odhrJ30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867009; c=relaxed/simple;
	bh=YWqc4woh/9dSrVNxJGRdB6aLU0ZbNj71WU5Cx6qRGY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h98iqfCrjxv1wpoWG53RfJ+Z7yEptvF9fKtTF1vyOjSaKZSYCV5eVQ4yQ+bdxdku7UTqPheIctA/ExTArmHqDZokg+bzuJmXzMp85tUF7Et060/7/HaRufDddPF84M5wOv5f3pB4iGWl7IAFVFMjO8awomEfdcUYRJBuVkdxdpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdSI5KUa; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdSI5KUa"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ba4efedbeaso86197105ad.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779867007; x=1780471807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lohoenMotyMbRmEhEDshxbrM7q8cjRNCyEwZfAWuu2M=;
        b=YdSI5KUaiHbXw0z1Ot/DeaX+zygkXIpQpd65zCvmRnOb6AcxklckJ1u9iLFBRg20bb
         r6P29ErxD4Edn9T7EPQlhGlWTAXTfCrtSRgGmINCc3CoNdi9HKrlERnsMPyq63iwD5dQ
         3NBbCSHlXZVKYCjgiCQtdpJiy80hhKfk9/b0abuDWbzDBi8aj0lXPOtYBzUJcwy5QDrp
         gdB5LObYcA0Dpar+GbD8nR5qS1pp+Cw4E1XXxOPEauy6ahtMd6jWzAy/BSH98WqBkaRr
         ATgFYAaBYs0/QeolwWUJ8d3YaY1MPvR+aizg9j7RAzLMW9TFMBSVZyciuHTcXREH012X
         STgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779867007; x=1780471807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lohoenMotyMbRmEhEDshxbrM7q8cjRNCyEwZfAWuu2M=;
        b=lzioTZKnab/9GtOg/Iiankg47/8BXta+HZVB5XBa+9X+WZlw7SNBAUEHdEcjoQZobm
         KIWqoglKojwabBmT+6IH6agcvRVd24ui48FLnDNJtcpOfTHmUoY3ABpdwHN3M1Mci3N8
         91QE3S9FLEnZb2pbkTJGpkJdAJnI1fOFTAzLjASQexaEI+9YLuyzCw2pn0/wkwK9rlgg
         /Yqt3DFFYpfqli27mR0Rh5uyv7S8Ahg1ZqP+F3bMnVolsST+Zmw8OBCWkWADPjEtk/Pp
         SoaNqZf064/R4pphyxHHRnvcEVXQlJQ3kTUSPSToUpU8ZdPjLSuexZyETb5Gg6Nwh96/
         8o3A==
X-Gm-Message-State: AOJu0Yy0iV34GOfP9zoNuk88g1XMohE4rqxAeGqyzIPuvlkZ3GmoQf7O
	QrNkcDCXSaW5XkbGl5dGnRDVjs59nFjwYsYPEa8GZDcYsJDsefRvV1spssxpOYAJ
X-Gm-Gg: Acq92OEtStiyIvPJupTxaJjk1cHKouNNcctt5T+Z5bcdFdkWrPS1NdUcZwMfN2ajCe2
	WJJTAqtt1DONHBInpDe8Vo11k2fnX46itqERSj75DZD0859Zqr+A5dxkhfqZAWEovm0olRRGMbY
	teVshrjNFgjLU/OrTxjZ3gFk9lDv5lkodTQ8e14ggGxH+0zDKQZewVw6UFQYkMEK6VCd+8DHdom
	EPJAHh9qv/itl+mzRKddnczxyK+YPvVuMEXH/OBASaIrvU/gBjTeHJ+KJk9Vzl71A1PdEkDy5F5
	zo1nRhkEiJnBaPgko/VBxcNQADZcJ1LP/4fM1LxH4kq8aZEtlIXkA375NIs2HNFhycUfcERDs9a
	e4Db3yzlMjNQ1dcZsad4Cd4aDQaZGplvg2W0LHR7DuR8XLDCgIt5JZk0KYaT0xhDzr7sCzo9l4m
	sg8EIiy1MQtAd7MsuofVoWqQlqMvBNfcOu+34gdvBJ5LNg8sfxwYJ4rTbrnG1X2Q==
X-Received: by 2002:a17:902:ccd0:b0:2b4:5f19:1d34 with SMTP id d9443c01a7336-2beb05eec0amr268454135ad.17.1779867006769;
        Wed, 27 May 2026 00:30:06 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm89242325ad.2.2026.05.27.00.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:30:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next v3 2/6] bpf: compute loops hierarchy
Date: Wed, 27 May 2026 00:29:50 -0700
Message-ID: <20260527-better-1m-reporting-v3-2-b3ede0588a75@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
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
 kernel/bpf/loops.c           | 196 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  10 ++-
 5 files changed, 221 insertions(+), 2 deletions(-)

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
index 000000000000..aec11248d048
--- /dev/null
+++ b/kernel/bpf/loops.c
@@ -0,0 +1,196 @@
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
+	int i, s, h, err, cur, stack_sz;
+	struct bpf_iarray *succ;
+
+	stack[0] = start;
+	state[start].traversed = true;
+	state[start].next_succ = 0;
+	dfs_pos[start] = 1;
+	stack_sz = 1;
+	i = 0;
+	do {
+		/*
+		 * The algorithm should be very fast in practice,
+		 * guard against pathological inputs, just in case.
+		 */
+		if (i++ == 1024) {
+			i = 0;
+			if (signal_pending(current))
+				return -EAGAIN;
+			cond_resched();
+		}
+
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
2.53.0
