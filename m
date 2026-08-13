Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B86041687A
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647863; cv=none; b=df614n3739WhzA9+7hBPeOCAMkwMnAAnsOrGtWMfFrKhMsyS3B/0e+4bWTsA890Ec72/h2n5d6x34f02G3NTqp3caSHqcxei+EW9eVe5d5Y0XS0uNByNNQjx+PBFZkR1sPw1SR3ORCjP1zrR67fl6mn9ecWt0GqzAFlE/bq/YkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647863; c=relaxed/simple;
	bh=py08yf7ffvlyMB+r/1cXd/G+joODL5qxb+iUNQ5V34U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhuI0eGKMZCWrdE5TSdSEPa3G8UEFZBDN397rQan9lm+5LaCtYjJGdavtjwlx7zC4FtySoeMC9kWXZZjjagoAck+U2Yy86lT9wnz8dNWsr8cg70KSi7fGjQrLkySzEnzw+EPzT3uYaDdFDIIuhD14Lt1n2Ydya/z4oqFOa4pmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/PfS4Re; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/PfS4Re"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957331F00A3A;
	Thu, 13 Aug 2026 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647861;
	bh=zdw4Rd74+qNA8x6GuPjYv1FD5puUAHQOB8zlSXzCHa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A/PfS4Re44iYGkRzDJC70X0w/q9Of2kPgyYaASWuInWH61oq0cT7k3nwOimB/vcuT
	 wx4E3Gz5DjBqkKT/zs4IvWmoysokV75QGJ38wvZnkldJKP43RGen6LMuo0l0MoSEAn
	 22UipvO78BpPSSlPNFZq+CaTDcdmZPKoCsD06KqQtRNS7uvP4G8g3pm/2Zv3niZGn+
	 GdwaHkR63Ocw7+iPA7sTsD+a6H7bHHqf78WSCjdhpXkOxllHpb/IjU+yF3AG2j3yKj
	 SB7NXI4jlpuv5nSKMWQEHb/LPpzULvr44zSsIkViWTxK/US/Zes8KZ4SrTUoNEF3Xb
	 FMo8VTas3J1yg==
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
	Tejun Heo <tj@kernel.org>,
	Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH bpf-next v2 2/7] arm64: insn: Add encoder for ADD/SUB (extended register)
Date: Thu, 13 Aug 2026 12:03:49 -0700
Message-ID: <20260813190356.335181-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813190356.335181-1-puranjay@kernel.org>
References: <20260813190356.335181-1-puranjay@kernel.org>
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
existing IMM_6 field type. The opt field in bits 23:22 is part of the
opcode here rather than a shift type, and any value other than 00 is
unallocated, so the decode masks cover it.

Note that register 31 does not mean the same thing in the two forms: in
the extended-register encoding it is SP for Rn, and for Rd unless the
instruction sets the flags, while it stays XZR for Rm. Callers porting a
shifted-register site that passes A64_ZR need to be aware of that, so
say so above the function.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Reviewed-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/include/asm/insn.h | 23 ++++++++++++++
 arch/arm64/lib/insn.c         | 60 +++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index cc0702fa64a79..1ce75a4426387 100644
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
+__AARCH64_INSN_FUNCS(add_ext,	0x7FE00000, 0x0B200000)
+__AARCH64_INSN_FUNCS(adds_ext,	0x7FE00000, 0x2B200000)
+__AARCH64_INSN_FUNCS(sub_ext,	0x7FE00000, 0x4B200000)
+__AARCH64_INSN_FUNCS(subs_ext,	0x7FE00000, 0x6B200000)
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

