Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755462;
	b=j0xmst/cZEHwRjoMBiE4rdDYlP+urKfv7cH7APLqKioFqveqNs7m2nv3R2IDzJizDYSG
	 csxDefIEgtxtFz81gD58zQAI+rQ9li7sDfilfA7FMboBX+KftQ7jXs3MoTjE1M23eYGNj
	 f0FNPGAzMQGRp1a+SVJQ8rGJmWn2A9ZMZy/chzdNBlZ8dyCZNZXN9ki4Cz6Y46FU0MPPY
	 mZdSgfpD1AnvwH/BuWoMhsHZzJgX9ySiGSQow6Ol4djcuBjBey+bHnF+dpHAJS+WKXlYV
	 fK3yJ18Iq0qXt1lXKuRrQu215VSp4IMudwSflU5pT1/HCJPse6+ac1CI2Uc25zTJi6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SENimnwhsnT7e4IkV7rFbd4mPNAMjij+oCmMuczZEWA=;
	b=e6b5NJ9f/tQ+hWHoKavHw+uLGWDULKfIXYo62QLRex3FiczHjRpKtaeYAIybZIzF2i5/
	 AgQihqvfX/gOf+Z3C2lLtR3MKXEcODDXak6qcWyyd1FLVaMNZXQaECEqXx3LMDZEqxGCB
	 L3tcgob2LyItEico1NgckY/qLgaS5coGz63TnOAnFrmT5N5Wb7N4nslQ9vdxm+5Y+nSS6
	 BtWvfM/XUQmCtZMDsXm661EhVQ+VEkvS69dmbTRK9GSoiYqWAKt35H8pSTx5BBmjH2QDT
	 tqcjDSFmWANz+p0zu6g3YlHSpFkRZIYUEUs43QkB0EvYLJbSGV3yNSWRCfb+VpUPwGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vwkwCibq;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BADD606A328
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BADD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vwkwCibq
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdab938dc83so77989a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755462; x=1794360262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SENimnwhsnT7e4IkV7rFbd4mPNAMjij+oCmMuczZEWA=;
        b=vwkwCibq94SeAjtqjnVS14zLafs61pFNRfMbF/QLXx1Gj50wzfamG9TNFQjg4cKvy+
         jbvTdi3RrgHzHWyntalD0RSot5rvxDj4NuW3Glu6XFDjA8JNzxYYuvIFzHksTNufbZUe
         eblQV8DpuFFcUX+aiZR2P0y4NKfp2cDSaz6nSiBjX+6MD6MFoqW9491EtXY7NMvkKlN+
         PFtopLnegbPvidDgc6K4vMuM0DFUJavP1VyXBFHj0gSRw+yQLE6rLQwVqD2QEvmkSyn1
         gJDUHyfMD8weFHLuQEJV/G7vTloNrsVarKcY0VfkY5KfOX9aNj3w4cgXw71e7IEoTnHa
         sQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755462; x=1794360262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SENimnwhsnT7e4IkV7rFbd4mPNAMjij+oCmMuczZEWA=;
        b=jclTM1wuHWAcbj2ggOcoqn+cC79wb9pzogSrQFqS9J+n/eML5ELo8VUbBoGfm7nWMC
         zr1VUxibqgdl6H996CHMe6Y3h/zQBhVD2ZTcGWSPt25ZSBiVLnTXTD+E0zR0yQdYgydz
         D1g166VDen7boF19nsZBfl6EcHwjon89nN16MSWmUhuy8j2TSF90zuS+fb+g7M04MODq
         lBf466WSrhnC3qETeY26FH6ndM0938XOTqPi4B6yFVZ3CmOtCyhgE67/cgV4XycYpuUM
         fUpxHowot4LWZa0Eed0nrdS0YKLTdEtDwsBcOF0tbyTDIbvptI1BJs0UiYWrbFPSVffZ
         zBqw==
X-Gm-Message-State: APuU4Z9LTLAvDU8LxToKmK/a0XplM7rMLj8I193M58Cypoy5nnqiwoar
	d2d2UagNI2kJ0/4JAd+fOv8YDDyiY3z4ptpsV2T9KL4Obe9f+lOf2/llMPpkzw==
