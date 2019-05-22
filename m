Return-Path: <SRS0=789D=TW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336F0C282DC
	for <bpf@archiver.kernel.org>; Wed, 22 May 2019 18:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C1D2173C
	for <bpf@archiver.kernel.org>; Wed, 22 May 2019 18:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="CaUS0zwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfEVS4R (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 May 2019 14:56:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45843 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbfEVS4E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 14:56:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id b18so3443312wrq.12
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VM5kQ5xTvrcmLaizE6FBV/hPB0ZSdjwt/JEn0M8IaOQ=;
        b=CaUS0zwABgARMnK6mFPGgo6ia4rVXZ8q7672Cp8tXO/G3Hl38pZiql9whud6POTwv+
         HDs+bpx6wNF+QqHhZmTcBifkDDVLYP1ZDzLFBHMK5a5VuDmcJzX9kPnjBbFlutqt9Qr6
         LPxZuKll8YtZyRN7d5wNRseUE830rLeYgDiSDOoNDEfzHCAUsBlsJScJ7Y+9H+bTYo/Y
         JV88Brj72Pu8tnaX8BklvK0zc4ZPtQBS2/x8UbSscT4Pa3M1BGdnaRGnqABSbO8uerlA
         lo3ujeOug46ZSeavzIusn9O+bquPYTMbGSeBVmk/NiSmYOQzxoGN+sw9LvbIE+oabm7e
         +rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VM5kQ5xTvrcmLaizE6FBV/hPB0ZSdjwt/JEn0M8IaOQ=;
        b=mY2TUO61DmuNUWydqglKmj/Ewfv5UdQlRwqv1qj0j0uGcpDBtrzxQZ2Iabw96zjVoF
         yxhiXEee9QR1rDqsImNPUS0YrbdKNlChTqcSEx4s4NbSPUN2HMMn6RqTPzprtmiA+EI9
         h+9LpKj088kzvAe7RkysBDBWIg71QElw2aDt/8P3Y4hNOx8mg0GKNPwEqjhAdqQlsuzZ
         di2RWSPN0d6qmz5gDE4WWxJ8lYCpSpj0VkyDEqexLIrkwMB0zBjiAhyWbol07HW0FHNL
         JovuT9UN4UVaKsWEMOOZjL5WYYVm+0pcjYHxFDE4EMin0UTNyX+r6q5TdTifL1dftljb
         ptPg==
X-Gm-Message-State: APjAAAUqlgnJPHDOq6LbIhDDu6QEqI+pRHeyXSwhWPtvAmkbmLvDqRfW
        iDUDktgkkH/p+dXKLP6/qLpmZg==
X-Google-Smtp-Source: APXvYqyRMeAX2oTt+8sUCY8k6sJ0861XQxX1q7qVGyhHZy8nLXGHymhnfgI3zhijMXMtzyD9nWhU7Q==
X-Received: by 2002:a5d:4e41:: with SMTP id r1mr20065764wrt.66.1558551362677;
        Wed, 22 May 2019 11:56:02 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id t12sm16328801wro.2.2019.05.22.11.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 May 2019 11:56:01 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, davem@davemloft.net,
        paul.burton@mips.com, udknight@gmail.com, zlim.lnx@gmail.com,
        illusionist.neo@gmail.com, naveen.n.rao@linux.ibm.com,
        sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, jakub.kicinski@netronome.com,
        Jiong Wang <jiong.wang@netronome.com>
Subject: [PATCH v7 bpf-next 12/16] s390: bpf: eliminate zero extension code-gen
Date:   Wed, 22 May 2019 19:55:08 +0100
Message-Id: <1558551312-17081-13-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558551312-17081-1-git-send-email-jiong.wang@netronome.com>
References: <1558551312-17081-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/s390/net/bpf_jit_comp.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 5e7c630..e636728 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -299,9 +299,11 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 
 #define EMIT_ZERO(b1)						\
 ({								\
-	/* llgfr %dst,%dst (zero extend to 64 bit) */		\
-	EMIT4(0xb9160000, b1, b1);				\
-	REG_SET_SEEN(b1);					\
+	if (!fp->aux->verifier_zext) {				\
+		/* llgfr %dst,%dst (zero extend to 64 bit) */	\
+		EMIT4(0xb9160000, b1, b1);			\
+		REG_SET_SEEN(b1);				\
+	}							\
 })
 
 /*
@@ -520,6 +522,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 	case BPF_ALU | BPF_MOV | BPF_X: /* dst = (u32) src */
 		/* llgfr %dst,%src */
 		EMIT4(0xb9160000, dst_reg, src_reg);
