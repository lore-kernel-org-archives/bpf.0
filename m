Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34EBC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE722082F
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="L+F3d8/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbfCZSGl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:41 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39015 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732387AbfCZSGl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:41 -0400
Received: by mail-wr1-f52.google.com with SMTP id j9so15489241wrn.6
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P1Pl+PYiZgKtWPFgiB/xp+eSvP3P0DnTxOTxRs5FUHk=;
        b=L+F3d8/ms86DugHNXolFhLyKA2+yjXi3S88nkVMNyeEaUM4z6oR0xbBM+lyLT4xVGp
         94RNQR6cu/FCvzCNPcJHvEhbU6rF+yavRg/HI0McsGIx9cZdLGdN4QnwRNQSE9fV0KNP
         Ex6SmmBjC469VYp8LCdgZgwyG988Hjdisjz+NhetiK2HHXG5GbiuOB1aGhdzWNI4RqUL
         CSc7a9DivwJT1SgdGk1PyFp4hyzUFOcyD6gyRiGMUdW41QEfUMTPUUF0Kf5x2YKdlCQg
         3Vyd51Zg9olS8kX6+RwqJa8+NzoF+kfEV9+fVdGPJdrMQkvaAKZ/84gQn1L1W+ONDDZH
         9PcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P1Pl+PYiZgKtWPFgiB/xp+eSvP3P0DnTxOTxRs5FUHk=;
        b=MQJZEnI0IE2sQ/8/2kovZ20wJFC5yx5oeeHZiXE0Bf+K4fcQWydcPu+CdS3yW1+LOZ
         G9B1oRo3lJXHoPu6fKxiqmYJ/33s98AwsaH/Omuu0irwxXifjPnx46UCqC055Vk8sUu+
         314/MlJBQcl9JPhRMWQZIGMgpxbMn9vJE64gZivEhQGI2p5cepqKMubDF1DXrW96LYsv
         XRy8pHC5AIe3LyxLM53IgCR23Pp8AMepRiN7bri3irTcauKrWz6uJ1OrqUIMdnHjhe94
         ub4rLB3CAZC1XssJCe3AmWdUJmXAeYAJsGXE5n+F16OVJ2eqICehH4L6q+AgSFNB6BCK
         ozdQ==
X-Gm-Message-State: APjAAAXB0igMr1TwSYlYHX26e09enAUCcq0l1NxtHF3X16EN3u0gkgef
        FTg6nj5XYJY1axugADFzQmIR7Q==
X-Google-Smtp-Source: APXvYqyE9hyjrpOWMiw7X86SzTW7hMQF9CajkzzGYGO/YBTcSDoetUYjAjOirz9J4BRLehcz/PoWxg==
X-Received: by 2002:a5d:6887:: with SMTP id h7mr21832885wru.122.1553623599106;
        Tue, 26 Mar 2019 11:06:39 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:38 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC bpf-next 04/16] bpf: mark sub-register writes that really need zero extension to high bits
