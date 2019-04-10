Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91577C10F14
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5754B20820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="KEmF+7/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfDJTur (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:50:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54990 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfDJTuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so3891448wml.4
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bY31K3qUtUB/VTz310uOs02Po0yxYg6fK7p/+dcUrWM=;
        b=KEmF+7/q8bNbHj1bf1YkPxppykf3uW7x1xQ6VGwRuIeyQ7Dpqotq7EsTU5tSEbqhrI
         5VdYNk1OC9GLG6SwQmimVeux5rHkBynfH/inp4Tx9RvCRlmlxf/MUB+8/v8Ng/b7aJ1S
         0Nh/lroNrJXuePXf36h4LdOt4X6rJBydPvte4V+IbDBASts555CMw317pt+YbsRFHEzm
         Fsxm1jQ+Yw0qaCr8GzQW9VrRi/bfq23r3iG7l010hDlo3jiaKw42K7Y6PrajHYPxXqNR
         c8VWfoLFzKwdPmG29FEohjyGJXAX6xbRSO7Lh7418+2wiikwFCDko3lKMblxDgQl5jR6
         HK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bY31K3qUtUB/VTz310uOs02Po0yxYg6fK7p/+dcUrWM=;
        b=Lh+bHCaO3rVOU9bvpad2x3WzO5j8+P4+tROxuesApLdE7JT+M7RZylvvjB/hncPGVV
         +kfJd3NrrO4hN4PAzMy39X9N7YxqzgtVlEs5ZWrenRAuTSYa/XEXzWL9LAaxTcjrdCo6
         hIyGKgbOFj7tlHzkW21Twkl12PUO2u0jgRtFLmGiAD+Ee9PdgsbgOIFyiKyvPsIaL7dc
         EiVeB+D/oZI0URe0kRFD5SfAK84WO8a3GtgcKVT5oAb7pjTrX/RSXeVLmXi3OtfTdsOt
         zMelWQnFaQP61rAxkmzajKxyejbosRzcea7ae3AHp9i+BeG3BOQDJyhUjZ/Xxe7DKF2o
         Mscg==
X-Gm-Message-State: APjAAAVzDfn0IRmEwqYv0YN9vRetTobKUsMKBorE0WGIYR3mfk6Up9j2
        XA5Bvmy2lmIDItWxl2F2gYLXCQ==
X-Google-Smtp-Source: APXvYqxrifPWXqy4eq4q3mbVcHWN/dcziK5EFlQWW13ukbMgyqJJSZuHPKkB39gTmPXUX5rqhwzVWQ==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr4123518wmj.41.1554925844742;
        Wed, 10 Apr 2019 12:50:44 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:43 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC v2 bpf-next 05/19] bpf: split read liveness into REG_LIVE_READ64 and REG_LIVE_READ32
Date:   Wed, 10 Apr 2019 20:50:19 +0100
Message-Id: <1554925833-7333-6-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Register liveness infrastructure doesn't track register read width at the
moment, while the width information will be needed for the later 32-bit
safety analysis pass.

This patch take the first step to split read liveness into REG_LIVE_READ64
and REG_LIVE_READ32.

Liveness propagation code are updated accordingly. They are taught to
understand how to propagate REG_LIVE_READ64 and REG_LIVE_READ32 at the same
propagation iteration. For example, "mark_reg_read" now propagate "flags"
which could be multiple read bits instead of the single REG_LIVE_READ64.

