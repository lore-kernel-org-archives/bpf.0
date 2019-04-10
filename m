Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3748C282CE
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0DE20830
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="wSi9pcDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDJTu4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:50:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43978 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfDJTuz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so4340942wrx.10
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u7fZb3IEqFJRYe0oJUr+G1NSo0sv1IV8cJXsSnOcig0=;
        b=wSi9pcDZ9ct8tZUBGakzoQDEogC6W0cuDKRQAuhxv0zrh419r8IZ4hWLtsGIGKoNIr
         fyE/qUF7npgewhxHz3wJxZNRISTEXB+GlhyA1wYU1UGpNONkfRjf8MDEXpS5iiJFEqDm
         lfvEGknnGMz6ujpmMOdeNSN5Kv7q8bG4zW5VltOQQBUnScCRqiadkcJW7bevB3Huu8b6
         FNYhQcI1ZrW+Yvnl7H7h5ojAQWRcN9Mf3ncwtXfSRRIzqBsUGBLIVvmCoA6vHZepDMEq
         e5Ir+J9wD+g/E/Gq8GWqG3jSuTRxM1AZvaamoF22KzM2cXaY0A/uP5LHMkUwwvOPJa70
         SIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u7fZb3IEqFJRYe0oJUr+G1NSo0sv1IV8cJXsSnOcig0=;
        b=fN0isPseJkZTSOA6tw95IrsgnMS2b+oIFuNNP5vtPrE0Kx1ydhhBpq2nc/8F1xs8zB
         9VrRO3eans5nYuyeUM6r8Dg+URB9vhBTwUvT+6VBiGZqqls6S+ZB1HjhhbKM9qWKeHSv
         uy7DBV3/lzAppWF6UKdEjjReDopWBnlG4rJjPH25JRY5NV/fuPPyb2PdgVwzoSRJ9jyA
         TM44lnz/6ffWmwFXxMluMk8wdqtZ6lAf1bHPG+ZkdA+9sHf6UPgzTMgJvczYgR2FmCsw
         LO9njMdIhbtKgOPZ8qLvAnLCfpZx+hqj0XMJdfQzzKkczDhG9gMmm2neE1j33dskwaPf
         2qUQ==
X-Gm-Message-State: APjAAAWr0A50KT58xyKcves6nFM1Aix5AU7sekiPN5re+EHODdYOEQyv
        +fDBUh7IP3jtoGyQwQ1SuNiZbg==
X-Google-Smtp-Source: APXvYqzmZpmZZgoZ+HZAm+o/4Yjr4e9rlpoh1OaqlVxpynFlC/qhaxEJ32OR/EutnnVGgjbYUPvijg==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr27486531wrx.32.1554925854086;
        Wed, 10 Apr 2019 12:50:54 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:53 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        Shubham Bansal <illusionist.neo@gmail.com>
Subject: [PATCH/RFC v2 bpf-next 13/19] arm: bpf: eliminate zero extension code-gen
Date:   Wed, 10 Apr 2019 20:50:27 +0100
Message-Id: <1554925833-7333-14-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
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

