Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D565F2FFDDE
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 02:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009811; cv=none; b=b9vZHgank0yYF4pfh1OOcmdrVxF91TujEYz9m+LIP04y3R7M6bNcBtchcFcfluhQhq/S6rvekTaTEjFajcRsWxBCzW9u2hGeNhqjug0LhqBb6qaaZVz7BpkMj2k+c3Vs/GpchxadoWAnxmc8CxTRmxPMvF8wcmYueHUDDuw/++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009811; c=relaxed/simple;
	bh=GUbtxSBqNyuNe6fYumwzKVzXhtPop8FAGSvQU7WdZDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DISsPtzxs13BSQc8mKh+FdNN3ot1IyZ+bKtEilKoYsr7MfhB84CKho8Qgbn/hvB/yZ5eTuavxM6B7APY984HZunwAXijdrmiZFw6o30TDAKe8gtrZzFCp0fyiSyba6tKOQvMn4KMurwfC5VMjIzfsSlhKnLTb6qlHhSXzbm02lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwQBr5lE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwQBr5lE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so1746568a91.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775009809; x=1775614609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls53XxcDwJIUC3osQvX33862vfVXmJzwbirzI/ccWW4=;
        b=rwQBr5lEXoFZl6IjNtuMk2JFDqjcnBuN3HiaWEEsHhkEg8KuWurv56c43wQdqtzdlq
         7H3jnQQlyCWVK2xbWJoay+1eA5gW86/YfqkZdIltKCsadXAD5P4OHSvaJmfjNX82PzrL
         OLMddwPRXsCAtGVDH8jomDHfBjis/XexoiXsmwqEaZfddUYWl9PsALqdOIZtKJRdYwyz
         IBPFyHe7AH/qcuZCO07hkG95w5QD4L8IlQvK1d8NEZNGZI51eeTCG3+eyQcxiGg4ws33
         aid0/2dZ9sbjOQAtPWbnz7+V2i/t7rIfh/tZjTW4cFfBWsxoLYE+Ok4BanJI/1mfgWn3
         y/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009809; x=1775614609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ls53XxcDwJIUC3osQvX33862vfVXmJzwbirzI/ccWW4=;
        b=WhoM3BrhndCqWTRlHysA0/pG6KISEIcxmVcnfyWpILwp9nVpSjfR+b4/7cMvULycz8
         0FLjo7SNOEB0Po05/hQnlrpASoJgmc+3Vitn+Y6hK4J06FQ2uz4PUDjUHykf5HS5W2jl
         G3huA816+iWxVPZD0sGp4Y0Tov7RRJm3OFBjPZPM3q/UV2lcM8AWKP1V6eM1kiLys/dL
         /MteFBhxf2Qi5DqV5+Pl9eyJk2wJJ2hCXqTqGqtIFsB+WxuBopHlvotKb7YtwU/lpolW
         qh9xfpF3d+CNgWhWWhtJkilgnMmJhLQHUHPmflRfSI9NEcarOV03YpGvvZL7KtDr2zi2
         0/4A==
X-Gm-Message-State: AOJu0Yy0mHUF/nfoiRBs6mXE3daRqJ8vQrNvH7xWSZLEmfvYLw56746d
	+KY9tOAyfCgIvOhjHjNS+qvAySShcUBJ3+GZsiobMAv+5mCdx/n5pcD9wNq3jw==
X-Gm-Gg: ATEYQzwH9POO+Qg2phVxhV+eyS+jKxEnbCKh0XcgsJTkqskB8/BwPktIPtMXY2qszdz
	ECcuudL1YAx5SYW/mheTDkmv0c8GHQCLpkXV1F0B7nm5pq/prUSo0wp0Js6nRya0DcYng1T1Z2g
	d7+7+Uf0jA0cQj6ekjO3eNhvv1YymyBTemv0NDSKOjyAeP7JQp7wP9DWkJOKm8bcGzAZvx/1wZ5
	zGBpHvQGfNz7nNwy8e36OtuQWP1p82ENeEcNXiXd/D7vp2F4Au/oeQMmmPa/9H8yNueOpThro6U
	QvUzCtXMGGfkwDVHx9NgO6qtENYoHtIWJctZXFz4JTJntBVSFjvf8rhOEFIcV4OS71FcZfZ55TJ
	+JvAiqr2mVzKbEN9Wx7cv4z7ED2YPLxjs/2YPZPxlWXKILZXGmJ8KBCLq6ze4WV3Rr0qJjXPprT
	gzLJs6Dl6K/oPwod+7culOx8F5qJ9U0y0GE+UDRUmKfJsahmgGpW5b6pJv+NKpBKkcCX+AQPodX
	E1TcjkRDyfE3Ly+hVHrMK/0zrKlxF80so1iKNnly2ISmUtgj0a6xmX2U470yA==
