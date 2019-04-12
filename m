Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0529CC282DA
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6302084D
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="PWdoZ8gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfDLWAT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35374 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfDLWAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so13732453wrp.2
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u7fZb3IEqFJRYe0oJUr+G1NSo0sv1IV8cJXsSnOcig0=;
        b=PWdoZ8grCfTD8nOp7OrDYEhnOKSrSKq87DzC6lV4PZ8CGpkSAHYiI1wIe1C3JkBD5l
         r/nyGaMlXT+FtS6c5QNz3xSEEsdw4azIsyUe8QPD01DyehXWpGfChrhO1zkKerNrhBD+
         mFN3J2rA/4iLxwyjFQN7DhfwW4aZy09VIJZtbxDs+mJmpQWLFlmn3Xy3cNNPnE4T4g/u
         0eBzkmGvMY/uX+HHOCTVA4I3A6Rf6V9dSD1up8Ux6fKBIFy9BSUzeTUTWQYwmMV25ncD
         qRtVpJ6oqHy5fXfgCGQnN0Kjca57lAZ6i5l8SH/4gujLeNn2k0s4u0kZho1oD5prgdx8
         k4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u7fZb3IEqFJRYe0oJUr+G1NSo0sv1IV8cJXsSnOcig0=;
        b=dH25ltdSDqll3LlJavJgs4wnjCa0moe85R3YFd7u7xvZZadnPz73LpAr0R/rGysOvF
         oTWJ556og2ImTa2pRXZn+DODj9ZN253C0F9yL+/3EDk7I6ZMX0w5Ze87nBZaWqh7vkKk
         C7g1aRr6N0MyZe2eMNeTZrK0D7FCaD0HXKiFlD85yLMuGk8U8vUKh0K2NzcTzW3T9R5j
         SKzC+xslesVCXHWvn2ndRl6kDqeT8rUYsPZ4po98IASdRA39Rku95x0+vZpOffF8+s8w
         hGRNBEPKleueAWXfntPJuvki3+u7bGQ+bDHR5KsbFGGFP7To4zdzMACvvBmM3sJ1lbuu
         ia3w==
X-Gm-Message-State: APjAAAVpEdTduHJ1uuBR+E0PKfTDvXRbZ/d79JMxjx7Otb1vQoMV5nG+
        jZmPT7nu27GMleSA1syODEr+Tw==
X-Google-Smtp-Source: APXvYqzHxMQKW6YRTv+3Xu/l3AfjHs7tRnsSD1QGXND72AwDdRKYWeWMYL92rWL+OckFRF3yNULcaA==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr8265477wru.161.1555106416596;
        Fri, 12 Apr 2019 15:00:16 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.15.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:15 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        Shubham Bansal <illusionist.neo@gmail.com>
Subject: [PATCH v3 bpf-next 13/19] arm: bpf: eliminate zero extension code-gen
Date:   Fri, 12 Apr 2019 22:59:46 +0100
Message-Id: <1555106392-20117-14-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
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

