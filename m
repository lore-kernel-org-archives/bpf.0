Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38F2AE8D
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110679; cv=none; b=uZtjI/QkIac1A1HNjx75+cGVGTsKc8DZxiBc6pwuCHnDwwt4IeNTqBd6zAhxOcIszCxG0UdAuJYL4omayfPbRMS6EmFgV1NhpCnskryhzjplQxitfdOB41BeHffPFwjmkquNO/1eH5Gpaij27RQoBicFgxQKXS7BGuZ//jpDrOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110679; c=relaxed/simple;
	bh=F+56IUXcH+CAjs/e9/0kEysqmwXDsR1l7dH0yhC863M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMD6wJqQdFMCJ78+3y3xe/5JhqnrOUxOCy0h1oKjWWEuSj5gx8qW9AR2h8qbh6H5gvinkxpPznXioTS61EXrOVT1coHq+OzJyrsQ1pGwnPaORwUYjTGv8JEyh5hUzrNMnjHHIz6uq+AoQXrRq/VNns9bAGqqHkko1WYWBv0++v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awfi/myC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awfi/myC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aae146b604so2913675ad.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 23:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775110677; x=1775715477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joQ+/Oqz2/BV3S5ctlMELtUgqu/hSmtE0YbXrA9HuSg=;
        b=awfi/myCg4oeP56+9E8ZPEx2CbhKHHEt2qVhppySj3um5VAG1UIPT2G7QeC/6kACok
         2yB49Yo5Qm6ULq8TP8Z1NZzArOql9y80kWUTWsHShiYC73+H3Xtwe+kuylHan1tr8rso
         XOEs4I19pxy6HRSodizgX9mvdAKPEQjhx4PZHFBtzvv6LC9II23h7UFWUq0Xda0Q3Tcp
         L9ETjSLr3xV7YEaytIj2vPi7BhP4+zDttqaE7O9wfk7eUuks4L/Ujf8BGQi1hcZcvuqi
         e5Gp8oN6XH/PV4KI41KJUMw0i06NQjlDo1uF2I9mptK72NRlxI48gXLUCsyHY0kvLKzt
         SJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775110677; x=1775715477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=joQ+/Oqz2/BV3S5ctlMELtUgqu/hSmtE0YbXrA9HuSg=;
        b=Bmft+06wCpd3bAL11G9+LdwQTkVuBjo7TDyTIFtMh8Ajl2wMu4hVumyD9CSnqbfXO7
         3OzU7IrZtPWlwYCyEd2MSHigbbl69nhH6L7xWxTLGbTlM9YjaSYWnSWRoQZAUuRsetdE
         olE37s/end2ESl2hYtlppkwjIl2df2i1pA8yTn2956bPWEidr5tElZ4MBd6jsA0PF/1p
         KfSIsHlf5jBIfhAv1YviAvJ/aNWrnltG9iIPCTmaYO9ena27OWb/SDxgYljnLafa29dr
         4o5NS0uO23IZIbHK9aDHgUF2kKeBwNE9NmtlpcWrJJx/AQWD6hJ8y2IjJqPOiDYzhJ4/
         r2Ag==
X-Gm-Message-State: AOJu0YyzWPiI+kTmNHoVX5HbL1zUqBeY2OZimQRtzwFg2KEnFtCshwy6
	3d0quG4XA7eqjuO/PVdbPcaHhVmArZA8AIu/gMQ03GIe5cEgVzwu49qXUGaMyw==
X-Gm-Gg: AeBDietQIck+DvcllWwnnBuiZ/DtkgE99CV8jTOzKg6nc9C37U7WHTs58t760qTdIBj
	W+mV8Hq3z5cg77Yhp+uf3pZawVPjEmoM3ZT/VOeua374ddvdnxrTU7i3zhtojTZdura9GXFAGk2
	YIo14fZwLCThuafWcDAfuHuBBeLF6F8tbp/4/BvPdVM13ERJW0RQL4awW8tQd65ah5T7helEzFA
	3eqRa4xB9ba7PckPSC4yGemiFcBmxIywkX2Ku3Wcr2thmicetXPqNXbNcDgR29Fu4t1qHgFBOVE
	zna5k9aagnnFkDN3Byh7LKXzLBMYHANuqgQKS9DOLoCdxfcarU25sfDW+FgBjgjMe92zUvgKLTP
	oSxcTj8YbHXCF8+nSQLG95iArRPVGofYsN7kUnqiOj9Py5TxYHEyaw73mlkzbVBDJRSIORMv2st
	m8GAMlzHGjhoEJ113a9fGwmrp0WKU9JiIipf++s1g/QX/QyRSPIJwyM9UNqQINUbqBpL+qDSp0v
	/34fFoa3tyqpA2gqlg6QmvRtI0j87m+99k4BZliQnwgNg84/sXKoyoqapNDTA==
