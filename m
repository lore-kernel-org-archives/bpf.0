Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF37C10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3CF218A1
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="fGNHMh/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfDOR06 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:26:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39376 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfDOR04 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:26:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so22995732wrn.6
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qxA1L/gVWESQpZ3Mokilcchz/Sf49i0tM5B88NgcAXI=;
        b=fGNHMh/S4Ip66Mu37dXdYgiMYnIQaBV7cvE9F8cmzlmxCh1t5bU4UFJBHSbmTjE/Mk
         9x1myLH2dbKWxyiR3Rf3zJQhf625wQeVCTBK0lv5n5tikN7FIdp0K99PSOBX/tgIIVxN
         rFRUWAHtjhDnevhwkWXEecuho18nvG8BPLgctvTc+UXX6dR+LDSoLlQH4i+Y6SWJRDRy
         aeSWSBlDEjvhpe+Vs0xURjCMy0At2+8qshriNeMDooMuJX/CB0bQGep0yTOpQLsXgh1Y
         W2j2CXgW0lxW4gTqY5F7zyQgGMyXLWoiS3YlBmw3yxsOG8q05nyN2cRDa0g9/lpcOIsd
         HfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qxA1L/gVWESQpZ3Mokilcchz/Sf49i0tM5B88NgcAXI=;
        b=f3nHuw3Xlbe6ZOOGB594IGRTtx+CioRSN1CElouALjANeTrxPQ9kRTTMy9yPWuZ8ge
         m6BblJk3c9FzoKUi+AXkNQ3aexZayDdQjzZLGY8BQ1a5Ydl2317nNCJhi6qPxPjGjDGY
         xOOvj0ID1ft80esiy2q7SVOyBU5MfTnYyhwPfj0nYT6eLqRfdU7PMTFl4hyogVEUbffc
         oW3VmZKTnD9bHbEJGToS/7rTKL7YSEolxhR5DQEy2fvAemQjcKAULcZp+6VSfal4sK0O
         AKBX69y5CxuXGtxhmJFV5TrIx2GhxTUR203M0ehVHvP+flNkEBpOFAw0o8G9fQrOwLmy
         s73w==
X-Gm-Message-State: APjAAAW+86Uo1awnaCxrQ6Tmn9t+Oe66PKyCMFEhVlybSzhjq9jphNy2
        51fViGbqlTO8ZQ2wNnYiycsVew==
X-Google-Smtp-Source: APXvYqwoLIAb9Xwqdp1Xdl2knZ8mcbtNF7GEoN4l1cWwaqxy14T8SagTESqqo601zz+unws97dV/Vg==
X-Received: by 2002:a5d:4492:: with SMTP id j18mr5038268wrq.212.1555349213368;
        Mon, 15 Apr 2019 10:26:53 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v190sm27094232wme.18.2019.04.15.10.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 10:26:52 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v4 bpf-next 15/15] nfp: bpf: eliminate zero extension code-gen
Date:   Mon, 15 Apr 2019 18:26:25 +0100
Message-Id: <1555349185-12508-16-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch eliminate zero extension code-gen for instructions except
load/store when possible.

Elimination for load/store will be supported in up coming patches.

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 drivers/net/ethernet/netronome/nfp/bpf/jit.c      | 119 +++++++++++++---------
 drivers/net/ethernet/netronome/nfp/bpf/main.h     |   2 +
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c |  12 +++
 3 files changed, 83 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
index f272247..eb30c52 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
@@ -612,6 +612,13 @@ static void wrp_immed(struct nfp_prog *nfp_prog, swreg dst, u32 imm)
 }
 
 static void
