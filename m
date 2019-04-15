Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984F9C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEC120656
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="QKpnv5hG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfDOR1O (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:27:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32975 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfDOR0k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:26:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so23050941wrp.0
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YVxWiS0txKksQPu6/HyI4hLBjdspevQZvc7yRcEosdY=;
        b=QKpnv5hGwbwMKE+yC16kJkCY8PVM+qJpmt7lafBXhNWz+eolD4bO1Fu3/wXwiB8u1+
         geznF7JcxRWhJ73hoqEcBtwpR2jyll1FuxDozo7UGNqNsP+qs3N+S4TwAmiJOTfAKcXd
         XBaVbH6d6CG5/H8Wlz/B3TmhR/EV5iUgE0SwQOXMhNb0XXo0kaCo73Ou3VdDHIAxB4Xh
         /SCwa2chtrwyePGbrtBPE0ClV6M/DZaVHEQoiqm5DOxCyEANQOm80oITQRc3f0kkIYrT
         l2vcKjLvf4mOzbn8szveu+PVuh+BpdyJXJrZMaMmSGt1FjiJLfek3BDtbbeFkjrouPXa
         L7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YVxWiS0txKksQPu6/HyI4hLBjdspevQZvc7yRcEosdY=;
        b=JtoHSRE+Wo/veGKj449i2enZ7DtIKMsjBYIcptY8ow035wlctpZamFcG7vEBt65Lew
         LNskTB1dK3HmE0fiTsu13gd/JschcLQbmcsrs+ICfoQ/9MKNaMpQ2HMC0UJaZAv29wVJ
         PklOtjwJsAP9r8RxnZzIXIF4WHxT+RTfkOv/YAhfac1jk45D48VdZpazYx5pPSMGoNIH
         ovIaTdDpwKnpUj/NJJ7Fmx7+EiRWVwWWfnsyMCQEHNquHAtIDFR+95a4LAVYV8jJVMNe
         BIBwYtXTTwIk22XiBAp1Yb1xAa2ZarCpBJgQ9OmakCXszxBtAI3cTdLPrR9bBpK4Z+W/
         kl3A==
X-Gm-Message-State: APjAAAV3NvXv3ahHqPULpVr/lkNyCTHCOEC6YTjWj7wrCnbSlGp1fkp4
        pq43iRIMXBrGzEInapIWjDSb6us4Klc=
X-Google-Smtp-Source: APXvYqzeX67Dsj4Vdmr3ouXQe5UCIWjKwhoc1JSOR2rGYB9RbJeDaaKQUEhqQlAOgI033DnYhaQ9eA==
X-Received: by 2002:a5d:634c:: with SMTP id b12mr24393717wrw.203.1555349198282;
        Mon, 15 Apr 2019 10:26:38 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v190sm27094232wme.18.2019.04.15.10.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 10:26:37 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v4 bpf-next 02/15] bpf: mark lo32 writes that should be zero extended into hi32
Date:   Mon, 15 Apr 2019 18:26:12 +0100
Message-Id: <1555349185-12508-3-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
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
index 5784b279..d5cc167 100644
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
@@ -1259,6 +1261,19 @@ static bool is_reg64(struct bpf_insn *insn, u32 regno,
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
@@ -1285,6 +1300,9 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 		if (regno == BPF_REG_FP)
 			return 0;
 
+		if (rw64)
+			mark_insn_zext(env, reg);
+
 		return mark_reg_read(env, reg, reg->parent,
 				     rw64 ? REG_LIVE_READ64 : REG_LIVE_READ32);
 	} else {
@@ -1294,6 +1312,7 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 			return -EACCES;
 		}
 		reg->live |= REG_LIVE_WRITTEN;
+		reg->subreg_def = rw64 ? DEF_NOT_SUBREG : env->insn_idx;
 		if (t == DST_OP)
 			mark_reg_unknown(env, regs, regno);
 	}
@@ -2176,6 +2195,12 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
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
@@ -3376,6 +3401,9 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
 	}
 
+	/* helper call must return full 64-bit R0. */
+	regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
+
 	/* update return register (already marked as written above) */
 	if (fn->ret_type == RET_INTEGER) {
 		/* sets type to SCALAR_VALUE */
@@ -4307,6 +4335,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				 */
 				*dst_reg = *src_reg;
 				dst_reg->live |= REG_LIVE_WRITTEN;
+				dst_reg->subreg_def = DEF_NOT_SUBREG;
 			} else {
 				/* R1 = (u32) R2 */
 				if (is_pointer_value(env, insn->src_reg)) {
@@ -4317,6 +4346,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 				} else if (src_reg->type == SCALAR_VALUE) {
 					*dst_reg = *src_reg;
 					dst_reg->live |= REG_LIVE_WRITTEN;
+					dst_reg->subreg_def = env->insn_idx;
 				} else {
 					mark_reg_unknown(env, regs,
 							 insn->dst_reg);
@@ -5380,6 +5410,8 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	 * Already marked as written above.
 	 */
 	mark_reg_unknown(env, regs, BPF_REG_0);
+	/* ld_abs load up to 32-bit skb data. */
+	regs[BPF_REG_0].subreg_def = env->insn_idx;
 	return 0;
 }
 
@@ -6319,6 +6351,9 @@ static bool states_equal(struct bpf_verifier_env *env,
 	return true;
 }
 
+/* Return 0 if no propagation happened. Return negative error code if error
+ * happened. Otherwise, return the propagated bits.
+ */
 static int propagate_liveness_reg(struct bpf_verifier_env *env,
 				  struct bpf_reg_state *reg,
 				  struct bpf_reg_state *parent_reg)
@@ -6337,7 +6372,7 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	return 0;
+	return bits_prop;
 }
 
 /* A write screens off any subsequent reads; but write marks come from the
@@ -6371,8 +6406,10 @@ static int propagate_liveness(struct bpf_verifier_env *env,
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
@@ -6382,11 +6419,11 @@ static int propagate_liveness(struct bpf_verifier_env *env,
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