X-Gm-Gg: AYBFou2dCmKmV/9knLbVxMITKfUJkrNfFypk2v8PMYSCcDLq3hj7B3P7HEUEq8QS0G9
	MUPxsR4n8ZXnagpvuJc0ecK9TmIwWJK3DW0tGXonmNLA9VLYok7efR2gbtBu+aQcuGrJbsaDI5f
	bkKhO8RRhbiLd5s34rjrXmJ9Ru6zmVJ5Q8poZlZis3BWbu442tM6kGi+8zIq47vYUNT5KDv8dyK
	Lh9tsaI/9iXn3QEV6I4+bFZhLCTLIpFfNuJQCF8mpxCKHBpsNfeJe4YMV6njS7Zmip9cM5QtFA/
	QFS2gwKhpacH75Mzs08jcljezQyOibfwJlIzGucRMWfKsOVOBO2355YFejFFjS0Umy8LH17mY1K
	LS61Gaz8wmvAPpuslSXI3bG/VHtx3WBRdiM9XeYql5rcZ3X4Y4riz7EqOqsj6QTc9TTVwd3ziOJ
	1hKoa7WKVE+ih+msegtxwIVN/YT03+zBw9FBkIO/hiWuQMW02cEFGz+6lGNx1VlBDIq6J2k62iu
	ozFwmUSCUNpi+drCKa/94AxqfTJ9f09e1vqClbTxnjSlx86q7fEg9yTk1vJTudC++1228q1A7ss
	E/iPcDTy4CawC/LNojfsMLKSVUW3dgfmbzhkFerZoZrqJ/K9hjBBZXaYThIDLK0jMnp0nRSagHv
	URuKaqqCshds2XwIZMs20uvoCnQNxr/lHU9zF5uDya18SITf7tCzj+MMRJsCiGT3Wc9rH0UsZgX
	KLpiJDU4KQ5vtN69W+WTs=
X-Received: by 2002:a17:90b:35c8:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3ae897aa7aemr12393755a91.49.1793755461323;
        Tue, 03 Nov 2026 17:24:21 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b095314e85sm1102133a91.15.2026.11.03.17.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:24:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 03/14] bpf: Treat addr_space_cast of a pointer that is not in arena as a move
Date: Wed,  4 Nov 2026 01:23:49 +0000
Message-ID: <20261104012401.1354861-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
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

All other pointers are kernel pointers for the verifier, trusted or not.
A kernel pointer is in address space 0 already. Thus a move is the correct
cast. rX is a copy of rY. The verifier applies the same checks to the two
registers: bounds, NULL, references.

The verifier replaces the cast one time, for all paths. Thus it rejects a
prog when it finds a number at a cast on one path and a kernel pointer at
the same cast on a different path:

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
only where the verifier finds a kernel pointer at a cast.

The kernel marks the pointers to arena in its structs with
btf_type_tag("arena"). gcc does not emit the tag. Then such a member is
a kernel pointer for the verifier, and the cast is a move now. The members
'u64 __arena *' and 'void __arena *' of an object from bpf_obj_new() are
rdonly_untrusted_mem for the verifier, and the cast is a move too.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/fixups.c          | 20 +++++++++++++
 kernel/bpf/liveness.c        | 15 ++++++++--
 kernel/bpf/verifier.c        | 54 ++++++++++++++++++++++++++++++++++--
 4 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4a514f27f239..9ae6e109d211 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -795,6 +795,8 @@ struct bpf_insn_aux_data {
 	u64 non_sleepable:1; /* helper/kfunc may be called from non-sleepable context */
 	u64 is_iter_next:1; /* bpf_iter_<type>_next() kfunc call */
 	u64 call_with_percpu_alloc_ptr:1; /* {this,per}_cpu_ptr() with prog percpu alloc */
+	u64 cast_arena:1; /* addr_space_cast of an address in arena */
+	u64 cast_mov:1; /* addr_space_cast of a pointer that is not in arena, it's a move */
 	u64 bb_end:1; /* last instruction of a basic block */
 	u64 need_scev:1;
 	u64 alu_state:5; /* used in combination with alu_limit */
@@ -2089,6 +2091,7 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env);
 void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env);
 int bpf_opt_remove_dead_code(struct bpf_verifier_env *env);
 int bpf_opt_remove_nops(struct bpf_verifier_env *env);
+void bpf_lower_cast_mov(struct bpf_verifier_env *env);
 int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env, const union bpf_attr *attr);
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
 int bpf_jit_subprogs(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6b719a28be68..eb5756cbc7e5 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -709,6 +709,26 @@ static bool insn_is_nop(struct bpf_verifier_env *env, int i, int next)
 	       !memcmp(&insn, &MAY_GOTO_0, sizeof(MAY_GOTO_0));
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
 	int insn_cnt = env->prog->len;
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index f51445ead384..1a4cfb575077 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1456,8 +1456,16 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -1474,8 +1482,9 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
index 62f26149c3ae..488ee53561be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17894,6 +17894,51 @@ int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
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
@@ -17955,9 +18000,9 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
@@ -24231,6 +24276,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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