X-Received: by 2002:a17:90b:2689:b0:35b:9896:cbd0 with SMTP id 98e67ed59e1d1-35dc6f423d3mr1584672a91.25.1775009808552;
        Tue, 31 Mar 2026 19:16:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24265aa9fsm123101895ad.20.2026.03.31.19.16.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 31 Mar 2026 19:16:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 4/6] bpf: Add compute_const_regs() and prune_dead_branches() passes
Date: Tue, 31 Mar 2026 19:16:33 -0700
Message-ID: <20260401021635.34636-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add two passes before the main verifier pass:

compute_const_regs() is a forward dataflow analysis that tracks
register values in R0-R9 across the program using fixed-point
iteration in reverse postorder. Each register is tracked with
a six-state lattice:

  UNVISITED -> CONST(val) / MAP_PTR(map_index) /
               MAP_VALUE(map_index, offset) / SUBPROG(num) -> UNKNOWN

At merge points, if two paths produce the same state and value for
a register, it stays; otherwise it becomes UNKNOWN.

The analysis handles:
 - MOV, ADD, SUB, AND with immediate or register operands
 - LD_IMM64 for plain constants, map FDs, map values, and subprogs
 - LDX from read-only maps: constant-folds the load by reading the
   map value directly via bpf_map_direct_read()

Results that fit in 32 bits are stored per-instruction in
insn_aux_data and bitmasks.

prune_dead_branches() uses the computed constants to evaluate
conditional branches. When both operands of a conditional jump are
known constants, the branch outcome is determined statically and the
instruction is rewritten to an unconditional jump.
The CFG postorder is then recomputed to reflect new control flow.
This eliminates dead edges so that subsequent liveness analysis
doesn't propagate through dead code.

Also add runtime sanity check to validate that precomputed
constants match the verifier's tracked state.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |  23 ++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/const_fold.c                       | 385 ++++++++++++++++++
 kernel/bpf/verifier.c                         |  43 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c |  20 +-
 5 files changed, 458 insertions(+), 15 deletions(-)
 create mode 100644 kernel/bpf/const_fold.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4f492eaad5c2..0d797de30a3a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -595,6 +595,18 @@ struct bpf_insn_aux_data {
 	u32 scc;
 	/* registers alive before this instruction. */
 	u16 live_regs_before;
+	/*
+	 * Bitmask of R0-R9 that hold known values at this instruction.
+	 * const_reg_mask: scalar constants that fit in 32 bits.
+	 * const_reg_map_mask: map pointers, val is map_index into used_maps[].
+	 * const_reg_subprog_mask: subprog pointers, val is subprog number.
+	 * const_reg_vals[i] holds the 32-bit value for register i.
+	 * Populated by compute_const_regs() pre-pass.
+	 */
+	u16 const_reg_mask;
+	u16 const_reg_map_mask;
+	u16 const_reg_subprog_mask;
+	u32 const_reg_vals[10];
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
@@ -943,6 +955,10 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
+bool bpf_map_is_rdonly(const struct bpf_map *map);
+int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
+			bool is_ldsx);
+
 #define BPF_BASE_TYPE_MASK	GENMASK(BPF_BASE_TYPE_BITS - 1, 0)
 
 /* extract base type from bpf_{arg, return, reg}_type. */
@@ -1086,6 +1102,13 @@ struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_calls_callback(struct bpf_verifier_env *env, int insn_idx);
 
