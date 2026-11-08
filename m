Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166068;
	b=1QE3y8GQfLo/WR1l3K/L7uN9Ofv0lfAuMAMIretnr5OEgWjSsnecywd7GjMQehX5Kd1r
	 KzrpLLMvMk3SnZcatDNgKXgubBSKPw2vjxXrBpxGBrgz13g9vsZF90UzCpXWoEJJxi0qJ
	 dYZuM5cnFWuvngVLIpfjQ6NCT7GdUn8bbJnZdfp9hUTUs0iBcdRi/I3+TbieQifAUP4o6
	 JJ2KUYZ9purXSmj/N4M822A9ONGYoiRu3w9s+PLkTLDiIKHVFb5lxevNVlZ8kVRabsZc7
	 JmImL6gDyPXid6UU7S7HNUl6JjiZJYXHmAQxXmi9DulN7nx736lJBGHCri+KMMhfOAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166068;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=sBZSS7/PxUiDIvBG2L17TxcWPHQ9TOObt3Q9Q64pvMo=;
	b=dzFSnhABNYyiUztDUSUrfyELAwDY632nhiHUS4KAFJ6TzmWw2ibQNCPm2SC0Z7YbsuwP
	 Ea8tLkFubm2qV60EhumD7yU3yLQMVJZGvyD8j1srjoSlUyYInpG9yAtub7zjWmxVKkSMA
	 bqB4HHF7pbRqBPFcNYJWiyIrOfLqK9+WULdabw85Ik/W8d/4RjRbE/x7FMooV5x4bj21n
	 LVtSgEVizyGsetH+uUQ1fO4Akk78dILquzXuP8YjKPfOc4Sxd2K/Zqv/3Jf0hA5v4UFkC
	 cDUhDJk2v/s9wv/KWAxVs99wAx/DdjsEbwqAeiBiVQUg2KSi2Fre82YrKEX565SU1OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=hpe33U9E;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18F606A337
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B18F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=hpe33U9E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sBZSS7/PxUiDIvBG2L17TxcWPHQ9TOObt3Q9Q64pvMo=; b=hpe33U9EMFOHezDY64mEGt5Pcc
	Z9ntve3LWbUZfJhyA8wteMrtCjYvlhg6avRbdzxqmsf0OHSlQysEDg7Bd5/Qf48gX7LoSMQdqGJ1p
	ThCsvn/bKfKzYSMR1tbfU6W2EvtFRbz1JpH8TAZXzPbRcGdX3dSXSBvgUwWelAjpKy58Li0Zc45AC
	EufrgNn05sDtW4ywkacUetDDx4SW/MtPcF79rK2BUkCmeGdZDxJfNjmP0Ofk9Ewm8Ks0GaOyg9jSQ
	AknT54eE8WcP+V+joqS6VD7/q4KqPpW8+OrzSOz7Lr8LBNe/ThbM1QyTx3mUR1QDMDKH7QnqpUxFU
	UHSU3dNQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8YL-000Pmv-0Z;
	Sun, 08 Nov 2026 20:27:45 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 10/24] arm64, insn: Add the LDUR/STUR and TBZ/TBNZ encodings
Date: Sun,  8 Nov 2026 20:26:36 +0100
Message-ID: <3409c201739a30aee9edb358b7efa9dbb6ee4b02.1794165614.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

Add the encodings that the BPF JIT needs for its shorter sequences:

  - LDUR, STUR and LDURS{B,H,W}: loads and stores with a signed 9-bit
    byte offset, for the negative and unaligned offsets that the scaled
    forms cannot encode.
  - TBZ and TBNZ: test a single bit and branch, within +/-32KB.
  - Extend and shift parameters for the register offset loads and
    stores, in the same order as the extended register add and sub
    take them. They allow UXTW of a 32-bit offset register, and
    scaling the offset by the access size. UXTX gives the plain 64-bit
    register form as before.
  - A check that UMULH and SMULH use the 64-bit variant with Ra set to
    the zero register, as their encoding requires.

