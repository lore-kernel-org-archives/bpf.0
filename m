Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502331;
	b=NKy2Qs729bIV4NEwk+gY2Lr3TsmG0ohUMqhG5GGf1+xNSdBfhQ1fqJvQ73JBnFLrMc1V
	 clHrNcqCt4gTHf7/e8Fbwudoe1BK0D0MjVEtsNqQE+rNkfq8GzjXVZAuHBnByFPEdpRqu
	 QAv9yPq7ihbU4dcJfbvzc7YJKyXgb6K7pTHwgqKtFCScQDcJWLZs4qwKM22oz7VyTdbhG
	 yHFCt8teRETfpQKbVMwRIkPP9L/AuknPckI1gf5cSGwOap3Hq+jBHN+yV43Hv8CmGC1fV
	 Pegqndl5GUWK44JoY5YHn+QlPpj52yLAnQq6IRGuKwxOKd+xnq2sgEC1u04bZwdllAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PUfeEsnq77a4lCfrk3rcb888yzMGRzooM4fsbJpHu5s=;
	b=jrgcpIQXjQvd8GfiaouPybu4Kxk+uX2sr6cn9LW1fv4rb+iB3+BXVGd5RFru/iByXPZL
	 fr072sAvs9Dwj4BgybngCinK4n/pRLPFFmfSAS2XWjK3YX+7s1heaf5q27TQWbHOZnv5b
	 QJwwJ2li03GEeTkZpSAUq3PKu0CJ26ajLTt4WZdKCmBBeROYLPSUVvO5KpFVe4EuwkDtG
	 zRY7GbcUnSEg3Li2Zs+9p9KzBSd5F0FO6ZH18cr+XZG/Mf8084o2m4OhYaR/8DVKy75cr
	 MF0mZVys2ab6+ZfcUQ37XYuhDcA7F3f6o9MNtdgdrBV9waTahVWE7sTqkDYAKj4aJ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LhDifgBc;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC33606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CC33606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LhDifgBc
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso785942a91.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502331; x=1794107131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUfeEsnq77a4lCfrk3rcb888yzMGRzooM4fsbJpHu5s=;
        b=LhDifgBc6sNzaZpRmwkBQmTrbqqsXDwB1sNWgSo6hac389HKsSm4O7GDprni8VjRz6
         YPA94N18wAao3gMIGw4SWMUGx0VsRY6qqC24Y7ceFg8ri7gmYy+xYfcu8Tuf6dNp3LPc
         G9unxvsvtki2HMm96q6T6AlgS8aj401BSIcUBZJEnkWHslcAj2MBhkQlzmlVan59kvvk
         pbLi/yIq7ngh935bTQNa6sekv1NjQfecL1ykfCuYqdlkSwnC9WUpXvq20PUThUum7OkV
         h+R/v6dz1NR21Mh1c2719JQJoF3j05A+WkigTzsyL5QwnFdg3kIDAeCG9wLmi2FZtvbp
         JqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502331; x=1794107131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PUfeEsnq77a4lCfrk3rcb888yzMGRzooM4fsbJpHu5s=;
        b=U4hgCmpVbS7ACkWlsSX3v7sJk8eUhJXkyeeIZAooDACjX9bwiSzKFbzRBtq9vBKyiF
         xqxX5GkNg/gdY6mLvbsC4x5/SFKjespHJ9Jx6qSOZQnomxoVy9WFFl81ijS3plu/Dcf3
         wOvnAFO4p0XPuU2OfOmbCkxyC0I/fUH/qryTb92USbah1Wk7n6HQqeijrsAquCe2M05J
         K2jExgTRvtKdnhWYQcBnQpSpM7EyOERy7mDo0h2ULgBkwoda8tLmUl4FfMlimAaO6qnT
         fKdDg2jpmN8g8meTVrVq9ypfQXfHM92aK/n0mFkeKqXEc3jYeUnR20k27xPxKVmFZMxw
         JVug==
