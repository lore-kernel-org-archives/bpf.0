Return-Path: <SRS0=IWuG=RQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F6CC43381
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 19:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3502075C
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 19:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504917;
	bh=uBf6WCT8Qyp8OuImBV093cQtIIH1L1rnpU82AcuQQrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q253zQx8SzA0dFZdP+kEpViMdPcouNGZX5doHfHvXXJB8iZpt8DfASVYxch1cuxqE
	 ZrhUaIijuO+zPhiv9XjigtcqDCy5BuEqJPkQPYnIm8Y92MP7BVozmiyCpNxGle0Xgl
	 ui7PVLD+ud6Q/OaBhVL0W5mdMUHJJHXbPW8SX/So=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfCMTR4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbfCMTR4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Mar 2019 15:17:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E952075C;
        Wed, 13 Mar 2019 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504675;
        bh=uBf6WCT8Qyp8OuImBV093cQtIIH1L1rnpU82AcuQQrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRd2BbAzXD4dYwdsB3QvnfGF5YaqjjBCm5AceF6KC5MQSUJX9/wAooR3EjzcE5WNd
         MPA6CTGPpkVDmQOxSEVps8+lCRvDXkFDfwkGXxgf4Yuq0Ogo1xZ6gLx3Fs7P2SkGhz
         H9gEB3FbvT/wf8MqrAeSqS8/ONY8rp3I+VLAVdV0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, oss-drivers@netronome.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 22/24] nfp: bpf: fix ALU32 high bits clearance bug
Date:   Wed, 13 Mar 2019 15:16:45 -0400
Message-Id: <20190313191647.160171-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191647.160171-1-sashal@kernel.org>
References: <20190313191647.160171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jiong Wang <jiong.wang@netronome.com>

[ Upstream commit f036ebd9bfbe1e91a3d855e85e05fc5ff156b641 ]

NFP BPF JIT compiler is doing a couple of small optimizations when jitting
ALU imm instructions, some of these optimizations could save code-gen, for
example:

  A & -1 =  A
  A |  0 =  A
  A ^  0 =  A

However, for ALU32, high 32-bit of the 64-bit register should still be
cleared according to ISA semantics.

Fixes: cd7df56ed3e6 ("nfp: add BPF to NFP code translator")
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/netronome/nfp/nfp_bpf_jit.c    | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_bpf_jit.c b/drivers/net/ethernet/netronome/nfp/nfp_bpf_jit.c
index 6bfcd6eb74ca..73087770d72f 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_bpf_jit.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_bpf_jit.c
@@ -756,15 +756,10 @@ wrp_alu64_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 
 static int
 wrp_alu32_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
-	      enum alu_op alu_op, bool skip)
+	      enum alu_op alu_op)
 {
 	const struct bpf_insn *insn = &meta->insn;
 
-	if (skip) {
-		meta->skip = true;
-		return 0;
-	}
-
 	wrp_alu_imm(nfp_prog, insn->dst_reg * 2, alu_op, insn->imm);
 	wrp_immed(nfp_prog, reg_both(insn->dst_reg * 2 + 1), 0);
 
@@ -1017,7 +1012,7 @@ static int xor_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int xor_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_XOR, !meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_XOR);
 }
 
 static int and_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -1027,7 +1022,7 @@ static int and_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int and_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_AND, !~meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_AND);
 }
 
 static int or_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -1037,7 +1032,7 @@ static int or_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int or_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_OR, !meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_OR);
 }
 
 static int add_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -1047,7 +1042,7 @@ static int add_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int add_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_ADD, !meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_ADD);
 }
 
 static int sub_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
@@ -1057,7 +1052,7 @@ static int sub_reg(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 static int sub_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 {
-	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_SUB, !meta->insn.imm);
+	return wrp_alu32_imm(nfp_prog, meta, ALU_OP_SUB);
 }
 
 static int shl_imm(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
-- 
2.19.1

