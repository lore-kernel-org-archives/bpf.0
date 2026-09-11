Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C030C468C1A
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162445; cv=none; b=T/s+NqsPKO8M36VeNx3jt71+FPfSQEVTh1oEWeZMpzWw0aeoZCGnlSqaHplUexAoBuNQnTdAcn4xC/hN4oyrMjfjekDcnzBqUSzSX+b/syvLGNoyVAxgFwcHFrEcvUO1fQgXK9beUJ/hhm+RFU1KgGCKGgCG6RQbjKcYIA0GvA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162445; c=relaxed/simple;
	bh=uA0ykF/9XLZdNv217gEJhJFeitz39AccivE1H/bor60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vidre30UQoPE9pnPWBVSb/VwhsWSlSQ06PczP4UORfF9CtLIXFd8zlsgnFL5YTzxsCuo844sCZrwRBtGr9j/kab6H4Bd+4VhnBG8b04wu23TaEcFakfNFjy3iSQA2OAD4LiMiOZmZGktr8QEqRwLhg6hdCIlPOQn5VzaHDwkp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7LS1QUz; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7LS1QUz"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9120eda2195so14992706d6.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789162441; x=1789767241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUgjt9sq7z3DvWbwF3U4aS6WwCN2ZGW8QdNmOZJwJVc=;
        b=q7LS1QUzxuQU9DAahKwpa3D6pNaef94voTKx+Y+Q0f0cnQA9j54ZQ0c5r4qOw4mAra
         a6kPtm3AcDaWHoQNHgLOhx4uf5WvKAoQMXp2nlRs5pYZQ42Iovb8SRiZPaczb+cnPIIG
         /VZEXDv5Mnq1ymgpshCLZZjDjjEaatakT1KLz7VJCUn3OvyrUZGi+KO8CYGRJUjaA0I1
         3K0WddIr2ANG30yvx2PgqAfXNRKXrIDLQO2hubrhk/okxL96q4xMmQnWqD4XmJ68ORwT
         zdHdiwim6vmfhBcbxiPN8dql3WRjnaN1PaElihk3ZEMiUPphhoOnYtVBW/iqAox2aK0H
         dDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789162441; x=1789767241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eUgjt9sq7z3DvWbwF3U4aS6WwCN2ZGW8QdNmOZJwJVc=;
        b=Ys8lwp+G84rtT8kMEv7kSz6SU1UmybB/EjtZpMAi/dnZ9zqQlyq+knXQUc/w9U1lio
         SArblv3bqFNoSpI8vNvW0szzgeJbdSOcYc5jLee5jwo4A3ar4RuYjR3BQnWg87boQcWD
         i842QUVSL1D4PKCZ5tOa3GZlmtM1XQ+eqcSnLp0n2zUMVgnwuoMuUag0iNgVRyPMwkfW
         tZy59HxokeqFk7DdGvDsMcHDYFIjKCl3Xsp/X+Wxj/0FVcjQKxsVSKo/rHBcgqtGyxMW
         ZDhCDwtcPwZ4Wm4NaX6sQxyPe/EGI/Yhb/Cxu9kTIi681VzhMdgqwgAQn2HQ6hPRt3Jn
         HUDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQ+ujVEDuP0RahvZqLCTUJmPI0cP7akz93NPKUEj4L90fdIQ66kJdADBc9NIfpnYZ0k0c=@vger.kernel.org
X-Gm-Message-State: AFuF++nePGb2EUepmw2WLN14zISoPyCHAyjPjv1NAwcBNyBrQ5Ps2gkF
	uzvGHGoqJBQS07LIzAG3TDXTs7udYBa4AqsnJkcYdTvLi50BYDmd1GPu
X-Gm-Gg: AYBFou07uxJ1eCcY6IYlyAK4AsB/29ifnL/rJI0z79v3J9dVL9+qggaW14GN2fNhJWs
	hgbzax+8NW201sz9bDD5FBDIUQFHoqY9WzoMQnu1Q7O9y1pfEGXD3qvvohT1bWqwcvZGXuYyGE9
	dUbEocQ5W11PN8hxZwZAkkeiLzRDIsF9cpEiZoaiON5Fe84SGKBF5BQw0iVanVA41zg1thQNYE1
	+iPcXDs7cw7dBfdmSw/SKnpKEy5QitJML91UorZ42p9kGiGTNumLxa+AEuROoQ98Zm1icLrpCrA
	oX0dx1rw+o6P0wDwa/dDX3ZIq+3vfjkrcHCfysBtWNjjR73vrS4C4MjALQ3AY3mVMSI01X+Z84V
	hgSF3mIlOJvTKVz6x4fcQNZG0TE1JDxONS2wCghfNzGPvqyawx4vyRy8vXQjdATuMgV4x9lHWhK
	8uV9DdMzu3BXZ/pua4GhdEG7bt3PgOellhNCBDXGeTVrqeCqQgQaxWViOohkL401Q0HA==