A write still screen off all width of reads.

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 include/linux/bpf_verifier.h |   8 +--
 kernel/bpf/verifier.c        | 119 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 113 insertions(+), 14 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b3ab61f..fba0ebb 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -36,9 +36,11 @@
  */
 enum bpf_reg_liveness {
 	REG_LIVE_NONE = 0, /* reg hasn't been read or written this branch */
-	REG_LIVE_READ, /* reg was read, so we're sensitive to initial value */
-	REG_LIVE_WRITTEN, /* reg was written first, screening off later reads */
-	REG_LIVE_DONE = 4, /* liveness won't be updating this register anymore */
+	REG_LIVE_READ32 = 0x1, /* reg was read, so we're sensitive to initial value */
+	REG_LIVE_READ64 = 0x2, /* likewise, but full 64-bit content matters */
+	REG_LIVE_READ = REG_LIVE_READ32 | REG_LIVE_READ64,
+	REG_LIVE_WRITTEN = 0x4, /* reg was written first, screening off later reads */
+	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
 };
 
 struct bpf_reg_state {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bd30a65..44e4278 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1135,7 +1135,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
  */
 static int mark_reg_read(struct bpf_verifier_env *env,
 			 const struct bpf_reg_state *state,
-			 struct bpf_reg_state *parent)
+			 struct bpf_reg_state *parent, u8 flags)
 {
 	bool writes = parent == state->parent; /* Observe write marks */
 	int cnt = 0;
@@ -1150,17 +1150,17 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 				parent->var_off.value, parent->off);
 			return -EFAULT;
 		}
-		if (parent->live & REG_LIVE_READ)
+		if ((parent->live & REG_LIVE_READ) == flags)
 			/* The parentage chain never changes and
-			 * this parent was already marked as LIVE_READ.
+			 * this parent was already marked with all read bits.
 			 * There is no need to keep walking the chain again and
-			 * keep re-marking all parents as LIVE_READ.
+			 * keep re-marking all parents with reads bits in flags.
 			 * This case happens when the same register is read
 			 * multiple times without writes into it in-between.
 			 */
 			break;
 		/* ... then we depend on parent's value */
-		parent->live |= REG_LIVE_READ;
+		parent->live |= flags;
 		state = parent;
 		parent = state->parent;
 		writes = true;
@@ -1172,12 +1172,95 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* This function is supposed to be used by the following 32-bit optimization
+ * code only. It returns TRUE if the source or destination register operates
+ * on 64-bit, otherwise return FALSE.
+ */
+static bool is_reg64(struct bpf_insn *insn, u32 regno,
+		     struct bpf_reg_state *reg, enum reg_arg_type t)
+{
+	u8 code, class, op;
+
+	code = insn->code;
+	class = BPF_CLASS(code);
+	op = BPF_OP(code);
+	if (class == BPF_JMP) {
+		/* BPF_EXIT will reach here because of return value readability
+		 * test for "main" which has s32 return value.
+		 */
+		if (op == BPF_EXIT)
+			return false;
+		if (op == BPF_CALL) {
+			/* BPF to BPF call will reach here because of marking
+			 * caller saved clobber with DST_OP_NO_MARK for which we
+			 * don't care the register def because they are anyway
+			 * marked as NOT_INIT already.
+			 */
+			if (insn->src_reg == BPF_PSEUDO_CALL)
+				return false;
+			/* Helper call will reach here because of arg type
+			 * check. Conservatively marking all args as 64-bit.
+			 */
+			return true;
+		}
+	}
+
+	if (class == BPF_ALU64 || class == BPF_JMP ||
+	    /* BPF_END always use BPF_ALU class. */
+	    (class == BPF_ALU && op == BPF_END && insn->imm == 64))
+		return true;
+
+	if (class == BPF_ALU || class == BPF_JMP32)
+		return false;
+
+	if (class == BPF_LDX) {
+		if (t != SRC_OP)
+			return BPF_SIZE(code) == BPF_DW;
+		/* LDX source must be ptr. */
+		return true;
+	}
+
+	if (class == BPF_STX) {
+		if (reg->type != SCALAR_VALUE)
+			return true;
+		return BPF_SIZE(code) == BPF_DW;
+	}
+
+	if (class == BPF_LD) {
+		u8 mode = BPF_MODE(code);
+
+		/* LD_IMM64 */
+		if (mode == BPF_IMM)
+			return true;
+
+		/* Both LD_IND and LD_ABS return 32-bit data. */
+		if (t != SRC_OP)
+			return  false;
+
+		/* Implicit ctx ptr. */
+		if (regno == BPF_REG_6)
+			return true;
+
+		/* Explicit source could be any width. */
+		return true;
+	}
+
+	if (class == BPF_ST)
+		/* The only source register for BPF_ST is a ptr. */
+		return true;
+
+	/* Conservatively return true at default. */
+	return true;
+}
+
 static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 			 enum reg_arg_type t)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