X-Gm-Message-State: AFq9FYLELGHTTDc/SblMCeVu3eOp6GQ1JJmBIWplH3EaL4Nql4ukSsrF
	DTPhEFbTaWf000f3NxGFVwKES3qXumLGThKcBQJcw6vk5V32G3pnyxe67DE5lg==
X-Gm-Gg: AYBFou2lz50xbGEojRjWCR1MLWkOakW+4VZencYfJepLcX/ZVdxuTueNpKspD9rXejh
	uVt6kuteqYtJ3ksHYA6We7df1rwygiCxGQx8u8iGtiAmTO3Z3tUQXw/nfhUE+Fi11xRcVNvvnOX
	EApFfmL27mbX8P1j+03v/z3y4lCDgPysV6GISlP1RcszYNAruFOCRtVBPcNzYY+rfLNpuVSs0IQ
	uYoAEsurbGVuwARWsZ9C5TSwLNKcl7VPzdPOePOlKE3+IomULmEJYprFGD7rFbbCXVNK/pJOQjh
	nNNwHrIFLZ1dBcLDg53fOUckDtoznx2tNKYZ8U6BQZ3twda0RBnXwnil4I53Kg8pogoJwM9Oh0x
	xm8luFUiLzRfSIbRqRRJTPtnGmjW3B7F2xDBj9oova+uJ247HVXUB4OTCJfVXju+Aw8Vk/gAxJP
	8/EnjE54lAfmPovQUOcSho4b0x0BEIAvrb23b4kPE3Wzjr0F5a9czr+u76nvJG2xOUlAlAfpIrg
	rmyFmOhmACugR7QLluZtgBaluV7TVA/W9Q2ZMDyjxcIedsJ+9d48IB+ike21iVTOc6Q2YK87yrB
	1eik8lczzHQvR+K/Z2UihTncNWxIpACDyqESLyZonHpSb1CYiBQC3d3K1wV+0KbnQnX4Zjh47l3
	kniPX7ndXX2kurJYNL3FwwjXp0l2LJmmDJmb/tWW+EAhS3zu/mP1t7JXX/z8/M0eLFlDPhtbkcg
	==
X-Received: by 2002:a17:90b:4e83:b0:3aa:f4af:1e0f with SMTP id 98e67ed59e1d1-3ae89536c2emr5331094a91.8.1793502330623;
        Sat, 31 Oct 2026 20:05:30 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8803a80asm4747944a91.3.2026.10.31.20.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:05:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 03/14] bpf: Treat addr_space_cast of a pointer that is not in arena as a move
Date: Sun,  1 Nov 2026 03:04:59 +0000
Message-ID: <20261101030511.1578690-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

'rX = addr_space_cast(rY, 0, 1)' makes a pointer to arena from an address
in arena. The verifier gives rX the type PTR_TO_ARENA and replaces the insn
with 'wX = wY', which keeps the low 32 bits. The JIT adds the base of the
arena in each access. Thus an access through PTR_TO_ARENA cannot leave the
arena, and the verifier does not check it.

In C the __arena attribute marks the pointers to arena, and clang casts
only these pointers. Rust has no address spaces. The compiler follows each
pointer back to its origin, and it does not cast a pointer that comes from
the kernel. But it cannot always find the origin. For example, two progs of
an object call the same function. One prog passes a ring buffer record, and
the other prog passes an object in arena:

  fn fill(e: &mut Event)

  r6 = addr_space_cast(r1, 0, 1)     ; a ring buffer record, or a number
  *(u64 *)(r6 + 0) = r2

When the compiler does not know the origin, it casts the pointer. The
verifier does not examine the type of r1. r6 becomes PTR_TO_ARENA in the
two progs. The first prog loads, and it writes to arena instead of the
record.

The verifier knows the type of rY. Let the type select what the cast does:

  rY                             the cast becomes      rX
  -----------------------------  --------------------  ------------
  number (scalar), PTR_TO_ARENA  wX = wY, as before    PTR_TO_ARENA
  all other pointers             rX = rY, or nothing   a copy of rY
                                 when X == Y