X-Received: by 2002:a05:6214:460b:b0:910:3b67:b793 with SMTP id 6a1803df08f44-91202981ce7mr138281966d6.24.1789162441098;
        Fri, 11 Sep 2026 14:34:01 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f496598sm30170196d6.35.2026.09.11.14.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:34:00 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: tsbogend@alpha.franken.de,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	philmd@oss.qualcomm.com
Subject: [PATCH bpf-next v4 3/3] bpf, mips: Add support for BPF_SDIV and BPF_SMOD
Date: Fri, 11 Sep 2026 17:33:40 -0400
Message-ID: <20260911213340.3767930-4-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911213340.3767930-1-main.kalliope@gmail.com>
References: <20260911213340.3767930-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MIPS JITs handle BPF_DIV and BPF_MOD without inspecting insn->off,
which distinguishes BPF_SDIV and BPF_SMOD. Signed operations therefore
use unsigned instructions, or unsigned helpers for ALU64 on 32-bit
MIPS, and produce unsigned results for negative operands.

Pass insn->off unchanged through immediate validation and register
emission, and interpret it only in div/mod-specific paths. Use signed
DIV/DDIV for pre-R6 and DIV/MOD/DDIV/DMOD for R6. On 32-bit MIPS, use
div64_s64() and a signed remainder helper for ALU64. Keep the signed
quotient signed while computing that remainder, and keep signed
immediates out of the unsigned power-of-two shift/mask rewrite.

check_alu_op() rejects immediate zero divisors. bpf_do_misc_fixups()
rewrites signed immediate -1 and guards register divisors that are zero
or, for signed operations, -1 before JIT compilation. The ALU32 paths
continue to zero-extend their results.

Found while auditing BPF JIT handling of signed div/mod.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Link: https://lore.kernel.org/bpf/CAM1=_QS79dDBfaaNQXnWd61AqHd1M4o9aDMMiftnoJveNr=FZg@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CAM1=_QQ7XiJEozaetLt_+kVn91YAXWpJK_pyfT9=paXseW=wwA@mail.gmail.com/
---
 arch/mips/net/bpf_jit_comp.c   | 35 ++++++++++++++++-------
 arch/mips/net/bpf_jit_comp.h   |  4 +--
 arch/mips/net/bpf_jit_comp32.c | 29 ++++++++++++-------
 arch/mips/net/bpf_jit_comp64.c | 51 +++++++++++++++++++++-------------
 4 files changed, 78 insertions(+), 41 deletions(-)

diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index 320180330fb..f14de6d7312 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -208,7 +208,7 @@ void emit_mov_r(struct jit_context *ctx, u8 dst, u8 src)
 }
 
 /* Validate ALU immediate range */
-bool valid_alu_i(u8 op, s32 imm)
+bool valid_alu_i(u8 op, s32 imm, s16 off)
 {
 	switch (BPF_OP(op)) {
 	case BPF_NEG:
@@ -237,6 +237,9 @@ bool valid_alu_i(u8 op, s32 imm)
 		return imm == 0 || (imm > 0 && is_power_of_2(imm));
 	case BPF_DIV:
 	case BPF_MOD:
+		/* Do not use unsigned shift/mask rewrites for signed div/mod. */
+		if (off == 1)
+			return false;
 		/* imm must be an 17-bit power of two */
 		return (u32)imm <= 0x10000 && is_power_of_2((u32)imm);
 	}
@@ -339,29 +342,41 @@ void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
 }
 
 /* ALU division operation (32-bit) */
-static void emit_div(struct jit_context *ctx, u8 dst, u8 src)
+static void emit_div(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
 	if (cpu_has_mips32r6) {
-		emit(ctx, divu_r6, dst, dst, src);
+		if (off == 1)
+			emit(ctx, div_r6, dst, dst, src);
+		else
+			emit(ctx, divu_r6, dst, dst, src);
 	} else {
-		emit(ctx, divu, dst, src);
+		if (off == 1)
+			emit(ctx, div, dst, src);
+		else
+			emit(ctx, divu, dst, src);
 		emit(ctx, mflo, dst);
 	}
 }
 
 /* ALU modulo operation (32-bit) */
-static void emit_mod(struct jit_context *ctx, u8 dst, u8 src)
+static void emit_mod(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
 	if (cpu_has_mips32r6) {
-		emit(ctx, modu, dst, dst, src);
+		if (off == 1)
+			emit(ctx, mod, dst, dst, src);
+		else
+			emit(ctx, modu, dst, dst, src);
 	} else {
-		emit(ctx, divu, dst, src);
+		if (off == 1)
+			emit(ctx, div, dst, src);
+		else
+			emit(ctx, divu, dst, src);
 		emit(ctx, mfhi, dst);
 	}
 }
 
 /* ALU register operation (32-bit) */
