Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C9FC10F14
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585502084D
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qLrve8N9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfDLWAM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33380 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfDLWAK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so13776848wrp.0
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M4oS4lAyke3Kgzi/tLbCTTag+k010jqZDCyj0xY9SkE=;
        b=qLrve8N9AUJ4DxMgFP2HyMFx49nawGM6lwp+1vWYTFEh24UXSqbdUsaNxnCVarGSCF
         bBAHkY+KUTAK3WTZkgp6gn7qt5oHirKHCPJg8EXa/fEZR/Y8mB/+5rmT9XneSDAQtF4e
         N8qBmvoFgsnU72ChlfaYePQgBbcj46PgNN6eYIHzH3kUta5OH3zsf6OBSzrhQWbkI6Et
         yMKO1vYUsPatTHMhzhWCWXeNQXCxT6IkBxv0vH1YSPS3OwkB6TJPll2X9rjH3V7xTEcr
         gHjppeuXQknPgGG3ojAdyWzY6xaCgB0BV44/zDC0VmuijDCZC/lFKRkAAH1jAGxeu/Q8
         yBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M4oS4lAyke3Kgzi/tLbCTTag+k010jqZDCyj0xY9SkE=;
        b=WjQMx1sbph4P2Gblc18dkvQuu6UzxincVNev++qxP9EjhUPHeHVzDg1nzUwZ34h+Ha
         LPLktmUtWKHyww6SuTBsBhFtlwbct2qmIQAHp4Du2ikteerW6k2FX6aG8cBetN9I4bz9
         8f7dmrKlAIhBAH0XyQPhc6uBVpQ3uKgRHOODU9uoKI6xSPLbMvqRkyCTSZ7TVvsPLBzV
         bH3v9fAr788aq1wt62dOzBayjm0suX2RVKy2jZtckcYM0OSpZZ1P5fIwfRiJQ7rgqqJi
         KMQSea9aU3EHTYarJ4cq9onU9AjweVtgp8N0sf7/AYlimaryLsD2RAx1L4VtqosLyxw2
         thVg==
X-Gm-Message-State: APjAAAVp3K7Vr357J7bxjsE0hpPaUnN/gH3kXb+azsHqmuNsirOPgG6N
        vVqt3UBZ+wULxwyps0mmQNqk8Q==
X-Google-Smtp-Source: APXvYqwlEXG535b8Lq6fnGjlQ3jQBUXUai+DXcZ8SLPG5w2T3m5lucKqxIvF6+HeQ3zFkfqUlxwClA==
X-Received: by 2002:adf:fd41:: with SMTP id h1mr34930069wrs.155.1555106408601;
        Fri, 12 Apr 2019 15:00:08 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.15.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:07 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v3 bpf-next 06/19] bpf: mark lo32 writes that should be zero extended into hi32
Date:   Fri, 12 Apr 2019 22:59:39 +0100
Message-Id: <1555106392-20117-7-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

eBPF ISA specification requires high 32-bit cleared when low 32-bit
sub-register is written. This applies to destination register of ALU32 etc.
JIT back-ends must guarantee this semantic when doing code-gen.

x86-64 and arm64 ISA has the same semantic, so the corresponding JIT
back-end doesn't need to do extra work. However, 32-bit arches (arm, nfp
etc.) and some other 64-bit arches (powerpc, sparc etc), need explicit zero
extension sequence to meet such semantic.

This is important, because for code the following:

  u64_value = (u64) u32_value
  ... other uses of u64_value

compiler could exploit the semantic described above and save those zero
extensions for extending u32_value to u64_value. Hardware, runtime, or BPF
JIT back-ends, are responsible for guaranteeing this. Some benchmarks show
~40% sub-register writes out of total insns, meaning ~40% extra code-gen (
could go up to more for some arches which requires two shifts for zero
extension) because JIT back-end needs to do extra code-gen for all such
instructions.

However this is not always necessary in case u32_value is never cast into
a u64, which is quite normal in real life program. So, it would be really
good if we could identify those places where such type cast happened, and
only do zero extensions for them, not for the others. This could save a lot
of BPF code-gen.

Algo:
 - Record indices of instructions that do sub-register def (write). And
   these indices need to stay with reg state so path pruning and bpf
   to bpf function call could be handled properly.

   These indices are kept up to date while doing insn walk.

 - A full register read on an active sub-register def marks the def insn as
   needing zero extension on dst register.

 - A new sub-register write overrides the old one.

   A new full register write makes the register free of zero extension on
   dst register.

 - When propagating read64 during path pruning, also marks def insns whose
   defs are hanging active sub-register.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 include/linux/bpf_verifier.h |  6 ++++++
 kernel/bpf/verifier.c        | 45 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index fba0ebb..c1923a5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -133,6 +133,11 @@ struct bpf_reg_state {
 	 * pointing to bpf_func_state.
 	 */
 	u32 frameno;
+	/* Tracks subreg definition. The stored value is the insn_idx of the
+	 * writing insn. This is safe because subreg_def is used before any insn
+	 * patching which only happens after main verification finished.
+	 */
+	s32 subreg_def;
 	enum bpf_reg_liveness live;
 };
 
