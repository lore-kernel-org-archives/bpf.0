Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212785;
	b=h2zQLhNRPFoQxT+a7HC1CFlaApHNl+KvVESTtJY/hsWSkYrS3c/tJGfDq1hEM/D5ukQV
	 cSIkt8ZcM4AqU20wee+byZXkL68KCHEoeZSruamOJPjJlWd1FFaFnD57bx2oBxhk1dr3T
	 Bg6hUKGvyNU/oyIkv4XAS4MPf7Gl03ywr1rL9SwCLXmyKViWwDaE6huqy8q8K/uU9/dut
	 7X08NvVQjBzQUjPcrngLBGmWKYKnVn87t6P2iRDu8XvNPrnkSm7M5GviLqTnT28O88/8M
	 6a/0hbU3Zq+sO5sML3jmwpqqcOxvD1xw4Ysi+JciHfj+0DldzxA64Ol2Eafpgws+KPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=LkLxQQFzVDlWTP6vW8CjPH5HbnqTjj/vP7TP7HAYsw0=;
	b=U6s+YleprYfVK2OtHojXQ+OPkxA42GH+1PLPEJLgy3S8+Ys3/T6Y2Ru9onLk7lHzYZdj
	 WsvehC561nSGNGl9ibUzG+tSvZCZPDMfL2NKeuAoWyhKSOSzmZ2C8eJb5icTo7Da8EpEf
	 b//T/VtCWNvqzJDFOEg3YkQQvW8FypovTStdFeHbfIat/8uPHftGsubf4TP+80t7IYUXU
	 KjZlXLe/SBZx8kNlU3k577o8PCtmN1iGU/+jhS5c4Cxc+/WkRkcocNswPfGcgX44y1642
	 85G6HeZ6UqtJdRkeoe/ZwXYPfoEqUY7gmRmv6V1Pb+WBxr/ri5DMX3IVr8u2HO4QoWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENlpHYs5;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287D606A322
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 18:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4287D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENlpHYs5
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8246b13cbso11155015ad.2
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793212784; x=1793817584; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LkLxQQFzVDlWTP6vW8CjPH5HbnqTjj/vP7TP7HAYsw0=;
        b=ENlpHYs5jATjl9VnDo+SB+LRo8CN2e1HMO4nWO/2m6nKteGJVi3opz9Rs9oukSAoIR
         Bx6AybjByLmmJQNRhUPh5/NyeupxCzQleiXAay/chrf0e6urz8zDvvK45uCkfh5oW5th
         tL7R/fCGJT/upXSN1bCU6BlNC+6j52hDjNynmv5OAEk55ytVtY4uE1vG6bUz4KxZMKeg
         FccwQhQlvvf9blj4ctwVOe8K8org2DZ5nDSh324jhISwxUWrkBAkiZeK9QgT++5ysRfG
         PvmYSAtRDfyjDVPRZ8M24CAar7xrejyroA2VViFVJJWm1KqUlk59fssbiTV+h/3wgm01
         Pkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793212784; x=1793817584;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkLxQQFzVDlWTP6vW8CjPH5HbnqTjj/vP7TP7HAYsw0=;
        b=CsuBGMMjLIuRNUXDofcjLAtNdHDNAL1zD2iua3nxOaUg4N4/RcPS1AUqZ1LdTcCqYf
         yzRvMvzQun82uIDDL0GqfixL00b9tNjkK+tucW18P9lvpphvFaYsaPTgBpdOMDQ9YYMl
         oWdjw/QYTxJPcdLdupIo1nk6aIkV+jSoDxnYQALzUQ1WMJI+y1Wffo9xf62r4rKQnkgo
         /f87BF8pHEE9EYmGnLwNQQ1eqMehQEErxg2FUEJiqoO+atJN6sIkiIQCqVBs3vQvVb9E
         4k8UKaP5doPxgDCrB028p7Nh3o0L/Q6aU50vGUeiqphRSQ8kwzVJWICxaL5vPu7OOqsB
         iWbw==