-void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
+void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op, s16 off)
 {
 	switch (BPF_OP(op)) {
 	/* dst = dst & src */
@@ -407,11 +422,11 @@ void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 		break;
 	/* dst = dst / src */
 	case BPF_DIV:
-		emit_div(ctx, dst, src);
+		emit_div(ctx, dst, src, off);
 		break;
 	/* dst = dst % src */
 	case BPF_MOD:
-		emit_mod(ctx, dst, src);
+		emit_mod(ctx, dst, src, off);
 		break;
 	}
 	clobber_reg(ctx, dst);
diff --git a/arch/mips/net/bpf_jit_comp.h b/arch/mips/net/bpf_jit_comp.h
index a37fe20818e..0ddedb733dd 100644
--- a/arch/mips/net/bpf_jit_comp.h
+++ b/arch/mips/net/bpf_jit_comp.h
@@ -163,7 +163,7 @@ void emit_mov_i(struct jit_context *ctx, u8 dst, s32 imm);
 void emit_mov_r(struct jit_context *ctx, u8 dst, u8 src);
 
 /* Validate ALU/ALU64 immediate range */
-bool valid_alu_i(u8 op, s32 imm);
+bool valid_alu_i(u8 op, s32 imm, s16 off);
 
 /* Rewrite ALU/ALU64 immediate operation */
 bool rewrite_alu_i(u8 op, s32 imm, u8 *alu, s32 *val);
@@ -172,7 +172,7 @@ bool rewrite_alu_i(u8 op, s32 imm, u8 *alu, s32 *val);
 void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op);
 
 /* ALU register operation (32-bit) */
-void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op);
+void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op, s16 off);
 
 /* Atomic read-modify-write (32-bit) */
 void emit_atomic_r(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 code);
diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 40a878b672f..6619182b5ef 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -512,7 +512,7 @@ static void emit_mul_r64(struct jit_context *ctx,
 	clobber_reg64(ctx, dst);
 }
 
-/* Helper function for 64-bit modulo */
+/* Helper function for unsigned 64-bit modulo */
 static u64 jit_mod64(u64 a, u64 b)
 {
 	u64 rem;
@@ -521,13 +521,22 @@ static u64 jit_mod64(u64 a, u64 b)
 	return rem;
 }
 
+/* Helper function for signed 64-bit modulo */
+static s64 jit_smod64(s64 a, s64 b)
+{
+	s64 quot = div64_s64(a, b);
+
+	return a - quot * b;
+}
+
 /* ALU div/mod register (64-bit) */
-static void emit_divmod_r64(struct jit_context *ctx,
-			    const u8 dst[], const u8 src[], u8 op)
+static void emit_divmod_r64(struct jit_context *ctx, const u8 dst[],
+			    const u8 src[], u8 op, s16 off)
 {
 	const u8 *r0 = bpf2mips32[BPF_REG_0]; /* Mapped to v0-v1 */
 	const u8 *r1 = bpf2mips32[BPF_REG_1]; /* Mapped to a0-a1 */
 	const u8 *r2 = bpf2mips32[BPF_REG_2]; /* Mapped to a2-a3 */
+	bool is_signed = off == 1;
 	int exclude, k;
 	u32 addr = 0;
 
@@ -546,11 +555,11 @@ static void emit_divmod_r64(struct jit_context *ctx,
 	switch (BPF_OP(op)) {
 	/* dst = dst / src */
 	case BPF_DIV:
-		addr = (u32)&div64_u64;
+		addr = is_signed ? (u32)&div64_s64 : (u32)&div64_u64;
 		break;
 	/* dst = dst % src */
 	case BPF_MOD:
-		addr = (u32)&jit_mod64;
+		addr = is_signed ? (u32)&jit_smod64 : (u32)&jit_mod64;
 		break;
 	}
 	emit_mov_i(ctx, MIPS_R_T9, addr);
@@ -1516,9 +1525,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU | BPF_MOD | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, off)) {
 			emit_mov_i(ctx, MIPS_R_T6, imm);
-			emit_alu_r(ctx, lo(dst), MIPS_R_T6, BPF_OP(code));
+			emit_alu_r(ctx, lo(dst), MIPS_R_T6, BPF_OP(code), off);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_alu_i(ctx, lo(dst), val, alu);
 		}
@@ -1546,7 +1555,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU | BPF_MOD | BPF_X:
-		emit_alu_r(ctx, lo(dst), lo(src), BPF_OP(code));
+		emit_alu_r(ctx, lo(dst), lo(src), BPF_OP(code), off);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = imm (64-bit) */
@@ -1599,7 +1608,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		 * and then do the operation on this register.
 		 */
 		emit_mov_se_i64(ctx, tmp, imm);