All other pointers are kernel pointers, and they are in address space 0
already. Thus a move is the correct cast. rX is a copy of rY. The verifier
applies the same checks to the two registers: bounds, NULL, references.

The verifier replaces the cast one time, for all paths. Thus it rejects a
prog in which the same cast gets a number on one path and a kernel pointer
on a different path:

  same addr_space_cast insn cannot be used with a number and with a pointer

NULL is a number too.

The analysis of live stack slots follows a pointer to the stack through a
move. Make arg_track_xfer() follow it through the cast too. Otherwise the
analysis does not see a read of the stack through rX, and the verifier
forgets a slot that the prog reads. This analysis runs before the verifier
knows the type of rY, and it can take a number for a pointer to the stack.
Then rX points to arena. Thus rX is "the slot of rY, or not a pointer" for
the analysis: an access through rX can read or write that slot, and it is
never a certain write.

The cast continues to be one insn at most. A prog in C gets different code
only where it casts a pointer that is not in arena. In selftests
arena_htab_asm casts the address of a variable in .bss. It accessed arena
at the low 32 bits of that address, and now it accesses the variable.

The kernel marks the pointers to arena in its structs with
btf_type_tag("arena"). gcc does not emit the tag. Then such a member is
a kernel pointer for the verifier, and the cast is a move now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/fixups.c          | 20 +++++++++++++
 kernel/bpf/liveness.c        | 15 ++++++++--
 kernel/bpf/verifier.c        | 54 ++++++++++++++++++++++++++++++++++--
 4 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7baeb831281f..3562e57ebb5e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -782,6 +782,8 @@ struct bpf_insn_aux_data {
 	u64 non_sleepable:1; /* helper/kfunc may be called from non-sleepable context */
 	u64 is_iter_next:1; /* bpf_iter_<type>_next() kfunc call */
 	u64 call_with_percpu_alloc_ptr:1; /* {this,per}_cpu_ptr() with prog percpu alloc */
+	u64 cast_arena:1; /* addr_space_cast of an address in arena */
+	u64 cast_mov:1; /* addr_space_cast of a pointer that is not in arena, it's a move */
 	u64 bb_end:1; /* last instruction of a basic block */
 	u64 need_scev:1;
 	u64 alu_state:5; /* used in combination with alu_limit */
@@ -2013,6 +2015,7 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env);
 void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env);
 int bpf_opt_remove_dead_code(struct bpf_verifier_env *env);
 int bpf_opt_remove_nops(struct bpf_verifier_env *env);
