Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5204A2E0E
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342607; cv=none; b=ZbtlFYyGa5PxZAvrbZDAVfMJTENE7rrLcWtRRT3VBr9rtAsMMaHrmdd4ud3m/bThM+f3FY58Y6+QDFX2Oskb/v8ZfHkOPiTq9dVpfFdKvAoitrpRPM3a9hlTe6Y3i0lLzH3mW9d8OtphJ2U8XuWHl6M6fhnjwLtpJIu/AWxY41k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342607; c=relaxed/simple;
	bh=93rUqiTmLOlBYcxjo2qBGJJmGaqNm3uCmlbPQD5WM2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XdtlaMOmz7hMz5TBWoap8eJ1oBUbE3DshDyM2DRlrUzxuvn1ADw8UONVgEvxw0Vc27GQAfGPMwIP5oMHGGPJb/4zTPUZaYja0a5H6fmMVxNXZxwXra5aRL/7W/a3u9uAovOYzsX5cBnp70eJFWeO02i2u6VhOj+3yzN03Ziz2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4zUxtsg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4zUxtsg"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e54f8c051so64742885a.3
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785342600; x=1785947400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hsWOESKgHTvON6XDhMS2VGdVlmFZoXzpnfRn1GcRLY0=;
        b=L4zUxtsgcLayKosrB5V0ke4LPwkWUaJ9GR2D25Ks35zyAO0TqEu+QqXG+iUYeZQXSe
         pZwNV9OcsjetlrwWKI7ywWk3bJe+yVDc3oTXiuLdKhzqnLEYU+lzio/mSCe8RW8XL935
         1PkZKZWYnur72Fpp9+E+Wu0GFnWXY3g83OKzYpC7yqwGfvVrRWb4W/j2W9WebgMq6Rie
         5RuA/jbqo8LCRdP6Dl569HuQq5XQozWdava8vM8p+j3nktjfczr7piq2E7Q+4AVWNycP
         uSCVnbD3+6qtbKFfZ2GghsPNm3nJcfJjc/toGqlFrcgRuUIjR6xheU8WKToCPqOBzy0u
         B6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785342600; x=1785947400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hsWOESKgHTvON6XDhMS2VGdVlmFZoXzpnfRn1GcRLY0=;
        b=FQeERFzlzBKqZrPP67VEyTs5yiPYQbZlMqtCmfM5Q+tNnQSvRlh41wBuOOktj328d7
         9/r2VEv5I6bP9N8l/e1OgY0urtILNA0oYTfzwMSSsb3pu0OdeEalW02wzE+p76gQFd8m
         S9GObJDMszYt6fyGp4NfEeb4/J703mazjTbVLxOLbkHlSIwcqxHavSTtGWS+6asQA24d
         AsPVqtrYZvUbnR+J7HXAMT+inmNd//UTPNRkMqiju+PBRXeiCsoZYgRlRPEFsUVQ/VKi
         aBw/4DfLwuq8JRldWfjZJcHcFP14xVBYjRiC7iaclufWohFn1ay/41oZbb1rMbbYuxi7
         /v4g==
X-Forwarded-Encrypted: i=1; AHgh+Rruhxx52xl9jv5odqIHXgPxvOlksM2NjfuBRazyw3a71oQpnzvcLyp2FodpdvC8cFv0Jmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRwFmsglAMKLu9zo5ESi3AnNiOJZbbl/Kf4ioUXwzMt09rU9bq
	RqwzZ8S34xwpsMBWi5sAhjFmllUC86WaQbmW7Cyf2hxDo5o0g6NtJ3fU