-		emit_divmod_r64(ctx, dst, tmp, BPF_OP(code));
+		emit_divmod_r64(ctx, dst, tmp, BPF_OP(code), off);
 		break;
 	/* dst = dst & src (64-bit) */
 	/* dst = dst | src (64-bit) */
@@ -1629,7 +1638,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* dst = dst % src (64-bit) */
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		emit_divmod_r64(ctx, dst, src, BPF_OP(code));
+		emit_divmod_r64(ctx, dst, src, BPF_OP(code), off);
 		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 2520e1db7ab..db027c2d922 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -198,29 +198,42 @@ static void emit_alu_i64(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
 }
 
 /* ALU division operation (64-bit) */
-static void emit_div64(struct jit_context *ctx, u8 dst, u8 src)
+static void emit_div64(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
 	if (cpu_has_mips64r6) {
-		emit(ctx, ddivu_r6, dst, dst, src);
+		if (off == 1)
+			emit(ctx, ddiv_r6, dst, dst, src);
+		else
+			emit(ctx, ddivu_r6, dst, dst, src);
 	} else {
-		emit(ctx, ddivu, dst, src);
+		if (off == 1)
+			emit(ctx, ddiv, dst, src);
+		else
+			emit(ctx, ddivu, dst, src);
 		emit(ctx, mflo, dst);
 	}
 }
 
 /* ALU modulo operation (64-bit) */
-static void emit_mod64(struct jit_context *ctx, u8 dst, u8 src)
+static void emit_mod64(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
 	if (cpu_has_mips64r6) {
-		emit(ctx, dmodu, dst, dst, src);
+		if (off == 1)
+			emit(ctx, dmod, dst, dst, src);
+		else
+			emit(ctx, dmodu, dst, dst, src);
 	} else {
-		emit(ctx, ddivu, dst, src);
+		if (off == 1)
+			emit(ctx, ddiv, dst, src);
+		else
+			emit(ctx, ddivu, dst, src);
 		emit(ctx, mfhi, dst);
 	}
 }
 
 /* ALU register operation (64-bit) */
-static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op)
+static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op,
+			 s16 off)
 {
 	switch (BPF_OP(op)) {
 	/* dst = dst << src */
@@ -257,15 +270,15 @@ static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 		break;
 	/* dst = dst / src */
 	case BPF_DIV:
-		emit_div64(ctx, dst, src);
+		emit_div64(ctx, dst, src, off);
 		break;
 	/* dst = dst % src */
 	case BPF_MOD:
-		emit_mod64(ctx, dst, src);
+		emit_mod64(ctx, dst, src, off);
 		break;
 	default:
 		/* Width-generic operations */
-		emit_alu_r(ctx, dst, src, op);
+		emit_alu_r(ctx, dst, src, op, off);
 	}
 	clobber_reg(ctx, dst);
 }
@@ -686,9 +699,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_AND | BPF_K:
 	case BPF_ALU | BPF_XOR | BPF_K:
 	case BPF_ALU | BPF_LSH | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, off)) {
 			emit_mov_i(ctx, MIPS_R_T4, imm);
-			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
+			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code), off);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_alu_i(ctx, dst, val, alu);
 		}
@@ -708,10 +721,10 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU | BPF_MOD | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, off)) {
 			emit_sext(ctx, dst, dst);
 			emit_mov_i(ctx, MIPS_R_T4, imm);
-			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
+			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code), off);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_sext(ctx, dst, dst);
 			emit_alu_i(ctx, dst, val, alu);
@@ -726,7 +739,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_OR | BPF_X:
 	case BPF_ALU | BPF_XOR | BPF_X:
 	case BPF_ALU | BPF_LSH | BPF_X:
-		emit_alu_r(ctx, dst, src, BPF_OP(code));
+		emit_alu_r(ctx, dst, src, BPF_OP(code), off);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = dst >> src */
@@ -745,7 +758,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MOD | BPF_X:
 		emit_sext(ctx, dst, dst);
 		emit_sext(ctx, MIPS_R_T4, src);
-		emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
+		emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code), off);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = imm (64-bit) */
@@ -782,9 +795,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, off)) {
 			emit_mov_i(ctx, MIPS_R_T4, imm);
-			emit_alu_r64(ctx, dst, MIPS_R_T4, BPF_OP(code));
+			emit_alu_r64(ctx, dst, MIPS_R_T4, BPF_OP(code), off);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_alu_i64(ctx, dst, val, alu);
 		}
@@ -811,7 +824,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		emit_alu_r64(ctx, dst, src, BPF_OP(code));
+		emit_alu_r64(ctx, dst, src, BPF_OP(code), off);
 		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
