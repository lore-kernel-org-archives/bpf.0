Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983693;
	b=prCSRXWEVZIk0jjG9V/1Vm1Y+IARIruxEojd1is4X/fg21dL3HZzP3RPEkdO8SU32eYt
	 PFNA3sOcDIUZKKMLA+vsXIAWoE0Q+p6JBVq8v5jtGVwcDYZ+BFnf1rFfAIbUrk/l6LJeb
	 i6M6lZzE3sYwBV2Csg0MI7j+7MDAj7kd1VdXgvYrm/E90/xw4EBEEGxxlsjnt8MIiKdE/
	 z4zQZE/BSa/qKUGF5HID3SprxWS93If/TKBfxAHdAhDJdlT3E8L9xVb6ZIdMEXs6mh7Yu
	 wW9Q8q+EcVUCVSclqDeCnPr7304zB7VNvapveVya2qPzohiUQr6u2GBka4Qe2+1botw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983693;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8pJbuUnHLlClZBnry5+m0/JPpqyAsYC960Jnuq8D538=;
	b=oUvx3U6Zz7uTy2Q+2eNtuvTPrMGRQDW5VzVk1Q27k6q/soOQnjhilPOOK7HLIUlOorod
	 0DN4I9HXYdFGnhOuDoxfkWACsdB9ypaq2JO6X1QcF1wDJ8swpi+SeU6PjFedSEX1SRdiX
	 JJoZMmrnzqg094X49Mq7x6juwjtQKnsj2D9UJaGPo9KgRQSDxv4/Mv3B+ICOZMEtJrudF
	 euBdqW7F9mtv1abq6VYhykMXKY1xnk0mcavi1BRdRm7TimWouyDQgvx9Rt0iZEjzBBUnL
	 Jp3IG+9zIt2hh6zE5YiS6pmTnf9R8rgsSJNoc7NkRW3zLgEnBvKM24ZiUu0pOiy2t8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SVVBxWlY;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52213606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52213606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SVVBxWlY
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso15660925ad.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983692; x=1793588492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8pJbuUnHLlClZBnry5+m0/JPpqyAsYC960Jnuq8D538=;
        b=SVVBxWlY8kh5y/62sylG/8Fy0CKYlSXgi49HX/LW6zepO68urTPGBQJP5z4EEJ+PLl
         PSfXHnw3D6HfBI7wuvvgI03t95BYrF1qkYL8VaFw4VkCvMdHLmo13Dc+ouqR/dz30A34
         TWDEVcnUeIa5sZgxNKwDy5bw3afNYk6KFMwtLpKeTu+SgnV10+4HDz/GL+2+rCW6P5n4
         j6jrKHDdeYWFpcXAlGOjk7bLZTV15U79tPbbitqv+QYFbnDxcGLLuq1gUKo3Zr1jReMw
         2gq6ZGmlMSZmrfzWEbDPlfHrFzWHJN2ZU6jFoGgm/g4h1x9ow+Jd8lfc4rhl9+5qL45o
         HLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983692; x=1793588492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8pJbuUnHLlClZBnry5+m0/JPpqyAsYC960Jnuq8D538=;
        b=iLuYMvwYPhKbQlx850yH96OJSaTOpXgpryzH7tXVhytN0z3CS8yZ/2dnLgUOZxukyJ
         VNwrWqMo42rkVuQB/+3hKOABj0lwNlxK/gfYVvc1hPj8gTqCsBV3AOW4eyRQXYL/ZFnA
         V1vuHPM4RRniOYmgwMGy2ZZV5i6t27s1uoI2H93DKZ972sa8Wpc3AgrkVYaxhOTEZRkz
         LvVERCNNnFJ+DzzIFq6a2baSPexKeAOGo/E5cnSrK/J4IFGzovhaLjlHNtdD6sby1NwD
         yVBACFTKfPc/LiXX5TtjZydGCSebbGacoFPu+M6DdFYULe6BCOEupncI4PvKfrnc3u+f
         3IMA==
X-Gm-Message-State: AFq9FYI+0+EOz+SquPhdyhnaJ/16DJgN08h+JIVqeihg3PoeW9A44BlH
	RiDbY8spmgYgxnoY1wVcGbPht8H/YMBnTvqeN65/bOTSe2SVqs5/XZVKBIAnOA==
