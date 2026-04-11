Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F692D29C8
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775938176; cv=none; b=KhvPMVkqJ20pv0oy39GG4F8P3eXxv2MZS3nBtQ1z2T8jOgOfeSviypM+ueKyMKzLFcYvw7g1kx2Gq6b7dechXB3TgKqVhHf/Nvz5nmfxdoA81WRM3oxd+RjH3FTCiHa9pB1nb5vZjhhF4CsW0b2AFwLy6eSa13wC0TXebDML/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775938176; c=relaxed/simple;
	bh=m/WzxbyZu6dUFFu87GGychPTn9vBoeljsHJLtqlvukY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pZak07XL5uAYDJqT+oRRm5ymF/kkcwI8iJocJtNPo4bSlEx90Vjd6a0hlo51VmlLnWQJwoNkX7/gXGY/ubgAgAEU01PLLse5l6ZzmA3LBJzqGV6jqtdRy5PpxlrBgs6i6Y9ezz+dsB57AiBRsAr797CIySvAcf5JsisCDMx9wHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOnKmjQD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOnKmjQD"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82cf636dac8so1523893b3a.3
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 13:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775938174; x=1776542974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0GLdU4c2oHmoIZVPvT39T2jRN3VMUpKJO5RH9BprLs=;
        b=oOnKmjQDWNdw9rjwBzer3c1ofBwBxCOxObZHoYHqEecHYqTIVbrHX4SC9qFgE/4ze/
         cvgPxYyaeXHaz0ikBa75+iNpXEIs+wC2KuYz3TVOjXSK1CrLlyR1IZO9+61rIRFNuvbO
         m5lhZes1CF50zOqBTcNyBXr0AUg7xLDQlobVcKvdxVxwHOa9Jr9r84M3dftlSp1iFuoq
         5thjgMr95KXyUL3JzOSXQJIZmSnhOBI3/7Ph3N0NoF8mS3aB2n6M3TK8a+/iD3UfXAcT
         9ZiPDsDvEMTD5/Lwp22VHN6N+/5O4t3K+VcX5rlFsO4gBV0H8vC2DyDngTNHwpiQdkBV
         D73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775938174; x=1776542974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0GLdU4c2oHmoIZVPvT39T2jRN3VMUpKJO5RH9BprLs=;
        b=MPb4IpC7n3BTegxAWfeS2cbAKc81IOiXp+qalWKeu11i7a/JBAH+C+bvn6JcKLj1xu
         dkzbKHQFYmkn8WjGIqhSTb0O2D2N4CvesdcYEkqly8wUOGZaFwIBScuso6QJbqfBcgrZ
         iHfvlLlsQh80NLeW4F7Ttj4lgXDjjW51lbt7Ys0Gj9m9VtJjntCz200Hme/RpKIuOyrb
         c+ssMsoh7Bd45LEANTOd/VrFBeb85a8ymMLcaQpntuod68I7C50HjQK31srlk8YopCj5
         nlt1205j1Dye8AXdlRjenYSu2A29HoczPntaFA3VMD8Jox1Z6GeAamofFXCDBmzmp4BH
         BsIw==
X-Gm-Message-State: AOJu0YwvCCdpcuapNq4oCfCylxfRcXjmkNVx07OLdD+owLoD2l1B9Ie4
	Eq2Fy5tQu2CW0a8Aybb+RvpYGZUvP2Mg8tPgUyTW82zSd4OOt2YWOQ3TKcFiJw==
X-Gm-Gg: AeBDiesBbnggbK8UMZ4lAY0UZRnQPiftuA7OEruBetXaiE5nO6ud1HbIeVL6qNj9z2g
	eGZvrmblxfvJh+EfTEVUGM/AtLwU9A5zELeadroUreVcDZtW9/oxxA04GQl4RBJQoS8JFHV5oHi
	YnHC1+S6BJQ/70WNyBgfv76E9RS0/4HSUL8duFz99ndv9Mh+rckB6xvC4KHFny1duCy0RkL7YCA
	EqYkVglXxad5XOKHWUacWKrkbcx+2WPtSJsbffuEkZhk/QZK8m1Tewk1SYwsW31uOjgi798exCi
	M4CIOJPLMaN9ql8y4KGN7/av5XtTt87zxPElTx7iDWr6ivXlHl7ll5pVdk3pnPANeXCQ98Z/kUx
	W4IQSgzNuyAjbH3ev6VJ97c+EShp6w9lqa/HnE4VRCwCP2mLysq6MSM+xFiUMQ2w96qysetGgNQ
	hp0con5V0ZpnRXOVRWyU0B2xLv2YKWBFmhApzbigan5IffEy3htTMpj+2dhgeFWAvWzMDvDV9E8
	y4V61G5i7OtRjOOuf/saeHZ3AB2BPAQm3kjhbOBcDtlJRwca6gL5+p1hyDTaA==