+wrp_zext(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta, u8 dst)
+{
+	if (meta->flags & FLAG_INSN_DO_ZEXT)
+		wrp_immed(nfp_prog, reg_both(dst + 1), 0);
+}
+
+static void
 wrp_immed_relo(struct nfp_prog *nfp_prog, swreg dst, u32 imm,
 	       enum nfp_relo_type relo)
 {
@@ -847,7 +854,8 @@ static int nfp_cpp_memcpy(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 }
 
 static int
-data_ld(struct nfp_prog *nfp_prog, swreg offset, u8 dst_gpr, int size)
+data_ld(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta, swreg offset,
+	u8 dst_gpr, int size)
 {
 	unsigned int i;
 	u16 shift, sz;
@@ -870,14 +878,15 @@ data_ld(struct nfp_prog *nfp_prog, swreg offset, u8 dst_gpr, int size)
 			wrp_mov(nfp_prog, reg_both(dst_gpr + i), reg_xfer(i));
 
 	if (i < 2)
-		wrp_immed(nfp_prog, reg_both(dst_gpr + 1), 0);
+		wrp_zext(nfp_prog, meta, dst_gpr);
 
 	return 0;
 }
 
 static int
-data_ld_host_order(struct nfp_prog *nfp_prog, u8 dst_gpr,
-		   swreg lreg, swreg rreg, int size, enum cmd_mode mode)
+data_ld_host_order(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
+		   u8 dst_gpr, swreg lreg, swreg rreg, int size,
+		   enum cmd_mode mode)
 {
 	unsigned int i;
 	u8 mask, sz;
@@ -900,33 +909,34 @@ data_ld_host_order(struct nfp_prog *nfp_prog, u8 dst_gpr,
 			wrp_mov(nfp_prog, reg_both(dst_gpr + i), reg_xfer(i));
 
 	if (i < 2)
-		wrp_immed(nfp_prog, reg_both(dst_gpr + 1), 0);
+		wrp_zext(nfp_prog, meta, dst_gpr);
 
 	return 0;
 }
 
 static int
-data_ld_host_order_addr32(struct nfp_prog *nfp_prog, u8 src_gpr, swreg offset,
-			  u8 dst_gpr, u8 size)
+data_ld_host_order_addr32(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
+			  u8 src_gpr, swreg offset, u8 dst_gpr, u8 size)
 {
-	return data_ld_host_order(nfp_prog, dst_gpr, reg_a(src_gpr), offset,
-				  size, CMD_MODE_32b);
+	return data_ld_host_order(nfp_prog, meta, dst_gpr, reg_a(src_gpr),
+				  offset, size, CMD_MODE_32b);
 }
 
 static int
-data_ld_host_order_addr40(struct nfp_prog *nfp_prog, u8 src_gpr, swreg offset,
-			  u8 dst_gpr, u8 size)
+data_ld_host_order_addr40(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
+			  u8 src_gpr, swreg offset, u8 dst_gpr, u8 size)
 {
 	swreg rega, regb;
 
 	addr40_offset(nfp_prog, src_gpr, offset, &rega, &regb);
 
-	return data_ld_host_order(nfp_prog, dst_gpr, rega, regb,
+	return data_ld_host_order(nfp_prog, meta, dst_gpr, rega, regb,
 				  size, CMD_MODE_40b_BA);
 }
 
 static int
-construct_data_ind_ld(struct nfp_prog *nfp_prog, u16 offset, u16 src, u8 size)
+construct_data_ind_ld(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
+		      u16 offset, u16 src, u8 size)
 {
 	swreg tmp_reg;
 
@@ -942,10 +952,12 @@ construct_data_ind_ld(struct nfp_prog *nfp_prog, u16 offset, u16 src, u8 size)
 	emit_br_relo(nfp_prog, BR_BLO, BR_OFF_RELO, 0, RELO_BR_GO_ABORT);
 
 	/* Load data */
-	return data_ld(nfp_prog, imm_b(nfp_prog), 0, size);
+	return data_ld(nfp_prog, meta, imm_b(nfp_prog), 0, size);
 }
 
-static int construct_data_ld(struct nfp_prog *nfp_prog, u16 offset, u8 size)
+static int
+construct_data_ld(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
+		  u16 offset, u8 size)
 {
 	swreg tmp_reg;
 
@@ -956,7 +968,7 @@ static int construct_data_ld(struct nfp_prog *nfp_prog, u16 offset, u8 size)
 
 	/* Load data */
 	tmp_reg = re_load_imm_any(nfp_prog, offset, imm_b(nfp_prog));
-	return data_ld(nfp_prog, tmp_reg, 0, size);
+	return data_ld(nfp_prog, meta, tmp_reg, 0, size);
 }
 
 static int
@@ -1193,7 +1205,7 @@ mem_op_stack(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 	}
 
 	if (clr_gpr && size < 8)
-		wrp_immed(nfp_prog, reg_both(gpr + 1), 0);
+		wrp_zext(nfp_prog, meta, gpr);
 
 	while (size) {
 		u32 slice_end;
@@ -1294,9 +1306,10 @@ wrp_alu32_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 	      enum alu_op alu_op)
 {
 	const struct bpf_insn *insn = &meta->insn;
+	u8 dst = insn->dst_reg * 2;
 
-	wrp_alu_imm(nfp_prog, insn->dst_reg * 2, alu_op, insn->imm);
-	wrp_immed(nfp_prog, reg_both(insn->dst_reg * 2 + 1), 0);
+	wrp_alu_imm(nfp_prog, dst, alu_op, insn->imm);
+	wrp_zext(nfp_prog, meta, dst);
 
 	return 0;
 }
@@ -1308,7 +1321,7 @@ wrp_alu32_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 	u8 dst = meta->insn.dst_reg * 2, src = meta->insn.src_reg * 2;
 
 	emit_alu(nfp_prog, reg_both(dst), reg_a(dst), alu_op, reg_b(src));
-	wrp_immed(nfp_prog, reg_both(meta->insn.dst_reg * 2 + 1), 0);
+	wrp_zext(nfp_prog, meta, dst);
 
 	return 0;
 }
@@ -2385,12 +2398,14 @@ static int neg_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 	u8 dst = meta->insn.dst_reg * 2;
 
 	emit_alu(nfp_prog, reg_both(dst), reg_imm(0), ALU_OP_SUB, reg_b(dst));
-	wrp_immed(nfp_prog, reg_both(meta->insn.dst_reg * 2 + 1), 0);
+	wrp_zext(nfp_prog, meta, dst);
 
 	return 0;
 }
 
-static int __ashr_imm(struct nfp_prog *nfp_prog, u8 dst, u8 shift_amt)
+static int
+__ashr_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta, u8 dst,
+	   u8 shift_amt)
 {
 	if (shift_amt) {
 		/* Set signedness bit (MSB of result). */
@@ -2399,7 +2414,7 @@ static int __ashr_imm(struct nfp_prog *nfp_prog, u8 dst, u8 shift_amt)
 		emit_shf(nfp_prog, reg_both(dst), reg_none(), SHF_OP_ASHR,
 			 reg_b(dst), SHF_SC_R_SHF, shift_amt);
 	}
-	wrp_immed(nfp_prog, reg_both(dst + 1), 0);
+	wrp_zext(nfp_prog, meta, dst);
 
 	return 0;
 }
