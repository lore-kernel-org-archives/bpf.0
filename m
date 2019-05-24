Return-Path: <SRS0=P0Qj=TY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA48BC282E5
	for <bpf@archiver.kernel.org>; Fri, 24 May 2019 22:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815D42184E
	for <bpf@archiver.kernel.org>; Fri, 24 May 2019 22:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="HxM26Nfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404501AbfEXW1o (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 24 May 2019 18:27:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43538 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404461AbfEXW1n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 18:27:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id l17so2982348wrm.10
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mYjuI3PNQLgs76XUw59PtH5pPyLdg/8FK9GvazowTjQ=;
        b=HxM26NfxIsK0Bwo3jzTitFQ8xopdpZ3SF7SRsOsCx0/3Yphfy9z2BcykCgyKZJk4+q
         TR58J1VZ4Z2onwpSJzxFgpj/C8rXXuxCM9DM3GWoT88e3a15EYeJyArx1Q4F5IxsUHZh
         UKoIC1JM3i9p4F9fF7vjVo2o1f9hrjIdS0zNL++9F/OrYz6ZHstz53S5+1Rd1g8L4j3n
         rstvOPdpiWsQuna1vNVYFFBp0XKg7pyA/WJdkUvgohbGOV9YsLE6npqGBXFsz2Nq/kih
         60XiALqKr4KHfWQq31Ot1FQe+1KbePtkCFO4p/8wwKrEa4yHdizSyEnJBiF4cpn+E6i/
         9MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mYjuI3PNQLgs76XUw59PtH5pPyLdg/8FK9GvazowTjQ=;
        b=VxaSO0L/EWfXWXBVenZy2HEVHKuXDUqK29MzjHbn2tVCM3G0jzaeJ75SK2G06gaxuM
         K9PiKPt/jH2n+CwjV1SBuMZWNPFNS61Xr1iZrw1qXvelsn9x5mp/a1o6w68Z4yo3rKrS
         uAuVDcXzTqCeUKSAikYl1E3ECoT4ULJJsdefjOUIEQQqNZPj761qlHh6si6afuQew8vg
         lZCyW8Ez3sumAIeimN70+ykuyqVJAo45GVlTmffMhZyDu4iy0LEB9x/uwDFjLeA/4PPs
         GISOCKJneHy795mKh74pte7+znrjc9lBXOAuwJCm4gibz2+4LFHeBzLJv5bGp91x4sm9
         v6kA==
X-Gm-Message-State: APjAAAW84f1Pt+LwiQi9Ud8NLFoKuzWUT1Kf1vyAN9vExCRwvZi5p5RG
        VPWpyk1cxTSGvpm3kgLIyRHhY4kJIaE=
X-Google-Smtp-Source: APXvYqzOZKp+iTQYAUj2EP9SjraXFBpPvj7jfguVtsp0G4SiuP3RYNbNenNp8GD2q+3RFfWKy3FBJw==
X-Received: by 2002:a5d:504f:: with SMTP id h15mr5308100wrt.208.1558736860904;
        Fri, 24 May 2019 15:27:40 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id y10sm7194961wmg.8.2019.05.24.15.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 15:27:40 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