The JIT is the only user of the register offset encoder. It passes UXTX
without a shift, so its loads and stores stay the same, except for the
sign extending ones: their template had SXTX, which does the same for a
64-bit offset register, and they now get UXTX like the others.

Like the scaled and register offset forms, the unscaled sign extending
loads reject the 64-bit size, which would encode PRFUM.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/include/asm/insn.h |  21 +++++-
 arch/arm64/lib/insn.c         | 129 ++++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit.h      |  10 +--
 3 files changed, 155 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index f38738fa54a2..4834bf8ab87e 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -170,6 +170,8 @@ enum aarch64_insn_branch_type {
 	AARCH64_INSN_BRANCH_RETURN,
 	AARCH64_INSN_BRANCH_COMP_ZERO,
 	AARCH64_INSN_BRANCH_COMP_NONZERO,
+	AARCH64_INSN_BRANCH_TEST_ZERO,
+	AARCH64_INSN_BRANCH_TEST_NONZERO,
 };
 
 enum aarch64_insn_size_type {
@@ -196,6 +198,9 @@ enum aarch64_insn_ldst_type {
 	AARCH64_INSN_LDST_STORE_REL_EX,
 	AARCH64_INSN_LDST_SIGNED_LOAD_IMM_OFFSET,
 	AARCH64_INSN_LDST_SIGNED_LOAD_REG_OFFSET,
+	AARCH64_INSN_LDST_LOAD_UNSCALED_IMM_OFFSET,
+	AARCH64_INSN_LDST_STORE_UNSCALED_IMM_OFFSET,
+	AARCH64_INSN_LDST_SIGNED_LOAD_UNSCALED_IMM_OFFSET,
 };
 
 enum aarch64_insn_adsb_type {
@@ -205,7 +210,7 @@ enum aarch64_insn_adsb_type {
 	AARCH64_INSN_ADSB_SUB_SETFLAGS
 };
 
-/* option field of add/sub (extended register) */
+/* option field of add/sub (extended register) and load/store (register) */
 enum aarch64_insn_extend_type {
 	AARCH64_INSN_EXTEND_UXTB,
 	AARCH64_INSN_EXTEND_UXTH,
@@ -355,6 +360,9 @@ __AARCH64_INSN_FUNCS(store_post,	0x3FE00C00, 0x38000400)
 __AARCH64_INSN_FUNCS(load_post,	0x3FE00C00, 0x38400400)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
 __AARCH64_INSN_FUNCS(str_imm,	0x3FC00000, 0x39000000)
+__AARCH64_INSN_FUNCS(stur,	0x3FE00C00, 0x38000000)
+__AARCH64_INSN_FUNCS(ldur,	0x3FE00C00, 0x38400000)
+__AARCH64_INSN_FUNCS(signed_ldur, 0x3FE00C00, 0x38800000)
 __AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
 __AARCH64_INSN_FUNCS(ldclr,	0x3F20FC00, 0x38201000)
 __AARCH64_INSN_FUNCS(ldeor,	0x3F20FC00, 0x38202000)
@@ -586,6 +594,10 @@ u32 aarch64_insn_gen_comp_branch_imm(unsigned long pc, unsigned long addr,
 				     enum aarch64_insn_register reg,
 				     enum aarch64_insn_variant variant,
 				     enum aarch64_insn_branch_type type);
+u32 aarch64_insn_gen_test_branch_imm(unsigned long pc, unsigned long addr,
+				     enum aarch64_insn_register reg,
+				     int bit,
+				     enum aarch64_insn_branch_type type);
 u32 aarch64_insn_gen_cond_branch_imm(unsigned long pc, unsigned long addr,
 				     enum aarch64_insn_condition cond);
 
@@ -610,6 +622,8 @@ u32 aarch64_insn_gen_branch_reg(enum aarch64_insn_register reg,
 u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 				    enum aarch64_insn_register base,
 				    enum aarch64_insn_register offset,
+				    enum aarch64_insn_extend_type extend,
+				    int shift,
 				    enum aarch64_insn_size_type size,
 				    enum aarch64_insn_ldst_type type);
 u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
@@ -617,6 +631,11 @@ u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
 				    unsigned int imm,
 				    enum aarch64_insn_size_type size,
 				    enum aarch64_insn_ldst_type type);
+u32 aarch64_insn_gen_load_store_unscaled(enum aarch64_insn_register reg,
+					 enum aarch64_insn_register base,
+					 int imm,
+					 enum aarch64_insn_size_type size,
+					 enum aarch64_insn_ldst_type type);
 u32 aarch64_insn_gen_load_literal(unsigned long pc, unsigned long addr,
 				  enum aarch64_insn_register reg,
 				  bool is64bit);
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 87a06bd08811..540888474a71 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -331,6 +331,48 @@ u32 aarch64_insn_gen_comp_branch_imm(unsigned long pc, unsigned long addr,
 					     offset >> 2);
 }
 
+/*
+ * TBZ and TBNZ test @bit of @reg, 0 to 63 with the 64-bit register implied
+ * from bit 32 on, and reach [-32K, 32K) bytes.
+ */
+u32 aarch64_insn_gen_test_branch_imm(unsigned long pc, unsigned long addr,
+				     enum aarch64_insn_register reg,
+				     int bit,
+				     enum aarch64_insn_branch_type type)
+{
+	u32 insn;
+	long offset;
+
+	offset = label_imm_common(pc, addr, SZ_32K);
+	if (offset >= SZ_32K)
+		return AARCH64_BREAK_FAULT;
+
+	switch (type) {
+	case AARCH64_INSN_BRANCH_TEST_ZERO:
+		insn = aarch64_insn_get_tbz_value();
+		break;
+	case AARCH64_INSN_BRANCH_TEST_NONZERO:
+		insn = aarch64_insn_get_tbnz_value();
+		break;
+	default:
+		pr_err("%s: unknown branch encoding %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	if (bit < 0 || bit > 63) {
+		pr_err("%s: invalid bit %d\n", __func__, bit);
+		return AARCH64_BREAK_FAULT;
+	}
+	/* b5 in bit 31 and b40 in bits [23:19] hold the bit number */
+	insn |= (u32)(bit >> 5) << 31;
+	insn |= (bit & 0x1f) << 19;
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn, reg);
+
+	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_14, insn,
+					     offset >> 2);
+}
+
 u32 aarch64_insn_gen_cond_branch_imm(unsigned long pc, unsigned long addr,
 				     enum aarch64_insn_condition cond)
 {
@@ -376,9 +418,16 @@ u32 aarch64_insn_gen_branch_reg(enum aarch64_insn_register reg,
 	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, reg);
 }
 