@@ -2414,7 +2429,7 @@ static int ashr_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 	umin = meta->umin_src;
 	umax = meta->umax_src;
 	if (umin == umax)
-		return __ashr_imm(nfp_prog, dst, umin);
+		return __ashr_imm(nfp_prog, meta, dst, umin);
 
 	src = insn->src_reg * 2;
 	/* NOTE: the first insn will set both indirect shift amount (source A)
@@ -2423,7 +2438,7 @@ static int ashr_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 	emit_alu(nfp_prog, reg_none(), reg_a(src), ALU_OP_OR, reg_b(dst));
 	emit_shf_indir(nfp_prog, reg_both(dst), reg_none(), SHF_OP_ASHR,
 		       reg_b(dst), SHF_SC_R_SHF);
-	wrp_immed(nfp_prog, reg_both(dst + 1), 0);
+	wrp_zext(nfp_prog, meta, dst);
 
 	return 0;
 }
@@ -2433,15 +2448,17 @@ static int ashr_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 	const struct bpf_insn *insn = &meta->insn;
 	u8 dst = insn->dst_reg * 2;
 
-	return __ashr_imm(nfp_prog, dst, insn->imm);
+	return __ashr_imm(nfp_prog, meta, dst, insn->imm);
 }
 
-static int __shr_imm(struct nfp_prog *nfp_prog, u8 dst, u8 shift_amt)
+static int
+__shr_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta, u8 dst,
+	  u8 shift_amt)
 {
 	if (shift_amt)
 		emit_shf(nfp_prog, reg_both(dst), reg_none(), SHF_OP_NONE,
 			 reg_b(dst), SHF_SC_R_SHF, shift_amt);
-	wrp_immed(nfp_prog, reg_both(dst + 1), 0);
+	wrp_zext(nfp_prog, meta, dst);
 	return 0;
 }
 
@@ -2450,7 +2467,7 @@ static int shr_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 	const struct bpf_insn *insn = &meta->insn;
 	u8 dst = insn->dst_reg * 2;
 
-	return __shr_imm(nfp_prog, dst, insn->imm);
+	return __shr_imm(nfp_prog, meta, dst, insn->imm);
 }
 
 static int shr_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -2463,22 +2480,24 @@ static int shr_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 	umin = meta->umin_src;
 	umax = meta->umax_src;
 	if (umin == umax)
-		return __shr_imm(nfp_prog, dst, umin);
+		return __shr_imm(nfp_prog, meta, dst, umin);
 
 	src = insn->src_reg * 2;
 	emit_alu(nfp_prog, reg_none(), reg_a(src), ALU_OP_OR, reg_imm(0));
 	emit_shf_indir(nfp_prog, reg_both(dst), reg_none(), SHF_OP_NONE,
 		       reg_b(dst), SHF_SC_R_SHF);
-	wrp_immed(nfp_prog, reg_both(dst + 1), 0);
+	wrp_zext(nfp_prog, meta, dst);
 	return 0;
 }
 
-static int __shl_imm(struct nfp_prog *nfp_prog, u8 dst, u8 shift_amt)
+static int
+__shl_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta, u8 dst,
+	  u8 shift_amt)
 {
 	if (shift_amt)
 		emit_shf(nfp_prog, reg_both(dst), reg_none(), SHF_OP_NONE,
 			 reg_b(dst), SHF_SC_L_SHF, shift_amt);
-	wrp_immed(nfp_prog, reg_both(dst + 1), 0);
+	wrp_zext(nfp_prog, meta, dst);
 	return 0;
 }
 
@@ -2487,7 +2506,7 @@ static int shl_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 	const struct bpf_insn *insn = &meta->insn;
 	u8 dst = insn->dst_reg * 2;
 
-	return __shl_imm(nfp_prog, dst, insn->imm);
+	return __shl_imm(nfp_prog, meta, dst, insn->imm);
 }
 
 static int shl_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -2500,11 +2519,11 @@ static int shl_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 	umin = meta->umin_src;
 	umax = meta->umax_src;
 	if (umin == umax)
-		return __shl_imm(nfp_prog, dst, umin);
+		return __shl_imm(nfp_prog, meta, dst, umin);
 
 	src = insn->src_reg * 2;
 	shl_reg64_lt32_low(nfp_prog, dst, src);
-	wrp_immed(nfp_prog, reg_both(dst + 1), 0);
+	wrp_zext(nfp_prog, meta, dst);
 	return 0;
 }
 
@@ -2566,34 +2585,34 @@ static int imm_ld8(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int data_ld1(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return construct_data_ld(nfp_prog, meta->insn.imm, 1);
+	return construct_data_ld(nfp_prog, meta, meta->insn.imm, 1);
 }
 
 static int data_ld2(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return construct_data_ld(nfp_prog, meta->insn.imm, 2);
+	return construct_data_ld(nfp_prog, meta, meta->insn.imm, 2);
 }
 
 static int data_ld4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return construct_data_ld(nfp_prog, meta->insn.imm, 4);
+	return construct_data_ld(nfp_prog, meta, meta->insn.imm, 4);
 }
 
 static int data_ind_ld1(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return construct_data_ind_ld(nfp_prog, meta->insn.imm,
+	return construct_data_ind_ld(nfp_prog, meta, meta->insn.imm,
 				     meta->insn.src_reg * 2, 1);
 }
 
 static int data_ind_ld2(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return construct_data_ind_ld(nfp_prog, meta->insn.imm,
+	return construct_data_ind_ld(nfp_prog, meta, meta->insn.imm,
 				     meta->insn.src_reg * 2, 2);
 }
 
 static int data_ind_ld4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return construct_data_ind_ld(nfp_prog, meta->insn.imm,
+	return construct_data_ind_ld(nfp_prog, meta, meta->insn.imm,
 				     meta->insn.src_reg * 2, 4);
 }
 
@@ -2632,7 +2651,7 @@ static int mem_ldx_skb(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 		return -EOPNOTSUPP;
 	}
 
-	wrp_immed(nfp_prog, reg_both(meta->insn.dst_reg * 2 + 1), 0);
+	wrp_zext(nfp_prog, meta, dst);
 
 	return 0;
 }
@@ -2658,7 +2677,7 @@ static int mem_ldx_xdp(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 		return -EOPNOTSUPP;
 	}
 
-	wrp_immed(nfp_prog, reg_both(meta->insn.dst_reg * 2 + 1), 0);
+	wrp_zext(nfp_prog, meta, dst);
 
 	return 0;
 }
@@ -2671,7 +2690,7 @@ mem_ldx_data(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 
 	tmp_reg = re_load_imm_any(nfp_prog, meta->insn.off, imm_b(nfp_prog));
 
-	return data_ld_host_order_addr32(nfp_prog, meta->insn.src_reg * 2,
+	return data_ld_host_order_addr32(nfp_prog, meta, meta->insn.src_reg * 2,
 					 tmp_reg, meta->insn.dst_reg * 2, size);
 }
 
@@ -2683,7 +2702,7 @@ mem_ldx_emem(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 
 	tmp_reg = re_load_imm_any(nfp_prog, meta->insn.off, imm_b(nfp_prog));
 
-	return data_ld_host_order_addr40(nfp_prog, meta->insn.src_reg * 2,
+	return data_ld_host_order_addr40(nfp_prog, meta, meta->insn.src_reg * 2,
 					 tmp_reg, meta->insn.dst_reg * 2, size);
 }
 
@@ -2744,7 +2763,7 @@ mem_ldx_data_from_pktcache_unaligned(struct nfp_prog *nfp_prog,
 	wrp_reg_subpart(nfp_prog, dst_lo, src_lo, len_lo, off);
 
 	if (!len_mid) {
-		wrp_immed(nfp_prog, dst_hi, 0);
+		wrp_zext(nfp_prog, meta, dst_gpr);
 		return 0;
 	}
 
@@ -2752,7 +2771,7 @@ mem_ldx_data_from_pktcache_unaligned(struct nfp_prog *nfp_prog,
 
 	if (size <= REG_WIDTH) {
 		wrp_reg_or_subpart(nfp_prog, dst_lo, src_mid, len_mid, len_lo);
-		wrp_immed(nfp_prog, dst_hi, 0);
+		wrp_zext(nfp_prog, meta, dst_gpr);
 	} else {
 		swreg src_hi = reg_xfer(idx + 2);
 
@@ -2783,10 +2802,10 @@ mem_ldx_data_from_pktcache_aligned(struct nfp_prog *nfp_prog,
 
 	if (size < REG_WIDTH) {
 		wrp_reg_subpart(nfp_prog, dst_lo, src_lo, size, 0);
-		wrp_immed(nfp_prog, dst_hi, 0);
+		wrp_zext(nfp_prog, meta, dst_gpr);
 	} else if (size == REG_WIDTH) {
 		wrp_mov(nfp_prog, dst_lo, src_lo);
-		wrp_immed(nfp_prog, dst_hi, 0);
+		wrp_zext(nfp_prog, meta, dst_gpr);
 	} else {
 		swreg src_hi = reg_xfer(idx + 1);
 
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/main.h b/drivers/net/ethernet/netronome/nfp/bpf/main.h
index b25a482..7369bdf 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/main.h
+++ b/drivers/net/ethernet/netronome/nfp/bpf/main.h
@@ -249,6 +249,8 @@ struct nfp_bpf_reg_state {
 #define FLAG_INSN_SKIP_PREC_DEPENDENT		BIT(4)
 /* Instruction is optimized by the verifier */
 #define FLAG_INSN_SKIP_VERIFIER_OPT		BIT(5)
