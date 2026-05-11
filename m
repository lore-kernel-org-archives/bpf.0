Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0C29D26E
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537831; cv=none; b=BLf9/MJRXqPwrx50jJX68iHtjQcliG67BYs1gLH2IMIAEizvvGfJwf5cDBo4nBB95dvBpNNiyUWXxFWaBa5qxgKGVolNY4VEJTbD3LBk1GRZT2II7KRiaiWadMctWiKM9oolVukqGBdCIOHqg6JMRd+SC0Roi1XfRq5qqxyc2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537831; c=relaxed/simple;
	bh=hxgxXXX9KNU29N2vt4j9TZfSsWP0fn+WmP2W06CD2sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9hSOfsOoHLdGhV0+b9OixAt2vCSzBc37SXmf525Me/b9Sj2u8eKow07FIY/pE5d9oo21bC7M2YPIG3y2KRRnsyp7XhGosLtE8BpKJKWjZZ1wNn9uc6GNdJVwUb9UWVCX4ugRkkDWIZ/ztuw7YdVy/krZgcpsGz5vynk15NfEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ8Ff5Vs; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ8Ff5Vs"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso2315510b3a.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778537830; x=1779142630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzbHlwFEvu/VdMCQ/9sPrwxhCrnSDlirFVz5WBJAiSo=;
        b=aQ8Ff5Vso1WY9UfT2ft6zG8J6KhpYLJfL1O8zvcl62gW9P23mFNozJ4zAAIDqWhH9i
         3Wn6UyK+SIqdFAg54NW+Fj+Zd0d7ldNS39ryZCwQ0zRoUIYtXsg/3v6LcXZCtvcbWZZb
         wbBNJcChQO/iyq00swTwI8vAz+d3q4vkz6BFpJa8n5KY8Q6ikXW5LZXrmQPBJLrJivKi
         ot7fXOlHKGNnXNVdZzLLeA+eHorElypW/v2Y8lBVJp+EV/p+2uwWp9gQhYYy1Zjahzhj
         ipu75qSg1rqC7By+b2Wgdng1NhHR8BnnFkB1924p5/+dQnLKD25Se4N5fe75shfNMLAR
         I4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778537830; x=1779142630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nzbHlwFEvu/VdMCQ/9sPrwxhCrnSDlirFVz5WBJAiSo=;
        b=eU2hC5/0iLGcMFm9TFRnAP+BhcUheRtbuWAb+pdnQhxrlvqRvRph5R6U6zsNFPVV2M
         NmZcmu1WdnxTpcTrrgBTKJLhZmFhMyNRG73jeQ7+QC6ZIBQJzDW8SkHJXBdK0OJkBt9+
         UwmzO6lCVHUuM75bth1831PSp1VFaSAtEEKuHWnaggfcMm+GnXoo8TBpjswgBcZdWyei
         GzbMwKcr4YCWH0fyGlHvY9wyNb7zg6w/guald5AWGjC8xe1XDNdLLkS6vwQ/xA0aPLm0
         /uYxFJQnraaAERrUr10MZ9o3Yw86l/5wGKXQ9575V/JL9gyYqakNciXmS+UPdKTr2EF2
         uqKw==
X-Forwarded-Encrypted: i=1; AFNElJ8CqZ9CV3JypHTAYTWi3+80uwKWApCHPvyGr1+e6Dj+JSLouSK/FnCwABhTaXaM3HlYwc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ9LyMNPo2wVMzd933DGoFMNJ9ZTNjHiW7lc4QAz9IOiuBzil2
	dqYUtMpIK9bObb9j+0rkiQX3UBuYniFeynbA7bQYgLotv0axhQ9bEj1T
X-Gm-Gg: Acq92OFqTBNPZNESHUPzaYQsEonjPb5H+MtBDooDptBJCjSWYXEyVxBRj1KAeiOy90S
	z5aLD+QUZQPSfxE3uRiMxottRQ+wGtLVHyiEJMiH/2FaN1EFi58+rTS5FJuOFC3KBwgcP0j8XwN
	x5A7X6daS7CJOOVxD0ZJgwLPrj0+bNaP9EDREaPdYe/BhYZ84fwpy0JPW54jQVALSUrDVnb9n9h
	8vMbE6m57aXVQ06mCDwRa095bbN+TJouq97X664VwRnLZtqKm+eAzvYFO7RfmLhBpe6vUcZOL8X
	l9YjS87iXm6JG9uf7WbW8H826Z6KVjRMLLh1uJU1HysEaBxaF3jOhEx4R+6y8S+YSHwrD77boPG
	CPxrjcXR5Dl3Kg68H7WACKMDp2V5tO1btWdE4Q1lLEyrt8E7JTDJcXODrwufGHumYc0ldotTY2f
	Z6Bk88QEAs+74By2veppqiZ62UtbMs0B3jY0FcFmzwpPNUNikmjV48g8HklT/yORdXGeDIV4+2U
	+IwE8UF9ZLZstbdkj8NK535N5JPrFGvnw==
