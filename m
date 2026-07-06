Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3964E3B7B68
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358955; cv=none; b=GmUkZxldAD6EExVbRg6nshF9i5p6WglmHZJTbY0q4FEUuLcHH/RzxczBG4d9X8FcRb5u/sIkpOeEsNSDpqQfyoGqU3NRvyS/bGYEJ+YE5uhlqKSwIkmljm0D2/02lH08glM7hNjnJ+aqKcbeP93iFvLUfw6quO8f0JmdQ7s0cf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358955; c=relaxed/simple;
	bh=croLdcn3FwdzG8AWJzxdaWpM9dTxbRX/erkgu9LHroE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eL8HdqzkBXUk/8qrdqbPk18zRKwGgtHTdd7ykKGAcBbnfUA/59fOu3DTHQbDEp3ROh8P+3OI5XBZ9lgJH1IKyWgxAiNB3RgN+VjuGFfXAIHvctQp+3m34g9ACciFcnxvFOr+a2wCGoc8bEcIVEwA9kSXkmhE5p7NjjcHmj4mzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeQI+UTJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeQI+UTJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cab973140bso40650115ad.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358953; x=1783963753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/CMhFxVY82r5Eid4wLFl+1SdH8jeYdZBt6ircQEov1c=;
        b=UeQI+UTJwMShvPcuV/PG5+ELVZ+0NYVVW74DMx4n7Rj09uspKnNSFbxFXZdOzhTefo
         aGI9vFsIX1PMW9yqid9moqFTMjRg+nvvDLmjorhiJURK2EBBmDcNYS8z3J+XSD+2+rn8
         xNOanZIbDm+6XgBJ4eywxKh1+QzsFAoXVDU9KqTZ77kMiGIFg9MFLRDdbKyffPxp2YMj
         II0nyEKTFqm5XwW0nEnqfyHnXpJdkooWV46K4PVlPSFtca6F/B29AScq7NwEpePVj8in
         6k5+mHzoFaC3ezoYhSa0qLxZjjH9bDZhwGqGhXvesYKD7xb0TJMAwb2wkY+QT4B3BMnU
         wEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358953; x=1783963753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/CMhFxVY82r5Eid4wLFl+1SdH8jeYdZBt6ircQEov1c=;
        b=jFA6VF1+fq8CFDxgoGSqjNDIw5HIsanyxS1GGNNCFOeuURfCDHbtg59sMtAvewaHh/
         3yFT3ysRKKF0Jjc9K8gmh91zPYbRVrwC5HtaTAkb48qCLlpU+8zqgPrxkF1TOAgZ5gew
         vu+5cYtSTyhcXLh6liCGoJGKuhCGN0XXaEG7oZLQbmkkxOiHKy+9JoK5t/GFUseYX4jq
         pg01TGvpze009buyvsml14BcHet4lPG3LuYpq6D0ShtaCM6F6kwZcS4RG1dzmIqAQOuV
         rHuz6uqcAk3ye8aawW83p7IERe/PEVGoC9umU5Q4Amfx2Ks1h/WsIcClvbFwqsU42ksT
         ebDA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8Fu4WXkSYq0J1MecISpenIIpkPRvYskukwvwS6BoEaSY3fFjojgp0bv88zAIHD4vRhZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyynKyjfuPbBDDZ73SfCy+AVFKJQ5+NL555r6lrfeUAT+UPUrrC
	tQtHGSn3wmuRorjqRTh6s+t+3jIl7ny56dDxBW07ymr3AHnsBF1us89n