Subject: [PATCH v9 bpf-next 16/17] riscv: bpf: eliminate zero extension code-gen
Date:   Fri, 24 May 2019 23:25:27 +0100
Message-Id: <1558736728-7229-17-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558736728-7229-1-git-send-email-jiong.wang@netronome.com>
References: <1558736728-7229-1-git-send-email-jiong.wang@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: Björn Töpel <bjorn.topel@gmail.com>
Acked-by: Björn Töpel <bjorn.topel@gmail.com>
Tested-by: Björn Töpel <bjorn.topel@gmail.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/riscv/net/bpf_jit_comp.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp.c b/arch/riscv/net/bpf_jit_comp.c
index 80b12aa..c4c836e 100644
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
@@ -742,8 +743,13 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
+		if (imm == 1) {
+			/* Special mov32 for zext */
+			emit_zext_32(rd, ctx);
+			break;
+		}
 		emit(is64 ? rv_addi(rd, rs, 0) : rv_addiw(rd, rs, 0), ctx);
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 
@@ -771,19 +777,19 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 		emit(is64 ? rv_mul(rd, rd, rs) : rv_mulw(rd, rd, rs), ctx);
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 		emit(is64 ? rv_divu(rd, rd, rs) : rv_divuw(rd, rd, rs), ctx);
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
 		emit(is64 ? rv_remu(rd, rd, rs) : rv_remuw(rd, rd, rs), ctx);
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_LSH | BPF_X:
@@ -867,7 +873,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	case BPF_ALU | BPF_MOV | BPF_K:
 	case BPF_ALU64 | BPF_MOV | BPF_K:
 		emit_imm(rd, imm, ctx);
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 
@@ -882,7 +888,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit(is64 ? rv_add(rd, rd, RV_REG_T1) :
 			     rv_addw(rd, rd, RV_REG_T1), ctx);
 		}
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_SUB | BPF_K:
@@ -895,7 +901,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit(is64 ? rv_sub(rd, rd, RV_REG_T1) :
 			     rv_subw(rd, rd, RV_REG_T1), ctx);
 		}
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_AND | BPF_K:
@@ -906,7 +912,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_imm(RV_REG_T1, imm, ctx);
 			emit(rv_and(rd, rd, RV_REG_T1), ctx);
 		}
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_OR | BPF_K:
@@ -917,7 +923,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_imm(RV_REG_T1, imm, ctx);
 			emit(rv_or(rd, rd, RV_REG_T1), ctx);
 		}
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_XOR | BPF_K:
@@ -928,7 +934,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_imm(RV_REG_T1, imm, ctx);
 			emit(rv_xor(rd, rd, RV_REG_T1), ctx);
 		}
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_MUL | BPF_K:
@@ -936,7 +942,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_imm(RV_REG_T1, imm, ctx);
 		emit(is64 ? rv_mul(rd, rd, RV_REG_T1) :
 		     rv_mulw(rd, rd, RV_REG_T1), ctx);
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_DIV | BPF_K:
@@ -944,7 +950,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_imm(RV_REG_T1, imm, ctx);
 		emit(is64 ? rv_divu(rd, rd, RV_REG_T1) :
 		     rv_divuw(rd, rd, RV_REG_T1), ctx);
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_K:
@@ -952,7 +958,7 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_imm(RV_REG_T1, imm, ctx);
 		emit(is64 ? rv_remu(rd, rd, RV_REG_T1) :
 		     rv_remuw(rd, rd, RV_REG_T1), ctx);
-		if (!is64)
+		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_LSH | BPF_K:
@@ -1239,6 +1245,8 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_imm(RV_REG_T1, off, ctx);
 		emit(rv_add(RV_REG_T1, RV_REG_T1, rs), ctx);
 		emit(rv_lbu(rd, 0, RV_REG_T1), ctx);
+		if (insn_is_zext(&insn[1]))
+			return 1;
 		break;
 	case BPF_LDX | BPF_MEM | BPF_H:
 		if (is_12b_int(off)) {
@@ -1249,6 +1257,8 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_imm(RV_REG_T1, off, ctx);
 		emit(rv_add(RV_REG_T1, RV_REG_T1, rs), ctx);
 		emit(rv_lhu(rd, 0, RV_REG_T1), ctx);
+		if (insn_is_zext(&insn[1]))
+			return 1;
 		break;
 	case BPF_LDX | BPF_MEM | BPF_W:
 		if (is_12b_int(off)) {
@@ -1259,6 +1269,8 @@ static int emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		emit_imm(RV_REG_T1, off, ctx);
 		emit(rv_add(RV_REG_T1, RV_REG_T1, rs), ctx);
 		emit(rv_lwu(rd, 0, RV_REG_T1), ctx);
+		if (insn_is_zext(&insn[1]))
+			return 1;
 		break;
 	case BPF_LDX | BPF_MEM | BPF_DW:
 		if (is_12b_int(off)) {
@@ -1503,6 +1515,11 @@ static void bpf_flush_icache(void *start, void *end)
 	flush_icache_range((unsigned long)start, (unsigned long)end);
 }
 
+bool bpf_jit_needs_zext(void)
+{
+	return true;
+}
+
 struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 {
 	bool tmp_blinded = false, extra_pass = false;
-- 
2.7.4

