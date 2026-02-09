Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001D3803CE
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652803; cv=none; b=aIXB0VHz+FrCyclCBLAxDob8A35bUrUZGG85cUfD87UDgqr3DjQkijSXkrgR7nj+aGMnEBajJS373SgOF/vJyd3H0/8Le7q8W4iPdROOG2wp8hzD4+Ndhz7iXbWxuSjvlME7ik8kVKy3DjOeOMGCdGJU5vLSl2rq2cphnmvhetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652803; c=relaxed/simple;
	bh=UZKaGE2FkVwFZldBb0BAUqZHwR0VxjMcjGkoZBGWhkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQvmPx9NHCC6PxqyhtEhWN6ACx5PpxcHFE0TiZ8d+2DFeylVPVLGXsAyixH/+Gv3GnHN17HicOJexNi2uQIsUch8Eo3L++iWLsKZ4nqHPsPIvNIxPWQNv+tXmhEAFEPwLFi2C61OvTSje2dyCfOMjeHQI1GJmapUnDZ0k7/r68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RFCQUYMK; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RFCQUYMK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770652800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ezzu7T3RKu9KyoBU185swvCe1R+ppgyQIXoPi8CHzHo=;
	b=RFCQUYMK5Z1SQoo8rr40HOyHHx28p7NTG6I2uJZ+kSEWBMwI5+LfNABoD845V5UpT5d55X
	8ffeHMEnh/RyJS0TiBeoEamjUyGYcyjO1iVQCjEpj+ZPdpb/pCapJ+XXCmwqhm8v3fsguW
	0RMXiO5N/Jnt6/19ythOW9eRHrnsDF0=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 3/4] bpf, arm64: Add 64bit bitops kfuncs support
Date: Mon,  9 Feb 2026 23:59:14 +0800
Message-ID: <20260209155919.19015-4-leon.hwang@linux.dev>
In-Reply-To: <20260209155919.19015-1-leon.hwang@linux.dev>
References: <20260209155919.19015-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement JIT inlining of the 64bit bitops kfuncs on arm64.

bpf_clz64(), bpf_ffs64(), bpf_fls64(), and bpf_bitrev64() are always
supported using mandatory ARMv8 CLZ/RBIT instructions. bpf_ctz64() is
implemented via RBIT + CLZ, or via the native CTZ instruction when
FEAT_CSSC is available. bpf_rol64() and bpf_ror64() are always
supported via RORV.

