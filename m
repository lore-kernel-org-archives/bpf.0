Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401863;
	b=ydJtajth9pFjcPSPxPj7k+e4IBnc8Ob+5D2T9LYYMswshKRxsiWcLlX06IPplq2u+rpu
	 iDysMuxDYka1Nd+h0SMYivzPqgftfrAIKlshcbDkoVkpUi/dIC8Cu0Fp6L+jdH7+XvA/7
	 eX590UDzXNDkK7MuBgV0K+x24CKN15TQDJ2MRpDv15AVVXxZV0eNRytlJrgTJrd21xWUJ
	 lOcDN97ey58K1LsRFZSppy2zup8kUbcOUFcXgUHYdYWni6bybZVYIrvLU5AbTpI2ucvat
	 u08a8DVzrmLnWg9S/+A8Skbi4I9WXJit4xfTbv8RAUxNunFktu0cLazxaON7dzdG6Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=VD1+rpAxFamZx0j4jy4zHt2HYmwHJlGoMHEZh1ewYJQ=;
	b=Nn1X8XhJSOGevXnVP7VS8qQRK7G+tasvMWEUJuN1RS245Ol5RUlKIMH9V9tn13sCQhhu
	 0KqG7ZHWOogW66EAuLXr8z29Zp8pC8Iq2nv1K6qj4DoRcwh1y+AikNIwJrozwO6gzeClF
	 IMuVf+zeyW2plSGHAuq/H5ruGVuj01ydshaWKysKxnj/b+7Hggy5+ktyLPoA9J4n9Btbj
	 NxlNAH0GZYgnyvlLgeiNci8hFXxHvt3l7B8g2W6LIazA4ag5VzveIlb1MF3/9PtIECvYt
	 32GutBW1LKNfrZvwXcNN6lRfQQqxfKEhRPYhgQ+n8cV9BMy+bgCPvm8PcysoPFKb9jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O27Hv7LR;
	arc=none smtp.remote-ip=74.125.225.75
Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203AC606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 203AC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O27Hv7LR
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48fd1deda37so1175630f8f.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401861; x=1795006661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VD1+rpAxFamZx0j4jy4zHt2HYmwHJlGoMHEZh1ewYJQ=;
        b=O27Hv7LRIjetHkZ2HQbRSeVBA3Qp5/KQQqhjCQHDC2DPERDHnDvrrcM8h/2vQhMihf
         khWNGY2Gnvbh3Eg7GaGgIxrkl0K3nbSABr19B97oE3ugL/fq+MMKAqj9/xHCFkO+FHff
         GR4PEq+tfNsyw+cbTcnhLSNt4AAwPgwtiDV7mACFxKq8RC/B9ZDZYoEKroa3pedhdC1B
         j0uzhyD1s0fNVwbFEGVG9iZ+5RhnLgEAdz+WcibI8coSVVZQ9zSwoM473j+MFRYpk/Km
         acHEdwwLbIYxj0bj9zSRixpfSpU+fRneDkrV8pTtRJsvlCs+t/hSvf16jJTaKKvGZ7Qv
         GXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401861; x=1795006661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VD1+rpAxFamZx0j4jy4zHt2HYmwHJlGoMHEZh1ewYJQ=;
        b=rJtSQ38MfomcPiB3OMtvQsBUS9S1Vun1I0X8zlfuELSOHea+wnSUHFsk/MKMD7pgQQ
         HZjViMVFZsWnj0VI+ZC6AAo2X5wODnhGvvt9CZC5qB2kfHOaSTA/TLsaDRqFY9RRMUlq
         qk2YlbKZl5vUFroAeYMHVgHQbQZA6gD3ZyhsO2seslZjwcYp8u7zg9O8RpsPypxbTEbO
         /sOZycwcOwsjfVdeKFQ1v5tpNKwv/YkHyjV63b3zBm9Fl4aLbdENBgCU3UB1avRh7Bfn
         PKTwTTir4JVvJvm9+Aj2NSAhgwRHZgrjf/RI/RlNc9Un5yCbx7sFM5okxVtxWtVy3rip
         UAvw==