+int find_subprog(struct bpf_verifier_env *env, int off);
+int compute_const_regs(struct bpf_verifier_env *env);
+int prune_dead_branches(struct bpf_verifier_env *env);
+int compute_postorder(struct bpf_verifier_env *env);
+bool insn_is_cond_jump(u8 code);
+bool is_may_goto_insn(struct bpf_insn *insn);
+
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
 int bpf_update_live_stack(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 79cf22860a99..b8ae7b0988a4 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o liveness.o const_fold.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o bpf_insn_array.o
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
new file mode 100644
index 000000000000..9e5abc6ab46a
--- /dev/null
+++ b/kernel/bpf/const_fold.c
@@ -0,0 +1,385 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf_verifier.h>
+
+/*
+ * Forward dataflow analysis to determine constant register values at every
+ * instruction. Tracks 64-bit constant values in R0-R9 through the program,
+ * using a fixed-point iteration in reverse postorder. Records which registers
+ * hold known constants and their values in
+ * env->insn_aux_data[].{const_reg_mask, const_reg_vals}.
+ */
+
+enum const_arg_state {
+	CONST_ARG_UNVISITED,	/* instruction not yet reached */
+	CONST_ARG_UNKNOWN,	/* register value not a known constant */
+	CONST_ARG_CONST,	/* register holds a known 64-bit constant */
+	CONST_ARG_MAP_PTR,	/* register holds a map pointer, map_index is set */
+	CONST_ARG_MAP_VALUE,	/* register points to map value data, val is offset */
+	CONST_ARG_SUBPROG,	/* register holds a subprog pointer, val is subprog number */
+};
+
+struct const_arg_info {
+	enum const_arg_state state;
+	u32 map_index;
+	u64 val;
+};
+
+static bool ci_is_unvisited(const struct const_arg_info *ci)
+{
+	return ci->state == CONST_ARG_UNVISITED;
+}
+
+static bool ci_is_unknown(const struct const_arg_info *ci)
+{
+	return ci->state == CONST_ARG_UNKNOWN;
+}
+
+static bool ci_is_const(const struct const_arg_info *ci)
+{
+	return ci->state == CONST_ARG_CONST;
+}
+
+static bool ci_is_map_value(const struct const_arg_info *ci)
+{
+	return ci->state == CONST_ARG_MAP_VALUE;
+}
+
+/* Transfer function: compute output register state from instruction. */
+static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *ci_out,
+			   struct bpf_insn *insn, struct bpf_insn *insns, int idx)
+{
+	struct const_arg_info unknown = { .state = CONST_ARG_UNKNOWN, .val = 0 };
+	struct const_arg_info *dst = &ci_out[insn->dst_reg];
+	struct const_arg_info *src = &ci_out[insn->src_reg];
+	u8 class = BPF_CLASS(insn->code);
+	u8 opcode = BPF_OP(insn->code) | BPF_SRC(insn->code);
+	int r;
+
+	switch (class) {
+	case BPF_ALU:
+	case BPF_ALU64:
+		switch (opcode) {
+		case BPF_MOV | BPF_K:
+			dst->state = CONST_ARG_CONST;
+			dst->val = (s64)insn->imm;
+			break;
+		case BPF_MOV | BPF_X:
+			*dst = *src;
+			if (!insn->off)
+				break;
+			if (!ci_is_const(dst)) {
+				*dst = unknown;
+				break;
+			}
+			switch (insn->off) {
+			case 8:  dst->val = (s8)dst->val; break;
+			case 16: dst->val = (s16)dst->val; break;
+			case 32: dst->val = (s32)dst->val; break;
+			default: *dst = unknown; break;
+			}
+			break;
+		case BPF_ADD | BPF_K:
+			if (!ci_is_const(dst) && !ci_is_map_value(dst)) {
+				*dst = unknown;
+				break;
+			}
+			dst->val += insn->imm;
+			break;
+		case BPF_SUB | BPF_K:
+			if (!ci_is_const(dst) && !ci_is_map_value(dst)) {
+				*dst = unknown;
+				break;
+			}
+			dst->val -= insn->imm;
+			break;
+		case BPF_AND | BPF_K:
+			if (!ci_is_const(dst)) {
+				if (!insn->imm) {
+					dst->state = CONST_ARG_CONST;
+					dst->val = 0;
+				} else {
+					*dst = unknown;
+				}
+				break;
+			}
+			dst->val &= (s64)insn->imm;
+			break;
+		case BPF_AND | BPF_X:
+			if (ci_is_const(dst) && dst->val == 0)
+				break; /* 0 & x == 0 */
+			if (ci_is_const(src) && src->val == 0) {
+				dst->state = CONST_ARG_CONST;
+				dst->val = 0;
+				break;
+			}
+			if (!ci_is_const(dst) || !ci_is_const(src)) {
+				*dst = unknown;
+				break;
+			}
+			dst->val &= src->val;
+			break;
+		default:
+			*dst = unknown;
+			break;
+		}
+		if (class == BPF_ALU) {
+			if (ci_is_const(dst))
+				dst->val = (u32)dst->val;
+			else if (!ci_is_unknown(dst))
+				*dst = unknown;
+		}
+		break;
+	case BPF_LD:
+		if (BPF_MODE(insn->code) != BPF_IMM || BPF_SIZE(insn->code) != BPF_DW)
+			break;
+		if (insn->src_reg == BPF_PSEUDO_FUNC) {
+			int subprog = find_subprog(env, idx + insn->imm + 1);
+
+			if (subprog >= 0) {
+				dst->state = CONST_ARG_SUBPROG;
+				dst->val = subprog;
+			} else {
+				*dst = unknown;
+			}
+		} else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
+			   insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE) {
+			dst->state = CONST_ARG_MAP_VALUE;
+			dst->map_index = env->insn_aux_data[idx].map_index;
+			dst->val = env->insn_aux_data[idx].map_off;
+		} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
+			   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
+			dst->state = CONST_ARG_MAP_PTR;
+			dst->map_index = env->insn_aux_data[idx].map_index;
+		} else if (insn->src_reg == 0) {
+			dst->state = CONST_ARG_CONST;
+			dst->val = (u64)(u32)insn->imm | ((u64)(u32)insns[idx + 1].imm << 32);
+		} else {
+			*dst = unknown;
+		}
+		break;
+	case BPF_LDX:
+		if (!ci_is_map_value(src)) {
+			*dst = unknown;
+			break;
+		}
+		struct bpf_map *map = env->used_maps[src->map_index];
+		int size = bpf_size_to_bytes(BPF_SIZE(insn->code));
+		bool is_ldsx = BPF_MODE(insn->code) == BPF_MEMSX;
+		int off = src->val + insn->off;
+		u64 val = 0;
+
+		if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr ||
+		    bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
+			*dst = unknown;
+			break;
+		}
+		dst->state = CONST_ARG_CONST;
+		dst->val = val;
+		break;
+	case BPF_JMP:
+		if (opcode != BPF_CALL)
+			break;
+		for (r = BPF_REG_0; r <= BPF_REG_5; r++)
+			ci_out[r] = unknown;
+		break;
+	case BPF_STX:
+		if (BPF_MODE(insn->code) != BPF_ATOMIC)
+			break;
+		if (insn->imm == BPF_CMPXCHG)
+			ci_out[BPF_REG_0] = unknown;
+		else if (insn->imm == BPF_LOAD_ACQ)
+			*dst = unknown;
+		else if (insn->imm & BPF_FETCH)
+			*src = unknown;
+		break;
+	}
+}
+
+/* Join function: merge output state into a successor's input state. */
+static bool const_reg_join(struct const_arg_info *ci_target,
+			   struct const_arg_info *ci_out)
+{
+	bool changed = false;
+	int r;
+
+	for (r = 0; r < MAX_BPF_REG; r++) {
+		struct const_arg_info *old = &ci_target[r];
+		struct const_arg_info *new = &ci_out[r];
+
+		if (ci_is_unvisited(old) && !ci_is_unvisited(new)) {
+			ci_target[r] = *new;
+			changed = true;
+		} else if (!ci_is_unknown(old) && !ci_is_unvisited(old) &&
+			   (new->state != old->state || new->val != old->val ||
+			    new->map_index != old->map_index)) {
+			old->state = CONST_ARG_UNKNOWN;
+			changed = true;
+		}
+	}
+	return changed;
+}
+
+int compute_const_regs(struct bpf_verifier_env *env)
+{
+	struct const_arg_info unknown = { .state = CONST_ARG_UNKNOWN, .val = 0 };
+	struct bpf_insn_aux_data *insn_aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	int insn_cnt = env->prog->len;
+	struct const_arg_info (*ci_in)[MAX_BPF_REG];
+	struct const_arg_info ci_out[MAX_BPF_REG];
+	struct bpf_iarray *succ;
+	bool changed;
+	int i, r;
+
+	/* kvzalloc zeroes memory, so all entries start as CONST_ARG_UNVISITED (0) */
+	ci_in = kvzalloc_objs(*ci_in, insn_cnt, GFP_KERNEL_ACCOUNT);
+	if (!ci_in)
+		return -ENOMEM;
+
+	/* Subprogram entries (including main at subprog 0): all registers unknown */
+	for (i = 0; i < env->subprog_cnt; i++) {
+		int start = env->subprog_info[i].start;
+
+		for (r = 0; r < MAX_BPF_REG; r++)
+			ci_in[start][r] = unknown;
+	}
+
+redo:
+	changed = false;
+	for (i = env->cfg.cur_postorder - 1; i >= 0; i--) {
+		int idx = env->cfg.insn_postorder[i];
+		struct bpf_insn *insn = &insns[idx];
+		struct const_arg_info *ci = ci_in[idx];
+
+		memcpy(ci_out, ci, sizeof(ci_out));
+
+		const_reg_xfer(env, ci_out, insn, insns, idx);
+
+		succ = bpf_insn_successors(env, idx);
+		for (int s = 0; s < succ->cnt; s++)
+			changed |= const_reg_join(ci_in[succ->items[s]], ci_out);
+	}
+	if (changed)
+		goto redo;
+
+	/* Save computed constants into insn_aux[] if they fit into 32-bit */
+	for (i = 0; i < insn_cnt; i++) {
+		u16 mask = 0, map_mask = 0, subprog_mask = 0;
+		struct bpf_insn_aux_data *aux = &insn_aux[i];
+		struct const_arg_info *ci = ci_in[i];
+
+		for (r = BPF_REG_0; r < MAX_BPF_REG; r++) {
+			struct const_arg_info *c = &ci[r];
+
+			switch (c->state) {
+			case CONST_ARG_CONST: {
+				u64 val = c->val;
+
+				if (val != (u32)val)
+					break;
+				mask |= BIT(r);
+				aux->const_reg_vals[r] = val;
+				break;
+			}
+			case CONST_ARG_MAP_PTR:
+				map_mask |= BIT(r);
+				aux->const_reg_vals[r] = c->map_index;
+				break;
+			case CONST_ARG_SUBPROG:
+				subprog_mask |= BIT(r);
+				aux->const_reg_vals[r] = c->val;
+				break;
+			default:
+				break;
+			}
+		}
+		aux->const_reg_mask = mask;
+		aux->const_reg_map_mask = map_mask;
+		aux->const_reg_subprog_mask = subprog_mask;
+	}
+
+	kvfree(ci_in);
+	return 0;
+}
+
+static bool eval_const_branch(u8 opcode, u64 dst_val, u64 src_val)
+{
+	switch (BPF_OP(opcode)) {
+	case BPF_JEQ:	return dst_val == src_val;
+	case BPF_JNE:	return dst_val != src_val;
+	case BPF_JGT:	return dst_val > src_val;
+	case BPF_JGE:	return dst_val >= src_val;
+	case BPF_JLT:	return dst_val < src_val;
+	case BPF_JLE:	return dst_val <= src_val;
+	case BPF_JSGT:	return (s64)dst_val > (s64)src_val;
+	case BPF_JSGE:	return (s64)dst_val >= (s64)src_val;
+	case BPF_JSLT:	return (s64)dst_val < (s64)src_val;
+	case BPF_JSLE:	return (s64)dst_val <= (s64)src_val;
+	case BPF_JSET:	return dst_val & src_val;
+	default:	return false;
+	}
+}
+
+/*
+ * Rewrite conditional branches with constant outcomes into unconditional
+ * jumps using register values resolved by compute_const_regs() pass.
+ * This eliminates dead edges from the CFG so that compute_live_registers()
+ * doesn't propagate liveness through dead code.
+ */
+int prune_dead_branches(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *insn_aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	int insn_cnt = env->prog->len;
+	bool changed = false;
+	int i;
+
+	for (i = 0; i < insn_cnt; i++) {
+		struct bpf_insn_aux_data *aux = &insn_aux[i];
+		struct bpf_insn *insn = &insns[i];
+		u8 class = BPF_CLASS(insn->code);
+		u64 dst_val, src_val;
+		bool taken;
+
+		if (!insn_is_cond_jump(insn->code))
+			continue;
+		if (is_may_goto_insn(insn))
+			continue;
+
+		if (!(aux->const_reg_mask & BIT(insn->dst_reg)))
+			continue;
+		dst_val = aux->const_reg_vals[insn->dst_reg];
+
+		if (BPF_SRC(insn->code) == BPF_K) {
+			src_val = (u32)insn->imm;
+		} else {
+			if (!(aux->const_reg_mask & BIT(insn->src_reg)))
+				continue;
+			src_val = aux->const_reg_vals[insn->src_reg];
+		}
+
+		if (class == BPF_JMP32) {
+			/*
+			 * The (s32) cast maps the 32-bit range into two u64 sub-ranges:
+			 * [0x00000000, 0x7FFFFFFF] -> [0x0000000000000000, 0x000000007FFFFFFF]
+			 * [0x80000000, 0xFFFFFFFF] -> [0xFFFFFFFF80000000, 0xFFFFFFFFFFFFFFFF]
+			 * The ordering is preserved within each sub-range, and
+			 * the second sub-range is above the first as u64.
+			 */
+			dst_val = (s32)dst_val;
+			src_val = (s32)src_val;
+		}
+
+		taken = eval_const_branch(insn->code, dst_val, src_val);
+		*insn = BPF_JMP_A(taken ? insn->off : 0);
+		changed = true;
+	}
+
+	if (!changed)
+		return 0;
+	/* recompute postorder, since CFG has changed */
+	kvfree(env->cfg.insn_postorder);
+	return compute_postorder(env);
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 432806011d47..493f6acaa386 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -595,7 +595,7 @@ static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn
 	return false;
 }
 