X-Received: by 2002:a17:903:40c9:b0:2b2:4bf9:1744 with SMTP id d9443c01a7336-2b275b49904mr21438125ad.29.1775110676442;
        Wed, 01 Apr 2026 23:17:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a2e42sm15584985ad.56.2026.04.01.23.17.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 23:17:56 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v2 bpf-next 4/6] bpf: Add bpf_compute_const_regs() and bpf_prune_dead_branches() passes
Date: Wed,  1 Apr 2026 23:17:42 -0700
Message-ID: <20260402061744.10885-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
References: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add two passes before the main verifier pass:

bpf_compute_const_regs() is a forward dataflow analysis that tracks
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

bpf_prune_dead_branches() uses the computed constants to evaluate
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
 include/linux/bpf_verifier.h                  |  23 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/const_fold.c                       | 396 ++++++++++++++++++
 kernel/bpf/verifier.c                         |  75 +++-
 .../selftests/bpf/progs/verifier_scalar_ids.c |  20 +-
 .../selftests/bpf/progs/verifier_unpriv.c     |   6 +-
 6 files changed, 490 insertions(+), 32 deletions(-)
 create mode 100644 kernel/bpf/const_fold.c

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4f492eaad5c2..1c0b430f92ec 100644
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
 
+int bpf_find_subprog(struct bpf_verifier_env *env, int off);
+int bpf_compute_const_regs(struct bpf_verifier_env *env);
+int bpf_prune_dead_branches(struct bpf_verifier_env *env);
+int bpf_compute_postorder(struct bpf_verifier_env *env);
+bool bpf_insn_is_cond_jump(u8 code);
+bool bpf_is_may_goto_insn(struct bpf_insn *insn);
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
index 000000000000..db73c4740b1e
--- /dev/null
+++ b/kernel/bpf/const_fold.c
@@ -0,0 +1,396 @@
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
+	u8 mode = BPF_MODE(insn->code);
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
+		if (mode == BPF_ABS || mode == BPF_IND)
+			goto process_call;
+		if (mode != BPF_IMM || BPF_SIZE(insn->code) != BPF_DW)
+			break;
+		if (insn->src_reg == BPF_PSEUDO_FUNC) {
+			int subprog = bpf_find_subprog(env, idx + insn->imm + 1);
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
+		bool is_ldsx = mode == BPF_MEMSX;
+		int off = src->val + insn->off;
+		u64 val = 0;
+
+		if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr ||
+		    map->map_type == BPF_MAP_TYPE_INSN_ARRAY ||
+		    off < 0 || off + size > map->value_size ||
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
+process_call:
+		for (r = BPF_REG_0; r <= BPF_REG_5; r++)
+			ci_out[r] = unknown;
+		break;
+	case BPF_STX:
+		if (mode != BPF_ATOMIC)
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
+int bpf_compute_const_regs(struct bpf_verifier_env *env)
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
+		for (r = BPF_REG_0; r < ARRAY_SIZE(aux->const_reg_vals); r++) {
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
+static int eval_const_branch(u8 opcode, u64 dst_val, u64 src_val)
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
+	case BPF_JSET:	return (bool)(dst_val & src_val);
+	default:	return -1;
+	}
+}
+
+/*
+ * Rewrite conditional branches with constant outcomes into unconditional
+ * jumps using register values resolved by bpf_compute_const_regs() pass.
+ * This eliminates dead edges from the CFG so that compute_live_registers()
+ * doesn't propagate liveness through dead code.
+ */
+int bpf_prune_dead_branches(struct bpf_verifier_env *env)
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
+		int taken;
+
+		if (!bpf_insn_is_cond_jump(insn->code))
+			continue;
+		if (bpf_is_may_goto_insn(insn))
+			continue;
+
+		if (!(aux->const_reg_mask & BIT(insn->dst_reg)))
+			continue;
+		dst_val = aux->const_reg_vals[insn->dst_reg];
+
+		if (BPF_SRC(insn->code) == BPF_K) {
+			src_val = insn->imm;
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
+		if (taken < 0) {
+			bpf_log(&env->log, "Unknown conditional jump %x\n", insn->code);
+			return -EFAULT;
+		}
+		*insn = BPF_JMP_A(taken ? insn->off : 0);
+		changed = true;
+	}
+
+	if (!changed)
+		return 0;
+	/* recompute postorder, since CFG has changed */
+	kvfree(env->cfg.insn_postorder);
+	env->cfg.insn_postorder = NULL;
+	return bpf_compute_postorder(env);
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c0630691c32d..6a0d7548daae 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -595,14 +595,14 @@ static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn
 	return false;
 }
 