+		if (insn_is_zext(&insn[1]))
+			insn_count = 2;
 		break;
 	case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
 		/* lgr %dst,%src */
@@ -528,6 +532,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 	case BPF_ALU | BPF_MOV | BPF_K: /* dst = (u32) imm */
 		/* llilf %dst,imm */
 		EMIT6_IMM(0xc00f0000, dst_reg, imm);
+		if (insn_is_zext(&insn[1]))
+			insn_count = 2;
 		break;
 	case BPF_ALU64 | BPF_MOV | BPF_K: /* dst = imm */
 		/* lgfi %dst,imm */
@@ -639,6 +645,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		EMIT4(0xb9970000, REG_W0, src_reg);
 		/* llgfr %dst,%rc */
 		EMIT4(0xb9160000, dst_reg, rc_reg);
+		if (insn_is_zext(&insn[1]))
+			insn_count = 2;
 		break;
 	}
 	case BPF_ALU64 | BPF_DIV | BPF_X: /* dst = dst / src */
@@ -676,6 +684,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 			      EMIT_CONST_U32(imm));
 		/* llgfr %dst,%rc */
 		EMIT4(0xb9160000, dst_reg, rc_reg);
+		if (insn_is_zext(&insn[1]))
+			insn_count = 2;
 		break;
 	}
 	case BPF_ALU64 | BPF_DIV | BPF_K: /* dst = dst / imm */
@@ -864,10 +874,13 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		case 16: /* dst = (u16) cpu_to_be16(dst) */
 			/* llghr %dst,%dst */
 			EMIT4(0xb9850000, dst_reg, dst_reg);
+			if (insn_is_zext(&insn[1]))
+				insn_count = 2;
 			break;
 		case 32: /* dst = (u32) cpu_to_be32(dst) */
-			/* llgfr %dst,%dst */
-			EMIT4(0xb9160000, dst_reg, dst_reg);
+			if (!fp->aux->verifier_zext)
+				/* llgfr %dst,%dst */
+				EMIT4(0xb9160000, dst_reg, dst_reg);
 			break;
 		case 64: /* dst = (u64) cpu_to_be64(dst) */
 			break;
@@ -882,12 +895,15 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 			EMIT4_DISP(0x88000000, dst_reg, REG_0, 16);
 			/* llghr %dst,%dst */
 			EMIT4(0xb9850000, dst_reg, dst_reg);
+			if (insn_is_zext(&insn[1]))
+				insn_count = 2;
 			break;
 		case 32: /* dst = (u32) cpu_to_le32(dst) */
 			/* lrvr %dst,%dst */
 			EMIT4(0xb91f0000, dst_reg, dst_reg);
-			/* llgfr %dst,%dst */
-			EMIT4(0xb9160000, dst_reg, dst_reg);
+			if (!fp->aux->verifier_zext)
+				/* llgfr %dst,%dst */
+				EMIT4(0xb9160000, dst_reg, dst_reg);
 			break;
 		case 64: /* dst = (u64) cpu_to_le64(dst) */
 			/* lrvgr %dst,%dst */
@@ -968,16 +984,22 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		/* llgc %dst,0(off,%src) */
 		EMIT6_DISP_LH(0xe3000000, 0x0090, dst_reg, src_reg, REG_0, off);
 		jit->seen |= SEEN_MEM;
+		if (insn_is_zext(&insn[1]))
+			insn_count = 2;
 		break;
 	case BPF_LDX | BPF_MEM | BPF_H: /* dst = *(u16 *)(ul) (src + off) */
 		/* llgh %dst,0(off,%src) */
 		EMIT6_DISP_LH(0xe3000000, 0x0091, dst_reg, src_reg, REG_0, off);
 		jit->seen |= SEEN_MEM;
+		if (insn_is_zext(&insn[1]))
+			insn_count = 2;
 		break;
 	case BPF_LDX | BPF_MEM | BPF_W: /* dst = *(u32 *)(ul) (src + off) */
 		/* llgf %dst,off(%src) */
 		jit->seen |= SEEN_MEM;
 		EMIT6_DISP_LH(0xe3000000, 0x0016, dst_reg, src_reg, REG_0, off);
+		if (insn_is_zext(&insn[1]))
+			insn_count = 2;
 		break;
 	case BPF_LDX | BPF_MEM | BPF_DW: /* dst = *(u64 *)(ul) (src + off) */
 		/* lg %dst,0(off,%src) */
@@ -1282,6 +1304,11 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp)
 	return 0;
 }
 
+bool bpf_jit_needs_zext(void)
+{
+	return true;
+}
+
 /*
  * Compile eBPF program "fp"
  */
-- 
2.7.4

