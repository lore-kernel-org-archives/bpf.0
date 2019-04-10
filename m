Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18498C10F14
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE7F20820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="KndacB3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDJTvB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:51:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43984 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfDJTvB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:51:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so4341157wrx.10
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNHJxDIKLsiKxKEQK4Ngr2CSz1DZ9y91uELS2TzjMyw=;
        b=KndacB3EVhZdtL4oZL25Q+OFwLxZkt7XMgADHnAsSA6Li9kngdynCsFtworNbmu76e
         2V+evGu9fKk3I77SXzfCYqIUpS9qjfHMbKmvNK3NF6Py03iekZiFAoSJJl6jB+LHD4/y
         RQTI8CbeavWRVTAB40XHjQl56VMLwILbTpE/3o3aTQmP0EvF5VXFnqILfOEs26mNfnkB
         78f4icwTzYbnYnyKn1xzKI7PV9NKXafHhCUAsmom/spUyT+Xu2um5d1lnJTPgMg81Svk
         mh0SlajMPMGzcOn/nCXI3bWHXU73x5bZgWIGfsydSCb+WO/dh/9cE1BzLn5dcYBFBpvI
         6rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNHJxDIKLsiKxKEQK4Ngr2CSz1DZ9y91uELS2TzjMyw=;
        b=CemgdgjdRnJk8cH/mvbOtBZHcU4GZ06u3ZeNyzJ2KuKSOn3L2iKDHjyiVSIgprUtFt
         IMFTlqajYRPSbrh3w6kSMF7E/KS685PoH/yRg6IfElZwdwGWui91BDwki+3Ngh0cUp44
         KGv0ZnrtRZK4sEDpCuRxL46uVWhCfrs2obnXwmBduA3h3q8tmh6biqC2YsxeUajm2STT
         s6ygfwa6LAUz68QvvnWNTXRI348v3+NFq4t3+fKdiO3J5Mcv2RLUyS2CHtZvJNfumri/
         OjC1gyO6cvNMU8WZse0cJQ5aZV9+OsRvUP4eXlS9SrNGB23kjFcl5nVd/tpCFVyEtsiL
         /tRA==
X-Gm-Message-State: APjAAAU43Ddvr7p0sjz/UmThg8byj6ZkyR4sT+wQz+mW8aOVMgaVJLwI
        We5LJwxFfz/z3uE2Yfu++dVyeg==
X-Google-Smtp-Source: APXvYqzvwBAXCrCCNRmBXEdCKHyl7bHAS1MOIuh25bhUL7rTkL0qD7skeRJ0uK/OPezXFD7dt6Iw3w==
X-Received: by 2002:adf:afd7:: with SMTP id y23mr27416995wrd.254.1554925859493;
        Wed, 10 Apr 2019 12:50:59 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:58 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
Subject: [PATCH/RFC v2 bpf-next 18/19] riscv: bpf: eliminate zero extension code-gen
Date:   Wed, 10 Apr 2019 20:50:32 +0100
Message-Id: <1554925833-7333-19-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
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

