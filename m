Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728286;
	b=0rncpWUmdUIXnk6Eas8oa6aGE2P08tCf4DK8zLj9Na8UMeYy90ySTcK68FAL1Ilb5WlF
	 GHXfX8fUS8h4xRUsxd06WmnfbvZaHasf9rkF64Tv7YioyrJGPFPwxNKPgFRhSIBzyKGkL
	 GSgrvYzC8hgM1ViNaj3oTCz/Pu1jmicLCU4oqGSg6PcNE3On72RfOg6ORxLjbVWt0an8N
	 yaTwPrbyBsHIvVjjJZdREGhJGHhzQAiiFWeIUMZonsGXynK8PZFgFQVnfYG/4NgCfUvM6
	 trqthk/UGoRUPOaweDdZjdLEbPlKDkyly5BZ84cH+5aoiqFq6CE0peNcJ/kvLl1mNhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=Ag/MzkJIdX8s4+ordh3TKSG1BMJ2dmSjrG8qtHhd31Q=;
	b=Yhpu+F3Jx43RZ/HEMxRlhXxe6gpNZhZw2uNUa/NSTRF8rd7xTRLPx8AXMQc32pXxBxFh
	 GLPMJkGp/68fmtG66EQhopKzBShKjbJ1Ji1zY+tjgcwqfVY78zSSSJhV2Dsd1dWKpM9wH
	 LfZiHIbxhqtTsWYYv5ytJyBi8afEbIl8y+4bGcUYGH//JDGuXT4diZg7BRbMrlOblBXgO
	 MQ9r5mIG5HKhgr7nYbQSLyloAL6nVSe0t5pVCm/C9R5F8XH3MXDn1gX42XnPsTPJPYy+j
	 cq1lgopHs/oqul0t2Yhm3aAM3XMYCUhrO6RJF6JoBsomIPr19oKpyOG0Gvim0T5Ps+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPtmKq2B;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42DB606A333
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 17:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A42DB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPtmKq2B
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso2689781a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 09:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728285; x=1794333085; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ag/MzkJIdX8s4+ordh3TKSG1BMJ2dmSjrG8qtHhd31Q=;
        b=ZPtmKq2BKFdOXApxF2JFKT34iLZz0j7vKwR8eQbcOilosOS+Xw9CMEmF0BwZ4oFMiW
         hXSeoE3WLC+5QFssNW2LGn6+Mi8ou1U4DGlPXDolkQqL7ts6XZmejdB8U4HLlJYNMY26
         sopZzWSXxN64fB71Z21cyEVgQ3FB5h4NN49X0XYVH6/7KhsoFwrO28vzTkGuBod6eDoY
         8GKs77x/bI4gKGw3/1lTz1YdivVeEYfbbe7rSki3a7tNX3M392/R1HuVe69O/GXEWhbf
         xjcrQ+HGU4HeKweE+whGTiPyacJs80z7hFp6Zs+pXj8ouGyz3Mys2bAKpRRgHOBBvwIV
         OyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728285; x=1794333085;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ag/MzkJIdX8s4+ordh3TKSG1BMJ2dmSjrG8qtHhd31Q=;
        b=Q/n1JbbwjBytjkmD6/MmLLDcYjM2wgZSvgMCW7piucQ0J7QkRb4hQwCQuQSM5a061A
         qZSiDjNSJv5yrFagwG6zxTgUHRQPQXeNFUbfWtgxcpV3o/YtMigsp/lQPVwimSU8HzBU
         tdyMhniBOd93/0XuUV4TSNnAzZs6gvoxvrFGkfGIjBCAeVjuypC0HelZCw8hZX1Thl6Z
         hj7x1hB2dLd31i32Hyoo4LL9kKff3i0m0dOfkXJ2u14/BNk4qn6mFLH3S67IoQOskKgM
         Me5gPBCZBDI7UY+inJD1WRKI5wOcOlUwy4TtNUCGjV3OvfhyZ4h4o/SuTORk922XPt5J
         /6oA==
X-Forwarded-Encrypted: i=1; AKwUvBwk3mDQAES20k5tb+JwzM5FSzoUUj/xKkarNEgHiBQQOKdx3sy4GqNnSHm+rQtVTe91yzk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/T4RW1S3+sZVlDtGLr9GVksnYbpY1aqh0F8kgl9RwHU6aa/x1K
	Gk6/GGN6oNCk6H35F8E5fNtADmSFXto+ebBiyEvT29Uov3gpVq1Vt3wb
