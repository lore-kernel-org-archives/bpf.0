Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2DDC282CE
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6350E2084D
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="X7hc/3Gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfDLWAm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46627 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfDLWAJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so13678481wrw.13
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Bth1/39lYXfmckbmsiuKqNidJbiikbB2x6UCWPFtnE=;
        b=X7hc/3GkhiE2EOcLELr74UaCPhQ5nCRpptUAks8871eObf54Y4+G/SrERs1q0NEU0D
         ssSibwaCGLdCBNOGLiwUVrub655Lj50wXi7cO6q6PlQjdETwn/juLkAELh9P6Xqbeo5f
         qhewwAyF6jDwlEzKMIKT2PzHawTDlgVF1Vg1f6qbdIte74RCF9h5qKhIqQkhvNO+eNRP
         MnwwmBVSm/91wi16EUDSMzZ91GrgYfAmxhBE3pmxEACvp8riCz9FJ7t/aK1cOe7js3wl
         6z6oxIG7sHWvaDYhT7uO+2/b+PmxnbLRb9WCqPQc4p53bmEF2TzHy+AziOkpRuTHL79k
         Xy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Bth1/39lYXfmckbmsiuKqNidJbiikbB2x6UCWPFtnE=;
        b=Y0sNAVufBBTfkswaiekW4gNKnRmx7TatQDaT81y7W5iup7fugK74D4znpBSkGUjhYJ
         h6t8VGxJ4RE5GGq68939JDE1F3pnpd7olNiAtrVq2TLnoFD5xQUDGhBGgm2x5dfnSFrD
         +5aNY88Hy3OzgAV28xZ2uku+kxQgFjk5JXWO8bihzAdFH2JBKt2BOjaX+Yh6nO3C7/8S
         Ywbc/pHxIa+0+HDp4+w31nac5s0SeE9U6FRfriFkNZyLV8wkm0iDgL/mJyeieTUSAxBg
         FDd7vtcWYfnYQizvkLqh2LNYgKkLf1zIT3dhTURWUTKtkZUbmnkWJ7P0uH0NBG8UmTsW
         vcJw==
X-Gm-Message-State: APjAAAWrDxljf5B8awqL67V3ONLcpHEzHLnIz8Ey7FJ8Y1ksOJSH7cbr
        uuZS23St51TjZElLX8Qh/D6zBw==
X-Google-Smtp-Source: APXvYqyfYVqH5BF4Cv1X5yIPKccmmEYQ967wfBjuRLAl2H8J8kPitchXYk+vrvTL6b5G9LvRSNdY/A==
X-Received: by 2002:adf:ce8c:: with SMTP id r12mr18363426wrn.60.1555106407407;
        Fri, 12 Apr 2019 15:00:07 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.15.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:06 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v3 bpf-next 05/19] bpf: split read liveness into REG_LIVE_READ64 and REG_LIVE_READ32
Date:   Fri, 12 Apr 2019 22:59:38 +0100
Message-Id: <1555106392-20117-6-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
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
index c722015..3c5ca00 100644
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
@@ -2337,7 +2425,9 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
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
@@ -6227,12 +6317,19 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
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

