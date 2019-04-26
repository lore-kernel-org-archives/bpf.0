Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFADC43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 19:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC91C2077B
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 19:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDZTsl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:48:41 -0400
Received: from www62.your-server.de ([213.133.104.62]:60874 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZTsl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Apr 2019 15:48:41 -0400
Received: from [178.199.41.31] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hK6pr-0004d6-Qi; Fri, 26 Apr 2019 21:48:39 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     will.deacon@arm.com, jean-philippe.brucker@arm.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next 1/2] bpf, arm64: remove prefetch insn in xadd mapping
Date:   Fri, 26 Apr 2019 21:48:21 +0200
Message-Id: <20190426194822.7328-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190426194822.7328-1-daniel@iogearbox.net>
References: <20190426194822.7328-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25431/Fri Apr 26 09:57:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prefetch-with-intent-to-write is currently part of the XADD mapping in
the AArch64 JIT and follows the kernel's implementation of atomic_add.
This may interfere with other threads executing the LDXR/STXR loop,
leading to potential starvation and fairness issues. Drop the optional
prefetch instruction.

Fixes: 85f68fe89832 ("bpf, arm64: implement jiting of BPF_XADD")
Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/net/bpf_jit.h      | 6 ------
 arch/arm64/net/bpf_jit_comp.c | 1 -
 2 files changed, 7 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 783de51..6c88165 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -100,12 +100,6 @@
 #define A64_STXR(sf, Rt, Rn, Rs) \
 	A64_LSX(sf, Rt, Rn, Rs, STORE_EX)
 
-/* Prefetch */
-#define A64_PRFM(Rn, type, target, policy) \
-	aarch64_insn_gen_prefetch(Rn, AARCH64_INSN_PRFM_TYPE_##type, \
-				  AARCH64_INSN_PRFM_TARGET_##target, \
-				  AARCH64_INSN_PRFM_POLICY_##policy)
-
 /* Add/subtract (immediate) */
 #define A64_ADDSUB_IMM(sf, Rd, Rn, imm12, type) \
 	aarch64_insn_gen_add_sub_imm(Rd, Rn, imm12, \
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index aaddc02..a1420626 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -762,7 +762,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_STX | BPF_XADD | BPF_DW:
 		emit_a64_mov_i(1, tmp, off, ctx);
 		emit(A64_ADD(1, tmp, tmp, dst), ctx);
-		emit(A64_PRFM(tmp, PST, L1, STRM), ctx);
 		emit(A64_LDXR(isdw, tmp2, tmp), ctx);
 		emit(A64_ADD(isdw, tmp2, tmp2, src), ctx);
 		emit(A64_STXR(isdw, tmp2, tmp, tmp3), ctx);
-- 
2.9.5

