Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8384443E41
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136407; cv=none; b=dziAJHPEOWxFQcnlfAp8yXBBIHrOGOcbIG9ZdQhNFukmEHDIh5SW/TBXzD1agzB2Q5AKdpVjZBReAXlva3PMn+ku4wRFdFWi259rAdOfwGp28bu9YqDBfgq0tzA7K6Ud80fh0QVqoGHBEUa/7ucRS6HdvAwujDoL9mwLKlHRLG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136407; c=relaxed/simple;
	bh=s5LQIFp/EQ4hPJQjUEL8quufpnd1wJ7BD6BMGRP74/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwmjW/3nHCCZ4mTu8H2QBAL8OG0oJtyd5zPdS6tmMpWC7LmBnSg7jz129fpjXPu6mURaQFJwZvewSimKSzwZXYfXY2Bt1xQXUTCNDEp1JA8L5djQ4gO2CPwIiCqAvq09F+20d6DDwTJ7x8f+tsoPbml5LxNRCxa5QIA+0xGib+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMtF+kJY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMtF+kJY"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e88b60121so3264093a91.3
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786136405; x=1786741205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y73u8qHwY5BW1e5hGkmnTGk1qhIOpMOQp5WnBWwro88=;
        b=NMtF+kJYSgAxYHCbveVA4495K6v+crqXomgGa0bzNtUc8VwapRwPymCU0/zqM6t3Vi
         fOe/TOx2XHvbBzoSMOGx9oFaRs1p4JkCYqAt1fVvzpiLJ78vQYWYA7d+6Cdvqtwd+pZF
         6vlVc9MOFEBxFGMApi5OlhA7hrYFrXNZnSxTKHUvPzKDvEgFrDwZT5FHu9USCxRoV1an
         g33tkTs1cjS64j20Tj6TGAmMyvmsgLX7wykwvF4uy+PXKxObLKYrOBxHdfoFCAOOEEBO
         f/2gaRxctDI2mXl4HWncfgsxJnRXprmVfGoeNyoqPcnPCdKyQF8r9Dl6Giw5rys2VfWQ
         8oRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136405; x=1786741205;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y73u8qHwY5BW1e5hGkmnTGk1qhIOpMOQp5WnBWwro88=;
        b=XvPC/rDPXtj1MQ3o9I7qaufTyrOTWO8NVUZTt0q/WUTopfgsIQtyKGSPMrmMWyYvef
         f/E+lcLKyElA673X2mwgzMMFzHEibwZjEgmuiwDMlhjGc0WyyHcYWddQKxyyxKTdQ8jC
         mLJBWN3Bee4sn+4+lhiM6MohPctPBVVWZoJfyDjYozSez9sY2qMNSdW7596DD8GDnzJ4
         yuDUiqcsUcbwGG0w/PxrjHY85zz73j0ZiuXJlsVB3RTmB0KEKfEoHP6/yR23eRH+GGMi
         8A829gyq6+0DHLb9UzEHAUGEmKvBB9YkejrN+wb0yf3eT+22Bi32VMDFotnuC/+GaEsU
         /yKw==
X-Gm-Message-State: AOJu0Yw23UYLacO8b4AXbCQQciI82M68uruzl7JGhYwwkvcINcPbzdDO
	WIFZ2xBUfb5Qc7Gh8QsS6F7yfsq7MO2vruPw/Bj6PGCNJOFmVb0JaKGb4uofJsgU
X-Gm-Gg: AR+sD12Q8biuS7Mav3lUg8uPMt5xf097LW/pkDXv/PVYOmUupmT4LQkYbKY1PAe7EEp
	CRFaPPSzVC5LBS8rEVkvxU7MvFnQlfuZjuVOvn14hHVGNs++pMC3SO8/dDWWUX8Tp1jXtX8SO5V
	fZAk/Our/DynKZ68jUOFd0tc7e3BKrLxjxDaWICu6WdEv/D2dZ6plGMGHyspEEY9vNJ5FJammTj
	YtgQRiLIscKhbvlmonrF7sTWn+kaLWEVTQ4Yg/zmCS10szO9RdDYabQ9rdxwA/G8KYVXXFYntiO
	pM8LT9DI5OVYb1sNV9mTr66fcoQdVOT7iCVSw11olBHT1cc3cZiwCdS/xEnXiYLSrlBp0ionMC7
	eTjE7bjHXRf/+LvGeE+8irUanOK4fv97jX2JYyM2vOrPWIbPYdLzINjsmLL/3AEmguRycJQZ7VC
	9fYdk7Wgx1pt4NjUPSeTp8UiGVMdSf6sR5wX5EMuM16zomb1dZxt7SSvIaSSnawyNztDCl6CJhr
	78fewLxD29L22dFGnVblURS73iqer3oNK2VC2gzQcRG0T+2cnD2rds=
X-Received: by 2002:a17:90b:5408:b0:38e:659b:f366 with SMTP id 98e67ed59e1d1-39281cda75fmr2797368a91.0.1786136404838;
        Fri, 07 Aug 2026 14:00:04 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1cba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4244sm9799783c88.4.2026.08.07.14.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:00:04 -0700 (PDT)
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
	gimm78064@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next v4 5/7] bpf: infer zext_dst based on static register liveness analysis
