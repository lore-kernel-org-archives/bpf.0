Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1831F998
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785546612; cv=none; b=Rq/utfFahyMkCuM93PiFQ2vsIP9hXkVjCJulqKZtgfFcvZtaz+ru180qBig6aUC+Lg9T+jJzKx4O7OxQdL+WxFdHlO+c1T6EOVdmR5F0D/3iE+cT09hQ+Cpbz20s6OTO0+PqvIGeAJ5GrkX+t3yLHufamP8WkNi1zGdBETMuqo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785546612; c=relaxed/simple;
	bh=eDG75osHjWzj7WtHyZ4MKP/D0hK/rtulvQjFoDZ4EX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQrz4dKZtCoi9TJfIksknKUQGRs+HHr3dpG8EYOsmKHtlIG372iXshrFM0JjhnPfvwBpwtK8JisFEhmsWEacWsG86u72WL04ntqcKBo5jLD6I3Zl9ExC9zde1R36b7L7RHG1cmT98XBQNLADQfXqSokiLFbJpuFMhbqhzSGPVIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKxadRNE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKxadRNE"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c999f162c9aso1034485a12.3
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 18:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785546611; x=1786151411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tl1v2cOXxh3pCVKKs82CYG3I2NpwbtE/ap0rAmIrZdA=;
        b=lKxadRNEm/hr5WMmbdwHvqH3WVwXMJD+ZfmSUgBWEzSkTzUJ5dBzWxU3SfGcB5de80
         cZSEnsm6pXrsR7oE4LtcNCoNsJ5AK9bt3cTcUEp/xKMoElhmxnxxLZ5zOHFH+TCVX5n6
         /AjVNV9nqP+UFS9hAVaue90keLcOM8RVYL9qmdK8wNrYjPfwb98y1GS0LXqNC4w4Gxwe
         ZNnZbjFxyQJpm1nVVuS6Ndb8X3MmIIIKGa9wvmLjluUUyll9RLLKgE7VRw/diUdRm5o3
         7EQEng8uL5ZQbF825T3F64JS7hE9wasV200yfmqIhmm2sONwntLYNGCm/TtSmAK65kx0
         MjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785546611; x=1786151411;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tl1v2cOXxh3pCVKKs82CYG3I2NpwbtE/ap0rAmIrZdA=;
        b=gmegecv27xRdK27aTfcfBasTTrypT/E4elnUoUKiGN36WCJ3wEE6osVKA5xPQNpbEn
         e4kfOXpkzjP2UP8Q6dc7vLWl92eVhYx8+eYGrs9hH3PkrvuZyfaa2igXqY0DDfWqZuCV
         B+imay0+VQzP8RV1u/GKvYtlIZTNe744cw22IIhooG0d3ptYib1byX0QwbJaPc614pqb
         lN6MK3QfQBbWNehbQqki6BcXvieO8CR4M76LTmoUS5vjbG7L9iuxn1wFe7uZvoL2NbV5
         emGBlzivnXj1ax7eB5rh310wTHq1ekoQ9dgNa8rswmF2O2jrrDmJ1eDoMtUvcxgZ05Ws
         qMpw==
X-Gm-Message-State: AOJu0YxPEqKFL/cRXv6zIagLhsWoJRYuQI4bx4BHVdHFhjvcizIqkkMV
	rQqlu+5vm7tSpmD6iNvFXRg+5JhtqbccKdxE1drouhb9RzwZFz+4jm4V7WlPzsag
