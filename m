Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708867;
	b=YCWJp5DExJDGGr6yEvBt52V367TOjj7QwHoc7m+mxI6178ttaeP1A+uilOM3Jk5p8Qs+
	 6PDFMcCtsGdifqXGzUqMWCRhzBiHLnqoCZP+A+fg99adsAHHt+3d1FR8EGRI0A1MBMaR7
	 ozZa6cF9ZJJXiuqI7tMORE4L2kGbirpO+driUpyjmHg20utOTWd3nGDA3MxyoRBJLLhy7
	 ju4jY3jaqI14XIrk+FRbN7C+ZV684a9XU4GiE/OM/YHB1KirvSVV1zyqg3/RopKYydxSC
	 kM6PSRotWfm5jdeq/N0XLYa54hl1kHJT23N7m43fxdlZvenBYNdVBwieDr+0Hpa9eew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708867;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=yRUS5xkKrg2l+xNUGRxYdX9u810bshj//MrJx5MAVYk=;
	b=oJfjyb6eVfeVPtXHugm6wNQD9o0nTsT3mpvc0She8bSyjrfmYRuBl4qNe/uSnFtUqc3l
	 tlBJTgPoNhycg2p2mcOWAIuSnWzVT2BWPnJUznSWkQz9TOX32yTr3dcJaSvPk+k3A+wV0
	 vVcuyioFUBuyz9BGVprO6Yztm9XYuwRRbO5QjFdVpz5L+wERf6kz8fA1FAortKWIrmgkT
	 g08d3hzw7unzjchx6DiHUNCo4Q8A2kExWhSheYHyebm9iamfPiWsL8IXFErtB/6VJJ+vZ
	 5DZ8paUT3rC4edib6zqDnY7ckv+V7+V816k5GdfQLCWcQXWbu0+q1o3aN1kS25+QJ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b="HNxSf/tY";
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344E2606A331
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 344E2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=HNxSf/tY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yRUS5xkKrg2l+xNUGRxYdX9u810bshj//MrJx5MAVYk=; b=HNxSf/tYDPIHCynl/kq0T20xni
	2pXMoqv0GRIETSELsBhe/u6Y5JPOCK225VZVA73vKfisK5EmtX94mceCiBzzOHNGjnZw8CbwN35DS
	pGF8BXnV+MuErJu/3Ao5lIzYwQiEB3aEp82iC2/EKv8gBmPpGHS49JuNRrSzsJlPyK75z/YzOd99s
	vvTmGmiKos8A3CQGpR8L1u9fYU0Gh6qt1XrnSKy880z/z4KdmUHmjocpXgF7y9uGU7fQWzCbUDTVn
	fg3R5btJX56GbakkrvApD6mk6a9PtkHc6PhlNHEY9tq7S8itQnPL1Qty8kh6oCd1XY77qXxSzc7kk
	o2Zak8fg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc2-000MQe-1T;
	Tue, 03 Nov 2026 13:27:38 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 06/20] arm64, insn: Add the LDUR/STUR and TBZ/TBNZ encodings
Date: Tue,  3 Nov 2026 13:27:19 +0100
Message-ID: <20261103122733.1383002-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103122733.1383002-1-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

Add the encodings the BPF JIT needs for its shorter sequences:

  - LDUR, STUR and LDURS{B,H,W}, the loads and stores with a signed
    9-bit byte offset, for the negative and unaligned offsets the
    scaled forms cannot encode.
  - TBZ and TBNZ, the test bit and branch within 32KB.
  - An extend parameter for the register offset loads and stores, for
    UXTW of a 32-bit offset register, which keeps the LSL form for
    UXTX, with a flag for the scaling of the offset by the access size,
    and a shift type parameter for the shifted register adds and subs,
    for LSR and ASR next to LSL.
  - A check that UMULH and SMULH take the 64-bit variant with Ra fixed
    to the zero register, as their encoding implies.

The JIT is the only user of the two extended encoders and passes what it
emits today, along with the bpf_jit.h macros for TBZ, TBNZ and the
shifted adds and subs. The sign extending loads with a register offset
carried the equivalent SXTX in their template and take UXTX now like the
other loads and stores, the same access through a 64-bit offset
register.

Like the scaled and register offset forms, the unscaled sign extending
loads reject the 64-bit size, which would encode PRFUM.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/include/asm/insn.h |  30 +++++++-
 arch/arm64/lib/insn.c         | 132 ++++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit.h      |  36 ++++++++--
 3 files changed, 191 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index f38738fa54a2..9a7273e1e1f0 100644
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
@@ -205,7 +210,15 @@ enum aarch64_insn_adsb_type {
 	AARCH64_INSN_ADSB_SUB_SETFLAGS
 };
 