X-Received: by 2002:a05:6a00:3914:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-82f0c28f038mr8002503b3a.14.1775938174163;
        Sat, 11 Apr 2026 13:09:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c32e744sm7270326b3a.13.2026.04.11.13.09.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Apr 2026 13:09:33 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v2 bpf-next] bpf: Move checks for reserved fields out of the main pass
Date: Sat, 11 Apr 2026 13:09:32 -0700
Message-ID: <20260411200932.41797-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Check reserved fields of each insn once in a prepass
instead of repeatedly rechecking them during the main verifier pass.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 347 ++++++++++--------
 .../selftests/bpf/verifier/junk_insn.c        |   2 +-
 2 files changed, 201 insertions(+), 148 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56fcc96dc780..974e46f04f18 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16782,23 +16782,6 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	int err;
 
 	if (opcode == BPF_END || opcode == BPF_NEG) {
-		if (opcode == BPF_NEG) {
-			if (BPF_SRC(insn->code) != BPF_K ||
-			    insn->src_reg != BPF_REG_0 ||
-			    insn->off != 0 || insn->imm != 0) {
-				verbose(env, "BPF_NEG uses reserved fields\n");
-				return -EINVAL;
-			}
-		} else {
-			if (insn->src_reg != BPF_REG_0 || insn->off != 0 ||
-			    (insn->imm != 16 && insn->imm != 32 && insn->imm != 64) ||
-			    (BPF_CLASS(insn->code) == BPF_ALU64 &&
-			     BPF_SRC(insn->code) != BPF_TO_LE)) {
-				verbose(env, "BPF_END uses reserved fields\n");
-				return -EINVAL;
-			}
-		}
-
 		/* check src operand */
 		err = check_reg_arg(env, insn->dst_reg, SRC_OP);
 		if (err)
@@ -16811,8 +16794,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		}
 
 		/* check dest operand */
