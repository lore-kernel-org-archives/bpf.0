Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20C31AF1B
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702279; cv=none; b=sxULEv2tSB0ynas6CW1yZWubXNGkvchYvPRkqnnWXghg3MAATmlO+ZTKlb/ee+Q1l1vyZVhfknzjiKGj43nsxod+yg/uz35NTu/+A18LWJVthzpl7ouADs5Abli1xhy98K61H2iAxhqS7/kKM3lYGEY0O3bPfYHPUHRqiMNbl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702279; c=relaxed/simple;
	bh=KWurprz7N9JJuduonFQEKmZkYWqxRNW9IzM7ak2vC6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/0ZR6aNOEQPG+LPot8eo6HJNuaOP6EckyNElkG26eJYZvyTNS1NzutnXxav3uC9457I5QcHjeD7KH8CJs1X8IsKry2fbxGy9LyH0+u4/zALwrIrXK3J7fylB9e7FX+LasGC18udAngROhMUG2h8aR+Wkh+h5MzGwYwPUW3ecPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG+gFCe4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG+gFCe4"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc73e322dbso24469065ad.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 13:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785702277; x=1786307077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CKzuQoPfLGuY5/b/qAHcEan6yaonEOhYq8VXWeXTnNM=;
        b=ZG+gFCe49nddCtdmYfHg8YhfmJJ1M4SHu/rZyhfcT9KLbg1UuxVEfapZnQnGk2aMw5
         F7lfcChkKxPWwlaUH2vQ7OR40ktezVnscxWtFFw8CrFLcBaCI+Z3jH1KgcoPsLTP7BVs
         peSREIonuaC0fEAu6jkT40x8gRE2vSRAmoKUH3BP5yxVGh1ByFbjCPcdOlll6V46tDZ+
         r5EVOEzk5kdLjbYKAjV/7qG89vMbsKR0iAZUYR2I6Ox5mQTGl2iCz2BtrPZaGToeWZlA
         FUp4LxgdswKEf9knFoKz9SiCqJ7gkWmQ5h21T01Xh1lIMdu651UaqIcEEyBTpDa2wO81
         800w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785702277; x=1786307077;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CKzuQoPfLGuY5/b/qAHcEan6yaonEOhYq8VXWeXTnNM=;
        b=FKt42aAkVyIb980usCLwec9UtC+n+gh8dVDh9uhYFnad8lKCYqACiQbfA6PWyta1pi
         6rHMzKCTFF9DpKes6RYH7DzKcl8UrJyLd7BtzOIoP/pKC9jdl3HCsQqTedf3iow8F/lY
         xozpnpJFrAHIzFrJBkIl1JJWvkV2J66HAIXKmG2zPfoZcI/ReWNBCFHcQXfbWg/NMXIc
         d9OmyORRXjTK1RGcAQYECcXcNVJrlIpNVHiZkicnWxvSdVXF6/3E7bhrTfJV1cyNe9ij
         1iFeI/tS8VkfKencqrS4/WkCVNQ/A74Rfi+NP0lzxL2VWS87L23mwsIZzmPIJLN2vvML
         RMvA==
X-Gm-Message-State: AOJu0YzGbk2s4HmlfQ6X1ZqS5pgT6oRV0gppvyWb2gfvn2WHQe4Eepjq
	7knnIWWG9KukCPfpaTa44np6L6xcORdQcin5W5sDxur5dqySAIaFwybHAylSzA==
X-Gm-Gg: AR+sD10XbGzfCyjkZVR8PIvmB2Rmyq6naDuEhkpOVPVvJBTFlANuXih73RM7QnmwrzH
	IRIMXEtqJ2fYKZKkwz4FJegsKjrl0DlIMvAUhq7cKusQtm/RH7XJ3qnaLm+LQQwboZsK7Jf6Ccl
	rPPyUS8JLLeQZvUMqzRPI87Rh/0dCFGaou6kFg+Vpxlc1hH7vJKkv3hpZ19HbTjHAlQye+8yfOL
	XCM6oUAVSRU8zolSd5fbfcvwIceRd8ZUgJbLajL6a8WF+XcVZwcsWNoEf6tRDIdSEYq7JRPT7r9
	a/thHtJ/J8l6/H73KWE6/JFyjL0ID+q3LlzC8Pj8A0RKAvVnFg+Yukq91H12sqwP9K8X1QdvmmN
	apyZTP+xQb17JqOYWWBUTgk26+bc3EYLPlYusaST20jXC1364HeoVIdG4QLzbn4sHY6LpI1TX9w
	RyviFEWuOnOOiWcibnyyymfL+fE9HYapeKLke9JkNyk07qTWA10THhoDBXIbmmzdeLrl0qqgpnd
	SvFTJM4ekrIUNn3
