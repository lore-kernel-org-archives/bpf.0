Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125492;
	b=QOBAmNruJD9L1Dvc09Lt7yCM1NG/KNLPZfkWD9BCPnQAR/ZMePbsHaXmDtMRWxCk1lTc
	 FQrsUV2XGRubU086dQ5+j7tbp8q4Db4IggiARP9CtQFw4PTxb6MukI/fHGg8AsTZxNc9b
	 QaDD8+DZuVGacFh2W/p0stdEWCCFRdqqYwXeLN1eKDwHFVw2a9fJ+6B0+Ghg7Nd3zyJwN
	 xV2NoqQa+x7hT1yB4SdY+zoqiu/sZ4DDNKWJXk+MJMjD9oHBzSjUfzX2jQl1AtbNWGSpt
	 JOeF8o3dy4L3U47h04cmUtvurL6fm8TDm69xjOQDeSjwwUIhdjJaKKtMFYsWi4WOrXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125492;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=z+wrKY39+yQaaJ8k2RYkx52MqiX937lV0kjs/VZz/4U=;
	b=s50iZPxJqpW8Z1pf564OlNDqQa/RRtkycFSRS6wCPY9YlvlsH6ez/Qwat5syKPz3tjER
	 9O9d1Qh9QqU5qE5IPSg4UTXjq2jUaXeE069rN1ag1bZZhnSwx1IPIiIaM1hXCYyAYajq/
	 T4u7azPqPsjLJ4RTMKqT5f35TtP2wuABHByEd+19L0LtoHJ8QWZk8Qt4gFs1YwFQKRTwW
	 YxTNaYMBdq+73m+IufHhw0mVVeW45PUNTj6AEltmzmCSwBINShvswOwocTtnNWrzvaeb6
	 71UnnazvfL+nMXEQJzem6sbdc2w9ZlfYpzxlzbpvd5FJgE6Q8RLduBPl3nVTbQt8rfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=qFNToXZp;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB63606A32D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AB63606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=qFNToXZp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=z+wrKY39+yQaaJ8k2RYkx52MqiX937lV0kjs/VZz/4U=; b=qFNToXZp26VglwmwvfT/vB6DYp
	vuleXYG/YVHmJ407nDNY4q3q9qMDI2qnUipty7MXhpmM/pFwO+HqlWNNU9Hr6legfyt/+oh4PtOnO
	MvMWxR0vk8saYLK+daxwuAjRQ9hOetZBXByZ8zsSG9XYUFMwnXC43sEqQJV/ktKyD59eRnfb255LC
	zFBghdN7VQ4rOxzuQEYEkGdeJee72Q6e4K1aiXZAQNygcYLcMPCLpfgBG4goiAKKDaKspd3t6xvoV
	9wJTgRwpov3FcPoK4phRbbY55pd3JLPXH6pZiAQiqDaW5/EliqBiG+FFIefxlGWcm2MTAWzDQZP8X
	2omJ3Kxw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqs-000Ijz-0O;
	Tue, 27 Oct 2026 19:24:50 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 06/21] arm64, insn: Add the LDUR/STUR, UMULH/SMULH and TBZ/TBNZ encodings
Date: Tue, 27 Oct 2026 19:24:30 +0100
Message-ID: <20261027182445.1156335-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182445.1156335-1-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