Date:   Tue, 26 Mar 2019 18:05:27 +0000
Message-Id: <1553623539-15474-5-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
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
   these indices need to stay with function state so path pruning and bpf
   to bpf function call could be handled properly.

   These indices are kept up to date while doing insn walk.

 - A full register read on an active sub-register def marks the def insn as
   needing zero extension on dst register.

 - A new sub-register write overrides the old one.

   A new full register write makes the register free of zero extension on
   dst register.

 - When propagating register read64 during path pruning, it also marks def
   insns whose defs are hanging active sub-register, if there is any read64
   from shown from the equal state.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 include/linux/bpf_verifier.h |  4 +++
 kernel/bpf/verifier.c        | 85 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 27761ab..0ae9a3f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -181,6 +181,9 @@ struct bpf_func_state {
 	 */
 	u32 subprogno;
 
+	/* tracks subreg definition. */
+	s32 subreg_def[MAX_BPF_REG];
+
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
 	struct bpf_reference_state *refs;
@@ -232,6 +235,7 @@ struct bpf_insn_aux_data {
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
 	int sanitize_stack_off; /* stack slot to be cleared */
 	bool seen; /* this insn was processed by the verifier */
+	bool zext_dst; /* this insn zero extend dst reg */
 	u8 alu_state; /* used in combination with alu_limit */
 	unsigned int orig_idx; /* original instruction index */
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b95c438..66e5e65 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -971,16 +971,19 @@ static void mark_reg_not_init(struct bpf_verifier_env *env,
 	__mark_reg_not_init(regs + regno);
 }
 
+#define DEF_NOT_SUBREG	(-1)
 static void init_reg_state(struct bpf_verifier_env *env,
 			   struct bpf_func_state *state)
 {
 	struct bpf_reg_state *regs = state->regs;
+	s32 *subreg_def = state->subreg_def;
 	int i;
 
 	for (i = 0; i < MAX_BPF_REG; i++) {
 		mark_reg_not_init(env, regs, i);
 		regs[i].live = REG_LIVE_NONE;
 		regs[i].parent = NULL;
+		subreg_def[i] = DEF_NOT_SUBREG;
 	}
 
 	/* frame pointer */
@@ -1149,18 +1152,66 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* This function is supposed to be used by the following check_reg_arg only. */
+static bool insn_has_reg64(struct bpf_insn *insn)
+{
+	u8 code, class, op;
+
+	code = insn->code;
+	class = BPF_CLASS(code);
+	op = BPF_OP(code);
+
+	/* BPF_EXIT will reach here because of return value readability test for
+	 * "main" which has s32 return value.
+	 * BPF_CALL will reach here because of marking caller saved clobber with
+	 * DST_OP_NO_MARK for which we don't care the register def because they
+	 * are anyway marked as NOT_INIT already.
+	 *
+	 * So, return false for both.
+	 */
+	if (class == BPF_JMP && (op == BPF_EXIT || op == BPF_CALL))
+		return false;
+
+	if (class == BPF_ALU64 || class == BPF_JMP ||
+	    /* BPF_END always use BPF_ALU class. */
+	    (class == BPF_ALU && op == BPF_END && insn->imm == 64))
+		return true;
+
+	if (class == BPF_ALU || class == BPF_JMP32)
+		return false;
+
+	/* LD/ST/LDX/STX */
+	return BPF_SIZE(code) == BPF_DW;
+}
+
+static void mark_insn_zext(struct bpf_verifier_env *env,
+			   struct bpf_func_state *state, u8 regno)
+{
+	s32 def_idx = state->subreg_def[regno];
+
+	if (def_idx == DEF_NOT_SUBREG)
+		return;
+
+	env->insn_aux_data[def_idx].zext_dst = true;
+	/* The dst will be zero extended, so won't be sub-register anymore. */
+	state->subreg_def[regno] = DEF_NOT_SUBREG;
+}
+
 static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 			 enum reg_arg_type t)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
+	struct bpf_insn *insn = env->prog->insnsi + env->insn_idx;
 	struct bpf_reg_state *regs = state->regs;
+	bool dw_reg;
 
 	if (regno >= MAX_BPF_REG) {
 		verbose(env, "R%d is invalid\n", regno);
 		return -EINVAL;
 	}
 
+	dw_reg = insn_has_reg64(insn);
 	if (t == SRC_OP) {
 		/* check whether register used as source operand can be read */
 		if (regs[regno].type == NOT_INIT) {
@@ -1168,9 +1219,12 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 			return -EACCES;
 		}
 		/* We don't need to worry about FP liveness because it's read-only */
-		if (regno != BPF_REG_FP)
+		if (regno != BPF_REG_FP) {
+			if (dw_reg)
+				mark_insn_zext(env, state, regno);
 			return mark_reg_read(env, &regs[regno],
-					     regs[regno].parent, true);
+					     regs[regno].parent, dw_reg);
+		}
 	} else {
 		/* check whether register used as dest operand can be written to */
 		if (regno == BPF_REG_FP) {
@@ -1178,6 +1232,8 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 			return -EACCES;
 		}
 		regs[regno].live |= REG_LIVE_WRITTEN;
+		state->subreg_def[regno] =
+			dw_reg ? DEF_NOT_SUBREG : env->insn_idx;
 		if (t == DST_OP)
 			mark_reg_unknown(env, regs, regno);
 	}
@@ -2360,6 +2416,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
 	if (err)
 		return err;
 
+	/* arg_type doesn't differentiate 32 and 64-bit arg, always zext. */
+	mark_insn_zext(env, cur_func(env), regno);
+
 	if (arg_type == ARG_ANYTHING) {
 		if (is_pointer_value(env, regno)) {
 			verbose(env, "R%d leaks addr into helper function\n",
@@ -2880,10 +2939,13 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return err;
 
 	/* copy r1 - r5 args that callee can access.  The copy includes parent
-	 * pointers, which connects us up to the liveness chain
+	 * pointers, which connects us up to the liveness chain. subreg_def for
+	 * them need to be copied as well.
 	 */
-	for (i = BPF_REG_1; i <= BPF_REG_5; i++)
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++) {
 		callee->regs[i] = caller->regs[i];
+		callee->subreg_def[i] = caller->subreg_def[i];
+	}
 
 	/* after the call registers r0 - r5 were scratched */
 	for (i = 0; i < CALLER_SAVED_REGS; i++) {
@@ -2928,8 +2990,11 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 
 	state->curframe--;
 	caller = state->frame[state->curframe];
-	/* return to the caller whatever r0 had in the callee */
+	/* return to the caller whatever r0 had in the callee, subreg_def should
+	 * be copied to caller as well.
+	 */
 	caller->regs[BPF_REG_0] = *r0;
+	caller->subreg_def[BPF_REG_0] = callee->subreg_def[BPF_REG_0];
 
 	/* Transfer references to the caller */
 	err = transfer_reference_state(caller, callee);
@@ -3118,6 +3183,9 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
 		check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
 	}
 
+	/* helper call must return full 64-bit R0. */
+	cur_func(env)->subreg_def[BPF_REG_0] = DEF_NOT_SUBREG;
+
 	/* update return register (already marked as written above) */
 	if (fn->ret_type == RET_INTEGER) {
 		/* sets type to SCALAR_VALUE */
@@ -5114,6 +5182,8 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	 * Already marked as written above.
 	 */
 	mark_reg_unknown(env, regs, BPF_REG_0);
+	/* ld_abs load up to 32-bit skb data. */
+	cur_func(env)->subreg_def[BPF_REG_0] = env->insn_idx;
 	return 0;
 }
 
@@ -6092,12 +6162,17 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 	BUILD_BUG_ON(BPF_REG_FP + 1 != MAX_BPF_REG);
 	parent_regs = vparent->frame[vparent->curframe]->regs;
 	regs = vstate->frame[vstate->curframe]->regs;
+	parent = vparent->frame[vparent->curframe];
 	/* We don't need to worry about FP liveness because it's read-only */
 	for (i = 0; i < BPF_REG_FP; i++) {
 		err = propagate_liveness_reg(env, &regs[i], &parent_regs[i],
 					     REG_LIVE_READ64);
 		if (err < 0)
 			return err;
+
+		if (err > 0)
+			mark_insn_zext(env, parent, i);
+
 		err = propagate_liveness_reg(env, &regs[i], &parent_regs[i],
 					     REG_LIVE_READ32);
 		if (err < 0)
-- 
2.7.4

