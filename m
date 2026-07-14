Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243241DE4FB
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783988797; cv=none; b=kjp+PRvMQVbNSbPQpSt71NuCLK5VxeTf3rITcleszwUIKCZLLHxoj2HUXYELJMStZS0+LdEAmoO2mo6EVTF6O5Z8SHL0cQ1qfCJ2L0eACYaal4lwjlzeI9TXsG+WKYKUSfbtq93fX5yHTwlN2Ba/Nopsq7LSso6Uchd2vtKAOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783988797; c=relaxed/simple;
	bh=9DqkAxVw/jo0CkSix2eh69kcZmDjqv/rR3SY8RCjyWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDgvM7HsKiWJ/lZ2NL3+uAhZBvx06t99CisuKzcYNin0f9uXhbB+iuGnrFvh4RgX82OQYN7LCrR4Sqf/gM+PtSI+hRf7IEjjCvDRFkjuOiQFjyYLNCn/KX1xi9sCuz02MIhZQHljQjKGvjl4JrDjov0ALKyJMSrrLf9U6Vq9IIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nab4aLUN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nab4aLUN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caced6038eso5606755ad.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 17:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783988795; x=1784593595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G4Ey8HWp4FvJFSC3M85sFIilUNxEqpxDJnLthZ96lPI=;
        b=Nab4aLUNFy7vR1aoreQeT2nm7HTR1QU6GWSe4Ts4X94dbZPoHOR58TDS6XnAZfnAgD
         8tZ9kjuHdkBJVY0SXujk9wbFBsNykdvOmdgigJ8gVP6vj8EHaVvK925TUZZ8m40nj0RA
         HMMY2j7vz6U2j69EJnjmVtM+eLOobzhGJuEmUta6Uk6Z7EY+lJiue5NVAqutX9pOIuep
         4onJHnMVJ5DhSqV93QegV4p11uBUgM9i+HTkC4D+kWj2ZXozEvJE68sCVYItB8EFtTTX
         yJ5rVVH+lLw2NOGPt5ERlXFQE+IEAmjkNYvjHe1xF+gLTZBgleZ2/dKlyZUmYiq7HAsz
         mgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783988795; x=1784593595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G4Ey8HWp4FvJFSC3M85sFIilUNxEqpxDJnLthZ96lPI=;
        b=KfF0v43qWlNxogdT5M2joXOLyTcvpN7fA3NDbdeoCFdf9IE1SNbnKPbI9DXOu7S53n
         IZubIH3cO3wL56KgAEtvHuJ9BhVc/kWRpoWCko9FM2jZzLS7qHQNuMy5wVm6YYNpVFoq
         ef7gHDWkl+fLRWEb4OMd7p+Oi3I64axHD2SXCkyTAxE1CffGVy8ZljlY+Icr9lKoHt4r
         yxZuBtH193PJsm0YgtOkEVVs3w6RKRYmL7cspFWitIlwRpBV0Ct3t+pfATLLvEbwx6xu
         X1tqBEJpOsrQsu8TIvkEPOntzUtKYCCjbysUwmV3rdbTbrUvREV6IktJJJ1hUuRNUkQJ
         oGqA==
X-Forwarded-Encrypted: i=1; AHgh+RoYwnEefFQiiUJ4u16QAFWZZ5NsQMQWGg1vApXTSvIfCnD67I6+wVar4XnXdKgT0rm7kB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCD2uMisekSBVVTNFRD13oMqxSXxO+H2j6D70/GNQWr5jrfn/3
	ieIYrhGS84FM4S4Viq0Ei389mGRT2lsJ7jiSwNniHU4djcGx81+7XyC8
X-Gm-Gg: AfdE7cnWxVGTrtT+KykL4b2OShEZ6u51omsICzZgBpsnkxfMvivIT1FoDc49Op9D3wy
	bY6Wx6v9VrNbQprXysi2Ehk227ttuBSSlvRV2kx4G9owdD21XIm5hntZ/nK52wdYvSTnCXGJ0Xt
	IQzqb225JkOBodpQL9zy85y4KGh5gZLfYJM8wqp1lHWPfZsOmfgZjW5nLuTtTNHlOTZih3FVWMz
	aVmr9bIIGh+UkynFGG8qEyog1765cIWB/VGyW0Dh10az+D68UFucv1WGGcBZovFoGqpxsJDYXT0
	pAfKaUCZ//uiQqAZ4A7mkkgyh9ChEKcfopukvKj4qUPCPW3gEY/Ri1qESGmPAUzBlJlLFXBTVvM
	kZYfJM2uPlLVtw1EZHFT80J220Nd1dHbfzzpwxkDiZrTBGB1Q5sV6Uvfl3Cu71SSB55B0UBUkdi
	BQmfvFRFLK/t1ZPtNbchJpIjnWGZHXZ1gM5VeirOKiHf7OCF2s03J4lmroZkGyvZ3JwrdS7Uu6m
	okMiYZJlZGChwg=
X-Received: by 2002:a17:903:110f:b0:2cc:92ae:b36 with SMTP id d9443c01a7336-2ce82970406mr140024965ad.24.1783988795333;
        Mon, 13 Jul 2026 17:26:35 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (131.197.81.34.bc.googleusercontent.com. [34.81.197.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1edb0sm105796545ad.53.2026.07.13.17.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 17:26:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/3] riscv, bpf: Add support for BPF_SDIV and BPF_SMOD in RV32 JIT
Date: Tue, 14 Jul 2026 00:24:49 +0000
Message-ID: <20260714002451.4091139-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260714002451.4091139-1-visitorckw@gmail.com>
References: <20260714002451.4091139-1-visitorckw@gmail.com>
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
Reviewed-by: Pu Lehui <pulehui@huawei.com>
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
2.55.0.795.g602f6c329a-goog

