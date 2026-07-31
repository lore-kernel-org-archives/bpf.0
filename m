Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009147A869
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524884; cv=none; b=Ycxi2l4tMWi0TricGIYhbBhd8UnnDyl3My5XBmAWsS5S3IsHrRfEcr12gJ6YJ8+RF8kXT/TZ9NRQXsG9/GfrGYN40TaMWwfGjKRgqkELJsJYIYBStOmwRfzAWbJQbn2yHgxNZiT4gfkBzsqDqXidTDJE2N62Zf5311af52gCPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524884; c=relaxed/simple;
	bh=zvhPncZ2a5cUqPjSDyRKl9XsOpRxybYFoVp+sk45WzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0EIaIacNoexOerpjkJAEicv9L5JjZEPeYpEVT6gfd8/vmqbSZo8hNCF2JS6rL7/xHNclsyEpLv4N00msctl0Tb8cx9d8MdoLvllo3mZsjtpk0OPmcrRyuFTqv4s+48eqGPYsw3XtexMCohpMswEz80Dy5QGpqtmvL9w/teq+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGZX46do; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGZX46do"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso924621a12.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785524882; x=1786129682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BEsSckxek0n5RbmafbosEMQ+22o2My3Y1CVLkKNk4/g=;
        b=iGZX46dokPDMnTuDUbNAF+Zh4lyvfq5IxytZUbwCN/YHe5VzCqveIC4diICl1ZFBFx
         bRsv43B4AIGZRTe3QEEEh0MgZd0sQwRCb8naDUz0xZFltX0MvA/2g1dzskWDPW/Cv+bu
         idoyIyQL9qWk+vF0Mc4mSopriEBc5pjRRZ2EpCNuoffd0D2F+AfwsgOnsrdZWUT85RUo
         fyDe5SWAwAR6C9uINvUb9A7FSe0NeOQcGzK8rPvWvQvbZqM8sxkfAecOebOsfmrmFIPX
         j+RQC9d/1y10Nr7MkapJqpfXD0mnVF4kBRI//5+5cIZV5ZhZ0XT99c103yYFiqNaaRTA
         gx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785524882; x=1786129682;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BEsSckxek0n5RbmafbosEMQ+22o2My3Y1CVLkKNk4/g=;
        b=DoDhstYlGgzTzZV2BOmYrWYWbuhWmK3fF5PtwcF9SZU1EikQ/XLOau4uzR4ZiLK74J
         7jRKpgGPPc2Heh5V2CxZdEjacgfAssZPNsGS9at95gCvS+Vcj5gvgyfGFl/yqmDIopdG
         T2RHMrVGKdGD/hPDRuCG778hy6hP111MYnOqD3+/wjHO4ryokqq/LQlmG4smivZ3j+SO
         YQf4A6/jsxp5mTjU8da6Ozfx9jYzCgBl7dU8HKBXcE0FCP/0/xkwsJUB54ARatSyZHIk
         wYz9oovaaCULjcduqOusMm7snAf6GvLeCx2EfuDtJI5AeJ4mIlF5padn6YobDNlnur5E
         ibmg==
X-Gm-Message-State: AOJu0Yy0pu4keaf48sph6DyGoRpMgG00dUYfea7yuGzVQg6IixrXpAqj
	zmDnH7pqtt7gDlXmVPqcZpFvo5984caaVzaTyK5pVT4l9MBCa1jDy2PjtKHVCyHT
X-Gm-Gg: AR+sD1049O5uZLZgA+/Va1u1pcC3KnHzvvDr7Yf11yPcmmaTwo58mY18yswtWDpYgH6
	p+SRhgvgzAWg9ELkEi4Izfr0l09s7hWmH3v+G9TAWaoTqIyFDVPGKZVToO9gsCofratQ6jvjORM
	QMIparfhByq7mI0vsEvk+UXEWGc5V1JbNgNwfWY9SBkARWSCkZ6bF30FyGEpRocjPrMuo7c0iHq
	iq+WqUfB0L/Oc6w41I4uup3FoEt8DhoEPu+hBW9JmSPvYe9qKSYeqOw90Wau8kf1BLsMK4g7i6P
	kxgbK7WTGO/r+seQ5EuDI4/zM0QpSh/C0hcBi3IPMX3HzDj3spGKD0hsmUpujgBMY4PlTVTnLCA
	gzKoAcpw+PS+KYZIYR/B80EFsqcZmmp6NRnvxVcwsUdmmLuyKBXz3Lcq6rQU5z/kwtKoZawJonI
	HuHtQ6zozaY9KB576Ni423cEcfXL+MP9xX9lWgIJU0ybtIlpQ2bji8D7jaga5Izj+Ld6/RPsuVl
	2kf8mrubzZEldgCSjX2mf8XrASqVqw3+G/LJvqkZhge
