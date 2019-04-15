Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7127EC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379AA2183F
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="AASpbTNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfDOR0k (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:26:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38197 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfDOR0j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:26:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so23034743wro.5
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dgi4wERAFj1Xhn1vp6Z/GOnemM6lGF5dz6R1stetD64=;
        b=AASpbTNoZNQx9lsquKypdk61fkH2ALmb0he+Bs1enTe1yQRt0M35C7LuXq5TTih5+x
         +uZEB6eG6uJxsTmp/4SMpHWSulPXsusikNTSluEYI85XfJK034MSAWTi4DG2Uk9y4dLT
         sk5w6TkGqJPCq1IvxbOoU7WEw4ta31xUz8AWl0+xytflQ1eGBF+CAoyqNAX7BSzf6jJd
         VrA0Vdv8xhQ5AxHpY2zlVqr1uX3nAmgjmljaTiWTGiO99kEEnuyq+gWRVdKSJrdjmo2Q
         23D2cnJNExyFsytoKDCSkNrHeS7TcS2x8BTHaDbNJSQj3Li8j97HslrpWpZ8tq9vTdsH
         6C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dgi4wERAFj1Xhn1vp6Z/GOnemM6lGF5dz6R1stetD64=;
        b=t4hunSK9t11bnY8fLB1WW7A8Dm85Zv2rcM4MvP5NyMdAKkU8eLova1KBUjFQHhSb8d
         c5K/ffAcSkyYkhcvgdFI8F4msOG/Pc2IfhZTGn1gF6ztfmY/aywDf26/ThMya49iv8PY
         Ms6BAqRqKMvMy6UPvEyFYweFdxK9weiwI3suJrelYA1KmUB+fvHYUTeaqw8+9cEWz3JA
         U4c+IWX1EA4rxRWgzei6b1EHHQux00JTvZEOpgr2U2ROEhGgbQGGvKUeiKNrsQScm/eA
         Z536n8NbHq7PH6u46arnWCohxjD2ReWEo3vSqhj33JjSUy5DGzXdragEtsSk4DcwDZLR
         k5Cw==
X-Gm-Message-State: APjAAAU5omVpTD8gkXwIYDyMF5kmmBxn9fH7Q9xD+EUWui46SJG4qDrN
        EN+Smh6a6u8c3rGg4Z34lRH62+nCM6E=
X-Google-Smtp-Source: APXvYqxMJ2aXHXt8YDFkY/2UryeMlMNyfmpLGCY2llDxoSTo3Gdfk0XGE6puNCnZiCId3FG0KuEROw==
X-Received: by 2002:adf:f68d:: with SMTP id v13mr47226860wrp.6.1555349197158;
        Mon, 15 Apr 2019 10:26:37 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v190sm27094232wme.18.2019.04.15.10.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 10:26:35 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v4 bpf-next 01/15] bpf: split read liveness into REG_LIVE_READ64 and REG_LIVE_READ32
Date:   Mon, 15 Apr 2019 18:26:11 +0100
Message-Id: <1555349185-12508-2-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
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
 2 files changed, 115 insertions(+), 12 deletions(-)

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
index c722015..5784b279 100644
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
@@ -1150,17 +1150,23 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 				parent->var_off.value, parent->off);
 			return -EFAULT;
 		}
-		if (parent->live & REG_LIVE_READ)
+		/* The first condition is much more likely to be true than the
+		 * second, make it checked first.
+		 */
+		if ((parent->live & REG_LIVE_READ) == flags ||
+		    parent->live & REG_LIVE_READ64)
 			/* The parentage chain never changes and
 			 * this parent was already marked as LIVE_READ.
 			 * There is no need to keep walking the chain again and
 			 * keep re-marking all parents as LIVE_READ.
 			 * This case happens when the same register is read
 			 * multiple times without writes into it in-between.
+			 * Also, if parent has REG_LIVE_READ64 set, then no need
+			 * to set the weak REG_LIVE_READ32.
 			 */
 			break;
 		/* ... then we depend on parent's value */
-		parent->live |= REG_LIVE_READ;
+		parent->live |= flags;
 		state = parent;
 		parent = state->parent;
 		writes = true;
@@ -1172,12 +1178,95 @@ static int mark_reg_read(struct bpf_verifier_env *env,
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
@@ -1185,6 +1274,7 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 	}
 
 	reg = &regs[regno];
+	rw64 = is_reg64(insn, regno, reg, t);
 	if (t == SRC_OP) {
 		/* check whether register used as source operand can be read */
 		if (reg->type == NOT_INIT) {
@@ -1195,7 +1285,8 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 		if (regno == BPF_REG_FP)
 			return 0;
 
-		return mark_reg_read(env, reg, reg->parent);
+		return mark_reg_read(env, reg, reg->parent,
+				     rw64 ? REG_LIVE_READ64 : REG_LIVE_READ32);
 	} else {
 		/* check whether register used as dest operand can be written to */
 		if (regno == BPF_REG_FP) {
@@ -1382,7 +1473,8 @@ static int check_stack_read(struct bpf_verifier_env *env,
 			state->regs[value_regno].live |= REG_LIVE_WRITTEN;
 		}
 		mark_reg_read(env, &reg_state->stack[spi].spilled_ptr,
-			      reg_state->stack[spi].spilled_ptr.parent);
+			      reg_state->stack[spi].spilled_ptr.parent,
+			      REG_LIVE_READ64);
 		return 0;
 	} else {
 		int zeros = 0;
@@ -1399,7 +1491,9 @@ static int check_stack_read(struct bpf_verifier_env *env,
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
@@ -2337,7 +2431,9 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
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
@@ -6227,12 +6323,17 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
 				  struct bpf_reg_state *reg,
 				  struct bpf_reg_state *parent_reg)
 {
+	u8 parent_bits = parent_reg->live & REG_LIVE_READ;
+	u8 bits = reg->live & REG_LIVE_READ;
+	u8 bits_diff = parent_bits ^ bits;
+	u8 bits_prop = bits_diff & bits;
 	int err;
 
-	if (parent_reg->live & REG_LIVE_READ || !(reg->live & REG_LIVE_READ))
+	/* No diff bit comes from "reg". */
+	if (!bits_prop)
 		return 0;
 
-	err = mark_reg_read(env, reg, parent_reg);
+	err = mark_reg_read(env, reg, parent_reg, bits_prop);
 	if (err)
 		return err;
 
-- 
2.7.4