X-Received: by 2002:a17:902:ef01:b0:2ca:d975:5bbd with SMTP id d9443c01a7336-2d05222b91dmr72629625ad.20.1785702276499;
        Sun, 02 Aug 2026 13:24:36 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0ea128sm28590865ad.40.2026.08.02.13.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:24:35 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	iii@linux.ibm.com,
	gimm78064@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 3/5] bpf: infer zext_dst based on static register liveness analysis
Date: Sun,  2 Aug 2026 13:24:19 -0700
Message-ID: <20260802-static-zext-v3-3-3456b2604574@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
References: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

As reported in the thread [1], the verifier's 32-bit operations zero
extension logic is broken. This logic is responsible for correct
semantics of 32-bit operations on s390 architecture.
According to BPF semantics, operation `w1 += 1` is supposed to zero
extend the upper half of the register `r1`. On s390 the JIT relies on
the verifier emitting explicit zero extension before such operations.

The verifier attempts to minimize the amount of zero extensions
inserted by tracking whether upper halves of the 64-bit registers are
ever used. Previously such tracking worked as follows:
- bpf_reg_state->subreg_def field was set by do_check_insn()
  for each operation defining lower but not the upper halves
  of the register.
- Whenever an operation reading the whole register was verified,
  the verifier checked register's subreg_def and set
  bpf_insn_aux_data->zext_dst flag as true via a call to
  mark_insn_zext() function.
- After the verification was complete, a special pass
  bpf_opt_subreg_zext_lo32_rnd_hi32() extended 32-bit operations
  with bpf_insn_aux_data->zext_dst set as true by adding
  explicit zero extension.

Note that the logic above relies on bpf_reg_state->subreg_def,
which is a property of a current verifier state.
Before the commit [2] two additional steps happened:
- The verifier tracked upper and lower register halves' liveness as
  flags REG_LIVE_READ{32,64} in bpf_reg_state->live.
- The function propagate_liveness() called mark_insn_zext()
  in order to transfer the knowledge about which registers have
  their upper halves alive (and thus might require zero extension).

The commit [2] removed the two steps described above,
hence making possible a situation like below:
- The register's upper half is set and is used on some verification
  path P1 and the register happens not to be marked as precise.
- The checkpoint C is created while processing some instruction
  between register initialization and usage.
- On some other verification path P2 the register's upper half is not
  initialized and that path ends hitting the checkpoint C.
- In such a case the register's initialization on path P2 would lack
  zext_dst mark, making it possible for the program to inject
  an arbitrary value in the register's upper half.

This commit replaces subreg_def based logic with computing zext_dst
statically, as a part of the bpf_compute_live_registers() analysis:
- The analysis now tracks usage of upper and lower halves of the
  registers separately.
- If some instruction defines a 32-bit subregister, but not the whole
  register, *and* the upper half of the register is alive after that
  instruction, the instruction is marked as zext_dst.

There is one notable drop in precision: whenever a BPF subprogram is
called, all 64 bits of parameter registers are presumed to be used.
The assumption is that such a drop in precision would not inflict
a noticeable performance penalty.

[1] https://lore.kernel.org/bpf/CAGKGUv=sOuqQtA1Ub-5JXfA4FPosJFYKAQE4B79cK+P1erxqtg@mail.gmail.com/
[2] commit 107e16979905 ("bpf: disable and remove registers chain based liveness")