@@ -234,6 +239,7 @@ struct bpf_insn_aux_data {
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	int sanitize_stack_off; /* stack slot to be cleared */
 	bool seen; /* this insn was processed by the verifier */
+	bool zext_dst; /* this insn zero extend dst reg */
 	u8 alu_state; /* used in combination with alu_limit */
 	unsigned int orig_idx; /* original instruction index */
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3c5ca00..3bcbd9b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -980,6 +980,7 @@ static void mark_reg_not_init(struct bpf_verifier_env *env,
 	__mark_reg_not_init(regs + regno);
 }
 
+#define DEF_NOT_SUBREG	(-1)
 static void init_reg_state(struct bpf_verifier_env *env,
 			   struct bpf_func_state *state)
 {
@@ -990,6 +991,7 @@ static void init_reg_state(struct bpf_verifier_env *env,
 		mark_reg_not_init(env, regs, i);
 		regs[i].live = REG_LIVE_NONE;
 		regs[i].parent = NULL;
+		regs[i].subreg_def = DEF_NOT_SUBREG;
 	}
 
 	/* frame pointer */
@@ -1253,6 +1255,19 @@ static bool is_reg64(struct bpf_insn *insn, u32 regno,
 	return true;
 }
 
+static void mark_insn_zext(struct bpf_verifier_env *env,
+			   struct bpf_reg_state *reg)
+{
+	s32 def_idx = reg->subreg_def;
+
+	if (def_idx == DEF_NOT_SUBREG)
+		return;
+
+	env->insn_aux_data[def_idx].zext_dst = true;
+	/* The dst will be zero extended, so won't be sub-register anymore. */
+	reg->subreg_def = DEF_NOT_SUBREG;
+}
+
 static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 			 enum reg_arg_type t)
 {
@@ -1279,6 +1294,9 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 		if (regno == BPF_REG_FP)
 			return 0;
 
+		if (rw64)
+			mark_insn_zext(env, reg);
+
 		return mark_reg_read(env, reg, reg->parent,
 				     rw64 ? REG_LIVE_READ64 : REG_LIVE_READ32);
 	} else {
@@ -1288,6 +1306,7 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 			return -EACCES;
 		}
 		reg->live |= REG_LIVE_WRITTEN;
+		reg->subreg_def = rw64 ? DEF_NOT_SUBREG : env->insn_idx;
 		if (t == DST_OP)
 			mark_reg_unknown(env, regs, regno);
 	}
@@ -2170,6 +2189,12 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 						    value_regno);
 				if (reg_type_may_be_null(reg_type))
 					regs[value_regno].id = ++env->id_gen;
+				/* A load of ctx field could have different
+				 * actual load size with the one encoded in the
+				 * insn. When the dst is PTR, it is for sure not
+				 * a sub-register.
+				 */
+				regs[value_regno].subreg_def = DEF_NOT_SUBREG;
 			}
 			regs[value_regno].type = reg_type;
 		}
@@ -3370,6 +3395,9 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
 	}
 
+	/* helper call must return full 64-bit R0. */
+	regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
+
 	/* update return register (already marked as written above) */
 	if (fn->ret_type == RET_INTEGER) {
 		/* sets type to SCALAR_VALUE */
@@ -4301,6 +4329,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				 */
 				*dst_reg = *src_reg;
 				dst_reg->live |= REG_LIVE_WRITTEN;
+				dst_reg->subreg_def = DEF_NOT_SUBREG;
 			} else {
 				/* R1 = (u32) R2 */
 				if (is_pointer_value(env, insn->src_reg)) {
@@ -4311,6 +4340,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				} else if (src_reg->type == SCALAR_VALUE) {
 					*dst_reg = *src_reg;
 					dst_reg->live |= REG_LIVE_WRITTEN;
+					dst_reg->subreg_def = env->insn_idx;
 				} else {
 					mark_reg_unknown(env, regs,
 							 insn->dst_reg);
@@ -5374,6 +5404,8 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	 * Already marked as written above.
 	 */
 	mark_reg_unknown(env, regs, BPF_REG_0);
+	/* ld_abs load up to 32-bit skb data. */
+	regs[BPF_REG_0].subreg_def = env->insn_idx;
 	return 0;
 }
 
@@ -6313,6 +6345,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	return true;
 }
 
+/* Return 0 if no propagation happened. Return negative error code if error
+ * happened. Otherwise, return the propagated bits.
+ */
 static int propagate_liveness_reg(struct bpf_verifier_env *env,
 				  struct bpf_reg_state *reg,
 				  struct bpf_reg_state *parent_reg)
@@ -6333,7 +6368,7 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	return 0;
+	return bits_prop;
 }
 
 /* A write screens off any subsequent reads; but write marks come from the
@@ -6367,8 +6402,10 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 		for (i = frame < vstate->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++) {
 			err = propagate_liveness_reg(env, &state_reg[i],
 						     &parent_reg[i]);
-			if (err)
+			if (err < 0)
 				return err;
+			if (err & REG_LIVE_READ64)
+				mark_insn_zext(env, &parent_reg[i]);
 		}
 
 		/* Propagate stack slots. */
@@ -6378,11 +6415,11 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 			state_reg = &state->stack[i].spilled_ptr;
 			err = propagate_liveness_reg(env, state_reg,
 						     parent_reg);
-			if (err)
+			if (err < 0)
 				return err;
 		}
 	}
-	return err;
+	return 0;
 }
 
 static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
-- 
2.7.4