-/* option field of add/sub (extended register) */
+/* shift field of the shifted register forms */
+enum aarch64_insn_shift_type {
+	AARCH64_INSN_SHIFT_LSL,
+	AARCH64_INSN_SHIFT_LSR,
+	AARCH64_INSN_SHIFT_ASR,
+	AARCH64_INSN_SHIFT_ROR,
+};
+
+/* option field of add/sub (extended register) and load/store (register) */
 enum aarch64_insn_extend_type {
 	AARCH64_INSN_EXTEND_UXTB,
 	AARCH64_INSN_EXTEND_UXTH,
@@ -355,6 +368,9 @@ __AARCH64_INSN_FUNCS(store_post,	0x3FE00C00, 0x38000400)
 __AARCH64_INSN_FUNCS(load_post,	0x3FE00C00, 0x38400400)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
 __AARCH64_INSN_FUNCS(str_imm,	0x3FC00000, 0x39000000)
+__AARCH64_INSN_FUNCS(stur,	0x3FE00C00, 0x38000000)
+__AARCH64_INSN_FUNCS(ldur,	0x3FE00C00, 0x38400000)
+__AARCH64_INSN_FUNCS(signed_ldur, 0x3FE00C00, 0x38800000)
 __AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
 __AARCH64_INSN_FUNCS(ldclr,	0x3F20FC00, 0x38201000)
 __AARCH64_INSN_FUNCS(ldeor,	0x3F20FC00, 0x38202000)
@@ -586,6 +602,10 @@ u32 aarch64_insn_gen_comp_branch_imm(unsigned long pc, unsigned long addr,
 				     enum aarch64_insn_register reg,
 				     enum aarch64_insn_variant variant,
 				     enum aarch64_insn_branch_type type);
+u32 aarch64_insn_gen_test_branch_imm(unsigned long pc, unsigned long addr,
+				     enum aarch64_insn_register reg,
+				     int bit,
+				     enum aarch64_insn_branch_type type);
 u32 aarch64_insn_gen_cond_branch_imm(unsigned long pc, unsigned long addr,
 				     enum aarch64_insn_condition cond);
 
@@ -610,6 +630,8 @@ u32 aarch64_insn_gen_branch_reg(enum aarch64_insn_register reg,
 u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 				    enum aarch64_insn_register base,
 				    enum aarch64_insn_register offset,
+				    enum aarch64_insn_extend_type extend,
+				    bool scaled,
 				    enum aarch64_insn_size_type size,
 				    enum aarch64_insn_ldst_type type);
 u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
@@ -617,6 +639,11 @@ u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
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
@@ -654,6 +681,7 @@ u32 aarch64_insn_gen_movewide(enum aarch64_insn_register dst,
 u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
 					 enum aarch64_insn_register src,
 					 enum aarch64_insn_register reg,
+					 enum aarch64_insn_shift_type shift_type,
 					 int shift,
 					 enum aarch64_insn_variant variant,
 					 enum aarch64_insn_adsb_type type);
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 48a481aa9656..f863297f76e4 100644
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
+ * SXTW, and shifted left by the log2 of the access size when @scaled.
+ */
 u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 				    enum aarch64_insn_register base,
 				    enum aarch64_insn_register offset,
+				    enum aarch64_insn_extend_type extend,
+				    bool scaled,
 				    enum aarch64_insn_size_type size,
 				    enum aarch64_insn_ldst_type type)
 {
@@ -405,6 +454,22 @@ u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 		return AARCH64_BREAK_FAULT;
 	}
 
+	switch (extend) {
+	case AARCH64_INSN_EXTEND_UXTW:
+	case AARCH64_INSN_EXTEND_UXTX:
+	case AARCH64_INSN_EXTEND_SXTW:
+	case AARCH64_INSN_EXTEND_SXTX:
+		/* option in bits [15:13], S in bit 12 for the scaling */
+		insn &= ~GENMASK(15, 12);
+		insn |= extend << 13;
+		if (scaled)
+			insn |= BIT(12);
+		break;
+	default:
+		pr_err("%s: invalid extend encoding %d\n", __func__, extend);
+		return AARCH64_BREAK_FAULT;
+	}
+
 	insn = aarch64_insn_encode_ldst_size(size, insn);
 
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn, reg);
@@ -469,6 +534,50 @@ u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
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
@@ -943,6 +1052,7 @@ u32 aarch64_insn_gen_movewide(enum aarch64_insn_register dst,
 u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
 					 enum aarch64_insn_register src,
 					 enum aarch64_insn_register reg,
+					 enum aarch64_insn_shift_type shift_type,
 					 int shift,
 					 enum aarch64_insn_variant variant,
 					 enum aarch64_insn_adsb_type type)
@@ -967,6 +1077,19 @@ u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
 		return AARCH64_BREAK_FAULT;
 	}
 