X-Gm-Message-State: APuU4Z/TDefTbGlvAHOIA7KA1u9Oq6+v+w9P77KMcsY+Jr8F4C1MdyeM
	3bbZ/VDdEQzishzzkjFR4aOtZbfNDoGpk56vVY6aRFENpJq1We4qzEYZDEUN1QyKZG0=
X-Gm-Gg: AYBFou00cqgU9l/ZE9S6jQy4JsgY3GRuI2hXWL3CCQRHCKi3bmhUV4AjUH1nVTBMXkD
	VwADVErfuxD0qqCW7xc6+uXBOYjb/mgis4RmarPBGkhuwMJ7iiZ92arM8e2TM4TsxR2sm4eychB
	Kmh0t57jGNekwzoiH51q5iR8jd7BsljU+WEW4JPgtL7ix0GYp8aoonat09+pJtlBSRkGTnih2wf
	ZuQJjfi+NRLAt3ok3Ld6xR8iwPpkCa7FXA1Gugoaif8AQof8Qp9JYpDRYD58GZO0g4U6mnpupqn
	HPmyuQ4bYosJO4Dvy6stLpDuFzhd+ZFe2q7JVdbY/g904p5AmhuhFJZ1kQCUv6gaeq6FBnwUuXG
	krmABj62yqma72Nq958yND82RXP8jKvpG2Z2357fA0cU1tkc9gVHk1QMVcaLgfuJG4SP0zRMd4v
	VRg5wFoD15tC3khWBSXV/xYqLm3rs7r6goVpgfENfcuyRdfVu4sl612r+AaEDZammzrvtobm8C2
	mVrY32/TjTeGi2BFGPRltBrtMR+N8bZhx9H+sPsaYVQL50cB5TFEDZVWBMncB0e8Q5luvjQ+cvJ
	0gkk1dQ5OV8laWYDER9CHXvqvt2eYPFnryp4UajAAum3U5BliVF2rIj2wDt2xzz0cQqzzei3j4D
	BceNPJ/mTSrRGNcMMlXZecw3XROW04IFMRSXkAFsP0pfqRgQ0P0RQdxgwd8LNgoQ1pF2/
X-Received: by 2002:a05:6000:26c9:b0:490:b23b:8017 with SMTP id ffacd0b85a97d-499c75529e1mr4125878f8f.34.1794401861181;
        Wed, 11 Nov 2026 04:57:41 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585923bsm11163144f8f.11.2026.11.11.04.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:40 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 07/29] bpf: Add one allocator for hidden stack slots
Date: Wed, 11 Nov 2026 13:57:05 +0100
Message-ID: <9d074f026dcb520b11bb1365d7116b95e0b789c6.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19847; i=memxor@gmail.com; h=from:subject:message-id; bh=eHSr6a7U8O3Gi8UZNuPxdrQhJbH4jiKQrIXEVGWivz0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzDz5lW9cj6k2iHvn3Du262TrVa6uV4GOa6wrtt220 u2eL9rRUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInYBDAyfLE13aa0n3uW41sx lSNrfX8aMmS3LCnXuDGNd5eSaXn8Pob/WbumXpwQe3LlzZJrTidmpJZ8UHhw8JBcjYhMsyuPYR4 7LwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Rewrites after verification need stack space that the program does not
know about:

 - the may_goto count, or the register that a timed may_goto saves;
 - the spill area of an inlined bpf_loop();
 - the context pointer that a generated epilogue reads back.

Each user computes its own offsets below the verified stack depth and
bumps stack_depth at a subprogram boundary in its own loop. may_goto also
keeps stack_extra, so that a prologue patch at the end of
bpf_do_misc_fixups() knows how many slots to initialize, with a bug check
that nothing else uses it.