-static bool is_may_goto_insn(struct bpf_insn *insn)
+bool is_may_goto_insn(struct bpf_insn *insn)
 {
 	return insn->code == (BPF_JMP | BPF_JCOND) && insn->src_reg == BPF_MAY_GOTO;
 }
@@ -3082,7 +3082,7 @@ struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *en
 }
 
 /* Find subprogram that starts exactly at 'off' */
-static int find_subprog(struct bpf_verifier_env *env, int off)
+int find_subprog(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *p;
 
@@ -7287,7 +7287,7 @@ static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 	set_sext32_default_val(reg, size);
 }
 
-static bool bpf_map_is_rdonly(const struct bpf_map *map)
+bool bpf_map_is_rdonly(const struct bpf_map *map)
 {
 	/* A map is considered read-only if the following condition are true:
 	 *
@@ -7307,8 +7307,8 @@ static bool bpf_map_is_rdonly(const struct bpf_map *map)
 	       !bpf_map_write_active(map);
 }
 
-static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
-			       bool is_ldsx)
+int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
+			bool is_ldsx)
 {
 	void *ptr;
 	u64 addr;
@@ -19234,7 +19234,7 @@ static int check_cfg(struct bpf_verifier_env *env)
  * [env->subprog_info[i].postorder_start, env->subprog_info[i+1].postorder_start)
  * with indices of 'i' instructions in postorder.
  */
-static int compute_postorder(struct bpf_verifier_env *env)
+int compute_postorder(struct bpf_verifier_env *env)
 {
 	u32 cur_postorder, i, top, stack_sz, s;
 	int *stack = NULL, *postorder = NULL, *state = NULL;
@@ -21538,6 +21538,27 @@ static int do_check(struct bpf_verifier_env *env)
 		sanitize_mark_insn_seen(env);
 		prev_insn_idx = env->insn_idx;
 
+		/* Sanity check: precomputed constants must match verifier state */
+		if (!state->speculative && insn_aux->const_reg_mask) {
+			struct bpf_reg_state *regs = cur_regs(env);
+			u16 mask = insn_aux->const_reg_mask;
+
+			for (int r = 0; r < MAX_BPF_REG; r++) {
+				u32 cval = insn_aux->const_reg_vals[r];
+
+				if (!(mask & BIT(r)))
+					continue;
+				if (regs[r].type != SCALAR_VALUE)
+					continue;
+				if (!tnum_is_const(regs[r].var_off))
+					continue;
+				if (verifier_bug_if((u32)regs[r].var_off.value != cval,
+						    env, "const R%d: %u != %llu",
+						    r, cval, regs[r].var_off.value))
+					return -EFAULT;
+			}
+		}
+
 		/* Reduce verification complexity by stopping speculative path
 		 * verification when a nospec is encountered.
 		 */
@@ -22527,7 +22548,7 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 	}
 }
 