X-Received: by 2002:a05:6a00:f0b:b0:82f:456c:29f1 with SMTP id d2e1a72fcca58-83ee83251bemr1014107b3a.12.1778537829642;
        Mon, 11 May 2026 15:17:09 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965a3e3ecsm21943329b3a.19.2026.05.11.15.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:17:09 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	alex@ghiti.fr,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	marscheng@google.com,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH bpf-next v2 1/3] riscv, bpf: Fix support for BPF_SDIV and BPF_SMOD in RV32 JIT
Date: Mon, 11 May 2026 22:16:46 +0000
Message-ID: <20260511221648.3251464-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260511221648.3251464-1-visitorckw@gmail.com>
References: <20260511221648.3251464-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current rv32 bpf jit compiler incorrectly treats BPF_SDIV and
BPF_SMOD as unsigned operations. The BPF instruction set allows
signed division and modulo by reusing the BPF_DIV and BPF_MOD opcodes
with the instruction offset set to 1.

Update the emit_alu_r32() function to accept an 'is_sdiv' variable and
emit the correct div and rem instructions when the offset is 1.

Before this patch:
[   44.161771] test_bpf: #165 ALU_SDIV_X: -6 / 2 = -3 jited:1 ret 2147483645 != -3 (0x7ffffffd != 0xfffffffd)FAIL (1 times)
[   44.167385] test_bpf: #166 ALU_SDIV_K: -6 / 2 = -3 jited:1 ret 2147483645 != -3 (0x7ffffffd != 0xfffffffd)FAIL (1 times)
[   44.171053] test_bpf: #169 ALU_SMOD_X: -7 % 2 = -1 jited:1 ret 1 != -1 (0x1 != 0xffffffff)FAIL (1 times)
[   44.172081] test_bpf: #170 ALU_SMOD_K: -7 % 2 = -1 jited:1 ret 1 != -1 (0x1 != 0xffffffff)FAIL (1 times)

After this patch:
[   16.002192] test_bpf: #165 ALU_SDIV_X: -6 / 2 = -3 jited:1 95 PASS
[   16.002983] test_bpf: #166 ALU_SDIV_K: -6 / 2 = -3 jited:1 1059 PASS
[   16.017167] test_bpf: #169 ALU_SMOD_X: -7 % 2 = -1 jited:1 136 PASS
[   16.023002] test_bpf: #170 ALU_SMOD_K: -7 % 2 = -1 jited:1 109 PASS

Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 arch/riscv/net/bpf_jit_comp32.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index 592dd86fbf81..7396899ea276 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -509,7 +509,7 @@ static void emit_alu_r64(const s8 *dst, const s8 *src,
 }
 
 static void emit_alu_r32(const s8 *dst, const s8 *src,
-			 struct rv_jit_context *ctx, const u8 op)
+			 struct rv_jit_context *ctx, const u8 op, bool is_sdiv)
 {
 	const s8 *tmp1 = bpf2rv32[TMP_REG_1];
 	const s8 *tmp2 = bpf2rv32[TMP_REG_2];
@@ -539,10 +539,16 @@ static void emit_alu_r32(const s8 *dst, const s8 *src,
 		emit(rv_mul(lo(rd), lo(rd), lo(rs)), ctx);
 		break;
 	case BPF_DIV:
-		emit(rv_divu(lo(rd), lo(rd), lo(rs)), ctx);
+		if (is_sdiv)
+			emit(rv_div(lo(rd), lo(rd), lo(rs)), ctx);
+		else
+			emit(rv_divu(lo(rd), lo(rd), lo(rs)), ctx);
 		break;
 	case BPF_MOD:
-		emit(rv_remu(lo(rd), lo(rd), lo(rs)), ctx);
+		if (is_sdiv)
+			emit(rv_rem(lo(rd), lo(rd), lo(rs)), ctx);
+		else
+			emit(rv_remu(lo(rd), lo(rd), lo(rs)), ctx);
 		break;
 	case BPF_LSH:
 		emit(rv_sll(lo(rd), lo(rd), lo(rs)), ctx);
@@ -959,6 +965,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 	u8 code = insn->code;
 	s16 off = insn->off;
 	s32 imm = insn->imm;
+	bool is_sdiv = false;
 
 	const s8 *dst = bpf2rv32[insn->dst_reg];
 	const s8 *src = bpf2rv32[insn->src_reg];
@@ -1041,7 +1048,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_imm32(tmp2, imm, ctx);
 			src = tmp2;
 		}
-		emit_alu_r32(dst, src, ctx, BPF_OP(code));
+		if ((BPF_OP(code) == BPF_DIV || BPF_OP(code) == BPF_MOD) && insn->off == 1)
+			is_sdiv = true;
+		emit_alu_r32(dst, src, ctx, BPF_OP(code), is_sdiv);
 		break;
 
 	case BPF_ALU | BPF_MOV | BPF_K:
@@ -1065,7 +1074,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		 * src is ignored---choose tmp2 as a dummy register since it
 		 * is not on the stack.
 		 */
-		emit_alu_r32(dst, tmp2, ctx, BPF_OP(code));
+		emit_alu_r32(dst, tmp2, ctx, BPF_OP(code), false);
 		break;
 
 	case BPF_ALU | BPF_END | BPF_FROM_LE:
-- 
2.54.0.563.g4f69b47b94-goog