X-Gm-Gg: AR+sD137267+ABOhFyb4WJaRCgWkearB3Z4W/YIdG4ynPrZMIAjwO/iGgtTVCEfTkw9
	UWEETgt+APuHJ3nAUujl61aWzdQBXkoPUaTzVj/C5lSYaYmcsRwdhOBF6FyrxTOJwdBoc2YcUca
	jcPMMaEOZRX4mFUoMJJz9ZtdMtaiiqlNeErdJPHWVzy5Y/2q+o7fAT+GnhMy+E9gmsDNlX6pPVG
	V7fQc0uy4Erl6UD38eWSANFkqzNdezcbd5T7//4vfVY+qrg8CCTImFCl9xA5pyo3FkVzH+9TMan
	BzUdd/6NeDe4SzMoozIcPzEvFzVx4BN1RPhuC3jKPFQH21PRRzWgaAR5J8VznkpG18HzldUExig
	NGMLaVxMpsJm1XHhcD+RZAwsXH5mWDSGuOu+K32Wwo/0UnKdrLp/DMsPQ6lJgaL+UdsdCTSUybb
	YWM61pTq4nyST9oZ1iVJaOAVvfIG0iBT8obZOwz/kCX8GCtG3MfNluhHj3T2ooya6gUvS6SdoFT
	Z1CSqrmnNHcjfWUIyZ12Zy59Nv/
X-Received: by 2002:a05:620a:4491:b0:92e:5612:ba3a with SMTP id af79cd13be357-9330259272dmr693715485a.17.1785342599654;
        Wed, 29 Jul 2026 09:29:59 -0700 (PDT)
