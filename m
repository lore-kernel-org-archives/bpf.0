Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04A0C4360F
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1B42082F
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qCQ/JbIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbfCZSGl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42023 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732451AbfCZSGj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so12006891wrx.9
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9WXitAHkulex430Kpiw9BHjYykl0TxdU8tfkPsWWgwE=;
        b=qCQ/JbIEAvdU3/+D53teuOGKBWdAnKKyxoKNFO9ksD6Ii5XjwD5aMrytX2He0di1Rf
         flCgUWClRCfOHSOmdR0itbKnHO8uis7neFNnGUAX6Qil+4GcuL7gY3dyYA7qpT5EbI65
         rhCVpyNEEZeOGzO4NRjRsGIK9LJR1s2IYZU9oG3fQKHp+NVwjv1KzaWALYP1WaHm9dKf
         bQLVnAkTtx/j8qavFRGuh/KntX8xV/yFliC9kyzR2yhAR/iK2yYIgHFRXWUn7ZrmdLEP
         RY91imhTd1YK7mCJZFin7T/XABGqYx4eLWszhCGMlj1gWYOfc+NXz5nnNb6u/9Mglxpr
         X20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9WXitAHkulex430Kpiw9BHjYykl0TxdU8tfkPsWWgwE=;
        b=ZK2nzSr5IRnK2Vm4g8ljsbvN26/VHkmypsPrptgjDoCxA44TRb3yl/Xp9Ty0fwBb8F
         1sOKHJGJdm7F89eUtWEfYtBDHFHVOf5fwzbiRJfMMjfSQx+M+e53XK4cEmlWI5eL8RxC
         bjDRgFNYulLla4HQzLixGNqvdbHQZgdpi2lK9GkxxSDnzFx4Tg6dUgWUYHt3ilVSzxRk
         iewCHSgKxvjM3sTlHYJDi2zreUrCf+dEtIMLHd940Mdico3t4nV8vhHqkdkzlL/VPlhp
         tQvg4M1NqV/dg81x4ZyVky4xoYWtbgZuLdRd5r500h3tb1mzINZXCx2vwLYV1S8dKHLH
         yh9g==
X-Gm-Message-State: APjAAAU1vvXGHKm0eBRNYCVidkuM7HPIV92GaUicCG7iWoQBXMp56xFS
        vrEH4mYiRUWiCwM7taUtJtHdMQ==
X-Google-Smtp-Source: APXvYqxUFmAnnGo5W0ha/TISBlXiZBH5Odotvyo2sIMLnQCV2JBlPq25kOzmcKHspWctr9p0GucbAg==
X-Received: by 2002:adf:f1cc:: with SMTP id z12mr20443656wro.180.1553623597905;
        Tue, 26 Mar 2019 11:06:37 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:37 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH/RFC bpf-next 03/16] bpf: split read liveness into REG_LIVE_READ64 and REG_LIVE_READ32
Date:   Tue, 26 Mar 2019 18:05:26 +0000
Message-Id: <1553623539-15474-4-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In previous patch, we have split register arg type for sub-register read,
but haven't touch read liveness.

This patch further split read liveness into REG_LIVE_READ64 and
REG_LIVE_READ32. Liveness propagation code are updated accordingly.

After this split, customized actions could be defined when propagating full
register read (REG_LIVE_READ64) or sub-register read (REG_LIVE_READ32).

Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 include/linux/bpf_verifier.h |  9 ++++++---
 kernel/bpf/verifier.c        | 30 +++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f03c86a..27761ab 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -37,11 +37,14 @@
 /* Reg hasn't been read or written this branch. */
 #define REG_LIVE_NONE		0x0
 /* Reg was read, so we're sensitive to initial value. */
-#define REG_LIVE_READ		0x1
+#define REG_LIVE_READ32		0x1
+/* Likewise, but full 64-bit content matters. */
+#define REG_LIVE_READ64		0x2
+#define REG_LIVE_READ		(REG_LIVE_READ32 | REG_LIVE_READ64)
 /* Reg was written first, screening off later reads. */
-#define REG_LIVE_WRITTEN	0x2
+#define REG_LIVE_WRITTEN	0x4
 /* Liveness won't be updating this register anymore. */
