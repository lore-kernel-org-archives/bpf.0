Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD93793BF
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388986; cv=none; b=pqcr2DbxMkLm4wePEHSWlaVDGEhFQ3TURJO/2g+T7PcHCa3qKlNSii7+UotOKPaj00oIvGGry4lSxsWz6t6ehmHDj1xTvpJSe4Qg2nwNbqoQO+UgcQ25u6VSZEVylyDh9PsVp3BK1MU8xiv4Pv2CxrS2Xefdi1ZZzN2uqmxEVA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388986; c=relaxed/simple;
	bh=MBOLtLj2c9kXFDpjWyCIqO2KhtMBFhuAAI9sw2pV2U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoDUOiFHiw4A3e+ka2P+d1JnUe3oqvz4tKSuGBQREt9lld1ZmmDmD58thkWz5YnYUfmbnVAiCKRm8tHgTNgpKbbD/YT4IJ1XjSSmvjlR9WIMlusOqv6eNrXk9NoKrtAd+vFJFunwmJY5oiYEy2TyoLAKOA9u7dx2i/t9VThhGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIUX1SoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIUX1SoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2FF1F000E9;
	Mon, 10 Aug 2026 19:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388984;
	bh=+LVWsQHCw7o1dTxzw87BDLvRlaxP9h1j0pYcFUXXL9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BIUX1SoJ19pZqUkpYUBs+T/4bTUwDdb+Tz1pK+e0sATHgD71hY0a5KZoXDfyLe1Vg
	 MblxAtwWTGVqcTLHmCJx2anJ7OCbegEhnpo28j7SYTEvFVKFjZlG/CdhOm+cDQ7upv
	 2TdEOtYRq9qWNP13T9B17kjvlFpShGldPIBzzvua6bcsFNoHiBqmUwYHQEOJh5CIEu
	 IDgHrvq6gSV7g1ffEDx0Aabsj3pXH7Jf9IjffjKGEoSh5kPM+lS1eQPan8FY4V9D7w
	 vU9Zj/JQFof3RrjxoHoYxlosQMoCDZz88CoT/F5xIUhFao6tSAj/7g9xXB1DLWpwcs
	 t1CLuKDGrjhig==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next 2/7] arm64: insn: Add encoder for ADD/SUB (extended register)
Date: Mon, 10 Aug 2026 12:09:15 -0700
Message-ID: <20260810190922.3408757-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810190922.3408757-1-puranjay@kernel.org>
References: <20260810190922.3408757-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

The insn library encodes the immediate and shifted-register forms of
ADD/SUB but not the extended-register form. The BPF JIT wants it to
rebase a 32-bit arena offset onto the arena kernel base in a single
instruction, add xN, xBASE, wN, uxtw, instead of a separate zero-extend
followed by a plain add.

Add aarch64_insn_gen_add_sub_extended_reg(), modeled on the
shifted-register generator. The option and imm3 fields occupy the same
bits as the shifted form's shift amount, so they are encoded through the
existing IMM_6 field type.

Note that register 31 does not mean the same thing in the two forms: in
the extended-register encoding it is SP for Rn, and for Rd unless the
instruction sets the flags, while it stays XZR for Rm. Callers porting a
shifted-register site that passes A64_ZR need to be aware of that, so
say so above the function.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/include/asm/insn.h | 23 ++++++++++++++
 arch/arm64/lib/insn.c         | 60 +++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index cc0702fa64a79..4548e8015808d 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -205,6 +205,18 @@ enum aarch64_insn_adsb_type {
 	AARCH64_INSN_ADSB_SUB_SETFLAGS
 };
 
