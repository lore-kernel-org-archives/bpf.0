Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E404C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EAB2082F
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="k8noji8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbfCZSGy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33248 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732519AbfCZSGw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so2988379wmi.0
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=esldtJjtJ7LjAyiBdO+8AWliqTz0U0S4jG86huzM9ss=;
        b=k8noji8QmwO/ufvcMYhtIST6ndEfDeg/HD04iJrYn9FZDz6hj4HVJVMMsuNPp/EYwV
         S13x3XSO6sgGSsAHJnCi8wjkaj0iuHd7opdu029/3h6iuHHx97T6AslAJto3wmZNVJf/
         XAX73wWepIyN0hUgxxajNo3iiNcBb5tzH7Zfz6tfyyIpTfOfAUySYj+U1JlFyVsqdAq1
         c6WaO+e0LcdUsEnBoGZ9ANeEYDGQ714Hbp/OkZu1Nykm6GmarLo08dln4YdNw/qoqiGN
         rIdRSq1ipmvSnOc0Gftef+8+p+oiojNpHKSHRi+oeAyX56nlZCNnSXbMQb7lfsHSGU/P
         veuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=esldtJjtJ7LjAyiBdO+8AWliqTz0U0S4jG86huzM9ss=;
        b=SG2XzsuK6Ja+tNpvP8ecoasD6ylIwW4uufxQnKGBTUkodwK2PwrNuRoQONH8sXf4MF
         SlzK/53SXML4il7luvVCXCnA2QIYEdE8CilNuoONO5qPTwJ0uLUUJqvJnPWjdF+0lt+C
         p39qI0HXqSZxTwKe/B/W9MSSc2jtTXP8lSjL2bcx40JMEZNtG+31iUqkYOXx3xIJdush
         ySFBstDYkRXGfKppoEEXEs8TibQrDitac/QEQqolAx2fn9dM4A59XV451En+jDauV2e4
         pQH8VWP3iMZF8hDv7W914XS/fzxw1KAppFUx/hI8gdwsuxo98y97tg3PX7Sz06ZI3EiD
         S2qA==
X-Gm-Message-State: APjAAAWS/y97ibHTbj1G3qh83A5P1JR9/B9n53BBovH29Ncw7S6/Ha95
        jMVf27kVdJTm3Ii883Wy+uiSYQ==
X-Google-Smtp-Source: APXvYqyEtlLHLRihOask+JJDJ+7LuYwBN2xnI3Su4W7+V+AII9DiIfRbSdHZOe1mgHAH2+BfKIjKDA==
X-Received: by 2002:a1c:7dcc:: with SMTP id y195mr1164740wmc.13.1553623610619;
        Tue, 26 Mar 2019 11:06:50 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:50 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        Wang YanQing <udknight@gmail.com>
Subject: [PATCH/RFC bpf-next 12/16] x32: bpf: eliminate zero extension code-gen
Date:   Tue, 26 Mar 2019 18:05:35 +0000
Message-Id: <1553623539-15474-13-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
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