Later patches need more hidden slots, for the handles of resources that
an unwinder has to find. Add one allocator:

 - bpf_reserve_stack_slots() hands out 8-byte slots, top down, below the
   verified depth of a subprogram rounded up to 8 bytes. It bumps
   stack_depth and stack_extra.
 - bpf_stack_slot_init() records the value that a slot must hold on
   entry.
 - bpf_emit_stack_inits() patches all initializing stores into the
   subprogram prologues in one place, in chunks that fit the instruction
   buffer. Jumps to the first instruction are redirected past the stores,
   as the may_goto patch did.

Convert the three users:

 - The may_goto slot is reserved at the first may_goto of a subprogram
   and shared by the rest. The bpf_loop() spill area works the same way.
 - The epilogue slot keeps its offset by asking for the next slot before
   gen_epilogue() decides whether it is needed.

The "stack size %d(extra %d) is too large" check for interpreted programs
moves into the allocator, so it covers every user. Slots now start at an
8-byte aligned offset. Before, a subprogram with an unaligned depth got
unaligned may_goto slots.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  12 ++
 kernel/bpf/fixups.c          | 265 +++++++++++++++++++++++------------
 kernel/bpf/verifier.c        |   1 +
 3 files changed, 190 insertions(+), 88 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4771c55d8f41..7a2b6507f562 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1023,6 +1023,7 @@ struct bpf_subprog_info {
 	u32 exit_idx;
 	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
 	u16 stack_depth; /* max. stack depth used by this function */
+	/* bytes below the verified stack depth reserved for hidden slots, see bpf_reserve_stack_slots() */
 	u16 stack_extra;
 	u16 arena_stack_depth; /* size of the frame in the stack in arena */
 	u32 insns_total;
@@ -1208,6 +1209,13 @@ void bpf_patch_image_install(struct bpf_prog *prog, const struct bpf_patch_image
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
+/* Initialization of a hidden stack slot, emitted in the subprogram's prologue. */
+struct bpf_stack_init {
+	u32 subprog;
+	s16 off;
+	s32 imm;
+};
+
 struct bpf_verifier_env {
 	u32 insn_idx;
 	u32 prev_insn_idx;
@@ -1233,6 +1241,8 @@ struct bpf_verifier_env {
 	u32 insn_array_map_cnt;		/* number of used maps of type BPF_MAP_TYPE_INSN_ARRAY */
 	u32 id_gen;			/* used to generate unique reg IDs */
 	u32 hidden_subprog_cnt;		/* number of hidden subprogs */
+	struct bpf_stack_init *stack_inits; /* hidden slot initializations, see bpf_stack_slot_init() */
+	u32 stack_init_cnt;
 	int exception_callback_subprog;
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
@@ -2174,6 +2184,8 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 
 /* Functions in fixups.c, called from bpf_check() */
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len);
+int bpf_reserve_stack_slots(struct bpf_verifier_env *env, int subprog, int nr, s16 *off);
+int bpf_stack_slot_init(struct bpf_verifier_env *env, int subprog, s16 off, s32 imm);
 int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env);
 int bpf_optimize_bpf_loop(struct bpf_verifier_env *env);
 void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 8597b443d561..04d89113e596 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -918,6 +918,87 @@ int bpf_insert_recursion_checks(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/*
+ * Hidden stack slots. Post-verification rewrites need stack space the program
+ * does not know about: may_goto counters, the spill area of an inlined
+ * bpf_loop(), the context pointer a generated epilogue reads back. Such slots
+ * are reserved below the stack depth verification established for a
+ * subprogram, after bpf_remove_fastcall_spills_fills() has shrunk it, so that
+ * they sit directly under the program's own frame. Slots are 8 bytes, 8-byte
+ * aligned and handed out top down: the first slot of a subprogram lies right
+ * below its verified depth rounded up to 8 bytes.
+ */
+static s16 next_stack_slot_off(const struct bpf_subprog_info *info)
+{
+	return -(s32)(round_up(info->stack_depth, BPF_REG_SIZE) + BPF_REG_SIZE);
+}
+
+/* Reserve @nr slots in @subprog; @off receives the offset of the topmost one. */
+int bpf_reserve_stack_slots(struct bpf_verifier_env *env, int subprog, int nr, s16 *off)
+{
+	struct bpf_subprog_info *info = &env->subprog_info[subprog];
+	u32 depth = round_up(info->stack_depth, BPF_REG_SIZE) + nr * BPF_REG_SIZE;
+	u32 extra = depth - info->stack_depth;
+
+	if ((depth > MAX_BPF_STACK && !env->prog->jit_requested) || depth > S16_MAX + 1U) {
+		verbose(env, "stack size %d(extra %d) is too large\n", depth, info->stack_extra + extra);
+		return -EINVAL;
+	}
+	*off = next_stack_slot_off(info);
+	info->stack_depth = depth;
+	info->stack_extra += extra;
+	return 0;
+}
+
+/* Initialize the hidden slot at @off of @subprog to @imm in its prologue. */
+int bpf_stack_slot_init(struct bpf_verifier_env *env, int subprog, s16 off, s32 imm)
+{
+	struct bpf_stack_init *inits;
+	u32 cnt = env->stack_init_cnt;
+
+	inits = kvrealloc(env->stack_inits, array_size(cnt + 1, sizeof(*inits)),
+			  GFP_KERNEL_ACCOUNT);
+	if (!inits)
+		return -ENOMEM;
+	inits[cnt] = (struct bpf_stack_init) { .subprog = subprog, .off = off, .imm = imm };
+	env->stack_inits = inits;
+	env->stack_init_cnt = cnt + 1;
+	return 0;
+}
+
+/*
+ * Emit the stores that initialize hidden slots at the start of each subprogram.
+ * They go in front of the first instruction, which a jump to it skips, so a
+ * loop back to the entry does not rerun the initialization. The patch list is
+ * empty on entry and committed on return.
+ */
+static int bpf_emit_stack_inits(struct bpf_verifier_env *env)
+{
+	struct bpf_insn *insn_buf = env->insn_buf;
+	u32 i, j, cnt;
+	int ret;
+
+	for (i = 0; i < env->subprog_cnt; i++) {
+		j = 0;
+		do {
+			cnt = 0;
+			for (; j < env->stack_init_cnt && cnt < INSN_BUF_SIZE; j++) {
+				const struct bpf_stack_init *init = &env->stack_inits[j];
+
+				if (init->subprog == i)
+					insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, init->off,
+								     init->imm);
+			}
+			if (!cnt)
+				break;
+			ret = bpf_patch_list_insert(env, env->subprog_info[i].start, insn_buf, cnt);
+			if (ret)
+				return ret;
+		} while (j < env->stack_init_cnt);
+	}
+	return bpf_patch_list_commit(env);
+}
+
 /* Clean up dynamically allocated fields of aux data for instructions [start, ...] */
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 {
@@ -1461,16 +1542,22 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 	int epilogue_idx = 0;
 
 	if (ops->gen_epilogue) {
-		epilogue_cnt = ops->gen_epilogue(epilogue_buf, env->prog,
-						 -(subprogs[0].stack_depth + 8));
+		s16 ctx_off = next_stack_slot_off(&subprogs[0]);
+
+		epilogue_cnt = ops->gen_epilogue(epilogue_buf, env->prog, ctx_off);
 		if (epilogue_cnt >= INSN_BUF_SIZE) {
 			verifier_bug(env, "epilogue is too long");
 			return -EFAULT;
 		} else if (epilogue_cnt) {
+			s16 off;
+
 			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
-			subprogs[0].stack_depth += 8;
-			insn_buf[0] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,
-						  -subprogs[0].stack_depth);
+			ret = bpf_reserve_stack_slots(env, 0, 1, &off);
+			if (ret)
+				return ret;
+			if (verifier_bug_if(off != ctx_off, env, "epilogue context slot moved"))
+				return -EFAULT;
+			insn_buf[0] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1, off);
 			ret = bpf_patch_list_insert(env, 0, insn_buf, 1);
 			if (ret)
 				return ret;
@@ -2321,6 +2408,25 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 	return 0;
 }
 
+/*
+ * Reserve the hidden slot of the may_goto instructions of @subprog once, and
+ * @init it: the plain form keeps its count there. The timed form keeps the
+ * count and the timestamp in per-cpu memory of the prog, see struct
+ * bpf_timed_may_goto, and needs the slot only to save R0 around its insns
+ * when every register is live. @off receives the offset of the slot.
+ */
+static int may_goto_stack_slot(struct bpf_verifier_env *env, int subprog, bool init, s16 *off)
+{
+	int ret;
+
+	if (*off)
+		return 0;
+	ret = bpf_reserve_stack_slots(env, subprog, 1, off);
+	if (!ret && init)
+		ret = bpf_stack_slot_init(env, subprog, *off, BPF_MAX_LOOPS);
+	return ret;
+}
+
 /*
  * Expand may_goto: load the count from the stack, jump to the target of
  * may_goto when it is zero, then the tail that updates the count.
@@ -2616,11 +2722,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	struct bpf_map *map_ptr;
 	int i, ret, cnt, cur_subprog = 0;
 	struct bpf_subprog_info *subprogs = env->subprog_info;
-	u16 stack_depth = subprogs[cur_subprog].stack_depth;
-	u16 stack_depth_extra = 0;
 	/* arch_bpf_timed_may_goto() takes and returns AX in a cpu register: for JITs only */
 	bool timed_may_goto = prog->jit_requested && bpf_jit_supports_timed_may_goto();
 	struct bpf_timed_may_goto __percpu *tmg = NULL;
+	s16 may_goto_slot = 0;
 
 	if (env->seen_exception && !env->exception_callback_subprog) {
 		struct bpf_insn *patch = insn_buf;
@@ -2879,9 +2984,12 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				if (!(live & BIT(reg)))
 					break;
 			if (reg > BPF_REG_9) {
+				/* R0 is saved in a hidden slot, shared by the may_goto of the subprog */
+				ret = may_goto_stack_slot(env, cur_subprog, false, &may_goto_slot);
+				if (ret)
+					return ret;
 				reg = BPF_REG_0;
-				save_off = -stack_depth - 8;
-				stack_depth_extra = 8;
+				save_off = may_goto_slot;
 			}
 			if (!tmg) {
 				tmg = alloc_percpu_gfp(struct bpf_timed_may_goto,
@@ -2899,16 +3007,16 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				return PTR_ERR(insn);
 			goto next_insn;
 		} else if (bpf_is_may_goto_insn(insn)) {
-			int stack_off = -stack_depth - 8;
-			struct bpf_insn tail[] = {
-				BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1),
-				BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off),
-			};
+			struct bpf_insn tail[2];
 
-			stack_depth_extra = 8;
-			cnt = may_goto_expand(insn_buf, insn->off,
-					      may_goto_off(env, insn, i),
-					      stack_off, tail, ARRAY_SIZE(tail));
+			/* the count is in a hidden slot, shared by the may_goto of the subprog */
+			ret = may_goto_stack_slot(env, cur_subprog, true, &may_goto_slot);
+			if (ret)
+				return ret;
+			tail[0] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
+			tail[1] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, may_goto_slot);
+			cnt = may_goto_expand(insn_buf, insn->off, may_goto_off(env, insn, i),
+					      may_goto_slot, tail, ARRAY_SIZE(tail));
 
 			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
 			if (IS_ERR(insn))
@@ -3431,18 +3539,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		insn->imm = BPF_CALL_IMM(fn->func);
 next_insn:
 		if (subprogs[cur_subprog + 1].start == i + 1) {
-			subprogs[cur_subprog].stack_depth += stack_depth_extra;
-			subprogs[cur_subprog].stack_extra = stack_depth_extra;
-
-			stack_depth = subprogs[cur_subprog].stack_depth;
-			if (stack_depth > MAX_BPF_STACK && !prog->jit_requested) {
-				verbose(env, "stack size %d(extra %d) is too large\n",
-					stack_depth, stack_depth_extra);
-				return -EINVAL;
-			}
 			cur_subprog++;
-			stack_depth = subprogs[cur_subprog].stack_depth;
-			stack_depth_extra = 0;
+			may_goto_slot = 0;
 		}
 		i++;
 		insn = &prog->insnsi[i];
@@ -3453,57 +3551,43 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		return ret;
 	prog = env->prog;
 
-	env->prog->aux->stack_depth = subprogs[0].stack_depth;
-	for (i = 0; i < env->subprog_cnt; i++) {
-		int stack_slots = subprogs[i].stack_extra / 8;
+	for (i = 0; tmg && i < env->subprog_cnt; i++) {
 		/* an invocation begins, see bpf_timed_may_goto_save() for async callbacks */
-		bool main_prog = tmg && !i;
+		bool main_prog = !i;
 		/* only a helper calls it, in a loop that ends when it returns 1 */
-		bool loop_cb = tmg && i && subprogs[i].is_loop_cb && !subprogs[i].is_called &&
+		bool loop_cb = i && subprogs[i].is_loop_cb && !subprogs[i].is_called &&
 			       !subprogs[i].is_other_cb && !subprogs[i].is_async_cb;
-
-		if (timed_may_goto ? !main_prog && !loop_cb : !stack_slots)
+		struct bpf_insn ld_tmg[] = {
+			BPF_LD_IMM64(BPF_REG_0, (__force unsigned long)tmg)
+		};
+		int count_off = offsetof(struct bpf_timed_may_goto, count);
+		int timestamp_off = offsetof(struct bpf_timed_may_goto, timestamp);
+		int owner_off = offsetof(struct bpf_timed_may_goto, owner);
+
+		if (!main_prog && !loop_cb)
 			continue;
-		if (stack_slots > 1) {
-			verifier_bug(env, "stack_slots supports may_goto only");
-			return -EFAULT;
-		}
 
 		cnt = 0;
-		stack_depth = subprogs[i].stack_depth;
-		if (timed_may_goto) {
-			struct bpf_insn ld_tmg[] = {
-				BPF_LD_IMM64(BPF_REG_0, (__force unsigned long)tmg)
-			};
-			int count_off = offsetof(struct bpf_timed_may_goto, count);
-			int timestamp_off = offsetof(struct bpf_timed_may_goto, timestamp);
-			int owner_off = offsetof(struct bpf_timed_may_goto, owner);
-
-			/* R0 has nothing at the entry */
-			insn_buf[cnt++] = ld_tmg[0];
-			insn_buf[cnt++] = ld_tmg[1];
-			insn_buf[cnt++] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
-			if (main_prog) {
-				insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, count_off,
-							     BPF_MAX_TIMED_LOOPS);
-				insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, timestamp_off, 0);
-				insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, owner_off, 0);
-			} else {
-				/*
-				 * The time is up, but the helper would call the function again and
-				 * again. End its loop. The verifier has seen that: the loop can end
-				 * after each call.
-				 */
-				insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0,
-							      count_off);
-				insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2);
-				insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, 1);
-				insn_buf[cnt++] = BPF_EXIT_INSN();
-			}
+		/* R0 has nothing at the entry */
+		insn_buf[cnt++] = ld_tmg[0];
+		insn_buf[cnt++] = ld_tmg[1];
+		insn_buf[cnt++] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+		if (main_prog) {
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, count_off,
+						     BPF_MAX_TIMED_LOOPS);
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, timestamp_off, 0);
+			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, owner_off, 0);
 		} else {
-			/* Add ST insn to subprog prologue to init extra stack */
-			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
-						     BPF_MAX_LOOPS);
+			/*
+			 * The time is up, but the helper would call the function again and
+			 * again. End its loop. The verifier has seen that: the loop can end
+			 * after each call.
+			 */
+			insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0,
+						      count_off);
+			insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2);
+			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, 1);
+			insn_buf[cnt++] = BPF_EXIT_INSN();
 		}
 		/* jumps to the first insn of the subprog skip the setup */
 		ret = bpf_patch_list_insert(env, subprogs[i].start, insn_buf, cnt);
