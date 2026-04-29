Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ABE3F23D1
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466136; cv=none; b=hXbuPHXi0PHPiLNWo7Ut7bi3RYBcCtasqnE16XcoiUoBQO0uMKKbi3Qev193/mDExS0XcYTQXOxWOkH7ztpdpPE7CueLD2jJ0RtEH7jcyRrLQqi4QAqhcn4du1idsRSk9hc9UIG7ppcjrSwNAJ7ov9Rb2DUq9k1BLumNUUKGrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466136; c=relaxed/simple;
	bh=MnqhpnMcV2P1Wy0heNfuJG74jwvy4A1hjAwYRvR5OgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ur5jsCrdCfzWlN3gEDdFQO03NnL1SI0qt0p4Y3FhHhSHlbvoNamhGTjcoUi2/wDR8U2O4ale3uSGFuhVTSKHr+DL0EYOnn1qgATVwjmlVBkYCJkBHhubN/Z4rYVrdzlEaRw6ll+d0i1qPHzv49aUTPw0EsajcKzLGK9EzDP5g48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkjKBKOg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkjKBKOg"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so12991226a91.0
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777466134; x=1778070934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxdKbXflghhv0mGi1QDRLpuzGnjGR2JliNl5UkqK1ag=;
        b=hkjKBKOg8w8ISxAHhrJFQfZNjQ9dtSq+nj0zURdGVBh4n+EZYXF3FjnIsuy3aclhCw
         MApqAu9DAgIqadz9I9xCyfx7nckQJ2pfwMmy6JjEjFqNhejhwbkueC06mtO/6EiTI2rK
         ONkcq8UBM+ZFhVo/S0cvGiXzIh+barTiJFsYJtALm3xYmUYyfqOWLSOP2KpvXvG5i0ny
         LuAdGZTqi5dBdOXxi3EDtCcN1u4syP7UgdyQZkSZUdIfSdmISt3IhMxreaYNbujYdnOh
         btNOFyK0nX/62bK/UyMtrP8m2UB6pl3AXDycCvpqWEQQ8U9iFqbxV2PaIgReKsA1gEyJ
         tZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466134; x=1778070934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mxdKbXflghhv0mGi1QDRLpuzGnjGR2JliNl5UkqK1ag=;
        b=PieRi+YKWdFjP8Fsea3XWt6lwil3xbxYzztAFF2FkQZPa8aUoMDxHRn5AllYqExy0v
         SJ2tcqb6nyxWIr8q+Q9EUcVHBJ2fN+Y5IyFcZAjUW1vw9wKVfrIqbpT+unVTVFZk9GHp
         ZN76tOE6adYxSkPV1XFKHUGfnkz6PjJpqBG0MOMC12HzjQeBoUb3D2eRsDu7wfpKfXes
         vfRgEMeaiPQVH9ALvi+OfBmug0z65erALa2H+Dl81CXSz0DReEr0PgoNa3eklu3YiXVv
         4v5wDXRYZJXTafm63jMs/YBavO0kpqlj55V1i4TH+SEENEwhq/6qQnkxQlzkPA1jgxFy
         4ZgA==
X-Forwarded-Encrypted: i=1; AFNElJ9IWzJ6RsWPpjI1HnpHVAk19UsS90orQG1v4rJ9kzK2qHvQ44jOBsBIAPj5ER/2fwfXTJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhVZfuUJznclSPsCBW/4yfTmz3j8pJIXlIJGTbJJpDbCyLNe46
	1gy7eJyycs+Rw/tYv5MG2uiJx47a+rlC7pqOz1Pp61ug5ngx/BFZbGKm
X-Gm-Gg: AeBDieuc7ukpt4ZA/tbY0qhGtZPl/vWLgkwypT4ZvGU/vP4TagdHHg1yLn3CU9IbNTO
	VpGsdNfpuvtQhZS3/kLx1RQuD+G76nBmz224CnJHnytmGUZpcLskxOhrdEx7gn5vWT2Sr2miGUq
	cq8rjngVhg3Grz8C/qQNGZLzb1uCy/lLGJum0vAyl+OZM01XQyHjiTi/o3L3KllTVmjH2nzLPtF
	GTY5QrG2n+ydsmDNwUWqICCHW2CrOZzNeIesnY06p1qTX7QyIA5xxbTGO2ywBC+OWZN+N5hZVBQ
	JSnkFVuVnFd7wdy59Rg+u+5GdI7cVXib+wV3g9/QtWUuKAD4eoyW3I/K6LBiFvv5rCzkWA7XQGa
	O6U/RV5//2UI4i9WtNPjMwt8ZrhZTLHM8aHAxSc8fyh/2J9CrR5SIqg+AnNM+0q34QGdVAdNuhV
	g+YzgYQ7x+zRKvJhxIAlQUntFcSkJO+pnk5/ZLXMM9aGecF3X5nz7mqtEAvPluA/jejf5mZj/15
	+bDtG1yHQxbbs0DW019IZqAS+KrVz5uraaH9VHtOGtY
X-Received: by 2002:a17:90b:3b8a:b0:35d:9da0:4947 with SMTP id 98e67ed59e1d1-36492019132mr7805627a91.11.1777466134253;
        Wed, 29 Apr 2026 05:35:34 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a419c9a6sm2261855a91.7.2026.04.29.05.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:35:33 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/3] riscv, bpf: Fix support for BPF_SDIV and BPF_SMOD in RV32 JIT
Date: Wed, 29 Apr 2026 12:35:11 +0000
Message-ID: <20260429123513.3477780-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429123513.3477780-1-visitorckw@gmail.com>
References: <20260429123513.3477780-1-visitorckw@gmail.com>
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
2.54.0.545.g6539524ca2-goog