Received: from localhost.localdomain ([187.15.144.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e7318180sm201745885a.28.2026.07.29.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:29:59 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	tsbogend@alpha.franken.de,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	philmd@oss.qualcomm.com,
	visitorckw@gmail.com,
	bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] bpf, mips: Add support for BPF_SDIV and BPF_SMOD
Date: Wed, 29 Jul 2026 12:29:31 -0400
Message-Id: <20260729162931.2369353-3-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729162931.2369353-1-main.kalliope@gmail.com>
References: <20260729162931.2369353-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MIPS JITs handle BPF_DIV and BPF_MOD without inspecting
insn->off, which distinguishes BPF_SDIV and BPF_SMOD. Signed
operations therefore use unsigned instructions, or unsigned helpers
for ALU64 on 32-bit MIPS, and produce unsigned results for negative
operands.

Use insn->off to select signed DIV/DDIV for pre-R6 and
DIV/MOD/DDIV/DMOD for R6. On 32-bit MIPS, use div64_s64() and a
signed remainder helper for ALU64. Add the corresponding uasm
emitters, and keep signed immediates out of the unsigned
power-of-two shift/mask rewrite.

The eBPF JIT is not available for microMIPS, so uasm-micromips does
not need matching emitters.

check_alu_op() rejects immediate zero divisors. bpf_do_misc_fixups()
rewrites signed immediate -1 and guards register divisors that are
zero or, for signed operations, -1 before JIT compilation. The ALU32
paths continue to zero-extend their results.

Found while auditing BPF JIT handling of signed div/mod. Tested with
test_bpf on the v7.2-rc4 bpf-next tree under QEMU on MIPS32r2,
MIPS64r2, MIPS32r6, and MIPS64r6 with
CONFIG_BPF_JIT_ALWAYS_ON=y.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/mips/include/asm/uasm.h   |  6 ++++
 arch/mips/mm/uasm-mips.c       | 10 ++++++
 arch/mips/mm/uasm.c            | 20 ++++++++----
 arch/mips/net/bpf_jit_comp.c   | 35 +++++++++++++++------
 arch/mips/net/bpf_jit_comp.h   |  5 +--
 arch/mips/net/bpf_jit_comp32.c | 30 ++++++++++++------
 arch/mips/net/bpf_jit_comp64.c | 56 ++++++++++++++++++++++------------
 7 files changed, 115 insertions(+), 47 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index b43bfd445..9d3edb59e 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -85,15 +85,20 @@ Ip_u1u2(_ctc1);
 Ip_u2u1(_ctcmsa);
 Ip_u2u1s3(_daddiu);
 Ip_u3u1u2(_daddu);
+Ip_u1u2(_ddiv);
+Ip_u3u1u2(_ddiv_r6);
 Ip_u1u2(_ddivu);
 Ip_u3u1u2(_ddivu_r6);
 Ip_u1(_di);
 Ip_u2u1msbu3(_dins);
 Ip_u2u1msbu3(_dinsm);
 Ip_u2u1msbu3(_dinsu);
+Ip_u1u2(_div);
+Ip_u3u1u2(_div_r6);
 Ip_u1u2(_divu);
 Ip_u3u1u2(_divu_r6);
 Ip_u1u2u3(_dmfc0);
+Ip_u3u1u2(_dmod);
 Ip_u3u1u2(_dmodu);
 Ip_u1u2u3(_dmtc0);
 Ip_u1u2(_dmultu);
@@ -135,6 +140,7 @@ Ip_u1u2u3(_mfc0);
 Ip_u1u2u3(_mfhc0);
 Ip_u1(_mfhi);
 Ip_u1(_mflo);
+Ip_u3u1u2(_mod);
 Ip_u3u1u2(_modu);
 Ip_u3u1u2(_movn);
 Ip_u3u1u2(_movz);
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index e15c6700c..ef1a2b040 100644
--- a/arch/mips/mm/uasm-mips.c
+++ b/arch/mips/mm/uasm-mips.c
@@ -75,6 +75,9 @@ static const struct insn insn_table[insn_invalid] = {
 	[insn_ctcmsa]	= {M(msa_op, 0, msa_ctc_op, 0, 0, msa_elm_op), RD | RE},
 	[insn_daddiu]	= {M(daddiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM},
 	[insn_daddu]	= {M(spec_op, 0, 0, 0, 0, daddu_op), RS | RT | RD},
+	[insn_ddiv]	= {M(spec_op, 0, 0, 0, 0, ddiv_op), RS | RT},
+	[insn_ddiv_r6]	= {M(spec_op, 0, 0, 0, ddiv_ddiv6_op, ddiv_op),
+				RS | RT | RD},
 	[insn_ddivu]	= {M(spec_op, 0, 0, 0, 0, ddivu_op), RS | RT},
 	[insn_ddivu_r6]	= {M(spec_op, 0, 0, 0, ddivu_ddivu6_op, ddivu_op),
 				RS | RT | RD},
@@ -82,10 +85,15 @@ static const struct insn insn_table[insn_invalid] = {
 	[insn_dins]	= {M(spec3_op, 0, 0, 0, 0, dins_op), RS | RT | RD | RE},
 	[insn_dinsm]	= {M(spec3_op, 0, 0, 0, 0, dinsm_op), RS | RT | RD | RE},
 	[insn_dinsu]	= {M(spec3_op, 0, 0, 0, 0, dinsu_op), RS | RT | RD | RE},
+	[insn_div]	= {M(spec_op, 0, 0, 0, 0, div_op), RS | RT},
+	[insn_div_r6]	= {M(spec_op, 0, 0, 0, div_div6_op, div_op),
+				RS | RT | RD},
 	[insn_divu]	= {M(spec_op, 0, 0, 0, 0, divu_op), RS | RT},
 	[insn_divu_r6]	= {M(spec_op, 0, 0, 0, divu_divu6_op, divu_op),
 				RS | RT | RD},
 	[insn_dmfc0]	= {M(cop0_op, dmfc_op, 0, 0, 0, 0), RT | RD | SET},
+	[insn_dmod]	= {M(spec_op, 0, 0, 0, ddiv_dmod_op, ddiv_op),
+				RS | RT | RD},
 	[insn_dmodu]	= {M(spec_op, 0, 0, 0, ddivu_dmodu_op, ddivu_op),
 				RS | RT | RD},
 	[insn_dmtc0]	= {M(cop0_op, dmtc_op, 0, 0, 0, 0), RT | RD | SET},
@@ -140,6 +148,8 @@ static const struct insn insn_table[insn_invalid] = {
 	[insn_mfhc0]	= {M(cop0_op, mfhc0_op, 0, 0, 0, 0),  RT | RD | SET},
 	[insn_mfhi]	= {M(spec_op, 0, 0, 0, 0, mfhi_op), RD},
 	[insn_mflo]	= {M(spec_op, 0, 0, 0, 0, mflo_op), RD},
+	[insn_mod]	= {M(spec_op, 0, 0, 0, div_mod_op, div_op),
+				RS | RT | RD},
 	[insn_modu]	= {M(spec_op, 0, 0, 0, divu_modu_op, divu_op),
 				RS | RT | RD},
 	[insn_movn]	= {M(spec_op, 0, 0, 0, 0, movn_op), RS | RT | RD},
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 125140979..06d722665 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -49,18 +49,20 @@ enum opcode {
 	insn_addiu, insn_addu, insn_and, insn_andi, insn_bbit0, insn_bbit1,
 	insn_beq, insn_beql, insn_bgez, insn_bgezl, insn_bgtz, insn_blez,
 	insn_bltz, insn_bltzl, insn_bne, insn_break, insn_cache, insn_cfc1,
-	insn_cfcmsa, insn_ctc1, insn_ctcmsa, insn_daddiu, insn_daddu, insn_ddivu,
-	insn_ddivu_r6, insn_di, insn_dins, insn_dinsm, insn_dinsu, insn_divu,
-	insn_divu_r6, insn_dmfc0, insn_dmodu, insn_dmtc0, insn_dmultu,
+	insn_cfcmsa, insn_ctc1, insn_ctcmsa, insn_daddiu, insn_daddu, insn_ddiv,
+	insn_ddiv_r6, insn_ddivu, insn_ddivu_r6, insn_di, insn_dins, insn_dinsm,
+	insn_dinsu, insn_div, insn_div_r6, insn_divu, insn_divu_r6, insn_dmfc0,
+	insn_dmod, insn_dmodu, insn_dmtc0, insn_dmultu,
 	insn_dmulu, insn_drotr, insn_drotr32, insn_dsbh, insn_dshd, insn_dsll,
 	insn_dsll32, insn_dsllv, insn_dsra, insn_dsra32, insn_dsrav, insn_dsrl,
 	insn_dsrl32, insn_dsrlv, insn_dsubu, insn_eret, insn_ext, insn_ins,
 	insn_j, insn_jal, insn_jalr, insn_jr, insn_lb, insn_lbu, insn_ld,
 	insn_lddir, insn_ldpte, insn_ldx, insn_lh, insn_lhu, insn_ll, insn_lld,
 	insn_lui, insn_lw, insn_lwu, insn_lwx, insn_mfc0, insn_mfhc0, insn_mfhi,
-	insn_mflo, insn_modu, insn_movn, insn_movz, insn_mtc0, insn_mthc0,
-	insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_mulu, insn_muhu, insn_nor,
-	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sb, insn_sc,
+	insn_mflo, insn_mod, insn_modu, insn_movn, insn_movz, insn_mtc0,
+	insn_mthc0, insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_mulu,
+	insn_muhu, insn_nor, insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr,
+	insn_sb, insn_sc,
 	insn_scd, insn_seleqz, insn_selnez, insn_sd, insn_sh, insn_sll,
 	insn_sllv, insn_slt, insn_slti, insn_sltiu, insn_sltu, insn_sra,
 	insn_srav, insn_srl, insn_srlv, insn_subu, insn_sw, insn_sync,
@@ -287,9 +289,12 @@ I_u1u2(_cfc1)
 I_u2u1(_cfcmsa)
 I_u1u2(_ctc1)
 I_u2u1(_ctcmsa)
+I_u1u2(_ddiv)
+I_u3u1u2(_ddiv_r6)
 I_u1u2(_ddivu)
 I_u3u1u2(_ddivu_r6)
 I_u1u2u3(_dmfc0)
+I_u3u1u2(_dmod)
 I_u3u1u2(_dmodu)
 I_u1u2u3(_dmtc0)
 I_u1u2(_dmultu)
@@ -297,6 +302,8 @@ I_u3u1u2(_dmulu)
 I_u2u1s3(_daddiu)
 I_u3u1u2(_daddu)
 I_u1(_di);
+I_u1u2(_div)
+I_u3u1u2(_div_r6)
 I_u1u2(_divu)
 I_u3u1u2(_divu_r6)
 I_u2u1(_dsbh);
@@ -332,6 +339,7 @@ I_u2s3u1(_lw)
 I_u2s3u1(_lwu)
 I_u1u2u3(_mfc0)
 I_u1u2u3(_mfhc0)
+I_u3u1u2(_mod)
 I_u3u1u2(_modu)
 I_u3u1u2(_movn)
 I_u3u1u2(_movz)
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index f99bb5705..a67885d28 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -208,7 +208,7 @@ void emit_mov_r(struct jit_context *ctx, u8 dst, u8 src)
 }
 
 /* Validate ALU immediate range */
-bool valid_alu_i(u8 op, s32 imm)
+bool valid_alu_i(u8 op, s32 imm, bool is_signed)
 {
 	switch (BPF_OP(op)) {
 	case BPF_NEG:
@@ -237,6 +237,9 @@ bool valid_alu_i(u8 op, s32 imm)
 		return imm == 0 || (imm > 0 && is_power_of_2(imm));
 	case BPF_DIV:
 	case BPF_MOD:
+		/* Do not use unsigned shift/mask rewrites for signed div/mod. */
+		if (is_signed)
+			return false;
 		/* imm must be an 17-bit power of two */
 		return (u32)imm <= 0x10000 && is_power_of_2((u32)imm);
 	}
@@ -338,28 +341,40 @@ void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
 	clobber_reg(ctx, dst);
 }
 
-static void emit_div(struct jit_context *ctx, u8 dst, u8 src)
+static void emit_div(struct jit_context *ctx, u8 dst, u8 src, bool is_signed)
 {
 	if (cpu_has_mips32r6) {
-		emit(ctx, divu_r6, dst, dst, src);
+		if (is_signed)
+			emit(ctx, div_r6, dst, dst, src);
+		else
+			emit(ctx, divu_r6, dst, dst, src);
 	} else {
-		emit(ctx, divu, dst, src);
+		if (is_signed)
+			emit(ctx, div, dst, src);
+		else
+			emit(ctx, divu, dst, src);
 		emit(ctx, mflo, dst);
 	}
 }
 
-static void emit_mod(struct jit_context *ctx, u8 dst, u8 src)
+static void emit_mod(struct jit_context *ctx, u8 dst, u8 src, bool is_signed)
 {
 	if (cpu_has_mips32r6) {
-		emit(ctx, modu, dst, dst, src);
+		if (is_signed)
+			emit(ctx, mod, dst, dst, src);
+		else
+			emit(ctx, modu, dst, dst, src);
 	} else {
-		emit(ctx, divu, dst, src);
+		if (is_signed)
+			emit(ctx, div, dst, src);
+		else
+			emit(ctx, divu, dst, src);
 		emit(ctx, mfhi, dst);
 	}
 }
 
 /* ALU register operation (32-bit) */
-void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
+void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op, bool is_signed)
 {
 	switch (BPF_OP(op)) {
 	/* dst = dst & src */
@@ -405,11 +420,11 @@ void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 		break;
 	/* dst = dst / src */
 	case BPF_DIV:
-		emit_div(ctx, dst, src);
+		emit_div(ctx, dst, src, is_signed);
 		break;
 	/* dst = dst % src */
 	case BPF_MOD:
-		emit_mod(ctx, dst, src);
+		emit_mod(ctx, dst, src, is_signed);
 		break;
 	}
 	clobber_reg(ctx, dst);
diff --git a/arch/mips/net/bpf_jit_comp.h b/arch/mips/net/bpf_jit_comp.h
index a37fe2081..39266daa6 100644
--- a/arch/mips/net/bpf_jit_comp.h
+++ b/arch/mips/net/bpf_jit_comp.h
@@ -163,7 +163,7 @@ void emit_mov_i(struct jit_context *ctx, u8 dst, s32 imm);
 void emit_mov_r(struct jit_context *ctx, u8 dst, u8 src);
 
 /* Validate ALU/ALU64 immediate range */
-bool valid_alu_i(u8 op, s32 imm);
+bool valid_alu_i(u8 op, s32 imm, bool is_signed);
 
 /* Rewrite ALU/ALU64 immediate operation */
 bool rewrite_alu_i(u8 op, s32 imm, u8 *alu, s32 *val);
@@ -172,7 +172,8 @@ bool rewrite_alu_i(u8 op, s32 imm, u8 *alu, s32 *val);
 void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op);
 
 /* ALU register operation (32-bit) */
-void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op);
+void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op,
+		bool is_signed);
 
 /* Atomic read-modify-write (32-bit) */
 void emit_atomic_r(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 code);
diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 40a878b67..c8d45a5d5 100644
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
@@ -521,9 +521,17 @@ static u64 jit_mod64(u64 a, u64 b)
 	return rem;
 }
 
+/* Helper function for signed 64-bit modulo */
+static s64 jit_smod64(s64 a, s64 b)
+{
+	u64 quot = div64_s64(a, b);
+
+	return a - quot * b;
+}
+
 /* ALU div/mod register (64-bit) */
-static void emit_divmod_r64(struct jit_context *ctx,
-			    const u8 dst[], const u8 src[], u8 op)
+static void emit_divmod_r64(struct jit_context *ctx, const u8 dst[],
+			    const u8 src[], u8 op, bool is_signed)
 {
 	const u8 *r0 = bpf2mips32[BPF_REG_0]; /* Mapped to v0-v1 */
 	const u8 *r1 = bpf2mips32[BPF_REG_1]; /* Mapped to a0-a1 */
@@ -546,11 +554,11 @@ static void emit_divmod_r64(struct jit_context *ctx,
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
@@ -1469,6 +1477,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	u8 code = insn->code;
 	s16 off = insn->off;
 	s32 imm = insn->imm;
+	bool is_signed = off == 1;
 	s32 val, rel;
 	u8 alu, jmp;
 
@@ -1516,9 +1525,10 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU | BPF_MOD | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, is_signed)) {
 			emit_mov_i(ctx, MIPS_R_T6, imm);
-			emit_alu_r(ctx, lo(dst), MIPS_R_T6, BPF_OP(code));
+			emit_alu_r(ctx, lo(dst), MIPS_R_T6, BPF_OP(code),
+				   is_signed);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_alu_i(ctx, lo(dst), val, alu);
 		}
@@ -1546,7 +1556,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU | BPF_MOD | BPF_X:
-		emit_alu_r(ctx, lo(dst), lo(src), BPF_OP(code));
+		emit_alu_r(ctx, lo(dst), lo(src), BPF_OP(code), is_signed);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = imm (64-bit) */
@@ -1599,7 +1609,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		 * and then do the operation on this register.
 		 */
 		emit_mov_se_i64(ctx, tmp, imm);
-		emit_divmod_r64(ctx, dst, tmp, BPF_OP(code));
+		emit_divmod_r64(ctx, dst, tmp, BPF_OP(code), is_signed);
 		break;
 	/* dst = dst & src (64-bit) */
 	/* dst = dst | src (64-bit) */
@@ -1629,7 +1639,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* dst = dst % src (64-bit) */
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		emit_divmod_r64(ctx, dst, src, BPF_OP(code));
+		emit_divmod_r64(ctx, dst, src, BPF_OP(code), is_signed);
 		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index befeb63ae..ca2741f14 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -197,28 +197,43 @@ static void emit_alu_i64(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
 	clobber_reg(ctx, dst);
 }
 
-static void emit_div64(struct jit_context *ctx, u8 dst, u8 src)
+static void emit_div64(struct jit_context *ctx, u8 dst, u8 src,
+		       bool is_signed)
 {
 	if (cpu_has_mips64r6) {
-		emit(ctx, ddivu_r6, dst, dst, src);
+		if (is_signed)
+			emit(ctx, ddiv_r6, dst, dst, src);
+		else
+			emit(ctx, ddivu_r6, dst, dst, src);
 	} else {
-		emit(ctx, ddivu, dst, src);
+		if (is_signed)
+			emit(ctx, ddiv, dst, src);
+		else
+			emit(ctx, ddivu, dst, src);
 		emit(ctx, mflo, dst);
 	}
 }
 
-static void emit_mod64(struct jit_context *ctx, u8 dst, u8 src)
+static void emit_mod64(struct jit_context *ctx, u8 dst, u8 src,
+		       bool is_signed)
 {
 	if (cpu_has_mips64r6) {
-		emit(ctx, dmodu, dst, dst, src);
+		if (is_signed)
+			emit(ctx, dmod, dst, dst, src);
+		else
+			emit(ctx, dmodu, dst, dst, src);
 	} else {
-		emit(ctx, ddivu, dst, src);
+		if (is_signed)
+			emit(ctx, ddiv, dst, src);
+		else
+			emit(ctx, ddivu, dst, src);
 		emit(ctx, mfhi, dst);
 	}
 }
 
 /* ALU register operation (64-bit) */
-static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op)
+static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op,
+			 bool is_signed)
 {
 	switch (BPF_OP(op)) {
 	/* dst = dst << src */
@@ -255,15 +270,15 @@ static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 		break;
 	/* dst = dst / src */
 	case BPF_DIV:
-		emit_div64(ctx, dst, src);
+		emit_div64(ctx, dst, src, is_signed);
 		break;
 	/* dst = dst % src */
 	case BPF_MOD:
-		emit_mod64(ctx, dst, src);
+		emit_mod64(ctx, dst, src, is_signed);
 		break;
 	default:
 		/* Width-generic operations */
-		emit_alu_r(ctx, dst, src, op);
+		emit_alu_r(ctx, dst, src, op, false);
 	}
 	clobber_reg(ctx, dst);
 }