+	switch (shift_type) {
+	case AARCH64_INSN_SHIFT_LSL:
+	case AARCH64_INSN_SHIFT_LSR:
+	case AARCH64_INSN_SHIFT_ASR:
+		/* shift type in bits [23:22], ROR is reserved for add/sub */
+		insn |= shift_type << 22;
+		break;
+	default:
+		pr_err("%s: invalid shift type encoding %d\n", __func__,
+		       shift_type);
+		return AARCH64_BREAK_FAULT;
+	}
+
 	switch (variant) {
 	case AARCH64_INSN_VARIANT_32BIT:
 		if (shift & ~(SZ_32 - 1)) {
@@ -1178,6 +1301,15 @@ u32 aarch64_insn_gen_data3(enum aarch64_insn_register dst,
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
index b2fe05fcdef0..b5e26cb1e753 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -26,6 +26,13 @@
 #define A64_CBZ(sf, Rt, imm19) A64_COMP_BRANCH(sf, Rt, (imm19) << 2, ZERO)
 #define A64_CBNZ(sf, Rt, imm19) A64_COMP_BRANCH(sf, Rt, (imm19) << 2, NONZERO)
 
+/* Test bit & branch (immediate) */
+#define A64_TEST_BRANCH(Rt, bit, offset, type) \
+	aarch64_insn_gen_test_branch_imm(0, offset, Rt, bit, \
+		AARCH64_INSN_BRANCH_TEST_##type)
+#define A64_TBZ(Rt, bit, imm14) A64_TEST_BRANCH(Rt, bit, (imm14) << 2, ZERO)
+#define A64_TBNZ(Rt, bit, imm14) A64_TEST_BRANCH(Rt, bit, (imm14) << 2, NONZERO)
+
 /* Conditional branch (immediate) */
 #define A64_COND_BRANCH(cond, offset) \
 	aarch64_insn_gen_cond_branch_imm(0, offset, cond)
@@ -52,11 +59,13 @@
 #define A64_BLR(Rn) aarch64_insn_gen_branch_reg(Rn, AARCH64_INSN_BRANCH_LINK)
 #define A64_RET(Rn) aarch64_insn_gen_branch_reg(Rn, AARCH64_INSN_BRANCH_RETURN)
 
-/* Load/store register (register offset) */
-#define A64_LS_REG(Rt, Rn, Rm, size, type) \
-	aarch64_insn_gen_load_store_reg(Rt, Rn, Rm, \
-		AARCH64_INSN_SIZE_##size, \
+/* Load/store register (register offset), Rm extended and scaled by the size */
+#define A64_LS_REG_EXT(Rt, Rn, Rm, ext, scaled, size, type) \
+	aarch64_insn_gen_load_store_reg(Rt, Rn, Rm, AARCH64_INSN_EXTEND_##ext, \
+		scaled, AARCH64_INSN_SIZE_##size, \
 		AARCH64_INSN_LDST_##type##_REG_OFFSET)
+#define A64_LS_REG(Rt, Rn, Rm, size, type) \
+	A64_LS_REG_EXT(Rt, Rn, Rm, UXTX, false, size, type)
 #define A64_STRB(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 8, STORE)
 #define A64_LDRB(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 8, LOAD)
 #define A64_LDRSB(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 8, SIGNED_LOAD)
@@ -231,11 +240,26 @@
 #define A64_MOVK(sf, Rd, imm16, shift) A64_MOVEW(sf, Rd, imm16, shift, KEEP)
 
 /* Add/subtract (shifted register) */
-#define A64_ADDSUB_SREG(sf, Rd, Rn, Rm, type) \
-	aarch64_insn_gen_add_sub_shifted_reg(Rd, Rn, Rm, 0, \
+#define A64_ADDSUB_SHIFT(sf, Rd, Rn, Rm, stype, shift, type) \
+	aarch64_insn_gen_add_sub_shifted_reg(Rd, Rn, Rm, \
+		AARCH64_INSN_SHIFT_##stype, shift, \
 		A64_VARIANT(sf), AARCH64_INSN_ADSB_##type)
+#define A64_ADDSUB_SREG(sf, Rd, Rn, Rm, type) \
+	A64_ADDSUB_SHIFT(sf, Rd, Rn, Rm, LSL, 0, type)
 /* Rd = Rn OP Rm */
 #define A64_ADD(sf, Rd, Rn, Rm)  A64_ADDSUB_SREG(sf, Rd, Rn, Rm, ADD)
+/* Rd = Rn + (Rm << shift) */
+#define A64_ADD_LSL(sf, Rd, Rn, Rm, shift) \
+	A64_ADDSUB_SHIFT(sf, Rd, Rn, Rm, LSL, shift, ADD)
+/* Rd = Rn + (Rm >> shift) */
+#define A64_ADD_LSR(sf, Rd, Rn, Rm, shift) \
+	A64_ADDSUB_SHIFT(sf, Rd, Rn, Rm, LSR, shift, ADD)
+/* Rd = Rn - (Rm << shift) */
+#define A64_SUB_LSL(sf, Rd, Rn, Rm, shift) \
+	A64_ADDSUB_SHIFT(sf, Rd, Rn, Rm, LSL, shift, SUB)
+/* Rd = Rn - (Rm >> shift); signed */
+#define A64_SUB_ASR(sf, Rd, Rn, Rm, shift) \
+	A64_ADDSUB_SHIFT(sf, Rd, Rn, Rm, ASR, shift, SUB)
 #define A64_SUB(sf, Rd, Rn, Rm)  A64_ADDSUB_SREG(sf, Rd, Rn, Rm, SUB)
 #define A64_SUBS(sf, Rd, Rn, Rm) A64_ADDSUB_SREG(sf, Rd, Rn, Rm, SUB_SETFLAGS)
 /* Rd = -Rm */
-- 
2.43.0