X-Gm-Gg: AYBFou2AUNBlU8vs7OGuu3x5Z9aSSncMF7IAwCJkQw65KxCjLj2Czemq9mpxUlwI3bD
	Ro5UhGCpYyLV66eZWGle7NmOToFY1KafKyh751yOKtbvIo1oCmwd5C08logpdbCJECW1nswKRga
	zWoWzfmXkFP6RoDJNOvs6nkRm6LLKeg5rQEgk0aJkhiwukOwsPy1Y6uE+XRAucSMhSB7znpT0HT
	XOnHMF8SZyCczl0uhNucJ6hJvf+oN0UFTQCQBnYxT1tl1wmwRRBvwGK1VsG547mySC29m6oT2aK
	ooJWIZmbzbDoYHMwupBOGHlqjYfxxiuo/kHNj8Y7k4FMu6Rr+I0PsMCESfu91MUzP0r6mnkltqL
	QldKGy2Atsly3iLEO7utMCng7DWPw/Je2Q6c041dajRbIh6Z+AItkfGH4aG0+axHNDPIBQS6i2O
	d+uLLm+20hkxed4ZXjQsnIhbBNZcblGBg6aPWXmevuVrKgUk7KFDa8jxai+CfKssXRboGLUkXMY
	Egu2R/37JnT7D37ps4qSMdFCQYU+q/e82XhO9e+aJQo9SqWrtJpFcbNh/YDF/1GZO3yn3zC3szF
	c02h3/jOSI4BKIdx0oH/5e2iPWMau9tT1+zwAN6znX0sq7fEbw4UEeouuR/jeWN7sEc6n7LyoIS
	7ToReP/seUljnstDO04HvLBl5VLAxuDSvdg==
X-Received: by 2002:a17:90b:4a83:b0:3ac:8af9:4a73 with SMTP id 98e67ed59e1d1-3ae89747a06mr10232115a91.28.1793728284500;
        Tue, 03 Nov 2026 09:51:24 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09452c2a8sm8767a91.2.2026.11.03.09.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 09:51:22 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 17:51:22 +0000
Message-Id: <DMLRLX4USTMF.18P3O2OCL0BRM@gmail.com>
Cc: <puranjay@kernel.org>, <memxor@gmail.com>, <xukuohai@huaweicloud.com>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 17/20] bpf, arm64: Use cbz, cbnz, tbz and
 tbnz for zero, sign and bit tests
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>
In-Reply-To: <20261103122733.1383002-18-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net> <20261103122733.1383002-18-daniel@iogearbox.net>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 04:27 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> pass which writes the image. The extra pass of a program with
> subprograms, whose calls turn direct, starts from the offsets of the
> first image, which bound no later layout: a call of a helper can leave
> the reach of the direct call as the code in front of it shrinks and
> take the indirect form again, three instructions more between a test
> ahead of it and its target. So the extra pass keeps the decisions for
> the tests ahead and takes only those for the tests back again, which can
> leave the image a word or two larger than the first one, within the
> maximum image size the sizing pass counted, which the check after the
> extra pass takes as its bound.

Another idea...
can we decide every test from the offsets of pass 1 ?
Pass 1 has cmp + b.cond for every test and the indirect form for every
call. It's the longest layout, ahead and back.
No later pass makes a distance longer.

  pass             this patch              decide after pass 1
  ---------------  ----------------------  -------------------
  1, sizing        -                       sets the bitmap
  2, no write      sets the bitmap         reads the bitmap
  3, write         reads the bitmap        reads the bitmap
  extra, no write  sets it for tests back  reads the bitmap
  extra, write     reads the bitmap        reads the bitmap

The bitmap doesn't change after pass 1. A test doesn't grow the image in
the extra pass.
Then no need for the extra_pass argument, max_idx and the new bound in
the "multi-func JIT bug" check.

The cost: a test back that gets in reach only after other code shrinks
keeps cmp + b.cond. A test ahead does that already.

find_tb() is new and emit_tb() only reads the bitmap. The rest is yours.
It doesn't block the patch. It can be a follow up.

