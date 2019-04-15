Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9520BC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658792183F
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="FJp4BOJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfDOR0s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:26:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46046 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfDOR0s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:26:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so22973907wra.12
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u7fZb3IEqFJRYe0oJUr+G1NSo0sv1IV8cJXsSnOcig0=;
        b=FJp4BOJ8ZFFTw6SkPFnVfy4eM6wNv0nuPSUjFBB7cOjhmsA3Y43xCkEZAcOqWbfiV5
         wZOPi9STV1hNVnzvNLPL1PH0L/gnRVUjbVV9Q79dp8OSrWioFZOLh8sPNnp9D/si0fDc
         ra82qQvNFXTn2VudaYQH2zrbprJkzirVYQvSVJbM1ynQCDQTS0tUtat0YU5s0EJhfXKo
         eDv9Wwqpc/XA7tCbK/iZjK19GhiAS0Q9TO9B0wqlaVAFT/6sjXuJklAERuQ+7Y2NyhbH
         T0r/1t8GFu5R8faoTJz5c05JCrvePImI8xpB4/ocuV4SdhO78BidZ1RCBcmv5omS0XU4
         Y6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u7fZb3IEqFJRYe0oJUr+G1NSo0sv1IV8cJXsSnOcig0=;
        b=h6al5IzYvcZyo0IVheoXkf1exCFfFnmYr1L/38RDpIZCLB5hOXYeWlR92zPOfcFuMW
         uueDSTkDRfTqe0Ntu7gGitlkba/5NGQgK1liI6vnParmdFsmQcYki1/KkjhMC4s7PcIB
         mhVCCPOaD4cWoj59g8yNOb+XbvGZ2qhyZ3cxRKynA0CDn2/oAFTyzMrWU/HoGhv/d/c1
         nWGrZ8Crj9a2SE8gUUDH85fWt7Od9njq0FxUCBi+8uYK0hxDpHKp5VYrb2MM8+DXRqR0
         LyskojYGELOH4cSknm2/4T5nT/cXoeX4LJHlcfeFDhDoJSsQPh0cfpmwKyQfgdI/pM7n
         oNiQ==
X-Gm-Message-State: APjAAAU4snzeFjRaHSd8pc9nLZoQz6nXtUr6wC/qZ3+rd7WDAyQ4lOjJ
        gm7u1mKyiElmwSLHy+ZAXFSc8Q==
X-Google-Smtp-Source: APXvYqydvtS8ZUV+079FjiEAh8mMtGvrRvMp6LY5K3ubiqz7ZeQn16g8P73gKuuumknuF1hVT58N9g==
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr35063047wru.58.1555349206493;
        Mon, 15 Apr 2019 10:26:46 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v190sm27094232wme.18.2019.04.15.10.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 10:26:45 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        Shubham Bansal <illusionist.neo@gmail.com>
Subject: [PATCH v4 bpf-next 09/15] arm: bpf: eliminate zero extension code-gen
Date:   Mon, 15 Apr 2019 18:26:19 +0100
Message-Id: <1555349185-12508-10-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: Shubham Bansal <illusionist.neo@gmail.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/arm/net/bpf_jit_32.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index c8bfbbf..8cecd06 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -736,7 +736,8 @@ static inline void emit_a32_alu_r64(const bool is64, const s8 dst[],
 
 		/* ALU operation */
 		emit_alu_r(rd[1], rs, true, false, op, ctx);
-		emit_a32_mov_i(rd[0], 0, ctx);
+		if (ctx->prog->aux->no_verifier_zext)
+			emit_a32_mov_i(rd[0], 0, ctx);
 	}
 
 	arm_bpf_put_reg64(dst, rd, ctx);
@@ -758,8 +759,9 @@ static inline void emit_a32_mov_r64(const bool is64, const s8 dst[],
 				  struct jit_ctx *ctx) {
 	if (!is64) {
 		emit_a32_mov_r(dst_lo, src_lo, ctx);
-		/* Zero out high 4 bytes */
-		emit_a32_mov_i(dst_hi, 0, ctx);
+		if (ctx->prog->aux->no_verifier_zext)
+			/* Zero out high 4 bytes */
+			emit_a32_mov_i(dst_hi, 0, ctx);
 	} else if (__LINUX_ARM_ARCH__ < 6 &&
 		   ctx->cpu_architecture < CPU_ARCH_ARMv5TE) {
 		/* complete 8 byte move */
@@ -1438,7 +1440,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		}
 		emit_udivmod(rd_lo, rd_lo, rt, ctx, BPF_OP(code));
 		arm_bpf_put_reg32(dst_lo, rd_lo, ctx);
-		emit_a32_mov_i(dst_hi, 0, ctx);
+		if (ctx->prog->aux->no_verifier_zext)
+			emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
@@ -1453,7 +1456,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 			return -EINVAL;
 		if (imm)
 			emit_a32_alu_i(dst_lo, imm, ctx, BPF_OP(code));
-		emit_a32_mov_i(dst_hi, 0, ctx);
+		if (ctx->prog->aux->no_verifier_zext)
+			emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	/* dst = dst << imm */
 	case BPF_ALU64 | BPF_LSH | BPF_K:
@@ -1488,7 +1492,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* dst = ~dst */
 	case BPF_ALU | BPF_NEG:
 		emit_a32_alu_i(dst_lo, 0, ctx, BPF_OP(code));
-		emit_a32_mov_i(dst_hi, 0, ctx);
+		if (ctx->prog->aux->no_verifier_zext)
+			emit_a32_mov_i(dst_hi, 0, ctx);
 		break;
 	/* dst = ~dst (64 bit) */
 	case BPF_ALU64 | BPF_NEG:
@@ -1838,6 +1843,11 @@ void bpf_jit_compile(struct bpf_prog *prog)
 	/* Nothing to do here. We support Internal BPF. */
 }
 
+bool bpf_jit_hardware_zext(void)
+{
+	return false;
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	struct bpf_prog *tmp, *orig_prog = prog;
-- 
2.7.4