Add the encodings the BPF JIT needs for its shorter sequences:

  - LDUR, STUR and LDURS{B,H,W}, the loads and stores with a signed
    9-bit byte offset, for the negative and unaligned offsets the
    scaled forms cannot encode.
  - UMULH and SMULH, as data-processing (3 source) instructions with Ra
    fixed to the zero register, for the division by a constant.
  - TBZ and TBNZ, the test bit and branch within 32KB.
  - An extend parameter for the register offset loads and stores, for
    UXTW of a 32-bit offset register, which keeps the LSL form for
    UXTX, and a shift type parameter for the shifted register adds and
    subs, for LSR and ASR next to LSL.

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
 arch/arm64/include/asm/insn.h |  33 ++++++++-
 arch/arm64/lib/insn.c         | 135 ++++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit.h      |  28 ++++++-
 3 files changed, 192 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 1ce75a442638..f469106c1508 100644
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
@@ -247,6 +260,8 @@ enum aarch64_insn_data2_type {
 enum aarch64_insn_data3_type {
 	AARCH64_INSN_DATA3_MADD,
 	AARCH64_INSN_DATA3_MSUB,
+	AARCH64_INSN_DATA3_UMULH,
+	AARCH64_INSN_DATA3_SMULH,
 };
 
 enum aarch64_insn_logic_type {
@@ -353,6 +368,9 @@ __AARCH64_INSN_FUNCS(store_post,	0x3FE00C00, 0x38000400)
 __AARCH64_INSN_FUNCS(load_post,	0x3FE00C00, 0x38400400)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
 __AARCH64_INSN_FUNCS(str_imm,	0x3FC00000, 0x39000000)
+__AARCH64_INSN_FUNCS(stur,	0x3FE00C00, 0x38000000)
+__AARCH64_INSN_FUNCS(ldur,	0x3FE00C00, 0x38400000)
+__AARCH64_INSN_FUNCS(signed_ldur, 0x3FE00C00, 0x38800000)
 __AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
 __AARCH64_INSN_FUNCS(ldclr,	0x3F20FC00, 0x38201000)
 __AARCH64_INSN_FUNCS(ldeor,	0x3F20FC00, 0x38202000)
@@ -396,6 +414,8 @@ __AARCH64_INSN_FUNCS(sub_ext,	0x7FE00000, 0x4B200000)
 __AARCH64_INSN_FUNCS(subs_ext,	0x7FE00000, 0x6B200000)
 __AARCH64_INSN_FUNCS(madd,	0x7FE08000, 0x1B000000)
 __AARCH64_INSN_FUNCS(msub,	0x7FE08000, 0x1B008000)
+__AARCH64_INSN_FUNCS(umulh,	0xFFE0FC00, 0x9BC07C00)
+__AARCH64_INSN_FUNCS(smulh,	0xFFE0FC00, 0x9B407C00)
 __AARCH64_INSN_FUNCS(udiv,	0x7FE0FC00, 0x1AC00800)
 __AARCH64_INSN_FUNCS(sdiv,	0x7FE0FC00, 0x1AC00C00)
 __AARCH64_INSN_FUNCS(lslv,	0x7FE0FC00, 0x1AC02000)
@@ -582,6 +602,10 @@ u32 aarch64_insn_gen_comp_branch_imm(unsigned long pc, unsigned long addr,
 				     enum aarch64_insn_register reg,
 				     enum aarch64_insn_variant variant,
 				     enum aarch64_insn_branch_type type);
+u32 aarch64_insn_gen_test_branch_imm(unsigned long pc, unsigned long addr,
+				     enum aarch64_insn_register reg,
+				     int bit,
+				     enum aarch64_insn_branch_type type);
 u32 aarch64_insn_gen_cond_branch_imm(unsigned long pc, unsigned long addr,
 				     enum aarch64_insn_condition cond);
 
@@ -606,6 +630,7 @@ u32 aarch64_insn_gen_branch_reg(enum aarch64_insn_register reg,
 u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 				    enum aarch64_insn_register base,
 				    enum aarch64_insn_register offset,
+				    enum aarch64_insn_extend_type extend,
 				    enum aarch64_insn_size_type size,
 				    enum aarch64_insn_ldst_type type);
 u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
@@ -613,6 +638,11 @@ u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
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
@@ -650,6 +680,7 @@ u32 aarch64_insn_gen_movewide(enum aarch64_insn_register dst,
 u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
 					 enum aarch64_insn_register src,
 					 enum aarch64_insn_register reg,
+					 enum aarch64_insn_shift_type shift_type,
 					 int shift,
 					 enum aarch64_insn_variant variant,
 					 enum aarch64_insn_adsb_type type);
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 98a047de5e67..544efe1fdefa 100644
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
@@ -376,9 +418,15 @@ u32 aarch64_insn_gen_branch_reg(enum aarch64_insn_register reg,
 	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, reg);
 }
 
+/*
+ * The offset register is extended per @extend: the 64-bit register as it is
+ * for UXTX and SXTX, the low 32 bits of it zero or sign extended for UXTW and
+ * SXTW. It is never scaled by the access size here.
+ */
 u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 				    enum aarch64_insn_register base,
 				    enum aarch64_insn_register offset,
+				    enum aarch64_insn_extend_type extend,
 				    enum aarch64_insn_size_type size,
 				    enum aarch64_insn_ldst_type type)
 {
@@ -405,6 +453,20 @@ u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 		return AARCH64_BREAK_FAULT;
 	}
 
+	switch (extend) {
+	case AARCH64_INSN_EXTEND_UXTW:
+	case AARCH64_INSN_EXTEND_UXTX:
+	case AARCH64_INSN_EXTEND_SXTW:
+	case AARCH64_INSN_EXTEND_SXTX:
+		/* option in bits [15:13], S in bit 12 clear for no scaling */
+		insn &= ~GENMASK(15, 12);
+		insn |= extend << 13;
+		break;
+	default:
+		pr_err("%s: invalid extend encoding %d\n", __func__, extend);
+		return AARCH64_BREAK_FAULT;
+	}
+
 	insn = aarch64_insn_encode_ldst_size(size, insn);
 
 	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn, reg);
@@ -469,6 +531,50 @@ u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
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
@@ -943,6 +1049,7 @@ u32 aarch64_insn_gen_movewide(enum aarch64_insn_register dst,
 u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
 					 enum aarch64_insn_register src,
 					 enum aarch64_insn_register reg,
+					 enum aarch64_insn_shift_type shift_type,
 					 int shift,
 					 enum aarch64_insn_variant variant,
 					 enum aarch64_insn_adsb_type type)
@@ -967,6 +1074,19 @@ u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
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
@@ -1167,11 +1287,26 @@ u32 aarch64_insn_gen_data3(enum aarch64_insn_register dst,
 	case AARCH64_INSN_DATA3_MSUB:
 		insn = aarch64_insn_get_msub_value();
 		break;
+	case AARCH64_INSN_DATA3_UMULH:
+		insn = aarch64_insn_get_umulh_value();
+		break;
+	case AARCH64_INSN_DATA3_SMULH:
+		insn = aarch64_insn_get_smulh_value();
+		break;
 	default:
 		pr_err("%s: unknown data3 encoding %d\n", __func__, type);
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
index af570c34a96d..fa2a57e6d90d 100644
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
@@ -54,7 +61,7 @@
 
 /* Load/store register (register offset) */
 #define A64_LS_REG(Rt, Rn, Rm, size, type) \
-	aarch64_insn_gen_load_store_reg(Rt, Rn, Rm, \
+	aarch64_insn_gen_load_store_reg(Rt, Rn, Rm, AARCH64_INSN_EXTEND_UXTX, \
 		AARCH64_INSN_SIZE_##size, \
 		AARCH64_INSN_LDST_##type##_REG_OFFSET)
 #define A64_STRB(Wt, Xn, Xm)  A64_LS_REG(Wt, Xn, Xm, 8, STORE)
@@ -231,11 +238,26 @@
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