Fixes: 107e16979905 ("bpf: disable and remove registers chain based liveness")
Reported-by: Min-gyu Kim <gimm78064@gmail.com>
Link: https://lore.kernel.org/bpf/CAGKGUv=sOuqQtA1Ub-5JXfA4FPosJFYKAQE4B79cK+P1erxqtg@mail.gmail.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   6 +--
 kernel/bpf/fixups.c          |  17 ++++---
 kernel/bpf/liveness.c        |  14 ++++++
 kernel/bpf/verifier.c        | 113 +++----------------------------------------
 4 files changed, 32 insertions(+), 118 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 682c2cd3b844..956243547446 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -162,11 +162,6 @@ struct bpf_reg_state {
 	 * pointing to bpf_func_state.
 	 */
 	u32 frameno;
-	/* Tracks subreg definition. The stored value is the insn_idx of the
-	 * writing insn. This is safe because subreg_def is used before any insn
-	 * patching which only happens after main verification finished.
-	 */
-	s32 subreg_def;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
 	bool precise;
 };
@@ -1655,5 +1650,6 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
 int bpf_jit_subprogs(struct bpf_verifier_env *env);
 int bpf_fixup_call_args(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
+int bpf_insn_def32(struct bpf_insn *insn);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index a0bddada7964..6125598d16a8 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -44,15 +44,18 @@ static int insn_def_regno(const struct bpf_insn *insn)
 	}
 }
 
-/* Return TRUE if INSN has defined any 32-bit value explicitly. */
-static bool insn_has_def32(struct bpf_insn *insn)
+/*
+ * Return the 32-bit subregister defined by INSN, or -1 if INSN does not
+ * explicitly define a 32-bit value.
+ */
+int bpf_insn_def32(struct bpf_insn *insn)
 {
 	int dst_reg = insn_def_regno(insn);
 
-	if (dst_reg == -1)
-		return false;
+	if (dst_reg < 0 || bpf_is_reg64(insn, dst_reg, NULL, DST_OP))
+		return -1;
 
-	return !bpf_is_reg64(insn, dst_reg, NULL, DST_OP);
+	return dst_reg;
 }
 
 static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
@@ -169,7 +172,7 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	 * (cnt == 1) is taken or not. There is no guarantee INSN at OFF is the
 	 * original insn at old prog.
 	 */
-	data[off].zext_dst = insn_has_def32(insn + off + cnt - 1);
+	data[off].zext_dst = bpf_insn_def32(insn + off + cnt - 1) >= 0;
 
 	if (cnt == 1)
 		return;
@@ -181,7 +184,7 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	for (i = off; i < off + cnt - 1; i++) {
 		/* Expand insni[off]'s seen count to the patched range. */
 		data[i].seen = old_seen;
-		data[i].zext_dst = insn_has_def32(insn + i);
+		data[i].zext_dst = bpf_insn_def32(insn + i) >= 0;
 	}
 
 	/*
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index edfc2480b0f0..78351e4a6f25 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2232,6 +2232,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct insn_live_regs *state;
 	int insn_cnt = env->prog->len;
+	u64 pos, insn_pos;
 	int err = 0, i, j;
 	bool changed;
 
@@ -2291,9 +2292,18 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	}
 
 	for (i = 0; i < insn_cnt; ++i) {
+		int def32 = bpf_insn_def32(&insns[i]);
+		u32 out = state[i].out;
 		u32 in = state[i].in;
 
 		insn_aux[i].live_regs_before = mask_lo(in) | mask_hi(in);
+		/*
+		 * On architectures where 32-bit operations do not reset upper halves
+		 * of the registers, the verifier needs to zero extend a destination
+		 * register if an instruction defines a 32-bit subregister and the
+		 * upper half of that register is alive after the instruction.
+		 */
+		insn_aux[i].zext_dst = def32 >= 0 && (mask_hi(out) & BIT(def32));
 	}
 
 	if (env->log.level & BPF_LOG_LEVEL2) {
@@ -2310,7 +2320,11 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 				else
 					verbose(env, ".");
 			verbose(env, " ");
+			pos = env->log.end_pos;
 			bpf_verbose_insn(env, &insns[i]);
+			insn_pos = env->log.end_pos;
+			if (insn_aux[i].zext_dst)
+				verbose(env, "%*c; zext", bpf_vlog_alignment(insn_pos - pos), ' ');
 			verbose(env, "\n");
 			if (bpf_is_ldimm64(&insns[i]))
 				i++;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 896bc5aaaaaf..e51cf5238f60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2129,12 +2129,9 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 /* Mark a register as having a completely unknown (scalar) value. */
 void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 {
-	s32 subreg_def = reg->subreg_def;
-
 	memset(reg, 0, sizeof(*reg));
 	reg->type = SCALAR_VALUE;
 	reg->var_off = tnum_unknown;
-	reg->subreg_def = subreg_def;
 	__mark_reg_unbounded(reg);
 }
 
@@ -2210,7 +2207,6 @@ static int mark_btf_ld_reg(struct bpf_verifier_env *env,
 	}
 }
 