+void bpf_lower_cast_mov(struct bpf_verifier_env *env);
 int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env, const union bpf_attr *attr);
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
 int bpf_jit_subprogs(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 41bc37e205e0..b0f0262e5263 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -723,6 +723,26 @@ int bpf_opt_remove_dead_code(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/* addr_space_cast of a pointer that is not in arena is a move, see is_cast_mov() */
+void bpf_lower_cast_mov(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_insn *insn = env->prog->insnsi;
+	int i;
+
+	for (i = 0; i < env->prog->len; i++, insn++) {
+		if (!aux[i].cast_mov)
+			continue;
+		/* an address in arena has 32 bits, this pointer has 64 */
+		aux[i].zext_dst = false;
+		if (insn->dst_reg == insn->src_reg)
+			/* bpf_opt_remove_nops() removes it */
+			*insn = NOP;
+		else
+			*insn = BPF_MOV64_REG(insn->dst_reg, insn->src_reg);
+	}
+}
+
 int bpf_opt_remove_nops(struct bpf_verifier_env *env)
 {
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index b49374a1ae0a..f30ea7b570e6 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1454,8 +1454,16 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		if (code == BPF_MOV) {
 			if (insn->off == 0) {
 				*dst = *src;
+			} else if (insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1) {
+				/*
+				 * The cast of a pointer to stack to as(0) is a move. But src
+				 * can be a stale spill, see below. Then it's a number for the
+				 * verifier, and dst points to arena. A store through dst must
+				 * not count as a certain store to a slot of the stack.
+				 */
+				*dst = __arg_track_join(*src, none);
 			} else {
-				/* addr_space_cast destroys a pointer */
+				/* the cast to as(1) and sign extension destroy a pointer */
 				*dst = none;
 			}
 		} else {
@@ -1472,8 +1480,9 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		 * Helpers, kfuncs and global subprogs can scratch stack slots. The verifier reads
 		 * a scalar from a scratched slot, but at_stack_out[slot] is not cleared, and
 		 * fill_from_stack() returns the stale spill: an FP-derived arg_track for a scalar.
-		 * A scalar can't be dereferenced, so the stale value can only set liveness bits
-		 * for stack accesses that don't happen. That is conservative.
+		 * A scalar can't be dereferenced before addr_space_cast, see above. So the stale
+		 * value can only set liveness bits for stack accesses that don't happen. That is
+		 * conservative.
 		 *
 		 * Static subprogs and callbacks can't store an FP-derived pointer into the frame of
 		 * the caller, but they can store any other pointer there. The caller can fill it
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b6c0674ff6a..f1eaff892beb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17835,6 +17835,51 @@ int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
 	return reg_bounds_sanity_check(env, acc, "bpf_reg_union");
 }
 
+/*
+ * There are no address spaces in Rust. The compiler doesn't cast a pointer that
+ * comes from the kernel. But it can't always tell, and then it casts the pointer
+ * to as(0) before the access, like an address in arena.
+ * A pointer that the verifier knows is in as(0) already, so the cast is a move.
+ * arg_track_xfer() does the same for pointers to stack.
+ */
+static bool is_cast_mov(const struct bpf_insn *insn, const struct bpf_reg_state *src_reg)
+{
+	/* cast from as(1) to as(0) */
+	if (insn->imm != 1)
+		return false;
+
+	switch (base_type(src_reg->type)) {
+	case SCALAR_VALUE:
+	case PTR_TO_ARENA:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static int check_addr_space_cast(struct bpf_verifier_env *env, struct bpf_insn *insn,
+				 struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg)
+{
+	struct bpf_insn_aux_data *aux = cur_aux(env);
+
+	if (is_cast_mov(insn, src_reg)) {
+		aux->cast_mov = true;
+		*dst_reg = *src_reg;
+	} else {
+		aux->cast_arena = true;
+		mark_reg_unknown(env, cur_regs(env), insn->dst_reg);
+		if (insn->imm == 1) /* cast from as(1) to as(0) */
+			dst_reg->type = PTR_TO_ARENA;
+	}
+
+	/* it's either wX = wY or rX = rY, see bpf_lower_cast_mov() */
+	if (aux->cast_mov && aux->cast_arena) {
+		verbose(env, "same addr_space_cast insn cannot be used with a number and with a pointer\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
@@ -17896,9 +17941,9 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			if (BPF_CLASS(insn->code) == BPF_ALU64) {
 				if (insn->imm) {
 					/* off == BPF_ADDR_SPACE_CAST */
-					mark_reg_unknown(env, regs, insn->dst_reg);
-					if (insn->imm == 1) /* cast from as(1) to as(0) */
-						dst_reg->type = PTR_TO_ARENA;
+					err = check_addr_space_cast(env, insn, dst_reg, src_reg);
+					if (err)
+						return err;
 				} else if (insn->off == 0) {
 					/* case: R1 = R2
 					 * copy register state to dest reg
@@ -24122,6 +24167,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret == 0)
 		ret = bpf_optimize_bpf_loop(env);
 
+	if (ret == 0)
+		bpf_lower_cast_mov(env);
+
 	if (is_priv) {
 		if (ret == 0)
 			bpf_opt_hard_wire_dead_code_branches(env);
-- 
2.55.0