Something like this (not even compile tested):

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index f38738f..ca23f3c 100644
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
@@ -586,6 +588,10 @@ u32 aarch64_insn_gen_comp_branch_imm(unsigned long pc, unsigned long addr,
 				     enum aarch64_insn_register reg,
 				     enum aarch64_insn_variant variant,
 				     enum aarch64_insn_branch_type type);
+u32 aarch64_insn_gen_test_branch_imm(unsigned long pc, unsigned long addr,
+				     enum aarch64_insn_register reg,
+				     int bit,
+				     enum aarch64_insn_branch_type type);
 u32 aarch64_insn_gen_cond_branch_imm(unsigned long pc, unsigned long addr,
 				     enum aarch64_insn_condition cond);

diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index dc483d1..9c2fe1a 100644
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
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 70fc329..a8b43eb 100644
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
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index e99f105..3613e21 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -92,6 +92,7 @@ struct jit_ctx {
 	bool fp_used;
 	bool priv_sp_used;
 	bool write;
+	unsigned long *tb;
 };

 struct bpf_plt {
@@ -268,8 +269,12 @@ static inline int bpf2a64_offset(int bpf_insn, int off,
 	/*
 	 * Whereas arm64 branch instructions encode the offset
 	 * from the branch itself, so we must subtract 1 from the
-	 * instruction offset.
+	 * instruction offset. A branch back takes its own position,
+	 * the next one emitted, as the offsets from the next
+	 * instruction on are still those of the previous pass.
 	 */
+	if (off < 0)
+		return ctx->offset[bpf_insn + off] - ctx->idx;
 	return ctx->offset[bpf_insn + off] - (ctx->offset[bpf_insn] - 1);
 }

@@ -357,6 +362,98 @@ static bool is_lsi_offset(int offset, int scale)
 	return true;
 }