-#define DEF_NOT_SUBREG	(0)
 static void init_reg_state(struct bpf_verifier_env *env,
 			   struct bpf_func_state *state)
 {
@@ -2219,7 +2215,6 @@ static void init_reg_state(struct bpf_verifier_env *env,
 
 	for (i = 0; i < MAX_BPF_REG; i++) {
 		bpf_mark_reg_not_init(env, &regs[i]);
-		regs[i].subreg_def = DEF_NOT_SUBREG;
 	}
 
 	/* frame pointer */
@@ -3122,30 +3117,14 @@ bool bpf_is_reg64(struct bpf_insn *insn,
 	return true;
 }
 
-static void mark_insn_zext(struct bpf_verifier_env *env,
-			   struct bpf_reg_state *reg)
-{
-	s32 def_idx = reg->subreg_def;
-
-	if (def_idx == DEF_NOT_SUBREG)
-		return;
-
-	env->insn_aux_data[def_idx - 1].zext_dst = true;
-	/* The dst will be zero extended, so won't be sub-register anymore. */
-	reg->subreg_def = DEF_NOT_SUBREG;
-}
-
 static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *regs, u32 regno,
 			   enum bpf_reg_arg_type t)
 {
-	struct bpf_insn *insn = env->prog->insnsi + env->insn_idx;
 	struct bpf_reg_state *reg;
-	bool rw64;
 
 	mark_reg_scratched(env, regno);
 
 	reg = &regs[regno];
-	rw64 = bpf_is_reg64(insn, regno, reg, t);
 	if (t == SRC_OP) {
 		/* check whether register used as source operand can be read */
 		if (reg->type == NOT_INIT) {
@@ -3156,9 +3135,6 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 		if (regno == BPF_REG_FP)
 			return 0;
 
-		if (rw64)
-			mark_insn_zext(env, reg);
-
 		return 0;
 	} else {
 		/* check whether register used as dest operand can be written to */
@@ -3166,7 +3142,6 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 			verbose(env, "frame pointer is read only\n");
 			return -EACCES;
 		}
-		reg->subreg_def = rw64 ? DEF_NOT_SUBREG : env->insn_idx + 1;
 		if (t == DST_OP)
 			mark_reg_unknown(env, regs, regno);
 	}
@@ -3822,11 +3797,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
 			if (size <= spill_size &&
 			    bpf_stack_narrow_access_ok(off, size, spill_size)) {
-				/* The earlier check_reg_arg() has decided the
-				 * subreg_def for this insn.  Save it first.
-				 */
-				s32 subreg_def = state->regs[dst_regno].subreg_def;
-
 				if (env->bpf_capable && size == 4 && spill_size == 4 &&
 				    get_reg_width(reg) <= 32)
 					/* Ensure stack slot has an ID to build a relation
@@ -3834,7 +3804,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					 */
 					assign_scalar_id_before_mov(env, reg);
 				state->regs[dst_regno] = *reg;
-				state->regs[dst_regno].subreg_def = subreg_def;
 
 				/* Break the relation on a narrowing fill.
 				 * coerce_reg_to_size will adjust the boundaries.
@@ -6271,12 +6240,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			} else {
 				mark_reg_known_zero(env, regs,
 						    value_regno);
-				/* A load of ctx field could have different
-				 * actual load size with the one encoded in the
-				 * insn. When the dst is PTR, it is for sure not
-				 * a sub-register.
-				 */
-				regs[value_regno].subreg_def = DEF_NOT_SUBREG;
 				if (base_type(info.reg_type) == PTR_TO_BTF_ID) {
 					regs[value_regno].btf = info.btf;
 					regs[value_regno].btf_id = info.btf_id;
@@ -7380,10 +7343,6 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			if (spi < 0)
 				return spi;
 
-			/*
-			 * For CONST_PTR_TO_DYNPTR, reg is already scratched by check_reg_arg
-			 * in check_helper_call and mark_btf_func_reg_size in check_kfunc_call.
-			 */
 			mark_stack_slots_scratched(env, spi, BPF_DYNPTR_NR_SLOTS);
 
 			reg = &state->stack[spi].spilled_ptr;
@@ -9463,7 +9422,6 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
 		if (!subprog_returns_void(env, subprog)) {
 			mark_reg_unknown(env, caller->regs, BPF_REG_0);
-			caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
 		}
 
 		if (env->subprog_info[subprog].might_throw) {
@@ -10482,9 +10440,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 	invalidate_outgoing_stack_args(env, cur_func(env));
 
-	/* helper call returns 64-bit value. */
-	regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
-
 	/* update return register (already marked as written above) */
 	ret_type = fn->ret_type;
 	ret_flag = type_flag(ret_type);
@@ -10722,30 +10677,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	return 0;
 }
 
-/* mark_btf_func_reg_size() is used when the reg size is determined by
- * the BTF func_proto's return value size and argument.
- */
-static void __mark_btf_func_reg_size(struct bpf_verifier_env *env, struct bpf_reg_state *regs,
-				     u32 regno, size_t reg_size)
-{
-	struct bpf_reg_state *reg = &regs[regno];
-
-	if (regno == BPF_REG_0) {
-		/* Function return value */
-		reg->subreg_def = reg_size == sizeof(u64) ?
-			DEF_NOT_SUBREG : env->insn_idx + 1;
-	} else if (reg_size == sizeof(u64)) {
-		/* Function argument */
-		mark_insn_zext(env, reg);
-	}
-}
-
-static void mark_btf_func_reg_size(struct bpf_verifier_env *env, u32 regno,
-				   size_t reg_size)
-{
-	return __mark_btf_func_reg_size(env, cur_regs(env), regno, reg_size);
-}
-
 static bool is_kfunc_acquire(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ACQUIRE;
@@ -12974,7 +12905,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
 	int err, insn_idx = *insn_idx_p;
-	const struct btf_param *args;
 	u32 i, nargs, ptr_type_id;
 	struct btf *desc_btf;
 	int id;
@@ -13018,7 +12948,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			verbose(env, "failed to mark s32 range for retval in forked state for lock\n");
 			return err;
 		}
-		__mark_btf_func_reg_size(env, regs, BPF_REG_0, sizeof(u32));
 	} else if (!insn->off && insn->imm == special_kfunc_list[KF___bpf_trap]) {
 		verbose(env, "unexpected __bpf_trap() due to uninitialized variable?\n");
 		return -EFAULT;
@@ -13168,7 +13097,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		u32 regno = caller_saved[i];
 
 		bpf_mark_reg_not_init(env, &regs[regno]);
-		regs[regno].subreg_def = DEF_NOT_SUBREG;
 	}
 	invalidate_outgoing_stack_args(env, cur_func(env));
 
@@ -13190,7 +13118,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		if (meta.btf == btf_vmlinux && (meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
 		    meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
 			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
-		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
 	} else if (btf_type_is_ptr(t)) {
 		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
 		err = check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc_btf);
@@ -13281,7 +13208,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
-		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
 			id = acquire_reference(env, insn_idx, 0);
 			if (id < 0)
@@ -13318,18 +13244,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			caller_info->stack_arg_cnt = stack_arg_cnt;
 	}
 
-	args = (const struct btf_param *)(meta.func_proto + 1);
-	for (i = 0; i < min_t(int, nargs, MAX_BPF_FUNC_REG_ARGS); i++) {
-		u32 regno = i + 1;
-
-		t = btf_type_skip_modifiers(desc_btf, args[i].type, NULL);
-		if (btf_type_is_ptr(t))
-			mark_btf_func_reg_size(env, regno, sizeof(void *));
-		else
-			/* scalar. ensured by check_kfunc_args() */
-			mark_btf_func_reg_size(env, regno, t->size);
-	}
-
 	if (bpf_is_iter_next_kfunc(&meta)) {
 		err = process_iter_next_call(env, insn_idx, &meta);
 		if (err)
@@ -14823,14 +14737,14 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		if (dst_reg->type != PTR_TO_ARENA)
 			*dst_reg = *src_reg;
 
-		dst_reg->subreg_def = env->insn_idx + 1;
-
-		if (BPF_CLASS(insn->code) == BPF_ALU64)
+		if (BPF_CLASS(insn->code) == BPF_ALU64) {
 			/*
 			 * 32-bit operations zero upper bits automatically.
 			 * 64-bit operations need to be converted to 32.
 			 */
 			aux->needs_zext = true;
+			aux->zext_dst = true;
+		}
 
 		/* Any arithmetic operations are allowed on arena pointers */
 		return 0;
@@ -14969,6 +14883,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
+	struct bpf_insn_aux_data *aux = cur_aux(env);
 	struct bpf_reg_state *regs = cur_regs(env);
 	u8 opcode = BPF_OP(insn->code);
 	int err;
@@ -15026,18 +14941,14 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				if (insn->imm) {
 					/* off == BPF_ADDR_SPACE_CAST */
 					mark_reg_unknown(env, regs, insn->dst_reg);
-					if (insn->imm == 1) { /* cast from as(1) to as(0) */
+					if (insn->imm == 1) /* cast from as(1) to as(0) */
 						dst_reg->type = PTR_TO_ARENA;
-						/* PTR_TO_ARENA is 32-bit */
-						dst_reg->subreg_def = env->insn_idx + 1;
-					}
 				} else if (insn->off == 0) {
 					/* case: R1 = R2
 					 * copy register state to dest reg
 					 */
 					assign_scalar_id_before_mov(env, src_reg);
 					*dst_reg = *src_reg;
-					dst_reg->subreg_def = DEF_NOT_SUBREG;
 				} else {
 					/* case: R1 = (s8, s16 s32)R2 */
 					if (is_pointer_value(env, insn->src_reg)) {
@@ -15055,7 +14966,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						if (!no_sext)
 							clear_scalar_id(dst_reg);
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
-						dst_reg->subreg_def = DEF_NOT_SUBREG;
 					} else {
 						mark_reg_unknown(env, regs, insn->dst_reg);
 					}
@@ -15080,7 +14990,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						 */
 						if (!is_src_reg_u32)
 							clear_scalar_id(dst_reg);
-						dst_reg->subreg_def = env->insn_idx + 1;
 					} else {
 						/* case: W1 = (s8, s16)W2 */
 						bool no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
@@ -15090,7 +14999,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						*dst_reg = *src_reg;
 						if (!no_sext)
 							clear_scalar_id(dst_reg);
-						dst_reg->subreg_def = env->insn_idx + 1;
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
 					}
 				} else {
@@ -15959,12 +15867,8 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			continue;
 		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
 		    reg->delta == known_reg->delta) {
-			s32 saved_subreg_def = reg->subreg_def;
-
 			*reg = *known_reg;
-			reg->subreg_def = saved_subreg_def;
 		} else {
-			s32 saved_subreg_def = reg->subreg_def;
 			s32 saved_off = reg->delta;
 			u32 saved_id = reg->id;
 
@@ -15974,12 +15878,11 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			/* reg = known_reg; reg += delta */
 			*reg = *known_reg;
 			/*
-			 * Must preserve off, id and subreg_def flag,
-			 * otherwise another sync_linked_regs() will be incorrect.
+			 * Must preserve off and id, otherwise another sync_linked_regs()
+			 * will be incorrect.
 			 */
 			reg->delta = saved_off;
 			reg->id = saved_id;
-			reg->subreg_def = saved_subreg_def;
 
 			scalar32_min_max_add(reg, &fake_reg);
 			scalar_min_max_add(reg, &fake_reg);
@@ -16414,8 +16317,6 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	 * Already marked as written above.
 	 */
 	mark_reg_unknown(env, regs, BPF_REG_0);
-	/* ld_abs load up to 32-bit skb data. */
-	regs[BPF_REG_0].subreg_def = env->insn_idx + 1;
 	/*
 	 * See bpf_gen_ld_abs() which emits a hidden BPF_EXIT with r0=0
 	 * which must be explored by the verifier when in a subprog.

-- 
2.53.0