X-Gm-Gg: AfdE7ckOCvnMliI/AWR3OtIp6DNNgj6BCEs062ZtvzPtkzrJwzXLPyiV8vWhvATlJ9Y
	+4BkfWFdfEwTpRGQOh1XXrh2FZ5E0L/TN81vf4i404VjnZ23lS22ZhrpOTd4ZgUVOtUhxQp3zNP
	dDM7bnTzmcIOoqG2GvPxb9Y6+taU2saOAzTYSNE2qi5WlxHIekU3GjNPPAoktIapzwzgPMjfRas
	NJZdDl9iWctQmPwAVHb3ztiGG/y5rqn7TttYxzb/hOrs3EflH8NeFwZ9qVUYU/0zbAc3olxPXFJ
	RnnS/St0+vC74LejClqF7upqE+fr2SiVilLemzOcPT/AZI4tenwFx5ltdVsA4TfAsy7BgsSPQeE
	G6GReDR7BADXdppnW//1RyJaD3HQSqO1ZDjxGJHPbiBmhCM0pLfFSO3FU91RnEcH9ECZm+BbsuZ
	MYr24bzFd0koEz6EN8SN2hFtPNupoaUzWD7y0Dr2uo4Vqev0/z2fcF3r9CeF6h1sac0Vtert8Az
	aDEkl9gJ8OoPBd9lznjGnM=
X-Received: by 2002:a17:903:17c5:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2ccbdf40961mr16975285ad.0.1783358953412;
        Mon, 06 Jul 2026 10:29:13 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e54sm54667005ad.2.2026.07.06.10.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:29:13 -0700 (PDT)
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
	aou@eecs.berkeley.edu,
	pulehui@huawei.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	alex@ghiti.fr,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	marscheng@google.com,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH bpf-next v3 1/3] riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
Date: Mon,  6 Jul 2026 17:28:44 +0000
Message-ID: <20260706172846.3876436-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260706172846.3876436-1-visitorckw@gmail.com>
References: <20260706172846.3876436-1-visitorckw@gmail.com>
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
 arch/riscv/net/bpf_jit_comp32.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
index 592dd86fbf81..89153946a4e4 100644
--- a/arch/riscv/net/bpf_jit_comp32.c
+++ b/arch/riscv/net/bpf_jit_comp32.c
@@ -509,12 +509,15 @@ static void emit_alu_r64(const s8 *dst, const s8 *src,
 }
 
 static void emit_alu_r32(const s8 *dst, const s8 *src,
-			 struct rv_jit_context *ctx, const u8 op)
+			 struct rv_jit_context *ctx,
+			 const struct bpf_insn *insn)
 {
 	const s8 *tmp1 = bpf2rv32[TMP_REG_1];
 	const s8 *tmp2 = bpf2rv32[TMP_REG_2];
 	const s8 *rd = bpf_get_reg32(dst, tmp1, ctx);
 	const s8 *rs = bpf_get_reg32(src, tmp2, ctx);
+	u8 op = BPF_OP(insn->code);
+	bool is_signed = insn->off == 1;
 
 	switch (op) {
 	case BPF_MOV:
@@ -539,10 +542,12 @@ static void emit_alu_r32(const s8 *dst, const s8 *src,
 		emit(rv_mul(lo(rd), lo(rd), lo(rs)), ctx);
 		break;
 	case BPF_DIV:
-		emit(rv_divu(lo(rd), lo(rd), lo(rs)), ctx);
+		emit(is_signed ? rv_div(lo(rd), lo(rd), lo(rs)) :
+				 rv_divu(lo(rd), lo(rd), lo(rs)), ctx);
 		break;
 	case BPF_MOD:
-		emit(rv_remu(lo(rd), lo(rd), lo(rs)), ctx);
+		emit(is_signed ? rv_rem(lo(rd), lo(rd), lo(rs)) :
+				 rv_remu(lo(rd), lo(rd), lo(rs)), ctx);
 		break;
 	case BPF_LSH:
 		emit(rv_sll(lo(rd), lo(rd), lo(rs)), ctx);
@@ -1041,7 +1046,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 			emit_imm32(tmp2, imm, ctx);
 			src = tmp2;
 		}
-		emit_alu_r32(dst, src, ctx, BPF_OP(code));
+		emit_alu_r32(dst, src, ctx, insn);
 		break;
 
 	case BPF_ALU | BPF_MOV | BPF_K:
@@ -1065,7 +1070,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		 * src is ignored---choose tmp2 as a dummy register since it
 		 * is not on the stack.
 		 */
-		emit_alu_r32(dst, tmp2, ctx, BPF_OP(code));
+		emit_alu_r32(dst, tmp2, ctx, insn);
 		break;
 
 	case BPF_ALU | BPF_END | BPF_FROM_LE:
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