Date: Fri,  7 Aug 2026 13:59:34 -0700
Message-ID: <20260807-static-zext-v4-5-b6c270013c77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
References: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
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
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   7 +--
 kernel/bpf/fixups.c          |  27 +++++++----
 kernel/bpf/liveness.c        |  14 ++++++
 kernel/bpf/verifier.c        | 112 +++----------------------------------------
 4 files changed, 38 insertions(+), 122 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a2a40caca0a0..2c74d676ede9 100644
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
@@ -1637,7 +1632,6 @@ struct bpf_kfunc_desc_tab {
 };
 
 /* Functions exported from verifier.c, used by fixups.c */
-bool bpf_is_reg64(struct bpf_insn *insn, u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t);
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len);
 void bpf_mark_subprog_exc_cb(struct bpf_verifier_env *env, int subprog);
 bool bpf_allow_tail_call_in_subprogs(struct bpf_verifier_env *env);
@@ -1661,5 +1655,6 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
 int bpf_jit_subprogs(struct bpf_verifier_env *env);
 int bpf_fixup_call_args(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
+int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index d2ff416d7ad6..447c54828cb9 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -68,8 +68,8 @@ static int insn_def_regno(const struct bpf_insn *insn)
  * code only. It returns TRUE if the source or destination register operates
  * on 64-bit, otherwise return FALSE.
  */
-bool bpf_is_reg64(struct bpf_insn *insn,
-		  u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t)
+static bool bpf_is_reg64(struct bpf_prog *prog, struct bpf_insn *insn,
+			 u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t)
 {
 	u8 code, class, op;
 
@@ -103,6 +103,10 @@ bool bpf_is_reg64(struct bpf_insn *insn,
 	if (class == BPF_ALU64 && op == BPF_END && (insn->imm == 16 || insn->imm == 32))
 		return false;
 
+	/* address space casts converted to BPF_ALU, see bpf_do_misc_fixups() */
+	if (is_addr_space_cast32(prog, insn))
+		return false;
+
 	if (class == BPF_ALU64 || class == BPF_JMP ||
 	    (class == BPF_ALU && op == BPF_END && insn->imm == 64))
 		return true;
@@ -154,15 +158,18 @@ bool bpf_is_reg64(struct bpf_insn *insn,
 	return true;
 }
 
-/* Return TRUE if INSN has defined any 32-bit value explicitly. */
-static bool insn_has_def32(struct bpf_insn *insn)
+/*
+ * Return the 32-bit subregister defined by INSN, or -1 if INSN does not
+ * explicitly define a 32-bit value.
+ */
+int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn)
 {
 	int dst_reg = insn_def_regno(insn);
 
-	if (dst_reg == -1)
-		return false;
+	if (dst_reg < 0 || bpf_is_reg64(prog, insn, dst_reg, NULL, DST_OP))
+		return -1;
 
-	return !bpf_is_reg64(insn, dst_reg, NULL, DST_OP);
+	return dst_reg;
 }
 
 static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
@@ -279,7 +286,7 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	 * (cnt == 1) is taken or not. There is no guarantee INSN at OFF is the
 	 * original insn at old prog.
 	 */
-	data[off].zext_dst = insn_has_def32(insn + off + cnt - 1);
+	data[off].zext_dst = bpf_insn_def32(new_prog, insn + off + cnt - 1) >= 0;
 
 	if (cnt == 1)
 		return;
@@ -291,7 +298,7 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	for (i = off; i < off + cnt - 1; i++) {
 		/* Expand insni[off]'s seen count to the patched range. */
 		data[i].seen = old_seen;
-		data[i].zext_dst = insn_has_def32(insn + i);
+		data[i].zext_dst = bpf_insn_def32(new_prog, insn + i) >= 0;
 	}
 
 	/*
@@ -730,7 +737,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 			 *       BPF_STX + SRC_OP, so it is safe to pass NULL
 			 *       here.
 			 */
-			if (bpf_is_reg64(&insn, load_reg, NULL, DST_OP)) {
+			if (bpf_is_reg64(env->prog, &insn, load_reg, NULL, DST_OP)) {
 				if (class == BPF_LD &&
 				    BPF_MODE(code) == BPF_IMM)
 					i++;
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index edfc2480b0f0..ef9a5a922887 100644
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
+		int def32 = bpf_insn_def32(env->prog, &insns[i]);
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
index cc97f008d977..14f751645874 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2132,12 +2132,9 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
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
 
@@ -2213,7 +2210,6 @@ static int mark_btf_ld_reg(struct bpf_verifier_env *env,
 	}
 }
 
-#define DEF_NOT_SUBREG	(0)
 static void init_reg_state(struct bpf_verifier_env *env,
 			   struct bpf_func_state *state)
 {
@@ -2222,7 +2218,6 @@ static void init_reg_state(struct bpf_verifier_env *env,
 
 	for (i = 0; i < MAX_BPF_REG; i++) {
 		bpf_mark_reg_not_init(env, &regs[i]);
-		regs[i].subreg_def = DEF_NOT_SUBREG;
 	}
 
 	/* frame pointer */
@@ -3058,30 +3053,14 @@ static void mark_stack_slots_scratched(struct bpf_verifier_env *env,
 		mark_stack_slot_scratched(env, spi - i);
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
@@ -3092,9 +3071,6 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 		if (regno == BPF_REG_FP)
 			return 0;
 
-		if (rw64)
-			mark_insn_zext(env, reg);
-
 		return 0;
 	} else {
 		/* check whether register used as dest operand can be written to */
@@ -3102,7 +3078,6 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 			verbose(env, "frame pointer is read only\n");
 			return -EACCES;
 		}
-		reg->subreg_def = rw64 ? DEF_NOT_SUBREG : env->insn_idx + 1;
 		if (t == DST_OP)
 			mark_reg_unknown(env, regs, regno);
 	}
@@ -3758,11 +3733,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 
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
@@ -3770,7 +3740,6 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 					 */
 					assign_scalar_id_before_mov(env, reg);
 				state->regs[dst_regno] = *reg;
-				state->regs[dst_regno].subreg_def = subreg_def;
 
 				/* Break the relation on a narrowing fill.
 				 * coerce_reg_to_size will adjust the boundaries.
@@ -6221,12 +6190,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
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
@@ -7325,10 +7288,6 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 			if (spi < 0)
 				return spi;
 
-			/*
-			 * For CONST_PTR_TO_DYNPTR, reg is already scratched by check_reg_arg
-			 * in check_helper_call and mark_btf_func_reg_size in check_kfunc_call.
-			 */
 			mark_stack_slots_scratched(env, spi, BPF_DYNPTR_NR_SLOTS);
 
 			reg = &state->stack[spi].spilled_ptr;
@@ -9432,7 +9391,6 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
 		if (!subprog_returns_void(env, subprog)) {
 			mark_reg_unknown(env, caller->regs, BPF_REG_0);
-			caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
 		}
 
 		if (env->subprog_info[subprog].might_throw) {
@@ -10452,9 +10410,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 	invalidate_outgoing_stack_args(env, cur_func(env));
 
-	/* helper call returns 64-bit value. */
-	regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
-
 	/* update return register (already marked as written above) */
 	ret_type = fn->ret_type;
 	ret_flag = type_flag(ret_type);
@@ -10694,30 +10649,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -12936,7 +12867,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
 	int err, insn_idx = *insn_idx_p;
-	const struct btf_param *args;
 	u32 i, nargs, ptr_type_id;
 	struct bpf_kfunc_desc *desc;
 	struct btf *desc_btf;
@@ -12988,7 +12918,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			verbose(env, "failed to mark s32 range for retval in forked state for lock\n");
 			return err;
 		}
-		__mark_btf_func_reg_size(env, regs, BPF_REG_0, sizeof(u32));
 	} else if (!insn->off && insn->imm == special_kfunc_list[KF___bpf_trap]) {
 		verbose(env, "unexpected __bpf_trap() due to uninitialized variable?\n");
 		return -EFAULT;
@@ -13141,7 +13070,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		u32 regno = caller_saved[i];
 
 		bpf_mark_reg_not_init(env, &regs[regno]);
-		regs[regno].subreg_def = DEF_NOT_SUBREG;
 	}
 	invalidate_outgoing_stack_args(env, cur_func(env));
 
@@ -13163,7 +13091,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		if (meta.btf == btf_vmlinux && (meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
 		    meta.func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
 			__mark_reg_const_zero(env, &regs[BPF_REG_0]);
-		mark_btf_func_reg_size(env, BPF_REG_0, t->size);
 	} else if (btf_type_is_ptr(t)) {
 		ptr_type = btf_type_skip_modifiers(desc_btf, t->type, &ptr_type_id);
 		err = check_special_kfunc(env, &meta, regs, insn_aux, ptr_type, desc_btf);
@@ -13254,7 +13181,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
-		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
 			id = acquire_reference(env, insn_idx, 0);
 			if (id < 0)
@@ -13291,18 +13217,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -14796,14 +14710,14 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
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
@@ -14999,18 +14913,14 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
@@ -15028,7 +14938,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						if (!no_sext)
 							clear_scalar_id(dst_reg);
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
-						dst_reg->subreg_def = DEF_NOT_SUBREG;
 					} else {
 						mark_reg_unknown(env, regs, insn->dst_reg);
 					}
@@ -15053,7 +14962,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						 */
 						if (!is_src_reg_u32)
 							clear_scalar_id(dst_reg);
-						dst_reg->subreg_def = env->insn_idx + 1;
 					} else {
 						/* case: W1 = (s8, s16)W2 */
 						bool no_sext = reg_umax(src_reg) < (1ULL << (insn->off - 1));
@@ -15063,7 +14971,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						*dst_reg = *src_reg;
 						if (!no_sext)
 							clear_scalar_id(dst_reg);
-						dst_reg->subreg_def = env->insn_idx + 1;
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
 					}
 				} else {
@@ -15932,12 +15839,8 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
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
 
@@ -15947,12 +15850,11 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
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
@@ -16387,8 +16289,6 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