X-Received: by 2002:a05:6a20:cfa1:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3c92a5a9d5fmr911354637.8.1785524881748;
        Fri, 31 Jul 2026 12:08:01 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:7346])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab13255esm4815801c88.3.2026.07.31.12.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:08:01 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	iii@linux.ibm.com,
	gimm78064@gmail.com
Subject: [PATCH bpf-next 3/5] bpf: infer zext_dst based on static register liveness analysis
Date: Fri, 31 Jul 2026 12:07:44 -0700
Message-ID: <20260731-static-zext-v1-3-98a4dc73e94b@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
References: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
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
 kernel/bpf/verifier.c        | 105 +------------------------------------------
 4 files changed, 27 insertions(+), 115 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d4bffed94e0a..66f506535cbd 100644
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
@@ -1657,5 +1652,6 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
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
index c996b8a03e79..ea002550671a 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2258,6 +2258,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct insn_live_regs *state;
 	int insn_cnt = env->prog->len;
+	u64 pos, insn_pos;
 	int err = 0, i, j;
 	bool changed;
 
@@ -2317,9 +2318,18 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
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
@@ -2336,7 +2346,11 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
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
index 8304452edc0f..0709dded013e 100644
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
@@ -14823,8 +14737,6 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		if (dst_reg->type != PTR_TO_ARENA)
 			*dst_reg = *src_reg;
 
-		dst_reg->subreg_def = env->insn_idx + 1;
-
 		if (BPF_CLASS(insn->code) == BPF_ALU64)
 			/*
 			 * 32-bit operations zero upper bits automatically.
@@ -15028,8 +14940,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					mark_reg_unknown(env, regs, insn->dst_reg);
 					if (insn->imm == 1) { /* cast from as(1) to as(0) */
 						dst_reg->type = PTR_TO_ARENA;
-						/* PTR_TO_ARENA is 32-bit */
-						dst_reg->subreg_def = env->insn_idx + 1;
 					}
 				} else if (insn->off == 0) {
 					/* case: R1 = R2
@@ -15037,7 +14947,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					 */
 					assign_scalar_id_before_mov(env, src_reg);
 					*dst_reg = *src_reg;
-					dst_reg->subreg_def = DEF_NOT_SUBREG;
 				} else {
 					/* case: R1 = (s8, s16 s32)R2 */
 					if (is_pointer_value(env, insn->src_reg)) {
@@ -15055,7 +14964,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						if (!no_sext)
 							clear_scalar_id(dst_reg);
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
-						dst_reg->subreg_def = DEF_NOT_SUBREG;
 					} else {
 						mark_reg_unknown(env, regs, insn->dst_reg);
 					}
@@ -15080,7 +14988,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						 */
 						if (!is_src_reg_u32)
 							clear_scalar_id(dst_reg);
-						dst_reg->subreg_def = env->insn_idx + 1;
 					} else {
 						/* case: W1 = (s8, s16)W2 */
 						bool no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
@@ -15090,7 +14997,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						*dst_reg = *src_reg;
 						if (!no_sext)
 							clear_scalar_id(dst_reg);
-						dst_reg->subreg_def = env->insn_idx + 1;
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
 					}
 				} else {
@@ -15959,12 +15865,8 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
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
 
@@ -15974,12 +15876,11 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
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
@@ -16414,8 +16315,6 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	 * Already marked as written above.
 	 */
 	mark_reg_unknown(env, regs, BPF_REG_0);
-	/* ld_abs load up to 32-bit skb data. */
-	regs[BPF_REG_0].subreg_def = env->insn_idx + 1;
 	/*
 	 * See bpf_gen_ld_abs() which emits a hidden BPF_EXIT with r0=0
 	 * which must be explored by the verifier when in a subprog.

-- 
2.55.0