-static bool is_may_goto_insn(struct bpf_insn *insn)
+bool bpf_is_may_goto_insn(struct bpf_insn *insn)
 {
 	return insn->code == (BPF_JMP | BPF_JCOND) && insn->src_reg == BPF_MAY_GOTO;
 }
 
 static bool is_may_goto_insn_at(struct bpf_verifier_env *env, int insn_idx)
 {
-	return is_may_goto_insn(&env->prog->insnsi[insn_idx]);
+	return bpf_is_may_goto_insn(&env->prog->insnsi[insn_idx]);
 }
 
 static bool is_storage_get_function(enum bpf_func_id func_id)
@@ -3082,7 +3082,7 @@ struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *en
 }
 
 /* Find subprogram that starts exactly at 'off' */
-static int find_subprog(struct bpf_verifier_env *env, int off)
+int bpf_find_subprog(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *p;
 
@@ -3101,7 +3101,7 @@ static int add_subprog(struct bpf_verifier_env *env, int off)
 		verbose(env, "call to invalid destination\n");
 		return -EINVAL;
 	}
-	ret = find_subprog(env, off);
+	ret = bpf_find_subprog(env, off);
 	if (ret >= 0)
 		return ret;
 	if (env->subprog_cnt >= BPF_MAX_SUBPROGS) {
@@ -3790,7 +3790,7 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 
 				if (!bpf_pseudo_call(&insn[idx]) && !bpf_pseudo_func(&insn[idx]))
 					continue;
-				callee = find_subprog(env, idx + insn[idx].imm + 1);
+				callee = bpf_find_subprog(env, idx + insn[idx].imm + 1);
 				if (callee < 0) {
 					ret = -EFAULT;
 					goto out;
@@ -4573,7 +4573,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
 			int subprog_insn_idx, subprog;
 
 			subprog_insn_idx = idx + insn->imm + 1;
-			subprog = find_subprog(env, subprog_insn_idx);
+			subprog = bpf_find_subprog(env, subprog_insn_idx);
 			if (subprog < 0)
 				return -EFAULT;
 
@@ -6905,7 +6905,7 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
 
 		/* find the callee */
 		next_insn = i + insn[i].imm + 1;
-		sidx = find_subprog(env, next_insn);
+		sidx = bpf_find_subprog(env, next_insn);
 		if (verifier_bug_if(sidx < 0, env, "callee not found at insn %d", next_insn))
 			return -EFAULT;
 		if (subprog[sidx].is_async_cb) {
@@ -7040,7 +7040,7 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 {
 	int start = idx + insn->imm + 1, subprog;
 
-	subprog = find_subprog(env, start);
+	subprog = bpf_find_subprog(env, start);
 	if (verifier_bug_if(subprog < 0, env, "get stack depth: no program at insn %d", start))
 		return -EFAULT;
 	return env->subprog_info[subprog].stack_depth;
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
@@ -10997,7 +10997,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	int err, subprog, target_insn;
 
 	target_insn = *insn_idx + insn->imm + 1;
-	subprog = find_subprog(env, target_insn);
+	subprog = bpf_find_subprog(env, target_insn);
 	if (verifier_bug_if(subprog < 0, env, "target of func call at insn %d is not a program",
 			    target_insn))
 		return -EFAULT;
@@ -17930,8 +17930,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 
 	if (insn->src_reg == BPF_PSEUDO_FUNC) {
 		struct bpf_prog_aux *aux = env->prog->aux;
-		u32 subprogno = find_subprog(env,
-					     env->insn_idx + insn->imm + 1);
+		u32 subprogno = bpf_find_subprog(env,
+						 env->insn_idx + insn->imm + 1);
 
 		if (!aux->func_info) {
 			verbose(env, "missing btf func_info\n");
@@ -19127,7 +19127,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 	default:
 		/* conditional jump with two edges */
 		mark_prune_point(env, t);
-		if (is_may_goto_insn(insn))
+		if (bpf_is_may_goto_insn(insn))
 			mark_force_checkpoint(env, t);
 
 		ret = push_insn(t, t + 1, FALLTHROUGH, env);
@@ -19234,7 +19234,7 @@ static int check_cfg(struct bpf_verifier_env *env)
  * [env->subprog_info[i].postorder_start, env->subprog_info[i+1].postorder_start)
  * with indices of 'i' instructions in postorder.
  */
-static int compute_postorder(struct bpf_verifier_env *env)
+int bpf_compute_postorder(struct bpf_verifier_env *env)
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
+bool bpf_insn_is_cond_jump(u8 code)
 {
 	u8 op;
 
@@ -22550,7 +22571,7 @@ static void opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env)
 	int i;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
-		if (!insn_is_cond_jump(insn->code))
+		if (!bpf_insn_is_cond_jump(insn->code))
 			continue;
 
 		if (!aux_data[i + 1].seen)
@@ -23046,7 +23067,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		 * need a hard reject of the program. Thus -EFAULT is
 		 * propagated in any case.
 		 */
-		subprog = find_subprog(env, i + insn->imm + 1);
+		subprog = bpf_find_subprog(env, i + insn->imm + 1);
 		if (verifier_bug_if(subprog < 0, env, "No program to jit at insn %d",
 				    i + insn->imm + 1))
 			return -EFAULT;
@@ -23261,7 +23282,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		if (!bpf_pseudo_call(insn))
 			continue;
 		insn->off = env->insn_aux_data[i].call_imm;
-		subprog = find_subprog(env, i + insn->off + 1);
+		subprog = bpf_find_subprog(env, i + insn->off + 1);
 		insn->imm = subprog;
 	}
 
@@ -23872,7 +23893,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
-		if (is_may_goto_insn(insn) && bpf_jit_supports_timed_may_goto()) {
+		if (bpf_is_may_goto_insn(insn) && bpf_jit_supports_timed_may_goto()) {
 			int stack_off_cnt = -stack_depth - 16;
 
 			/*
@@ -23915,7 +23936,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			env->prog = prog = new_prog;
 			insn = new_prog->insnsi + i + delta;
 			goto next_insn;
-		} else if (is_may_goto_insn(insn)) {
+		} else if (bpf_is_may_goto_insn(insn)) {
 			int stack_off = -stack_depth - 8;
 
 			stack_depth_extra = 8;
@@ -26341,7 +26362,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = compute_postorder(env);
+	ret = bpf_compute_postorder(env);
 	if (ret < 0)
 		goto skip_full_check;
 
@@ -26353,6 +26374,14 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret)
 		goto skip_full_check;
 
+	ret = bpf_compute_const_regs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
+	ret = bpf_prune_dead_branches(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = sort_subprogs_topo(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 58c7704d61cd..a5b8753ce52c 100644
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
@@ -605,6 +605,7 @@ __naked void no_scalar_id_for_const(void)
 	"if r0 > 7 goto l0_%=;"
 	/* possibly generate same scalar ids for r3 and r4 */
 	"r1 = 0;"
+	"r1 ^= r1;" /* prevent bpf_prune_dead_branches from folding the branch */
 	"r1 = r1;"
 	"r3 = r1;"
 	"r4 = r1;"
@@ -612,7 +613,9 @@ __naked void no_scalar_id_for_const(void)
 "l0_%=:"
 	/* possibly generate different scalar ids for r3 and r4 */
 	"r1 = 0;"
+	"r1 ^= r1;"
 	"r2 = 0;"
+	"r2 ^= r2;"
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
@@ -641,6 +644,7 @@ __naked void no_scalar_id_for_const32(void)
 	"if r0 > 7 goto l0_%=;"
 	/* possibly generate same scalar ids for r3 and r4 */
 	"w1 = 0;"
+	"w1 ^= w1;" /* prevent bpf_prune_dead_branches from folding the branch */
 	"w1 = w1;"
 	"w3 = w1;"
 	"w4 = w1;"
@@ -648,11 +652,13 @@ __naked void no_scalar_id_for_const32(void)
 "l0_%=:"
 	/* possibly generate different scalar ids for r3 and r4 */
 	"w1 = 0;"
+	"w1 ^= w1;"
 	"w2 = 0;"
+	"w2 ^= w2;"
 	"w3 = w1;"
 	"w4 = w2;"
 "l1_%=:"
-	/* predictable jump, marks r1 and r2 precise */
+	/* predictable jump, marks r3 and r4 precise */
 	"if w3 == w4 goto +0;"
 	"r0 = 0;"
 	"exit;"
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index 8ee1243e62a8..c16f8382cf17 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -584,7 +584,7 @@ __naked void alu32_mov_u32_const(void)
 {
 	asm volatile ("					\
 	w7 = 0;						\
-	w7 &= 1;					\
+	w7 ^= w7;					\
 	w0 = w7;					\
 	if r0 == 0 goto l0_%=;				\
 	r0 = *(u64*)(r7 + 0);				\
@@ -894,7 +894,9 @@ __naked void unpriv_spectre_v1_and_v4_simple(void)
 {
 	asm volatile ("					\
 	r8 = 0;						\
+	r8 ^= r8;					\
 	r9 = 0;						\
+	r9 ^= r9;					\
 	r0 = r10;					\
 	r1 = 0;						\
 	r2 = r10;					\
@@ -932,7 +934,9 @@ __naked void unpriv_ldimm64_spectre_v1_and_v4_simple(void)
 {
 	asm volatile ("					\
 	r8 = 0;						\
+	r8 ^= r8;					\
 	r9 = 0;						\
+	r9 ^= r9;					\
 	r0 = r10;					\
 	r1 = 0;						\
 	r2 = r10;					\
-- 
2.52.0

