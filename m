Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C8C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4528B2084B
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="YnWX5Dh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbfCZSG5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:06:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39487 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732530AbfCZSGx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so15490037wrn.6
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNHJxDIKLsiKxKEQK4Ngr2CSz1DZ9y91uELS2TzjMyw=;
        b=YnWX5Dh/NWzwe3RIRtGIX+hqHEUSpVj/pEt3iMeIhBQqAIwGqvCIkf3F6KHHvPVqPt
         wvV8WszyIMGPpInwZ9wPR+Jbs+gITPtIcnV1YEU33Z1qjE35zRHcTQT/HJCE5ZJAMQIY
         eA3nAFbw010d4hvnl7CVFMmGVoilD2weOzG/sXUZFAG6SKY3O37LBC4zkzFe+vB4Mbs0
         s8E3tBcdGgzeUvJ4/UXNHqB6IhVn/77p99JMyXB66ypZjxbuIX+LhcFSxDLdtyfghAxY
         BGMP2rbwu4lD6M0tVVXtXUOmS2Ry7gw0ACddMhC0CtzYpzClasZ5iuCoh8vcUX7bRHyS
         i0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNHJxDIKLsiKxKEQK4Ngr2CSz1DZ9y91uELS2TzjMyw=;
        b=EfE8nn1Y0eVxqQze6ANuPrBTbEgtqSVnrbbfS/wpofoj7+U7plwJ+vrq2nfzWR/+Ql
         RV4+nxXrBNAVhNf0xL7cHM878vM4wVfyxdSru3aFnFJ6zv/boz6YNmq5PdhEyXmusHzQ
         iACWuJXOPEaYTvlxj69zH4v9AisyWrhwSfdu88ontZIZMyupBt267sb7HqZMV290MAHc
         8z4UNsrsI97ouk/UTix7xzyV4VmqT8dyO8SoAsItusENM1fpIV772HF45sGPpAOgYwyE
         6tYGzzmtMqHs05AGbQvsf0dLRKNGSHEpC48lkiDrCIIlnGCHa0h7rKKsiBm6oDSSXxsx
         Dhng==
X-Gm-Message-State: APjAAAVl8XE5hZl431iyU4tlRQN1x2qmMQN2dcGBcm4BaPl4U00YZ8pi
        kqBQ6gWCH8eAlDv44nCsoritJA==
X-Google-Smtp-Source: APXvYqxRSJFmMkY3SvTBptAdcc9SGOsmJOTBv2WyDhuwf2hG7KwUfOlYOKU5MscPI1Rng9cC3VO/8A==
X-Received: by 2002:a5d:638d:: with SMTP id p13mr20002701wru.202.1553623611989;
        Tue, 26 Mar 2019 11:06:51 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:51 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
Subject: [PATCH/RFC bpf-next 13/16] riscv: bpf: eliminate zero extension code-gen
Date:   Tue, 26 Mar 2019 18:05:36 +0000
Message-Id: <1553623539-15474-14-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

CC: Björn Töpel <bjorn.topel@gmail.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/riscv/net/bpf_jit_comp.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp.c b/arch/riscv/net/bpf_jit_comp.c
index 80b12aa..9cba262 100644
--- a/arch/riscv/net/bpf_jit_comp.c
+++ b/arch/riscv/net/bpf_jit_comp.c
@@ -731,6 +731,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 {
 	bool is64 = BPF_CLASS(insn->code) == BPF_ALU64 ||
 		    BPF_CLASS(insn->code) == BPF_JMP;
+	struct bpf_prog_aux *aux = ctx->prog->aux;
 	int rvoff, i = insn - ctx->prog->insnsi;
 	u8 rd = -1, rs = -1, code = insn->code;
 	s16 off = insn->off;
@@ -743,7 +744,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
 		emit(is64 ? rv_addi(rd, rs, 0) : rv_addiw(rd, rs, 0), ctx);
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 
@@ -771,19 +772,19 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 		emit(is64 ? rv_mul(rd, rd, rs) : rv_mulw(rd, rd, rs), ctx);
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 		emit(is64 ? rv_divu(rd, rd, rs) : rv_divuw(rd, rd, rs), ctx);
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
 		emit(is64 ? rv_remu(rd, rd, rs) : rv_remuw(rd, rd, rs), ctx);
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_LSH | BPF_X:
@@ -867,7 +868,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_MOV | BPF_K:
 	case BPF_ALU64 | BPF_MOV | BPF_K:
 		emit_imm(rd, imm, ctx);
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 
@@ -882,7 +883,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit(is64 ? rv_add(rd, rd, RV_REG_T1) :
 			     rv_addw(rd, rd, RV_REG_T1), ctx);
 		}
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_SUB | BPF_K:
@@ -895,7 +896,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit(is64 ? rv_sub(rd, rd, RV_REG_T1) :
 			     rv_subw(rd, rd, RV_REG_T1), ctx);
 		}
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_AND | BPF_K:
@@ -906,7 +907,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_imm(RV_REG_T1, imm, ctx);
 			emit(rv_and(rd, rd, RV_REG_T1), ctx);
 		}
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_OR | BPF_K:
@@ -917,7 +918,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_imm(RV_REG_T1, imm, ctx);
 			emit(rv_or(rd, rd, RV_REG_T1), ctx);
 		}
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_XOR | BPF_K:
@@ -928,7 +929,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_imm(RV_REG_T1, imm, ctx);
 			emit(rv_xor(rd, rd, RV_REG_T1), ctx);
 		}
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_MUL | BPF_K:
@@ -936,7 +937,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_imm(RV_REG_T1, imm, ctx);
 		emit(is64 ? rv_mul(rd, rd, RV_REG_T1) :
 		     rv_mulw(rd, rd, RV_REG_T1), ctx);
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_DIV | BPF_K:
@@ -944,7 +945,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_imm(RV_REG_T1, imm, ctx);
 		emit(is64 ? rv_divu(rd, rd, RV_REG_T1) :
 		     rv_divuw(rd, rd, RV_REG_T1), ctx);
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_K:
@@ -952,7 +953,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_imm(RV_REG_T1, imm, ctx);
 		emit(is64 ? rv_remu(rd, rd, RV_REG_T1) :
 		     rv_remuw(rd, rd, RV_REG_T1), ctx);
-		if (!is64)
+		if (!is64 && aux->no_verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_LSH | BPF_K:
@@ -1503,6 +1504,11 @@ static void bpf_flush_icache(void *start, void *end)
 	flush_icache_range((unsigned long)start, (unsigned long)end);
 }
 
+bool bpf_jit_hardware_zext(void)
+{
+	return false;
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	bool tmp_blinded = false, extra_pass = false;
-- 
2.7.4