+/*
+ * A compare against zero or minus one for the sign, an unsigned 32-bit
+ * compare at the sign bit and a test of a single bit test a bit of the
+ * register: returns the bit, with *nonzero set when the branch is taken
+ * with it set, or -1.
+ */
+static int tb_bit(u8 op, bool is64, s32 imm, bool *nonzero)
+{
+	const int sign = is64 ? 63 : 31;
+	u64 mask;
+
+	switch (op) {
+	case BPF_JSLT:
+	case BPF_JSGE:
+		/* x < 0, x >= 0 */
+		if (imm)
+			return -1;
+		*nonzero = op == BPF_JSLT;
+		return sign;
+	case BPF_JSGT:
+	case BPF_JSLE:
+		/* x > -1, x <= -1 */
+		if (imm != -1)
+			return -1;
+		*nonzero = op == BPF_JSLE;
+		return sign;
+	case BPF_JGT:
+	case BPF_JLE:
+		/* x > 0x7fffffff, x <= 0x7fffffff in 32 bits */
+		if (is64 || imm != 0x7fffffff)
+			return -1;
+		*nonzero = op == BPF_JGT;
+		return 31;
+	case BPF_JGE:
+	case BPF_JLT:
+		/* x >= 0x80000000, x < 0x80000000 in 32 bits */
+		if (is64 || imm != INT_MIN)
+			return -1;
+		*nonzero = op == BPF_JGE;
+		return 31;
+	case BPF_JSET:
+		mask = is64 ? (u64)(s64)imm : (u32)imm;
+		if (!is_power_of_2(mask))
+			return -1;
+		*nonzero = true;
+		return ilog2(mask);
+	default:
+		return -1;
+	}
+}
+
+/*
+ * The test bit and branch reaches 8K instructions either way. Pass 1 takes
+ * the compare and the conditional branch for every test and the indirect form
+ * for every call. No later pass makes a distance longer, the extra pass
+ * included. A test that fits in the layout of pass 1 fits in every image.
+ */
+static void find_tb(struct jit_ctx *ctx)
+{
+	const struct bpf_prog *prog = ctx->prog;
+	bool nonzero;
+	int i, d;
+
+	for (i = 0; i < prog->len; i++) {
+		const struct bpf_insn *insn = &prog->insnsi[i];
+		const u8 class = BPF_CLASS(insn->code);
+
+		if ((class != BPF_JMP && class != BPF_JMP32) ||
+		    BPF_SRC(insn->code) != BPF_K)
+			continue;
+		if (tb_bit(BPF_OP(insn->code), class == BPF_JMP, insn->imm, &nonzero) < 0)
+			continue;
+		d = ctx->offset[i + 1 + insn->off] - (ctx->offset[i + 1] - 1);
+		if (d >= -SZ_8K && d < SZ_8K)
+			__set_bit(i, ctx->tb);
+	}
+}
+
+static bool emit_tb(bool nonzero, u8 reg, int bit, int i, s16 off, struct jit_ctx *ctx)
+{
+	int jmp_offset;
+
+	if (!test_bit(i, ctx->tb))
+		return false;
+	jmp_offset = bpf2a64_offset(i, off, ctx);
+	if (nonzero)
+		emit(A64_TBNZ(reg, bit, jmp_offset), ctx);
+	else
+		emit(A64_TBZ(reg, bit, jmp_offset), ctx);
+	return true;
+}
+
 /* generated main prog prologue:
  *      bti c // if CONFIG_ARM64_BTI_KERNEL
  *      mov x9, lr
@@ -1465,6 +1562,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	int off_adj;
 	int ret;
 	bool sign_extend;
+	bool nonzero;
+	int bit;

 	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
 		emit_bti(A64_BTI_J, ctx);
@@ -1799,6 +1898,20 @@ emit_cond_jmp:
 	case BPF_JMP32 | BPF_JSLT | BPF_K:
 	case BPF_JMP32 | BPF_JSGE | BPF_K:
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
+		/* A test of the sign within reach is a test bit and branch */
+		bit = tb_bit(BPF_OP(code), is64, imm, &nonzero);
+		if (bit >= 0 && emit_tb(nonzero, dst, bit, i, off, ctx))
+			break;
+		/* A compare against zero for equality is a compare and branch */
+		if (!imm && (BPF_OP(code) == BPF_JEQ || BPF_OP(code) == BPF_JNE)) {
+			jmp_offset = bpf2a64_offset(i, off, ctx);
+			check_imm19(jmp_offset);
+			if (BPF_OP(code) == BPF_JEQ)
+				emit(A64_CBZ(is64, dst, jmp_offset), ctx);
+			else
+				emit(A64_CBNZ(is64, dst, jmp_offset), ctx);
+			break;
+		}
 		if (is_addsub_imm(imm)) {
 			emit(A64_CMP_I(is64, dst, imm), ctx);
 		} else if (is_addsub_imm(-(u32)imm)) {
@@ -1810,6 +1923,10 @@ emit_cond_jmp:
 		goto emit_cond_jmp;
 	case BPF_JMP | BPF_JSET | BPF_K:
 	case BPF_JMP32 | BPF_JSET | BPF_K:
+		/* A test of a single bit within reach is a test bit and branch */
+		bit = tb_bit(BPF_OP(code), is64, imm, &nonzero);
+		if (bit >= 0 && emit_tb(nonzero, dst, bit, i, off, ctx))
+			break;
 		a64_insn = A64_TST_I(is64, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
 			emit(a64_insn, ctx);
@@ -2375,6 +2492,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	ctx.offset = kvzalloc_objs(int, prog->len + 1);
 	if (ctx.offset == NULL)
 		goto out_off;
+	ctx.tb = kvzalloc_objs(unsigned long, BITS_TO_LONGS(prog->len));
+	if (ctx.tb == NULL)
+		goto out_off;

 	if (bpf_prog_uses_arena_insns(prog)) {
 		ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
@@ -2402,6 +2522,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr

 	if (build_body(env, &ctx, extra_pass))
 		goto out_off;
+	find_tb(&ctx);

 	ctx.epilogue_offset = ctx.idx;
 	build_epilogue(&ctx, was_classic, false);
@@ -2522,6 +2643,7 @@ out_off:
 			prog->aux->priv_stack_ptr = NULL;
 		}
 		kvfree(ctx.offset);
+		kvfree(ctx.tb);
 out_priv_stack:
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
@@ -3580,6 +3702,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		 */
 		if (jit_data) {
 			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
+			kvfree(jit_data->ctx.tb);
 			kfree(jit_data);
 		}
 		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();