@@ -650,6 +665,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	u8 code = insn->code;
 	s16 off = insn->off;
 	s32 imm = insn->imm;
+	bool is_signed = off == 1;
 	s32 val, rel;
 	u8 alu, jmp;
 
@@ -684,9 +700,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_AND | BPF_K:
 	case BPF_ALU | BPF_XOR | BPF_K:
 	case BPF_ALU | BPF_LSH | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, false)) {
 			emit_mov_i(ctx, MIPS_R_T4, imm);
-			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
+			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code), false);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_alu_i(ctx, dst, val, alu);
 		}
@@ -706,10 +722,11 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU | BPF_MOD | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, is_signed)) {
 			emit_sext(ctx, dst, dst);
 			emit_mov_i(ctx, MIPS_R_T4, imm);
-			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
+			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code),
+				   is_signed);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_sext(ctx, dst, dst);
 			emit_alu_i(ctx, dst, val, alu);
@@ -724,7 +741,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_OR | BPF_X:
 	case BPF_ALU | BPF_XOR | BPF_X:
 	case BPF_ALU | BPF_LSH | BPF_X:
-		emit_alu_r(ctx, dst, src, BPF_OP(code));
+		emit_alu_r(ctx, dst, src, BPF_OP(code), false);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = dst >> src */
@@ -743,7 +760,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MOD | BPF_X:
 		emit_sext(ctx, dst, dst);
 		emit_sext(ctx, MIPS_R_T4, src);
-		emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
+		emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code), is_signed);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = imm (64-bit) */
@@ -780,9 +797,10 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, is_signed)) {
 			emit_mov_i(ctx, MIPS_R_T4, imm);
-			emit_alu_r64(ctx, dst, MIPS_R_T4, BPF_OP(code));
+			emit_alu_r64(ctx, dst, MIPS_R_T4, BPF_OP(code),
+				     is_signed);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_alu_i64(ctx, dst, val, alu);
 		}
@@ -809,7 +827,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		emit_alu_r64(ctx, dst, src, BPF_OP(code));
+		emit_alu_r64(ctx, dst, src, BPF_OP(code), is_signed);
 		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
-- 
2.34.1