X-Forwarded-Encrypted: i=1; AKwUvBxTQjwwEtSN5vZ56UQg2WdYaKA748UHbhDGi4FnHLB4QuwQ4ZVacbTXkifOXNrIfvAoYMw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4XYu3I/gvror3/ci7rjTpQ67HkUdvRqIJlwemC1fwwRTTAvKS
	2Yo52Xxlw0lhwea8omB8I0n4QA7ytc9+uRAaqg/jQW5gmPnXI4267sGA
X-Gm-Gg: AYBFou0N9AS8qzFchZJxdY8ESf47Vs4wiKY5hDhK4xQt581D66TFvFsYOu9P/NdJ8TD
	VwdZ2/U3uwpKuG1pUoEXUcsNJnyYM7brDvqxBKku1rbpQYzSzxCjJCFAnfvP/mJ8DhuinX+gc6b
	JJLYd7uAWIs/U9GaYjrnB979GeoCvyrwi2uk+nb5Wj6xnOVz0a+V9blLDlvNXZGrEGZK/dX8+Jw
	26rsaEFwLt0eOPsNrr6hE5p5vQxRAmLIdKH+kty7ENDsm5bHEU8faBb7IOX7zsYLMIycp+BK6lT
	Dq2L6hBFf9elMY5mG7V9QEpbvgCUl2B9qzqhCPE9jRFguNgR/b0autNNSdNtjCai64bYAdhraQP
	ynCXgEljc/L1tzHX6UYOLon+lyjNbf4eMSuU9c1wwGXbtMGjwFOpCakm0PbyrnfovCITANo8NZi
	5Wn2wL3hurDn47bixgMVd6oGP+Xb2M3/jEH66yDjwjiaAFJL+WvQTu+mBtbiyHNG9J/iKwWEUYX
	VpyHFoPoXujDU+YZPgaCZSzP0KwM+DgX2bl7EkDmvwFlcf4AZ5gEAO6fccFyONtCKQ4g5zh+0hU
	BJforfbwCJ5nDkTazhpuEfw2C0uAFZxv32+YqP1rxAIbWRvEGNqDrDe3DC1KYdg01dfC/nKtzn1
	8njcawvwI9oX1ztxMZlaOJ5D2ReSejHVn1Vs=
X-Received: by 2002:a17:90b:17cd:b0:3ab:b39f:41b9 with SMTP id 98e67ed59e1d1-3ae5835d86dmr2390991a91.61.1793212784426;
        Wed, 28 Oct 2026 11:39:44 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fba61sm616498a91.6.2026.10.28.11.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 11:39:43 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 18:39:43 +0000
Message-Id: <DMGOVO9NB7GQ.1UO7QW4VMBQW3@gmail.com>
Cc: <memxor@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 17/21] bpf, arm64: Use cbz, cbnz, tbz and tbnz
 for zero, sign and bit tests
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, <puranjay@kernel.org>
In-Reply-To: <20261027182445.1156335-18-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net> <20261027182445.1156335-18-daniel@iogearbox.net>
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

On Tue, Oct 27, 2026 at 11:24 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> TBZ and TBNZ only reach 8K instructions where B.cond reaches 256K, so a
> test takes them when its target is within reach. The sizing pass is
> repeated with the offsets of the previous one until the code settles,
> and where it has not after a few passes, all tests of the program keep
> the compare and the branch. A branch back takes its distance from its
> own position, as the offsets after it are still those of the previous
> pass, which would overestimate the distance by what the code in front of
> the branch shrank. The decisions are kept in a bitmap for the passes
> over the image, which must not grow. A program without such a test takes
> a single sizing pass as before.

This is quite heavy.
Pass 1 doesn't know the offsets ahead. So a prog with one forward
'if r0 s< 0 goto' runs build_body() at least one more time.

