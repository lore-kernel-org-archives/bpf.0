Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6478C10F14
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9148420820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="LGvY/WNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfDJTvC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:51:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39621 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfDJTvC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:51:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so3892747wmk.4
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=esldtJjtJ7LjAyiBdO+8AWliqTz0U0S4jG86huzM9ss=;
        b=LGvY/WNfIAH9sRfs5hSkFbE1cY9j2REUkmBhLePzIQJoM6K2/B4SIBJopiW0xEpbDm
         LRfYVvHorGRMnyg25A6UGyV8cHoE9X7oVtSDtlyzg6P2t/aOjOKTH/u/13URaE4JZ5Nt
         imGiLK5Mlq495TFuRrATG+anw5vZgy9+1vxqapn7XYZAC0ADGKJ4ykl2RWIuvP9s0zL6
         HeQQxN2jOE6O4mFfCG2lXC5orHG212GgrbGD4DsGDEDGrcTjv3eJPEzcJ+mdsERB2Vx7
         GIQKjf/p1Jktu4N/frv26YDRcFUapU1Whub8mDQJnWhaqFRCjtdo9u80s5iKekxDfxhK
         Xpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=esldtJjtJ7LjAyiBdO+8AWliqTz0U0S4jG86huzM9ss=;
        b=DD96w6wgUN2FMYHOev02KU5Tunr1sIHvXciQbJU8EUfbbj4xd0Endj2oZjTocIBFoh
         y/YfLxJ3a7VQlYc5IHbMbsgoAwzqnPST1dvikinh0X8YOWby9Pivk4wFABwPEMhUiMYl
         oBb8dw8M1fR1nUi2/+N6fHAuOcYWIiwNQ7JyGSM1C4oL8+WhyPclsqqnYKMfr9GWRc9E
         lpK6jfxHnvUK1Mon1EgHBhBGS8xeHvXF4pID9d87JbUko1rFPcSAlG/RhvsH3z6pSn6e
         lrE2EfmghahUtkY5VFts4cwcAQx9gS239L4PZK1gGSXmRKOmKmjUqa0XJoVcOSLYrAta
         uMxg==
X-Gm-Message-State: APjAAAVOKn4wTGXHl1zoe7XVJXpNYSxrGl22FHjoaqL4KWki8CgY9iz5
        r0l0xHJWXIztey71j07qdvAcvg==
X-Google-Smtp-Source: APXvYqzOQy3zlytD7JrLCciUOS41aptEdh8Xs8/g7bLzwzTinWCGmGY56aSX2cOfyj/DFqC58izafA==
X-Received: by 2002:a1c:ca07:: with SMTP id a7mr3951256wmg.104.1554925858673;
        Wed, 10 Apr 2019 12:50:58 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:57 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        Wang YanQing <udknight@gmail.com>
Subject: [PATCH/RFC v2 bpf-next 17/19] x32: bpf: eliminate zero extension code-gen
Date:   Wed, 10 Apr 2019 20:50:31 +0100
Message-Id: <1554925833-7333-18-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: Wang YanQing <udknight@gmail.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/x86/net/bpf_jit_comp32.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 0d9cdff..8c6cf22 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -567,7 +567,7 @@ static inline void emit_ia32_alu_r(const bool is64, const bool hi, const u8 op,
 static inline void emit_ia32_alu_r64(const bool is64, const u8 op,
 				     const u8 dst[], const u8 src[],
 				     bool dstk,  bool sstk,
-				     u8 **pprog)
+				     u8 **pprog, const struct bpf_prog_aux *aux)
 {
 	u8 *prog = *pprog;
 
@@ -575,7 +575,7 @@ static inline void emit_ia32_alu_r64(const bool is64, const u8 op,
 	if (is64)
 		emit_ia32_alu_r(is64, true, op, dst_hi, src_hi, dstk, sstk,
 				&prog);
-	else
+	else if (aux->no_verifier_zext)
 		emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
 	*pprog = prog;
 }
@@ -666,7 +666,8 @@ static inline void emit_ia32_alu_i(const bool is64, const bool hi, const u8 op,
 /* ALU operation (64 bit) */
 static inline void emit_ia32_alu_i64(const bool is64, const u8 op,
 				     const u8 dst[], const u32 val,
-				     bool dstk, u8 **pprog)
+				     bool dstk, u8 **pprog,
+				     const struct bpf_prog_aux *aux)
 {
 	u8 *prog = *pprog;
 	u32 hi = 0;
@@ -677,7 +678,7 @@ static inline void emit_ia32_alu_i64(const bool is64, const u8 op,
 	emit_ia32_alu_i(is64, false, op, dst_lo, val, dstk, &prog);
 	if (is64)
 		emit_ia32_alu_i(is64, true, op, dst_hi, hi, dstk, &prog);
-	else
+	else if (aux->no_verifier_zext)
 		emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
 
 	*pprog = prog;
@@ -1690,11 +1691,13 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			switch (BPF_SRC(code)) {
 			case BPF_X:
 				emit_ia32_alu_r64(is64, BPF_OP(code), dst,
-						  src, dstk, sstk, &prog);
+						  src, dstk, sstk, &prog,
+						  bpf_prog->aux);
 				break;
 			case BPF_K:
 				emit_ia32_alu_i64(is64, BPF_OP(code), dst,
-						  imm32, dstk, &prog);
+						  imm32, dstk, &prog,
+						  bpf_prog->aux);
 				break;
 			}
 			break;
@@ -1713,7 +1716,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 						false, &prog);
 				break;
 			}
-			emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
+			if (bpf_prog->aux->no_verifier_zext)
+				emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
 			break;
 		case BPF_ALU | BPF_LSH | BPF_X:
 		case BPF_ALU | BPF_RSH | BPF_X:
@@ -1733,7 +1737,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 						  &prog);
 				break;
 			}
-			emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
+			if (bpf_prog->aux->no_verifier_zext)
+				emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
 			break;
 		/* dst = dst / src(imm) */
 		/* dst = dst % src(imm) */
@@ -1755,7 +1760,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 						    &prog);
 				break;
 			}
-			emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
+			if (bpf_prog->aux->no_verifier_zext)
+				emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
 			break;
 		case BPF_ALU64 | BPF_DIV | BPF_K:
 		case BPF_ALU64 | BPF_DIV | BPF_X:
@@ -1772,7 +1778,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			EMIT2_off32(0xC7, add_1reg(0xC0, IA32_ECX), imm32);
 			emit_ia32_shift_r(BPF_OP(code), dst_lo, IA32_ECX, dstk,
 					  false, &prog);
-			emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
+			if (bpf_prog->aux->no_verifier_zext)
+				emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
 			break;
 		/* dst = dst << imm */
 		case BPF_ALU64 | BPF_LSH | BPF_K:
@@ -2367,6 +2374,11 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 	return proglen;
 }
 
+bool bpf_jit_hardware_zext(void)
+{
+	return false;
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	struct bpf_binary_header *header = NULL;
-- 
2.7.4