X-Gm-Gg: AR+sD11KWlSxahKKUidF2PLrutFmq2VPFAT3Pswu379p1oL6sJGjtALQ9d4iuCfL3Pj
	GZRHVBsL9IRaJ/TdqPDuvJXi+s8aV9yp6F/wORMV1NWd2kQ8SGoCvAVuPA1PTJFYwqOMjFRWwkN
	AIxV9x1gS+mPyF5KfqfIO3duP3c9yWGZOnwv0/s810mCjdIzbHvRIOR9qA17Mj7KwAzycCULXzA
	DOB0oIkTleTXnBQWlp3k9l1uj25ta59Ym4KmBYQdcB7MWUrFhV6aL9ZYu07Zgg+S/Px1VDIA1rz
	JWdu+wq0C3M8DcHjzZNjNcl5qfyDP8cqyJMDpv/KRJmieTJtypVqb8Ar9v3a+y/PYCIxM2cIaRj
	1TY3v7ApnzFwA4vxLAaqW9PCSscdST/WQi9xK4jTHdjJO05h8qmm9oROndTFCDMBaU+zt0U8fRS
	u7lGG2RSV9D3kZio9q8TDIaqDPV+i/+b8UhpwD8Ds2fkNm5/OpsiOJRO4Uepp0iTgzICcBBFCy7
	8ZHw/RE/vsd0a9AGKPewsBrxXF66Np07aETvy3LfMBtgQ==
X-Received: by 2002:a05:6a21:103:b0:3c0:9c1a:8943 with SMTP id adf61e73a8af0-3c92a9a285dmr1569422637.75.1785546610871;
        Fri, 31 Jul 2026 18:10:10 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:7346])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e29a126sm11234052eec.31.2026.07.31.18.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 18:10:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 4/5] bpf: simplify the bpf_is_reg64()
Date: Fri, 31 Jul 2026 18:09:52 -0700
Message-ID: <20260731-static-zext-v2-4-da4aa161e8c5@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

After the previous commit bpf_is_reg64() is only used in a context
where destination register's property is queried, and only for
instructions for which insn_def_regno() >= 0.
Hence, simplify the function by:
- removing unused parameters;
- removing code paths considering BPF_JMP{,32} instructions;
- streamlining the condition expressions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 -
 kernel/bpf/fixups.c          | 40 +++++++++++++++++++-
 kernel/bpf/verifier.c        | 90 --------------------------------------------
 3 files changed, 38 insertions(+), 93 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 66f506535cbd..2dbbd51cb923 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1628,7 +1628,6 @@ struct bpf_kfunc_desc_tab {
 };
 
 /* Functions exported from verifier.c, used by fixups.c */
-bool bpf_is_reg64(struct bpf_insn *insn, u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t);
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len);
 void bpf_mark_subprog_exc_cb(struct bpf_verifier_env *env, int subprog);
 bool bpf_allow_tail_call_in_subprogs(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6125598d16a8..ac0a388b4021 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -44,6 +44,42 @@ static int insn_def_regno(const struct bpf_insn *insn)
 	}
 }
 
+/*
+ * For use only in combination with insn_def_regno() >= 0.
+ * Returns TRUE if the destination register operates on 64-bit,
+ * otherwise return FALSE.
+ */
+static bool bpf_is_reg64(struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 mode = BPF_MODE(insn->code);
+	u8 size = BPF_SIZE(insn->code);
+	u8 op = BPF_OP(insn->code);
+
+	/* subregister endiness swap */
+	if ((class == BPF_ALU || class == BPF_ALU64) && op == BPF_END && insn->imm != 64)
+		return false;
+
+	/* w0 += 1 */
+	if (class == BPF_ALU && op != BPF_END)
+		return false;
+
+	/* non 64-bit loads */
+	if (class == BPF_LDX && mode == BPF_MEM && size != BPF_DW)
+		return false;
+
+	/* atomics, see insn_def_regno() */
+	if (class == BPF_STX && size != BPF_DW)
+		return false;
+
+	/* both LD_IND and LD_ABS return 32-bit data. */
+	if (class == BPF_LD && (mode == BPF_IND || mode == BPF_ABS))
+		return false;
+
+	/* Conservatively return true at default. */
+	return true;
+}
+
 /*
  * Return the 32-bit subregister defined by INSN, or -1 if INSN does not
  * explicitly define a 32-bit value.
@@ -52,7 +88,7 @@ int bpf_insn_def32(struct bpf_insn *insn)
 {
 	int dst_reg = insn_def_regno(insn);
 
-	if (dst_reg < 0 || bpf_is_reg64(insn, dst_reg, NULL, DST_OP))
+	if (dst_reg < 0 || bpf_is_reg64(insn))
 		return -1;
 
 	return dst_reg;
@@ -623,7 +659,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 			 *       BPF_STX + SRC_OP, so it is safe to pass NULL
 			 *       here.
 			 */
