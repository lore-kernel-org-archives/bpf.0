Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E984C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201652084B
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="PMBzJZyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfCZSHJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:07:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55229 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732495AbfCZSGr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id f3so13729152wmj.4
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u7fZb3IEqFJRYe0oJUr+G1NSo0sv1IV8cJXsSnOcig0=;
        b=PMBzJZyimubcntVcgh0pA6qard648dVzHUXODir6+ClbkXGCB5jsYBDwFmuPU4rShF
         09GBaGQMg2g2bh4nLtpHH0iUxz8IMWmKB4Djnv8oL3JhmtVuaquBJxC07XZG1kFlrFbO
         3YRMC6a23KRBwxVkSMEX8hCLmuPQr/XA4VAfbvcYygNDpOtmHnbGNFigFjb3csA5b+NA
         HpNq+ZAcKMJKLwmemT5YvHwFBGYJkPblikswy7RT9CdIu9dWNewRQSGnGv6fc39tmxDc
         41oXFP0LyW1jo8qSY35rJbzDALkZdo+BpfNqdeJztFlMXZJ2gLSu8PXCis3DN5eoJjS3
         Fuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u7fZb3IEqFJRYe0oJUr+G1NSo0sv1IV8cJXsSnOcig0=;
        b=AeAWg34WCzbPcP1TMXvZ9RaGks58yiUX+wgAafkkXgDMWMtSiSk8JGPIyAe6izclCd
         jZXWWhmvdzbeIRvw6mbMWZNARHU+J2/ktC5I6saH6awIy+8dRbZ6haXXBxWumGfEs+7G
         vaqiyGSeU2noOFA2mM6mBlpqVUTqJ6QV7CVGRQCCOWk9m8KXdcmdN20Ki6546EY9ulZ6
         ow4yHDW1FmD0hssJjXb7RHyaDA2tcSD4xmuSZfMuiSk7kwEuPhxstjjnuXVxwWwg7Zde
         P29X04c/0ts4P7VJepKLt1jFZlxfe8vapK6GaPrhpBQsMuyrgmltwk+VI7c+lSQ+z1LB
         ZECQ==
X-Gm-Message-State: APjAAAWpmpGLT4aajuKrr0iXUpC23LMQRivkrwc+ceIb7S5Hi2vGWNZ8
        dwrcn1KjnbYMr9ecPNTWeUvz7w==
X-Google-Smtp-Source: APXvYqzjI38mPozOmomKT4GGNc2NohaTE4YHBlCjoxEnOoH2poX4f4sM3FYnvRRj6IT5pqnuYY/jSQ==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr15644961wmk.114.1553623605187;
        Tue, 26 Mar 2019 11:06:45 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:44 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        Shubham Bansal <illusionist.neo@gmail.com>
Subject: [PATCH/RFC bpf-next 08/16] arm: bpf: eliminate zero extension code-gen
Date:   Tue, 26 Mar 2019 18:05:31 +0000
Message-Id: <1553623539-15474-9-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
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