-#define REG_LIVE_DONE		0x4
+#define REG_LIVE_DONE		0x8
 
 struct bpf_reg_state {
 	/* Ordering of fields matters.  See states_equal() */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 245bb3c..b95c438 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1126,7 +1126,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
  */
 static int mark_reg_read(struct bpf_verifier_env *env,
 			 const struct bpf_reg_state *state,
-			 struct bpf_reg_state *parent)
+			 struct bpf_reg_state *parent, bool dw_read)
 {
 	bool writes = parent == state->parent; /* Observe write marks */
 
@@ -1141,7 +1141,7 @@ static int mark_reg_read(struct bpf_verifier_env *env,
 			return -EFAULT;
 		}
 		/* ... then we depend on parent's value */
-		parent->live |= REG_LIVE_READ;
+		parent->live |= dw_read ? REG_LIVE_READ64 : REG_LIVE_READ32;
 		state = parent;
 		parent = state->parent;
 		writes = true;
@@ -1170,7 +1170,7 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 		/* We don't need to worry about FP liveness because it's read-only */
 		if (regno != BPF_REG_FP)
 			return mark_reg_read(env, &regs[regno],
-					     regs[regno].parent);
+					     regs[regno].parent, true);
 	} else {
 		/* check whether register used as dest operand can be written to */
 		if (regno == BPF_REG_FP) {
@@ -1357,7 +1357,7 @@ static int check_stack_read(struct bpf_verifier_env *env,
 			state->regs[value_regno].live |= REG_LIVE_WRITTEN;
 		}
 		mark_reg_read(env, &reg_state->stack[spi].spilled_ptr,
-			      reg_state->stack[spi].spilled_ptr.parent);
+			      reg_state->stack[spi].spilled_ptr.parent, true);
 		return 0;
 	} else {
 		int zeros = 0;
@@ -1374,7 +1374,8 @@ static int check_stack_read(struct bpf_verifier_env *env,
 			return -EACCES;
 		}
 		mark_reg_read(env, &reg_state->stack[spi].spilled_ptr,
-			      reg_state->stack[spi].spilled_ptr.parent);
+			      reg_state->stack[spi].spilled_ptr.parent,
+			      size == BPF_REG_SIZE);
 		if (value_regno >= 0) {
 			if (zeros == size) {
 				/* any size read into register is zero extended,
@@ -2220,7 +2221,8 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
 		 * the whole slot to be marked as 'read'
 		 */
 		mark_reg_read(env, &state->stack[spi].spilled_ptr,
-			      state->stack[spi].spilled_ptr.parent);
+			      state->stack[spi].spilled_ptr.parent,
+			      access_size == BPF_REG_SIZE);
 	}
 	return update_stack_depth(env, state, off);
 }
@@ -6059,7 +6061,7 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
 	if (parent_reg->live & flag || !(reg->live & flag))
 		return 0;
 
-	err = mark_reg_read(env, reg, parent_reg);
+	err = mark_reg_read(env, reg, parent_reg, flag == REG_LIVE_READ64);
 	if (err)
 		return err;
 
@@ -6092,7 +6094,12 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 	regs = vstate->frame[vstate->curframe]->regs;
 	/* We don't need to worry about FP liveness because it's read-only */
 	for (i = 0; i < BPF_REG_FP; i++) {
-		err = propagate_liveness_reg(env, &regs[i], &parent_regs[i]);
+		err = propagate_liveness_reg(env, &regs[i], &parent_regs[i],
+					     REG_LIVE_READ64);
+		if (err < 0)
+			return err;
+		err = propagate_liveness_reg(env, &regs[i], &parent_regs[i],
+					     REG_LIVE_READ32);
 		if (err < 0)
 			return err;
 	}
@@ -6107,7 +6114,12 @@ static int propagate_liveness(struct bpf_verifier_env *env,
 
 			parent_reg = &parent->stack[i].spilled_ptr;
 			reg = &state->stack[i].spilled_ptr;
-			err = propagate_liveness_reg(env, reg, parent_reg);
+			err = propagate_liveness_reg(env, reg, parent_reg,
+						     REG_LIVE_READ64);
+			if (err < 0)
+				return err;
+			err = propagate_liveness_reg(env, reg, parent_reg,
+						     REG_LIVE_READ32);
 			if (err < 0)
 				return err;
 		}
-- 
2.7.4