-			if (bpf_is_reg64(&insn, load_reg, NULL, DST_OP)) {
+			if (bpf_is_reg64(&insn)) {
 				if (class == BPF_LD &&
 				    BPF_MODE(code) == BPF_IMM)
 					i++;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0709dded013e..c3cddaec953b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3027,96 +3027,6 @@ static void mark_stack_slots_scratched(struct bpf_verifier_env *env,
 		mark_stack_slot_scratched(env, spi - i);
 }
 
-/* This function is supposed to be used by the following 32-bit optimization
- * code only. It returns TRUE if the source or destination register operates
- * on 64-bit, otherwise return FALSE.
- */
-bool bpf_is_reg64(struct bpf_insn *insn,
-	      u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t)
-{
-	u8 code, class, op;
-
-	code = insn->code;
-	class = BPF_CLASS(code);
-	op = BPF_OP(code);
-	if (class == BPF_JMP) {
-		/* BPF_EXIT for "main" will reach here. Return TRUE
-		 * conservatively.
-		 */
-		if (op == BPF_EXIT)
-			return true;
-		if (op == BPF_CALL) {
-			/* BPF to BPF call will reach here because of marking
-			 * caller saved clobber with DST_OP_NO_MARK for which we
-			 * don't care the register def because they are anyway
-			 * marked as NOT_INIT already.
-			 */
-			if (insn->src_reg == BPF_PSEUDO_CALL)
-				return false;
-			/* Helper call will reach here because of arg type
-			 * check, conservatively return TRUE.
-			 */
-			if (t == SRC_OP)
-				return true;
-
-			return false;
-		}
-	}
-
-	if (class == BPF_ALU64 && op == BPF_END && (insn->imm == 16 || insn->imm == 32))
-		return false;
-
-	if (class == BPF_ALU64 || class == BPF_JMP ||
-	    (class == BPF_ALU && op == BPF_END && insn->imm == 64))
-		return true;
-
-	if (class == BPF_ALU || class == BPF_JMP32)
-		return false;
-
-	if (class == BPF_LDX) {
-		if (t != SRC_OP)
-			return BPF_SIZE(code) == BPF_DW || BPF_MODE(code) == BPF_MEMSX;
-		/* LDX source must be ptr. */
-		return true;
-	}
-
-	if (class == BPF_STX) {
-		/* BPF_STX (including atomic variants) has one or more source
-		 * operands, one of which is a ptr. Check whether the caller is
-		 * asking about it.
-		 */
-		if (t == SRC_OP && reg->type != SCALAR_VALUE)
-			return true;
-		return BPF_SIZE(code) == BPF_DW;
-	}
-
-	if (class == BPF_LD) {
-		u8 mode = BPF_MODE(code);
-
-		/* LD_IMM64 */
-		if (mode == BPF_IMM)
-			return true;
-
-		/* Both LD_IND and LD_ABS return 32-bit data. */
-		if (t != SRC_OP)
-			return  false;
-
-		/* Implicit ctx ptr. */
-		if (regno == BPF_REG_6)
-			return true;
-
-		/* Explicit source could be any width. */
-		return true;
-	}
-
-	if (class == BPF_ST)
-		/* The only source register for BPF_ST is a ptr. */
-		return true;
-
-	/* Conservatively return true at default. */
-	return true;
-}
-
 static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *regs, u32 regno,
 			   enum bpf_reg_arg_type t)
 {

-- 
2.55.0