+	struct bpf_insn *insn = env->prog->insnsi + env->insn_idx;
 	struct bpf_reg_state *reg, *regs = state->regs;
+	bool rw64;
 
 	if (regno >= MAX_BPF_REG) {
 		verbose(env, "R%d is invalid\n", regno);
@@ -1185,6 +1268,7 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 	}
 
 	reg = &regs[regno];
+	rw64 = is_reg64(insn, regno, reg, t);
 	if (t == SRC_OP) {
 		/* check whether register used as source operand can be read */
 		if (reg->type == NOT_INIT) {
@@ -1195,7 +1279,8 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 		if (regno == BPF_REG_FP)
 			return 0;
 
-		return mark_reg_read(env, reg, reg->parent);
+		return mark_reg_read(env, reg, reg->parent,
+				     rw64 ? REG_LIVE_READ64 : REG_LIVE_READ32);
 	} else {
 		/* check whether register used as dest operand can be written to */
 		if (regno == BPF_REG_FP) {
@@ -1382,7 +1467,8 @@ static int check_stack_read(struct bpf_verifier_env *env,
 			state->regs[value_regno].live |= REG_LIVE_WRITTEN;
 		}
 		mark_reg_read(env, &reg_state->stack[spi].spilled_ptr,
-			      reg_state->stack[spi].spilled_ptr.parent);
+			      reg_state->stack[spi].spilled_ptr.parent,
+			      REG_LIVE_READ64);
 		return 0;
 	} else {
 		int zeros = 0;
@@ -1399,7 +1485,9 @@ static int check_stack_read(struct bpf_verifier_env *env,
 			return -EACCES;
 		}
 		mark_reg_read(env, &reg_state->stack[spi].spilled_ptr,
-			      reg_state->stack[spi].spilled_ptr.parent);
+			      reg_state->stack[spi].spilled_ptr.parent,
+			      size == BPF_REG_SIZE
+			      ? REG_LIVE_READ64 : REG_LIVE_READ32);
 		if (value_regno >= 0) {
 			if (zeros == size) {
 				/* any size read into register is zero extended,
@@ -2336,7 +2424,9 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
 		 * the whole slot to be marked as 'read'
 		 */
 		mark_reg_read(env, &state->stack[spi].spilled_ptr,
-			      state->stack[spi].spilled_ptr.parent);
+			      state->stack[spi].spilled_ptr.parent,
+			      access_size == BPF_REG_SIZE
+			      ? REG_LIVE_READ64 : REG_LIVE_READ32);
 	}
 	return update_stack_depth(env, state, min_off);
 }
@@ -6196,12 +6286,19 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
 				  struct bpf_reg_state *reg,
 				  struct bpf_reg_state *parent_reg)
 {
+	u8 parent_bits = parent_reg->live & REG_LIVE_READ;
+	u8 bits = reg->live & REG_LIVE_READ;
+	u8 bits_diff = parent_bits ^ bits;
+	u8 bits_prop = bits_diff & bits;
 	int err;
 
-	if (parent_reg->live & REG_LIVE_READ || !(reg->live & REG_LIVE_READ))
+	/* "reg" and "parent_reg" has the same read bits, or the bit doesn't
+	 * belong to "reg".
+	 */
+	if (!bits_diff || !bits_prop)
 		return 0;
 
-	err = mark_reg_read(env, reg, parent_reg);
+	err = mark_reg_read(env, reg, parent_reg, bits_prop);
 	if (err)
 		return err;
 
-- 
2.7.4