+/*
+ * The offset register is extended per @extend: the 64-bit register as it is
+ * for UXTX and SXTX, the low 32 bits of it zero or sign extended for UXTW and
+ * SXTW, then shifted left by @shift, which is 0 or the log2 of the access size.
+ */
 u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 				    enum aarch64_insn_register base,
 				    enum aarch64_insn_register offset,
+				    enum aarch64_insn_extend_type extend,
+				    int shift,
 				    enum aarch64_insn_size_type size,
 				    enum aarch64_insn_ldst_type type)
 {
@@ -405,6 +454,33 @@ u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 		return AARCH64_BREAK_FAULT;
 	}
 
+	if (size < AARCH64_INSN_SIZE_8 || size > AARCH64_INSN_SIZE_64) {
+		pr_err("%s: unknown size encoding %d\n", __func__, size);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	/* S in bit 12 shifts by the access size, so only that or 0 */
+	if (shift && shift != aarch64_insn_ldst_size[size]) {
+		pr_err("%s: invalid shift encoding %d\n", __func__, shift);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	switch (extend) {
+	case AARCH64_INSN_EXTEND_UXTW:
+	case AARCH64_INSN_EXTEND_UXTX:
+	case AARCH64_INSN_EXTEND_SXTW:
+	case AARCH64_INSN_EXTEND_SXTX:
+		/* option in bits [15:13], S in bit 12 for the shift */
+		insn &= ~GENMASK(15, 12);
+		insn |= extend << 13;
+		if (shift)
+			insn |= BIT(12);
+		break;
+	default:
+		pr_err("%s: invalid extend encoding %d\n", __func__, extend);
+		return AARCH64_BREAK_FAULT;
+	}
+
 	insn = aarch64_insn_encode_ldst_size(size, insn);
 
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn, reg);
@@ -469,6 +545,50 @@ u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
 	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_12, insn, imm);
 }
 