-static bool insn_is_cond_jump(u8 code)
+bool insn_is_cond_jump(u8 code)
 {
 	u8 op;
 
@@ -26353,6 +26374,14 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret)
 		goto skip_full_check;
 
+	ret = compute_const_regs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
+	ret = prune_dead_branches(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = sort_subprogs_topo(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 58c7704d61cd..0e907cad5902 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -592,10 +592,10 @@ __naked void check_ids_in_regsafe_2(void)
  */
 SEC("socket")
 __success __log_level(2)
-__msg("11: (1d) if r3 == r4 goto pc+0")
+__msg("14: (1d) if r3 == r4 goto pc+0")
 __msg("frame 0: propagating r3,r4")
-__msg("11: safe")
-__msg("processed 15 insns")
+__msg("14: safe")
+__msg("processed 18 insns")
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void no_scalar_id_for_const(void)
 {
@@ -606,13 +606,16 @@ __naked void no_scalar_id_for_const(void)
 	/* possibly generate same scalar ids for r3 and r4 */
 	"r1 = 0;"
 	"r1 = r1;"
+	"r1 |= 0;" /* prevent prune_dead_branches from folding the branch */
 	"r3 = r1;"
 	"r4 = r1;"
 	"goto l1_%=;"
 "l0_%=:"
 	/* possibly generate different scalar ids for r3 and r4 */
 	"r1 = 0;"
+	"r1 |= 0;"
 	"r2 = 0;"
+	"r2 |= 0;"
 	"r3 = r1;"
 	"r4 = r2;"
 "l1_%=:"
@@ -628,10 +631,10 @@ __naked void no_scalar_id_for_const(void)
 /* Same as no_scalar_id_for_const() but for 32-bit values */
 SEC("socket")
 __success __log_level(2)
-__msg("11: (1e) if w3 == w4 goto pc+0")
+__msg("14: (1e) if w3 == w4 goto pc+0")
 __msg("frame 0: propagating r3,r4")
-__msg("11: safe")
-__msg("processed 15 insns")
+__msg("14: safe")
+__msg("processed 18 insns")
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void no_scalar_id_for_const32(void)
 {
@@ -642,17 +645,20 @@ __naked void no_scalar_id_for_const32(void)
 	/* possibly generate same scalar ids for r3 and r4 */
 	"w1 = 0;"
 	"w1 = w1;"
+	"w1 |= 0;" /* prevent prune_dead_branches from folding the branch */
 	"w3 = w1;"
 	"w4 = w1;"
 	"goto l1_%=;"
 "l0_%=:"
 	/* possibly generate different scalar ids for r3 and r4 */
 	"w1 = 0;"
+	"w1 |= 0;"
 	"w2 = 0;"
+	"w2 |= 0;"
 	"w3 = w1;"
 	"w4 = w2;"
 "l1_%=:"
-	/* predictable jump, marks r1 and r2 precise */
+	/* predictable jump, marks r3 and r4 precise */
 	"if w3 == w4 goto +0;"
 	"r0 = 0;"
 	"exit;"
-- 
2.52.0