@@ -3512,9 +3596,15 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	}
 
 	ret = bpf_patch_list_commit(env);
+	if (ret)
+		return ret;
+
+	/* The hidden slots get their values in the prologues too. */
+	ret = bpf_emit_stack_inits(env);
 	if (ret)
 		return ret;
 	prog = env->prog;
+	prog->aux->stack_depth = subprogs[0].stack_depth;
 
 	/* Since poke tab is now finalized, publish aux to tracker. */
 	for (i = 0; i < prog->aux->size_poke_tab; i++) {
@@ -3613,14 +3703,14 @@ static bool is_bpf_loop_call(struct bpf_insn *insn)
 		insn->imm == BPF_FUNC_loop;
 }
 
-/* For all sub-programs in the program (including main) check
+/*
+ * For all sub-programs in the program (including main) check
  * insn_aux_data to see if there are bpf_loop calls that require
  * inlining. If such calls are found the calls are replaced with a
  * sequence of instructions produced by `inline_bpf_loop` function and
- * subprog stack_depth is increased by the size of 3 registers.
- * This stack space is used to spill values of the R6, R7, R8.  These
- * registers are used to store the loop bound, counter and context
- * variables.
+ * three hidden stack slots are reserved in the subprog to spill the
+ * values of R6, R7, R8. These registers are used to store the loop
+ * bound, counter and context variables.
  */
 int bpf_optimize_bpf_loop(struct bpf_verifier_env *env)
 {
@@ -3628,9 +3718,7 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env)
 	int i, cur_subprog = 0, err;
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
-	u16 stack_depth = subprogs[cur_subprog].stack_depth;
-	u16 stack_depth_roundup = round_up(stack_depth, 8) - stack_depth;
-	u16 stack_depth_extra = 0;
+	s16 loop_off = 0;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		struct bpf_loop_inline_state *inline_state =
@@ -3639,20 +3727,21 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env)
 		/* the callback that takes a stack in arena is not for a call from the program */
 		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline &&
 		    !subprogs[inline_state->callback_subprogno].arena_stack_entry) {
-			stack_depth_extra = BPF_REG_SIZE * 3 + stack_depth_roundup;
-			err = inline_bpf_loop(env, i,
-					      -(stack_depth + stack_depth_extra),
+			/* Three slots spill R6, R7 and R8, shared by the subprog's loops. */
+			if (!loop_off) {
+				err = bpf_reserve_stack_slots(env, cur_subprog, 3, &loop_off);
+				if (err)
+					return err;
+			}
+			err = inline_bpf_loop(env, i, loop_off - 2 * BPF_REG_SIZE,
 					      inline_state->callback_subprogno);
 			if (err)
 				return err;
 		}
 
 		if (subprogs[cur_subprog + 1].start == i + 1) {
-			subprogs[cur_subprog].stack_depth += stack_depth_extra;
 			cur_subprog++;
-			stack_depth = subprogs[cur_subprog].stack_depth;
-			stack_depth_roundup = round_up(stack_depth, 8) - stack_depth;
-			stack_depth_extra = 0;
+			loop_off = 0;
 		}
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c5b4025ee222..0684ac1f4f22 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25732,6 +25732,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	for (i = 0; i < env->func_set_cnt; i++)
 		kfree(env->func_sets[i]);
 	kfree(env->func_sets);
+	kvfree(env->stack_inits);
 	bpf_diag_free(env);
 	kvfree(env->idoms);
 	kvfree(env);
-- 
2.53.0