+u32 aarch64_insn_gen_load_store_unscaled(enum aarch64_insn_register reg,
+					 enum aarch64_insn_register base,
+					 int imm,
+					 enum aarch64_insn_size_type size,
+					 enum aarch64_insn_ldst_type type)
+{
+	u32 insn;
+
+	if (imm < -SZ_256 || imm >= SZ_256) {
+		pr_err("%s: invalid imm: %d\n", __func__, imm);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	switch (type) {
+	case AARCH64_INSN_LDST_LOAD_UNSCALED_IMM_OFFSET:
+		insn = aarch64_insn_get_ldur_value();
+		break;
+	case AARCH64_INSN_LDST_SIGNED_LOAD_UNSCALED_IMM_OFFSET:
+		/* With the size of 64 bits this encodes PRFUM */
+		if (size == AARCH64_INSN_SIZE_64) {
+			pr_err("%s: invalid size for a signed load %d\n",
+			       __func__, size);
+			return AARCH64_BREAK_FAULT;
+		}
+		insn = aarch64_insn_get_signed_ldur_value();
+		break;
+	case AARCH64_INSN_LDST_STORE_UNSCALED_IMM_OFFSET:
+		insn = aarch64_insn_get_stur_value();
+		break;
+	default:
+		pr_err("%s: unknown load/store encoding %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_encode_ldst_size(size, insn);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn, reg);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
+					    base);
+
+	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_9, insn, imm);
+}
+
 u32 aarch64_insn_gen_load_literal(unsigned long pc, unsigned long addr,
 				  enum aarch64_insn_register reg,
 				  bool is64bit)
@@ -1205,6 +1325,15 @@ u32 aarch64_insn_gen_data3(enum aarch64_insn_register dst,
 		return AARCH64_BREAK_FAULT;
 	}
 
+	if ((type == AARCH64_INSN_DATA3_UMULH ||
+	     type == AARCH64_INSN_DATA3_SMULH) &&
+	    (variant != AARCH64_INSN_VARIANT_64BIT ||
+	     src != AARCH64_INSN_REG_ZR)) {
+		pr_err("%s: invalid variant or Ra for multiply high\n",
+		       __func__);
+		return AARCH64_BREAK_FAULT;
+	}
+
 	switch (variant) {
 	case AARCH64_INSN_VARIANT_32BIT:
 		break;
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index d3e70de49b44..3dcc2d2cf035 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -55,11 +55,13 @@
 #define A64_BLR(Rn) aarch64_insn_gen_branch_reg(Rn, AARCH64_INSN_BRANCH_LINK)
 #define A64_RET(Rn) aarch64_insn_gen_branch_reg(Rn, AARCH64_INSN_BRANCH_RETURN)
 
-/* Load/store register (register offset) */
-#define A64_LS_REG(Rt, Rn, Rm, size, type) \
-	aarch64_insn_gen_load_store_reg(Rt, Rn, Rm, \
-		AARCH64_INSN_SIZE_##size, \
+/* Load/store register (register offset), at Rn + (EXT(Rm) << shift) */
+#define A64_LS_REG_EXT(Rt, Rn, Rm, ext, shift, size, type) \
+	aarch64_insn_gen_load_store_reg(Rt, Rn, Rm, AARCH64_INSN_EXTEND_##ext, \
+		shift, AARCH64_INSN_SIZE_##size, \
 		AARCH64_INSN_LDST_##type##_REG_OFFSET)
+#define A64_LS_REG(Rt, Rn, Rm, size, type) \
+	A64_LS_REG_EXT(Rt, Rn, Rm, UXTX, 0, size, type)
 #define A64_STRB(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 8, STORE)
 #define A64_LDRB(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 8, LOAD)
 #define A64_LDRSB(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 8, SIGNED_LOAD)
-- 
2.43.0