Pass 1 is the maximum size already. Pass 2 turns calls into direct calls
and the image shrinks.
can we decide in pass 2 ?
The offsets ahead are from pass 1 and the code only shrinks after it.
A test that fits there fits in the image.

  pass          this patch              decide in pass 2
  ------------  ----------------------  ---------------------
  1, sizing     1 to 10 build_body()    1, with cmp + b.cond
  2, no write   reads the bitmap        sets the bitmap
  3, write      reads the bitmap        reads the bitmap

The allocation has 4 unused bytes per tbz, like 12 bytes per direct call
today. A test that gets in reach only after other code shrinks keeps
cmp + b.cond.
Then no need for the loop, TB_PASSES, no_tb and tb_long.

The encoder and tb_bit() are yours. emit_tb() is different and
bpf_int_jit_compile() only allocates the bitmap.

Something like this (not even compile tested):

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 1ce75a4..36b199c 100644
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
@@ -582,6 +584,10 @@ u32 aarch64_insn_gen_comp_branch_imm(unsigned long pc, unsigned long addr,
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
index e70ac02..2dbc1f3 100644
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
index b2fe6e6..8dbe140 100644
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
index aaa34c7..9611170 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -92,6 +92,7 @@ struct jit_ctx {
 	bool fp_used;
 	bool priv_sp_used;
 	bool write;
+	unsigned long *tb;
 };

 struct bpf_plt {
@@ -257,8 +258,11 @@ static inline int bpf2a64_offset(int bpf_insn, int off,
 	/*
 	 * Whereas arm64 branch instructions encode the offset
 	 * from the branch itself, so we must subtract 1 from the
-	 * instruction offset.
+	 * instruction offset. A branch back is the next instruction
+	 * emitted. The offsets behind it are from the previous pass.
 	 */
+	if (off < 0)
+		return ctx->offset[bpf_insn + off] - ctx->idx;
 	return ctx->offset[bpf_insn + off] - (ctx->offset[bpf_insn] - 1);
 }

@@ -346,6 +350,80 @@ static bool is_lsi_offset(int offset, int scale)
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
+ * The test bit and branch reaches 8K instructions either way. Pass 1 sizes
+ * the image for the compare and the conditional branch. Pass 2 decides: the
+ * offsets ahead are from the previous pass and the code only shrinks, so
+ * a test that fits there fits in the image. Pass 3 keeps the decision.
+ */
+static bool emit_tb(bool nonzero, u8 reg, int bit, int i, s16 off, struct jit_ctx *ctx)
+{
+	int jmp_offset = bpf2a64_offset(i, off, ctx);
+
+	if (!ctx->image)
+		return false;
+	if (!ctx->write)
+		__assign_bit(i, ctx->tb, jmp_offset >= -SZ_8K && jmp_offset < SZ_8K);
+	if (!test_bit(i, ctx->tb))
+		return false;
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
@@ -1454,6 +1532,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	int off_adj;
 	int ret;
 	bool sign_extend;
+	bool nonzero;
+	int bit;

 	if (bpf_insn_is_indirect_target(env, ctx->prog, i))
 		emit_bti(A64_BTI_J, ctx);
@@ -1788,6 +1868,20 @@ emit_cond_jmp:
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
@@ -1799,6 +1893,10 @@ emit_cond_jmp:
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
@@ -2364,6 +2462,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	ctx.offset = kvzalloc_objs(int, prog->len + 1);
 	if (ctx.offset == NULL)
 		goto out_off;
+	ctx.tb = kvzalloc_objs(unsigned long, BITS_TO_LONGS(prog->len));
+	if (ctx.tb == NULL)
+		goto out_off;

 	if (bpf_prog_uses_arena_insns(prog)) {
 		ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
@@ -2511,6 +2612,7 @@ out_off:
 			prog->aux->priv_stack_ptr = NULL;
 		}
 		kvfree(ctx.offset);
+		kvfree(ctx.tb);
 out_priv_stack:
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
@@ -3569,6 +3671,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		 */
 		if (jit_data) {
 			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
+			kvfree(jit_data->ctx.tb);
 			kfree(jit_data);
 		}
 		prog->bpf_func = (void *)prog->bpf_func - cfi_get_offset();

pw-bot: cr