+/* option field of add/sub (extended register) */
+enum aarch64_insn_extend_type {
+	AARCH64_INSN_EXTEND_UXTB,
+	AARCH64_INSN_EXTEND_UXTH,
+	AARCH64_INSN_EXTEND_UXTW,
+	AARCH64_INSN_EXTEND_UXTX,
+	AARCH64_INSN_EXTEND_SXTB,
+	AARCH64_INSN_EXTEND_SXTH,
+	AARCH64_INSN_EXTEND_SXTW,
+	AARCH64_INSN_EXTEND_SXTX,
+};
+
 enum aarch64_insn_movewide_type {
 	AARCH64_INSN_MOVEWIDE_ZERO,
 	AARCH64_INSN_MOVEWIDE_KEEP,
@@ -378,6 +390,10 @@ __AARCH64_INSN_FUNCS(add,	0x7F200000, 0x0B000000)
 __AARCH64_INSN_FUNCS(adds,	0x7F200000, 0x2B000000)
 __AARCH64_INSN_FUNCS(sub,	0x7F200000, 0x4B000000)
 __AARCH64_INSN_FUNCS(subs,	0x7F200000, 0x6B000000)
+__AARCH64_INSN_FUNCS(add_ext,	0x7F200000, 0x0B200000)
+__AARCH64_INSN_FUNCS(adds_ext,	0x7F200000, 0x2B200000)
+__AARCH64_INSN_FUNCS(sub_ext,	0x7F200000, 0x4B200000)
+__AARCH64_INSN_FUNCS(subs_ext,	0x7F200000, 0x6B200000)
 __AARCH64_INSN_FUNCS(madd,	0x7FE08000, 0x1B000000)
 __AARCH64_INSN_FUNCS(msub,	0x7FE08000, 0x1B008000)
 __AARCH64_INSN_FUNCS(udiv,	0x7FE0FC00, 0x1AC00800)
@@ -637,6 +653,13 @@ u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
 					 int shift,
 					 enum aarch64_insn_variant variant,
 					 enum aarch64_insn_adsb_type type);
+u32 aarch64_insn_gen_add_sub_extended_reg(enum aarch64_insn_register dst,
+					  enum aarch64_insn_register src,
+					  enum aarch64_insn_register reg,
+					  enum aarch64_insn_extend_type extend,
+					  int shift,
+					  enum aarch64_insn_variant variant,
+					  enum aarch64_insn_adsb_type type);
 u32 aarch64_insn_gen_data1(enum aarch64_insn_register dst,
 			   enum aarch64_insn_register src,
 			   enum aarch64_insn_variant variant,
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 37ce75f7f1f08..e70ac02385153 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -986,6 +986,66 @@ u32 aarch64_insn_gen_add_sub_shifted_reg(enum aarch64_insn_register dst,
 	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_6, insn, shift);
 }
 
+/*
+ * Unlike the shifted-register form, register 31 is not XZR everywhere here:
+ * it encodes SP for @src, and for @dst too unless @type sets the flags. Only
+ * @reg keeps the XZR meaning.
+ */
+u32 aarch64_insn_gen_add_sub_extended_reg(enum aarch64_insn_register dst,
+					  enum aarch64_insn_register src,
+					  enum aarch64_insn_register reg,
+					  enum aarch64_insn_extend_type extend,
+					  int shift,
+					  enum aarch64_insn_variant variant,
+					  enum aarch64_insn_adsb_type type)
+{
+	u32 insn;
+
+	switch (type) {
+	case AARCH64_INSN_ADSB_ADD:
+		insn = aarch64_insn_get_add_ext_value();
+		break;
+	case AARCH64_INSN_ADSB_SUB:
+		insn = aarch64_insn_get_sub_ext_value();
+		break;
+	case AARCH64_INSN_ADSB_ADD_SETFLAGS:
+		insn = aarch64_insn_get_adds_ext_value();
+		break;
+	case AARCH64_INSN_ADSB_SUB_SETFLAGS:
+		insn = aarch64_insn_get_subs_ext_value();
+		break;
+	default:
+		pr_err("%s: unknown add/sub encoding %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	switch (variant) {
+	case AARCH64_INSN_VARIANT_32BIT:
+		break;
+	case AARCH64_INSN_VARIANT_64BIT:
+		insn |= AARCH64_INSN_SF_BIT;
+		break;
+	default:
+		pr_err("%s: unknown variant encoding %d\n", __func__, variant);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	if (shift < 0 || shift > 4) {
+		pr_err("%s: invalid shift encoding %d\n", __func__, shift);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RD, insn, dst);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, src);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, reg);
+
+	/* option in bits [15:13] and imm3 in [12:10] together fill IMM_6 */
+	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_6, insn,
+					     (extend << 3) | shift);
+}
+
 u32 aarch64_insn_gen_data1(enum aarch64_insn_register dst,
 			   enum aarch64_insn_register src,
 			   enum aarch64_insn_variant variant,
-- 
2.53.0-Meta