bpf_popcnt64() is not supported as the native population count
instruction requires NEON/SIMD registers, which should not be touched
from BPF programs.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c | 143 ++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 2dc5037694ba..b91896cef247 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1199,6 +1199,123 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
+static inline u32 a64_clz64(u8 rd, u8 rn)
+{
+	/*
+	 * Arm Architecture Reference Manual for A-profile architecture
+	 * (Document number: ARM DDI 0487)
+	 *
+	 *   A64 Base Instruction Descriptions
+	 *   C6.2 Alphabetical list of A64 base instructions
+	 *
+	 *   C6.2.91 CLZ
+	 *
+	 *     Count leading zeros
+	 *
+	 *     This instruction counts the number of consecutive binary zero bits,
+	 *     starting from the most significant bit in the source register,
+	 *     and places the count in the destination register.
+	 */
+	/* CLZ Xd, Xn */
+	return 0xdac01000 | (rn << 5) | rd;
+}
+
+static inline u32 a64_ctz64(u8 rd, u8 rn)
+{
+	/*
+	 * Arm Architecture Reference Manual for A-profile architecture
+	 * (Document number: ARM DDI 0487)
+	 *
+	 *   A64 Base Instruction Descriptions
+	 *   C6.2 Alphabetical list of A64 base instructions
+	 *
+	 *   C6.2.144 CTZ
+	 *
+	 *     Count trailing zeros
+	 *
+	 *     This instruction counts the number of consecutive binary zero bits,
+	 *     starting from the least significant bit in the source register,
+	 *     and places the count in the destination register.
+	 *
+	 *     This instruction requires FEAT_CSSC.
+	 */
+	/* CTZ Xd, Xn */
+	return 0xdac01800 | (rn << 5) | rd;
+}
+
+static inline u32 a64_rbit64(u8 rd, u8 rn)
+{
+	/*
+	 * Arm Architecture Reference Manual for A-profile architecture
+	 * (Document number: ARM DDI 0487)
+	 *
+	 *   A64 Base Instruction Descriptions
+	 *   C6.2 Alphabetical list of A64 base instructions
+	 *
+	 *   C6.2.320 RBIT
+	 *
+	 *     Reverse bits
+	 *
+	 *     This instruction reverses the bit order in a register.
+	 */
+	/* RBIT Xd, Xn */
+	return 0xdac00000 | (rn << 5) | rd;
+}
+
+static inline bool supports_cssc(void)
+{
+	/*
+	 * Documentation/arch/arm64/cpu-feature-registers.rst
+	 *
+	 *   ID_AA64ISAR2_EL1 - Instruction set attribute register 2
+	 *
+	 *     CSSC
+	 */
+	return cpuid_feature_extract_unsigned_field(read_sanitised_ftr_reg(SYS_ID_AA64ISAR2_EL1),
+						    ID_AA64ISAR2_EL1_CSSC_SHIFT);
+}
+
+static int emit_bitops(struct jit_ctx *ctx, s32 imm)
+{
+	const u8 r0 = bpf2a64[BPF_REG_0];
+	const u8 r1 = bpf2a64[BPF_REG_1];
+	const u8 r2 = bpf2a64[BPF_REG_2];
+	const u8 tmp = bpf2a64[TMP_REG_1];
+
+	switch (imm) {
+	case BPF_CLZ64:
+		emit(a64_clz64(r0, r1), ctx);
+		break;
+	case BPF_CTZ64:
+	case BPF_FFS64:
+		if (supports_cssc()) {
+			emit(a64_ctz64(r0, r1), ctx);
+		} else {
+			emit(a64_rbit64(tmp, r1), ctx);
+			emit(a64_clz64(r0, tmp), ctx);
+		}
+		break;
+	case BPF_FLS64:
+		emit(a64_clz64(tmp, r1), ctx);
+		emit(A64_NEG(1, tmp, tmp), ctx);
+		emit(A64_ADD_I(1, r0, tmp, 64), ctx);
+		break;
+	case BPF_BITREV64:
+		emit(a64_rbit64(r0, r1), ctx);
+		break;
+	case BPF_ROL64:
+		emit(A64_NEG(1, tmp, r2), ctx);
+		emit(A64_DATA2(1, r0, r1, tmp, RORV), ctx);
+		break;
+	case BPF_ROR64:
+		emit(A64_DATA2(1, r0, r1, r2, RORV), ctx);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
 /* JITs an eBPF instruction.
  * Returns:
  * 0  - successfully JITed an 8-byte eBPF instruction.
@@ -1451,6 +1568,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_ALU64 | BPF_ARSH | BPF_K:
 		emit(A64_ASR(is64, dst, dst, imm), ctx);
 		break;
+	case BPF_ALU64 | BPF_BITOPS:
+		ret = emit_bitops(ctx, imm);
+		if (ret)
+			return ret;
+		break;
 
 	/* JUMP reg */
 	case BPF_JMP | BPF_JA | BPF_X:
@@ -3207,3 +3329,24 @@ void bpf_jit_free(struct bpf_prog *prog)
 
 	bpf_prog_unlock_free(prog);
 }
+
+bool bpf_jit_inlines_bitops(s32 imm)
+{
+	switch (imm) {
+	case BPF_CLZ64:
+	case BPF_CTZ64:
+	case BPF_FFS64:
+	case BPF_FLS64:
+	case BPF_BITREV64:
+		/* They use RBIT/CLZ/CTZ which are mandatory in ARM64 */
+		return true;
+	case BPF_POPCNT64:
+		/* We should not touch NEON/SIMD register to support popcnt64 */
+		return false;
+	case BPF_ROL64:
+	case BPF_ROR64:
+		return true;
+	default:
+		return false;
+	}
+}
-- 
2.52.0