-		if ((opcode == BPF_NEG || opcode == BPF_END) &&
-		    regs[insn->dst_reg].type == SCALAR_VALUE) {
+		if (regs[insn->dst_reg].type == SCALAR_VALUE) {
 			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
 			err = err ?: adjust_scalar_min_max_vals(env, insn,
 							 &regs[insn->dst_reg],
@@ -16826,38 +16808,17 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	} else if (opcode == BPF_MOV) {
 
 		if (BPF_SRC(insn->code) == BPF_X) {
-			if (BPF_CLASS(insn->code) == BPF_ALU) {
-				if ((insn->off != 0 && insn->off != 8 && insn->off != 16) ||
-				    insn->imm) {
-					verbose(env, "BPF_MOV uses reserved fields\n");
-					return -EINVAL;
-				}
-			} else if (insn->off == BPF_ADDR_SPACE_CAST) {
-				if (insn->imm != 1 && insn->imm != 1u << 16) {
-					verbose(env, "addr_space_cast insn can only convert between address space 1 and 0\n");
-					return -EINVAL;
-				}
+			if (insn->off == BPF_ADDR_SPACE_CAST) {
 				if (!env->prog->aux->arena) {
 					verbose(env, "addr_space_cast insn can only be used in a program that has an associated arena\n");
 					return -EINVAL;
 				}
-			} else {
-				if ((insn->off != 0 && insn->off != 8 && insn->off != 16 &&
-				     insn->off != 32) || insn->imm) {
-					verbose(env, "BPF_MOV uses reserved fields\n");
-					return -EINVAL;
-				}
 			}
 
 			/* check src operand */
 			err = check_reg_arg(env, insn->src_reg, SRC_OP);
 			if (err)
 				return err;
-		} else {
-			if (insn->src_reg != BPF_REG_0 || insn->off != 0) {
-				verbose(env, "BPF_MOV uses reserved fields\n");
-				return -EINVAL;
-			}
 		}
 
 		/* check dest operand, mark as required later */
@@ -16963,28 +16924,13 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			}
 		}
 
-	} else if (opcode > BPF_END) {
-		verbose(env, "invalid BPF_ALU opcode %x\n", opcode);
-		return -EINVAL;
-
 	} else {	/* all other ALU ops: and, sub, xor, add, ... */
 
 		if (BPF_SRC(insn->code) == BPF_X) {
-			if (insn->imm != 0 || (insn->off != 0 && insn->off != 1) ||
-			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
-				verbose(env, "BPF_ALU uses reserved fields\n");
-				return -EINVAL;
-			}
 			/* check src1 operand */
 			err = check_reg_arg(env, insn->src_reg, SRC_OP);
 			if (err)
 				return err;
-		} else {
-			if (insn->src_reg != BPF_REG_0 || (insn->off != 0 && insn->off != 1) ||
-			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
-				verbose(env, "BPF_ALU uses reserved fields\n");
-				return -EINVAL;
-			}
 		}
 
 		/* check src2 operand */
@@ -17921,12 +17867,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
 		int idx = *insn_idx;
 
-		if (insn->code != (BPF_JMP | BPF_JCOND) ||
-		    insn->src_reg != BPF_MAY_GOTO ||
-		    insn->dst_reg || insn->imm) {
-			verbose(env, "invalid may_goto imm %d\n", insn->imm);
-			return -EINVAL;
-		}
 		prev_st = find_prev_entry(env, cur_st->parent, idx);
 
 		/* branch out 'fallthrough' insn as a new state to explore */
@@ -17948,11 +17888,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 	dst_reg = &regs[insn->dst_reg];
 	if (BPF_SRC(insn->code) == BPF_X) {
-		if (insn->imm != 0) {
-			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
-			return -EINVAL;
-		}
-
 		/* check src1 operand */
 		err = check_reg_arg(env, insn->src_reg, SRC_OP);
 		if (err)
@@ -17971,10 +17906,6 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		if (dst_reg->type == PTR_TO_STACK)
 			insn_flags |= INSN_F_DST_REG_STACK;
 	} else {
-		if (insn->src_reg != BPF_REG_0) {
-			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
-			return -EINVAL;
-		}
 		src_reg = &env->fake_reg[0];
 		memset(src_reg, 0, sizeof(*src_reg));
 		src_reg->type = SCALAR_VALUE;
@@ -18162,10 +18093,6 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		verbose(env, "invalid BPF_LD_IMM insn\n");
 		return -EINVAL;
 	}
-	if (insn->off != 0) {
-		verbose(env, "BPF_LD_IMM64 uses reserved fields\n");
-		return -EINVAL;
-	}
 
 	err = check_reg_arg(env, insn->dst_reg, DST_OP);
 	if (err)
@@ -18293,13 +18220,6 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		return -EFAULT;
 	}
 
-	if (insn->dst_reg != BPF_REG_0 || insn->off != 0 ||
-	    BPF_SIZE(insn->code) == BPF_DW ||
-	    (mode == BPF_ABS && insn->src_reg != BPF_REG_0)) {
-		verbose(env, "BPF_LD_[ABS|IND] uses reserved fields\n");
-		return -EINVAL;
-	}
-
 	/* check whether implicit source operand (register R6) is readable */
 	err = check_reg_arg(env, ctx_reg, SRC_OP);
 	if (err)
@@ -21614,13 +21534,9 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 		err = check_alu_op(env, insn);
 		if (err)
 			return err;
-
 	} else if (class == BPF_LDX) {
 		bool is_ldsx = BPF_MODE(insn->code) == BPF_MEMSX;
 
-		/* Check for reserved fields is already done in
-		 * resolve_pseudo_ldimm64().
-		 */
 		err = check_load_mem(env, insn, false, is_ldsx, true, "ldx");
 		if (err)
 			return err;
@@ -21633,22 +21549,12 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 			return 0;
 		}
 
