Return-Path: <SRS0=KuSb=6P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A7CC4724C
	for <bpf@archiver.kernel.org>; Fri,  1 May 2020 02:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32482208DB
	for <bpf@archiver.kernel.org>; Fri,  1 May 2020 02:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="buGYG1zP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgEACC0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 30 Apr 2020 22:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728109AbgEACCX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Apr 2020 22:02:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92FBC08E859
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 19:02:22 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f15so3161853plr.3
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 19:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fJ0X3HmB1iDCnqYSKzBuKNLlmf+ZNE7akQZz7eS+SQs=;
        b=buGYG1zPmUGmihTBS3FalBgnSAVFf5gYRLV938Kf3kJS7zBbWoaUgQlCNRvsd7Gm5v
         v2Ybw0vo68ILLFIbam3bSlhEXbSKXz3l13n0o1RPtmFAXsR5ue7ZzwtajUY8Q3ntIJfz
         e9gVZ4kpwNw5XkxtEthuLibHWDwI4OQuPiaZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fJ0X3HmB1iDCnqYSKzBuKNLlmf+ZNE7akQZz7eS+SQs=;
        b=ctlm3vTMVn4QWaSVfQLugpFaft1/0Qa4kA2iIE3dX3LFTVGyYlycoD1+6rINQdhDAQ
         IiqbWXJxPggfMLxAIUXqFu9auukUvVPQxK+zaDQeINXKdW/t/kofoSpF0VBojCh1u/wP
         s7vL+VZNZ7rOj7obxSgsHdzbj2Wrr9M44XxvPdOHdY+Q/I9wKUrma7Eng4mGsYDBohjV
         hq9Urp4Ta6ClvO/qC0k/ZS2VhzKpYqKKtpwY7JuYGUvfS93kknw5Yo9SxOSElp+LVIiZ
         i5AJKKZOOSC39z4Gg6OkUlcej8gvtbKWlhJZKD+UEWxClNFF4/jmtq68crGGrWuZU8IM
         0w2A==
X-Gm-Message-State: AGi0PuZk73JjBBy+hSaAtaI4c7tJBkQrpILIC2UU81htCM2OtokXb+Ck
        C6/6gmOsL00AnU9Ou5FOUZhqN8Rybzm49A==
X-Google-Smtp-Source: APiQypIIPeSyeqjGDdK6yZnRaWppj/2y2OI0Sxy/utZnN7It04QldoSdy+Qq/1GaEPCvXdGHIPur/Q==
X-Received: by 2002:a17:90b:1044:: with SMTP id gq4mr1928047pjb.81.1588298542058;
        Thu, 30 Apr 2020 19:02:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-53-94-119.hsd1.wa.comcast.net. [73.53.94.119])
        by smtp.gmail.com with ESMTPSA id fy21sm802915pjb.25.2020.04.30.19.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 19:02:21 -0700 (PDT)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] bpf, arm: Optimize ALU ARSH K using asr immediate instruction
Date:   Thu, 30 Apr 2020 19:02:10 -0700
Message-Id: <20200501020210.32294-3-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200501020210.32294-1-luke.r.nels@gmail.com>
References: <20200501020210.32294-1-luke.r.nels@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds an optimization that uses the asr immediate instruction
for BPF_ALU BPF_ARSH BPF_K, rather than loading the immediate to
a temporary register. This is similar to existing code for handling
BPF_ALU BPF_{LSH,RSH} BPF_K. This optimization saves two instructions
and is more consistent with LSH and RSH.

Example of the code generated for BPF_ALU32_IMM(BPF_ARSH, BPF_REG_0, 5)
before the optimization:

  2c:  mov    r8, #5
  30:  mov    r9, #0
  34:  asr    r0, r0, r8

and after optimization:

  2c:  asr    r0, r0, #5

Tested on QEMU using lib/test_bpf and test_verifier.

Co-developed-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 10 +++++++---
 arch/arm/net/bpf_jit_32.h |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 48b89211ee5c..0207b6ea6e8a 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -795,6 +795,9 @@ static inline void emit_a32_alu_i(const s8 dst, const u32 val,
 	case BPF_RSH:
 		emit(ARM_LSR_I(rd, rd, val), ctx);
 		break;
+	case BPF_ARSH:
+		emit(ARM_ASR_I(rd, rd, val), ctx);
+		break;
 	case BPF_NEG:
 		emit(ARM_RSB_I(rd, rd, val), ctx);
 		break;
@@ -1408,7 +1411,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU | BPF_LSH | BPF_X:
 	case BPF_ALU | BPF_RSH | BPF_X:
-	case BPF_ALU | BPF_ARSH | BPF_K:
 	case BPF_ALU | BPF_ARSH | BPF_X:
 	case BPF_ALU64 | BPF_ADD | BPF_K:
 	case BPF_ALU64 | BPF_ADD | BPF_X:
@@ -1465,10 +1467,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	case BPF_ALU64 | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
 		goto notyet;
-	/* dst = dst >> imm */
 	/* dst = dst << imm */
-	case BPF_ALU | BPF_RSH | BPF_K:
+	/* dst = dst >> imm */
+	/* dst = dst >> imm (signed) */
 	case BPF_ALU | BPF_LSH | BPF_K:
+	case BPF_ALU | BPF_RSH | BPF_K:
+	case BPF_ALU | BPF_ARSH | BPF_K:
 		if (unlikely(imm > 31))
 			return -EINVAL;
 		if (imm)
diff --git a/arch/arm/net/bpf_jit_32.h b/arch/arm/net/bpf_jit_32.h
index fb67cbc589e0..e0b593a1498d 100644
--- a/arch/arm/net/bpf_jit_32.h
+++ b/arch/arm/net/bpf_jit_32.h
@@ -94,6 +94,9 @@
 #define ARM_INST_LSR_I		0x01a00020
 #define ARM_INST_LSR_R		0x01a00030
 
+#define ARM_INST_ASR_I		0x01a00040
+#define ARM_INST_ASR_R		0x01a00050
+
 #define ARM_INST_MOV_R		0x01a00000
 #define ARM_INST_MOVS_R		0x01b00000
 #define ARM_INST_MOV_I		0x03a00000
-- 
2.17.1