X-Gm-Gg: AYBFou0cjXbcbx3Jp8I1sbraw3Ru/KoaLA5XQOKY2ic3WCaNTHigq44K0VmJGJzUTUq
	76OdEXlXB4pXNl+Ij6+PVGTr9TJsBMI9Ew47Mgztpu9Quzj64z9z1XcCde6yN9aNztU//gG5Q15
	5LXjXKcBuCSdLaYz1qptsfButNXAjJwHz6BaXFOIPaq9B9i/4fHPiMhBwwVEEanAdyRaKSU8vUT
	8vroblJDPoGMSFiyPXCfzJUxuPL44/gsdrmi8Ee6EfZKkbLCr6gqkL8OCKk+Aq/Dxw7Bljhn9ro
	BQip7SXxm0Af1gndNNO3YoqRiyXWgvnj590M7QraXrgNXsCJd7LQNVkVlPDIx5TErkV5Svovnoo
	2CilMZV1o4iQqu6AM/BFqGXQ1821PxG6hdr+EtgXOodf0RXdHALhPbc8V3KKvSNU4V2Di/IqfS+
	vHp6trHqeF34Psvp3/5ExE3BrWm0ZxoFoIRdDq1VQBcz9Fjxi4uETNbkQnXg4CxDUNRvC+F+TFL
	kkE3tbGHn5q+dQ10ue8wEGBm2yPlDURu25f9PrtibNjr8F0mqy/exFDNK4ayegYDkJVvw6jFYz5
	ch1IFsidOBNU9iw2Pt3PoEaIczpVx03aQ6RkFBQUW3X3RMa/+GWtO5Af/pVjUY9IGun2lPrNKXz
	6JhCqcW4wy4EQviG33aD3H2/N
X-Received: by 2002:a17:903:2a8b:b0:2e2:b7b8:abc5 with SMTP id d9443c01a7336-2ea9c80e15bmr48821545ad.32.1792983692318;
        Sun, 25 Oct 2026 20:01:32 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b19ea80sm10195445ad.42.2026.10.25.20.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:01:32 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 18/81] bpf: Treat addr_space_cast of a pointer that is not in arena as a move
Date: Mon, 26 Oct 2026 02:58:39 +0000
Message-ID: <20261026025943.404450-19-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The analysis of live stack slots follows a pointer to the stack through a
move. Make arg_track_xfer() follow it through the cast too. Otherwise the
analysis does not see a read of the stack through rX, and the verifier
forgets a slot that the prog reads.

The cast continues to be one insn at most. Progs in C get the same code.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  3 ++
 kernel/bpf/fixups.c          | 18 ++++++++++++
 kernel/bpf/liveness.c        |  6 ++--
 kernel/bpf/verifier.c        | 54 ++++++++++++++++++++++++++++++++++--
 4 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7030b997ce2c..ce3f0e275d9c 100644
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
@@ -2007,6 +2009,7 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env);
 void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env);
 int bpf_opt_remove_dead_code(struct bpf_verifier_env *env);
 int bpf_opt_remove_nops(struct bpf_verifier_env *env);
+void bpf_lower_cast_mov(struct bpf_verifier_env *env);
 int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env, const union bpf_attr *attr);
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
 int bpf_jit_subprogs(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fe8d51f8c855..ae3347e724ca 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -723,6 +723,24 @@ int bpf_opt_remove_dead_code(struct bpf_verifier_env *env)
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
index e657e6d95408..f2989a4fd9a7 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1426,10 +1426,12 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		} /* else if dst->frame is imprecise it stays so */
 	} else if (class == BPF_ALU64 && BPF_SRC(insn->code) == BPF_X) {
 		if (code == BPF_MOV) {
-			if (insn->off == 0) {
+			if (insn->off == 0 ||
+			    (insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1)) {
+				/* the cast of a pointer to stack to as(0) is a move */
 				*dst = *src;
 			} else {
-				/* addr_space_cast destroys a pointer */
+				/* the cast to as(1) and sign extension destroy a pointer */
 				*dst = none;
 			}
 		} else {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 84f722bac539..203edbe41397 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17803,6 +17803,51 @@ int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
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
@@ -17864,9 +17909,9 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
@@ -24069,6 +24114,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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