-		if (BPF_MODE(insn->code) != BPF_MEM || insn->imm != 0) {
-			verbose(env, "BPF_STX uses reserved fields\n");
-			return -EINVAL;
-		}
-
 		err = check_store_reg(env, insn, false);
 		if (err)
 			return err;
 	} else if (class == BPF_ST) {
 		enum bpf_reg_type dst_reg_type;
 
-		if (BPF_MODE(insn->code) != BPF_MEM ||
-		    insn->src_reg != BPF_REG_0) {
-			verbose(env, "BPF_ST uses reserved fields\n");
-			return -EINVAL;
-		}
 		/* check src operand */
 		err = check_reg_arg(env, insn->dst_reg, SRC_OP);
 		if (err)
@@ -21671,17 +21577,6 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
 		env->jmps_processed++;
 		if (opcode == BPF_CALL) {
-			if (BPF_SRC(insn->code) != BPF_K ||
-			    (insn->src_reg != BPF_PSEUDO_KFUNC_CALL &&
-			     insn->off != 0) ||
-			    (insn->src_reg != BPF_REG_0 &&
-			     insn->src_reg != BPF_PSEUDO_CALL &&
-			     insn->src_reg != BPF_PSEUDO_KFUNC_CALL) ||
-			    insn->dst_reg != BPF_REG_0 || class == BPF_JMP32) {
-				verbose(env, "BPF_CALL uses reserved fields\n");
-				return -EINVAL;
-			}
-
 			if (env->cur_state->active_locks) {
 				if ((insn->src_reg == BPF_REG_0 &&
 				     insn->imm != BPF_FUNC_spin_unlock &&
@@ -21707,23 +21602,8 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
 			mark_reg_scratched(env, BPF_REG_0);
 		} else if (opcode == BPF_JA) {
-			if (BPF_SRC(insn->code) == BPF_X) {
-				if (insn->src_reg != BPF_REG_0 ||
-				    insn->imm != 0 || insn->off != 0) {
-					verbose(env, "BPF_JA|BPF_X uses reserved fields\n");
-					return -EINVAL;
-				}
+			if (BPF_SRC(insn->code) == BPF_X)
 				return check_indirect_jump(env, insn);
-			}
-
-			if (BPF_SRC(insn->code) != BPF_K ||
-			    insn->src_reg != BPF_REG_0 ||
-			    insn->dst_reg != BPF_REG_0 ||
-			    (class == BPF_JMP && insn->imm != 0) ||
-			    (class == BPF_JMP32 && insn->off != 0)) {
-				verbose(env, "BPF_JA uses reserved fields\n");
-				return -EINVAL;
-			}
 
 			if (class == BPF_JMP)
 				env->insn_idx += insn->off + 1;
@@ -21731,14 +21611,6 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 				env->insn_idx += insn->imm + 1;
 			return 0;
 		} else if (opcode == BPF_EXIT) {
-			if (BPF_SRC(insn->code) != BPF_K ||
-			    insn->imm != 0 ||
-			    insn->src_reg != BPF_REG_0 ||
-			    insn->dst_reg != BPF_REG_0 ||
-			    class == BPF_JMP32) {
-				verbose(env, "BPF_EXIT uses reserved fields\n");
-				return -EINVAL;
-			}
 			return process_bpf_exit_full(env, do_print_state, false);
 		} else {
 			err = check_cond_jmp_op(env, insn, &env->insn_idx);
@@ -21760,13 +21632,7 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
 			env->insn_idx++;
 			sanitize_mark_insn_seen(env);
-		} else {
-			verbose(env, "invalid BPF_LD mode\n");
-			return -EINVAL;
 		}
-	} else {
-		verbose(env, "unknown insn class %d\n", class);
-		return -EINVAL;
 	}
 
 	env->insn_idx++;
@@ -22332,14 +22198,199 @@ static int add_used_map(struct bpf_verifier_env *env, int fd)
 	return __add_used_map(env, map);
 }
 
-/* find and rewrite pseudo imm in ld_imm64 instructions:
+static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 opcode = BPF_OP(insn->code);
+
+	switch (opcode) {
+	case BPF_NEG:
+		if (BPF_SRC(insn->code) != BPF_K || insn->src_reg != BPF_REG_0 ||
+		    insn->off != 0 || insn->imm != 0) {
+			verbose(env, "BPF_NEG uses reserved fields\n");
+			return -EINVAL;
+		}
+		return 0;
+	case BPF_END:
+		if (insn->src_reg != BPF_REG_0 || insn->off != 0 ||
+		    (insn->imm != 16 && insn->imm != 32 && insn->imm != 64) ||
+		    (class == BPF_ALU64 && BPF_SRC(insn->code) != BPF_TO_LE)) {
+			verbose(env, "BPF_END uses reserved fields\n");
+			return -EINVAL;
+		}
+		return 0;
+	case BPF_MOV:
+		if (BPF_SRC(insn->code) == BPF_X) {
+			if (class == BPF_ALU) {
+				if ((insn->off != 0 && insn->off != 8 && insn->off != 16) ||
+				    insn->imm) {
+					verbose(env, "BPF_MOV uses reserved fields\n");
+					return -EINVAL;
+				}
+			} else if (insn->off == BPF_ADDR_SPACE_CAST) {
+				if (insn->imm != 1 && insn->imm != 1u << 16) {
+					verbose(env, "addr_space_cast insn can only convert between address space 1 and 0\n");
+					return -EINVAL;
+				}
+			} else if ((insn->off != 0 && insn->off != 8 &&
+				    insn->off != 16 && insn->off != 32) || insn->imm) {
+				verbose(env, "BPF_MOV uses reserved fields\n");
+				return -EINVAL;
+			}
+		} else if (insn->src_reg != BPF_REG_0 || insn->off != 0) {
+			verbose(env, "BPF_MOV uses reserved fields\n");
+			return -EINVAL;
+		}
+		return 0;
+	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_AND:
+	case BPF_OR:
+	case BPF_XOR:
+	case BPF_LSH:
+	case BPF_RSH:
+	case BPF_ARSH:
+	case BPF_MUL:
+	case BPF_DIV:
+	case BPF_MOD:
+		if (BPF_SRC(insn->code) == BPF_X) {
+			if (insn->imm != 0 || (insn->off != 0 && insn->off != 1) ||
+			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
+				verbose(env, "BPF_ALU uses reserved fields\n");
+				return -EINVAL;
+			}
+		} else if (insn->src_reg != BPF_REG_0 ||
+			   (insn->off != 0 && insn->off != 1) ||
+			   (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
+			verbose(env, "BPF_ALU uses reserved fields\n");
+			return -EINVAL;
+		}
+		return 0;
+	default:
+		verbose(env, "invalid BPF_ALU opcode %x\n", opcode);
+		return -EINVAL;
+	}
+}
+
+static int check_jmp_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 opcode = BPF_OP(insn->code);
+
+	switch (opcode) {
+	case BPF_CALL:
+		if (BPF_SRC(insn->code) != BPF_K ||
+		    (insn->src_reg != BPF_PSEUDO_KFUNC_CALL && insn->off != 0) ||
+		    (insn->src_reg != BPF_REG_0 && insn->src_reg != BPF_PSEUDO_CALL &&
+		     insn->src_reg != BPF_PSEUDO_KFUNC_CALL) ||
+		    insn->dst_reg != BPF_REG_0 || class == BPF_JMP32) {
+			verbose(env, "BPF_CALL uses reserved fields\n");
+			return -EINVAL;
+		}
+		return 0;
+	case BPF_JA:
+		if (BPF_SRC(insn->code) == BPF_X) {
+			if (insn->src_reg != BPF_REG_0 || insn->imm != 0 || insn->off != 0) {
+				verbose(env, "BPF_JA|BPF_X uses reserved fields\n");
+				return -EINVAL;
+			}
+		} else if (insn->src_reg != BPF_REG_0 || insn->dst_reg != BPF_REG_0 ||
+			   (class == BPF_JMP && insn->imm != 0) ||
+			   (class == BPF_JMP32 && insn->off != 0)) {
+			verbose(env, "BPF_JA uses reserved fields\n");
+			return -EINVAL;
+		}
+		return 0;
+	case BPF_EXIT:
+		if (BPF_SRC(insn->code) != BPF_K || insn->imm != 0 ||
+		    insn->src_reg != BPF_REG_0 || insn->dst_reg != BPF_REG_0 ||
+		    class == BPF_JMP32) {
+			verbose(env, "BPF_EXIT uses reserved fields\n");
+			return -EINVAL;
+		}
+		return 0;
+	case BPF_JCOND:
+		if (insn->code != (BPF_JMP | BPF_JCOND) || insn->src_reg != BPF_MAY_GOTO ||
+		    insn->dst_reg || insn->imm) {
+			verbose(env, "invalid may_goto imm %d\n", insn->imm);
+			return -EINVAL;
+		}
+		return 0;
+	default:
+		if (BPF_SRC(insn->code) == BPF_X) {
+			if (insn->imm != 0) {
+				verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
+				return -EINVAL;
+			}
+		} else if (insn->src_reg != BPF_REG_0) {
+			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
+			return -EINVAL;
+		}
+		return 0;
+	}
+}
+
+static int check_insn_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	switch (BPF_CLASS(insn->code)) {
+	case BPF_ALU:
+	case BPF_ALU64:
+		return check_alu_fields(env, insn);
+	case BPF_LDX:
+		if ((BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) ||
+		    insn->imm != 0) {
+			verbose(env, "BPF_LDX uses reserved fields\n");
+			return -EINVAL;
+		}
+		return 0;
+	case BPF_STX:
+		if (BPF_MODE(insn->code) == BPF_ATOMIC)
+			return 0;
+		if (BPF_MODE(insn->code) != BPF_MEM || insn->imm != 0) {
+			verbose(env, "BPF_STX uses reserved fields\n");
+			return -EINVAL;
+		}
+		return 0;
+	case BPF_ST:
+		if (BPF_MODE(insn->code) != BPF_MEM || insn->src_reg != BPF_REG_0) {
+			verbose(env, "BPF_ST uses reserved fields\n");
+			return -EINVAL;
+		}
+		return 0;
+	case BPF_JMP:
+	case BPF_JMP32:
+		return check_jmp_fields(env, insn);
+	case BPF_LD: {
+		u8 mode = BPF_MODE(insn->code);
+
+		if (mode == BPF_ABS || mode == BPF_IND) {
+			if (insn->dst_reg != BPF_REG_0 || insn->off != 0 ||
+			    BPF_SIZE(insn->code) == BPF_DW ||
+			    (mode == BPF_ABS && insn->src_reg != BPF_REG_0)) {
+				verbose(env, "BPF_LD_[ABS|IND] uses reserved fields\n");
+				return -EINVAL;
+			}
+		} else if (mode != BPF_IMM) {
+			verbose(env, "invalid BPF_LD mode\n");
+			return -EINVAL;
+		}
+		return 0;
+	}
+	default:
+		verbose(env, "unknown insn class %d\n", BPF_CLASS(insn->code));
+		return -EINVAL;
+	}
+}
+
+/*
+ * Check that insns are sane and rewrite pseudo imm in ld_imm64 instructions:
  *
  * 1. if it accesses map FD, replace it with actual map pointer.
  * 2. if it accesses btf_id of a VAR, replace it with pointer to the var.
  *
  * NOTE: btf_vmlinux is required for converting pseudo btf_id.
  */
-static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
+static int check_and_resolve_insns(struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insn = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
@@ -22358,13 +22409,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			verbose(env, "R%d is invalid\n", insn->src_reg);
 			return -EINVAL;
 		}
-		if (BPF_CLASS(insn->code) == BPF_LDX &&
-		    ((BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) ||
-		    insn->imm != 0)) {
-			verbose(env, "BPF_LDX uses reserved fields\n");
-			return -EINVAL;
-		}
-
 		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
 			struct bpf_insn_aux_data *aux;
 			struct bpf_map *map;
@@ -22379,6 +22423,11 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 				return -EINVAL;
 			}
 
+			if (insn[0].off != 0) {
+				verbose(env, "BPF_LD_IMM64 uses reserved fields\n");
+				return -EINVAL;
+			}
+
 			if (insn[0].src_reg == 0)
 				/* valid generic load 64-bit imm */
 				goto next_insn;
@@ -22475,6 +22524,10 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			verbose(env, "unknown opcode %02x\n", insn->code);
 			return -EINVAL;
 		}
+
+		err = check_insn_fields(env, insn);
+		if (err)
+			return err;
 	}
 
 	/* now all pseudo BPF_LD_IMM64 instructions load valid
@@ -26658,7 +26711,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = resolve_pseudo_ldimm64(env);
+	ret = check_and_resolve_insns(env);
 	if (ret < 0)
 		goto skip_full_check;
 
diff --git a/tools/testing/selftests/bpf/verifier/junk_insn.c b/tools/testing/selftests/bpf/verifier/junk_insn.c
index 7d10b0a48f51..735d3b9510cf 100644
--- a/tools/testing/selftests/bpf/verifier/junk_insn.c
+++ b/tools/testing/selftests/bpf/verifier/junk_insn.c
@@ -10,7 +10,7 @@
 {
 	"junk insn2",
 	.insns = {
-	BPF_RAW_INSN(1, 0, 0, 0, 0),
+	BPF_RAW_INSN(BPF_LDX | BPF_MEM | BPF_W, 0, 0, 0, 1),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "BPF_LDX uses reserved fields",
-- 
2.52.0