+/* Instruction needs to zero extend to high 32-bit */
+#define FLAG_INSN_DO_ZEXT			BIT(6)
 
 #define FLAG_INSN_SKIP_MASK		(FLAG_INSN_SKIP_NOOP | \
 					 FLAG_INSN_SKIP_PREC_DEPENDENT | \
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
index 36f56eb..e92ee51 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
@@ -744,6 +744,17 @@ static unsigned int nfp_bpf_get_stack_usage(struct nfp_prog *nfp_prog)
 	goto continue_subprog;
 }
 
+static void nfp_bpf_insn_flag_zext(struct nfp_prog *nfp_prog,
+				   struct bpf_insn_aux_data *aux)
+{
+	struct nfp_insn_meta *meta;
+
+	list_for_each_entry(meta, &nfp_prog->insns, l) {
+		if (aux[meta->n].zext_dst)
+			meta->flags |= FLAG_INSN_DO_ZEXT;
+	}
+}
+
 int nfp_bpf_finalize(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *info;
@@ -784,6 +795,7 @@ int nfp_bpf_finalize(struct bpf_verifier_env *env)
 		return -EOPNOTSUPP;
 	}
 
+	nfp_bpf_insn_flag_zext(nfp_prog, env->insn_aux_data);
 	return 0;
 }
 
-- 
2.7.4

