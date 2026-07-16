Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323463C0626
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236279; cv=none; b=qTaax49Ghtrhz8uFgAFJhBsZOO6CdxiQYDjuXmm6tSseJ59DGH/WJu9JoEMru8Yi4CSg9yz8HxNLk2+EKZbc4pkmSV8BdKWNNYBlT+tbtVoEf2EYRt9do+FnzPo7QXTsGWm+28g4MJC8txO5N5rYmaDyQ18aykOhzBa5pk7E+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236279; c=relaxed/simple;
	bh=WPtT4jGHsjn7+X/+H2ehmKcd0yAjpsagxfNE90Gsar8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KUhkXG3MzoteB61W4PbK/NZQdL0HuexKy5t4/zms4gewNwA8jd9ESDAwrvTrbswKCyQFmQWI7ywiES1LW1VSBwaiZH1Z8rKRDiTe9/SHdW1nCkmQ4KF/ERNTXbuMbyYM6hQbdTBrlPBWUpxkbb0v5+jz/lrHSvFzQRzpbfqB3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/BR0bqa; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/BR0bqa"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so9399506d6.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784236276; x=1784841076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XXFmKHedDN1gUMf6fBkzgDeZOoz1x5qvsJD2OF4FvcA=;
        b=J/BR0bqaM648Q5b/tvtDSkOxe+tXtSx7JWY1Myx12Mwr91LxRVo1zfiXlb/hXqAe2u
         8RWym1r/VE/xcMg4rhvRUSWufGgwWzPeCyxwzP9yMvUTPqxCX7Tf/8Tt/O/o11I+D9pZ
         1af09Hb1Cqjt6l+5g4kzU2IslNaddbASUO32XdztI5RrpI78yBA4YPPW7BuRCPoFbSJx
         J088lJj1z/AEbY1db6KxhIC4d5ONgjNAVqfLNcrKmHjNZvYPSPVR1ehjVWrAVnIV33AS
         9UU29mtZJkuMIWL7Cw3zrIOm7HgR4MAtQdOL8leGm9n+LeYu1fP23RP4szzhYb8cqUp1
         o7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784236276; x=1784841076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XXFmKHedDN1gUMf6fBkzgDeZOoz1x5qvsJD2OF4FvcA=;
        b=PrT0mufyK7kLr63tctqj1DbthG5K3Y6shvH1D+jCvtI2Hb/5TJEGFAZW3a7Hz2vfCW
         YAvSyxmpLeYGxMuoTq0eJ2zbIuQ4h18mcoahr0Hfa2tDDBUqXePgGMuxlb1pgp67yIu5
         S9vXrhGFG2uFc8fIUMlP/QJ931aRMawhs8Kh11V0O7Re9modCE47tDjtYURr4mky/rCB
         idzFRTdOcWwUmDfNB055PYXnZe1cZM5JD2gXzgorKnU2LPHCtTDr2e98Fy6GKZklEGH3
         qeFwSs4uYc9qTHJe1hgZyS9decsWxknFY/jRzOfszCtYB0oL/WUUHI7hAAy6qSQ1MfXo
         ft2w==
X-Gm-Message-State: AOJu0YyI0FcgBAtRnc6OIwHlTyQJF0KSlvSPuTF4amUjTJjKmFHoZ/dT
	aE67HjmGIXSXpSofIvqCq77GIhmwCJB8zpYW6kyE/tjMODMLJP1Z35vu
X-Gm-Gg: AfdE7ck6paUvUlXoioVV168CNPX7otacXKcUGhvuW1++JLbZ4xDkpGDrAZ0Vr4tsvhG
	ScdznQByDiXUgA/dG3E4DxwDiLsA3eiP4xtvkoMd+ZCcU7gx+4R0gD1hkMUgghERJ7oVU3u6eDg
	4jJnYB3kY0fu9M1/UljdwDqxXCpaLCymJvRByahXSJHqOjiAIl+jwHDL2tFCI1ELFRVkvDKx+O+
	cwvW8dmd93UezhXtYIacYlwXoUIocSqCnMX1y7f++rDMt0JlZLKfKi+ni61w816NjYLbnqR7sTo
	0TzSHTmFcr9LeQIIONe/MxhgPNUwQV3lDn44DcLz+tJAcWPy1jkRLlcx7CdVDGOmTHaSEFx9xlR
	3y/YaqvH34sB+xfMfMrEgj2MAGMt9Z/RDbAoQp4oK6AxftvnaGwB8pSmX3zbdwc4dM9Hx7tVo1F
	pmo3M0nPCeyTUKJjpsPss=
X-Received: by 2002:ad4:5cca:0:b0:8e8:8647:5fe4 with SMTP id 6a1803df08f44-90768ed6083mr49785946d6.31.1784236275785;
        Thu, 16 Jul 2026 14:11:15 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90749b913absm89945456d6.10.2026.07.16.14.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 14:11:15 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	tsbogend@alpha.franken.de,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com
Subject: [PATCH bpf-next] bpf, mips: Add support for BPF_SDIV and BPF_SMOD in the mips JIT
Date: Thu, 16 Jul 2026 17:10:55 -0400
Message-Id: <20260716211055.2569433-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

build_insn() picks the div/mod opcode by ALU width alone and never
reads insn->off, so the mips32 and mips64 JITs do not implement signed
BPF_SDIV and BPF_SMOD (off == 1). Signed div/mod get an unsigned
quotient and remainder rather than the signed result the verifier and
interpreter produce for negative operands. Neither JIT has a signed
divide opcode or C helper.

Add the signed path alongside the unsigned one:

- uasm gains div/ddiv/mod/dmod emitters (and their R6 forms) next to
  the existing divu/ddivu/modu/dmodu. This is shared MIPS assembler
  infrastructure, so it lives with the unsigned emitters it mirrors,
  not in the JIT.
- The 32-bit and 64-bit JITs thread an is_signed flag (from
  insn->off == 1) through emit_alu_r()/emit_alu_r64() and pick the
  signed opcode. On 32-bit MIPS, ALU64 runs through a C helper, so
  add div64_s64() and a signed remainder helper beside the existing
  div64_u64()/jit_mod64().
- valid_alu_i() drops the divide-by-power-of-two strength reduction
  (/ (1<<n) -> >> n, % (1<<n) -> & mask) for the signed case. An
  arithmetic shift rounds toward negative infinity and a mask drops
  the sign, so the signed K-form falls through to the register path.

The K-form rejects imm == 0 at verify time, and MIPS div/ddiv, like
divu/ddivu, does not trap on S32_MIN/-1 or S64_MIN/-1. The ALU32
result is zero-extended after each div/mod, for the signed and
unsigned cases.

Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 arch/mips/include/asm/uasm.h   |  6 ++++
 arch/mips/mm/uasm-mips.c       | 10 ++++++
 arch/mips/mm/uasm.c            | 15 ++++++---
 arch/mips/net/bpf_jit_comp.c   | 47 ++++++++++++++++++++++------
 arch/mips/net/bpf_jit_comp.h   |  4 +--
 arch/mips/net/bpf_jit_comp32.c | 28 +++++++++++------
 arch/mips/net/bpf_jit_comp64.c | 57 ++++++++++++++++++++++------------
 7 files changed, 122 insertions(+), 45 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index b43bfd445252..9d3edb59efc0 100644
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
index e15c6700cd08..ef1a2b040070 100644
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
index 125140979d62..9d87d57164d7 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -49,16 +49,17 @@ enum opcode {
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
+	insn_mflo, insn_mod, insn_modu, insn_movn, insn_movz, insn_mtc0, insn_mthc0,
 	insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_mulu, insn_muhu, insn_nor,
 	insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr, insn_sb, insn_sc,
 	insn_scd, insn_seleqz, insn_selnez, insn_sd, insn_sh, insn_sll,
@@ -287,9 +288,12 @@ I_u1u2(_cfc1)
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
@@ -297,6 +301,8 @@ I_u3u1u2(_dmulu)
 I_u2u1s3(_daddiu)
 I_u3u1u2(_daddu)
 I_u1(_di);
+I_u1u2(_div)
+I_u3u1u2(_div_r6)
 I_u1u2(_divu)
 I_u3u1u2(_divu_r6)
 I_u2u1(_dsbh);
@@ -332,6 +338,7 @@ I_u2s3u1(_lw)
 I_u2s3u1(_lwu)
 I_u1u2u3(_mfc0)
 I_u1u2u3(_mfhc0)
+I_u3u1u2(_mod)
 I_u3u1u2(_modu)
 I_u3u1u2(_movn)
 I_u3u1u2(_movz)
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index 6ee4abe6a1f7..504daea4aac2 100644
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
@@ -237,6 +237,15 @@ bool valid_alu_i(u8 op, s32 imm)
 		return imm == 0 || (imm > 0 && is_power_of_2(imm));
 	case BPF_DIV:
 	case BPF_MOD:
+		/*
+		 * The rewrite to a shift/mask below is an unsigned-only
+		 * optimization: arithmetic right shift rounds toward
+		 * negative infinity rather than zero, and masking does not
+		 * reproduce a negative dividend's sign. Force the signed
+		 * case through the general register path instead.
+		 */
+		if (is_signed)
+			return false;
 		/* imm must be an 17-bit power of two */
 		return (u32)imm <= 0x10000 && is_power_of_2((u32)imm);
 	}
@@ -339,7 +348,7 @@ void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
 }
 
 /* ALU register operation (32-bit) */
-void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
+void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op, bool is_signed)
 {
 	switch (BPF_OP(op)) {
 	/* dst = dst & src */
@@ -385,20 +394,38 @@ void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 		break;
 	/* dst = dst / src */
 	case BPF_DIV:
-		if (cpu_has_mips32r6) {
-			emit(ctx, divu_r6, dst, dst, src);
+		if (is_signed) {
+			if (cpu_has_mips32r6) {
+				emit(ctx, div_r6, dst, dst, src);
+			} else {
+				emit(ctx, div, dst, src);
+				emit(ctx, mflo, dst);
+			}
 		} else {
-			emit(ctx, divu, dst, src);
-			emit(ctx, mflo, dst);
+			if (cpu_has_mips32r6) {
+				emit(ctx, divu_r6, dst, dst, src);
+			} else {
+				emit(ctx, divu, dst, src);
+				emit(ctx, mflo, dst);
+			}
 		}
 		break;
 	/* dst = dst % src */
 	case BPF_MOD:
-		if (cpu_has_mips32r6) {
-			emit(ctx, modu, dst, dst, src);
+		if (is_signed) {
+			if (cpu_has_mips32r6) {
+				emit(ctx, mod, dst, dst, src);
+			} else {
+				emit(ctx, div, dst, src);
+				emit(ctx, mfhi, dst);
+			}
 		} else {
-			emit(ctx, divu, dst, src);
-			emit(ctx, mfhi, dst);
+			if (cpu_has_mips32r6) {
+				emit(ctx, modu, dst, dst, src);
+			} else {
+				emit(ctx, divu, dst, src);
+				emit(ctx, mfhi, dst);
+			}
 		}
 		break;
 	}
diff --git a/arch/mips/net/bpf_jit_comp.h b/arch/mips/net/bpf_jit_comp.h
index a37fe20818eb..6367b936b67e 100644
--- a/arch/mips/net/bpf_jit_comp.h
+++ b/arch/mips/net/bpf_jit_comp.h
@@ -163,7 +163,7 @@ void emit_mov_i(struct jit_context *ctx, u8 dst, s32 imm);
 void emit_mov_r(struct jit_context *ctx, u8 dst, u8 src);
 
 /* Validate ALU/ALU64 immediate range */
-bool valid_alu_i(u8 op, s32 imm);
+bool valid_alu_i(u8 op, s32 imm, bool is_signed);
 
 /* Rewrite ALU/ALU64 immediate operation */
 bool rewrite_alu_i(u8 op, s32 imm, u8 *alu, s32 *val);
@@ -172,7 +172,7 @@ bool rewrite_alu_i(u8 op, s32 imm, u8 *alu, s32 *val);
 void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op);
 
 /* ALU register operation (32-bit) */
-void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op);
+void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op, bool is_signed);
 
 /* Atomic read-modify-write (32-bit) */
 void emit_atomic_r(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 code);
diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 40a878b672f5..5d7624f0e301 100644
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
+	s64 quot = div64_s64(a, b);
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
@@ -1516,9 +1524,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU | BPF_MOD | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, off == 1)) {
 			emit_mov_i(ctx, MIPS_R_T6, imm);
-			emit_alu_r(ctx, lo(dst), MIPS_R_T6, BPF_OP(code));
+			emit_alu_r(ctx, lo(dst), MIPS_R_T6, BPF_OP(code), off == 1);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_alu_i(ctx, lo(dst), val, alu);
 		}
@@ -1546,7 +1554,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU | BPF_MOD | BPF_X:
-		emit_alu_r(ctx, lo(dst), lo(src), BPF_OP(code));
+		emit_alu_r(ctx, lo(dst), lo(src), BPF_OP(code), off == 1);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = imm (64-bit) */
@@ -1599,7 +1607,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		 * and then do the operation on this register.
 		 */
 		emit_mov_se_i64(ctx, tmp, imm);
-		emit_divmod_r64(ctx, dst, tmp, BPF_OP(code));
+		emit_divmod_r64(ctx, dst, tmp, BPF_OP(code), off == 1);
 		break;
 	/* dst = dst & src (64-bit) */
 	/* dst = dst | src (64-bit) */
@@ -1629,7 +1637,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	/* dst = dst % src (64-bit) */
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		emit_divmod_r64(ctx, dst, src, BPF_OP(code));
+		emit_divmod_r64(ctx, dst, src, BPF_OP(code), off == 1);
 		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index fa7e9aa37f49..d0a8fb792c9b 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -198,7 +198,8 @@ static void emit_alu_i64(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
 }
 
 /* ALU register operation (64-bit) */
-static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op)
+static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op,
+			 bool is_signed)
 {
 	switch (BPF_OP(op)) {
 	/* dst = dst << src */
@@ -235,25 +236,43 @@ static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 		break;
 	/* dst = dst / src */
 	case BPF_DIV:
-		if (cpu_has_mips64r6) {
-			emit(ctx, ddivu_r6, dst, dst, src);
+		if (is_signed) {
+			if (cpu_has_mips64r6) {
+				emit(ctx, ddiv_r6, dst, dst, src);
+			} else {
+				emit(ctx, ddiv, dst, src);
+				emit(ctx, mflo, dst);
+			}
 		} else {
-			emit(ctx, ddivu, dst, src);
-			emit(ctx, mflo, dst);
+			if (cpu_has_mips64r6) {
+				emit(ctx, ddivu_r6, dst, dst, src);
+			} else {
+				emit(ctx, ddivu, dst, src);
+				emit(ctx, mflo, dst);
+			}
 		}
 		break;
 	/* dst = dst % src */
 	case BPF_MOD:
-		if (cpu_has_mips64r6) {
-			emit(ctx, dmodu, dst, dst, src);
+		if (is_signed) {
+			if (cpu_has_mips64r6) {
+				emit(ctx, dmod, dst, dst, src);
+			} else {
+				emit(ctx, ddiv, dst, src);
+				emit(ctx, mfhi, dst);
+			}
 		} else {
-			emit(ctx, ddivu, dst, src);
-			emit(ctx, mfhi, dst);
+			if (cpu_has_mips64r6) {
+				emit(ctx, dmodu, dst, dst, src);
+			} else {
+				emit(ctx, ddivu, dst, src);
+				emit(ctx, mfhi, dst);
+			}
 		}
 		break;
 	default:
 		/* Width-generic operations */
-		emit_alu_r(ctx, dst, src, op);
+		emit_alu_r(ctx, dst, src, op, false);
 	}
 	clobber_reg(ctx, dst);
 }
@@ -674,9 +693,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
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
@@ -696,10 +715,10 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MUL | BPF_K:
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU | BPF_MOD | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, off == 1)) {
 			emit_sext(ctx, dst, dst);
 			emit_mov_i(ctx, MIPS_R_T4, imm);
-			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
+			emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code), off == 1);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_sext(ctx, dst, dst);
 			emit_alu_i(ctx, dst, val, alu);
@@ -714,7 +733,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_OR | BPF_X:
 	case BPF_ALU | BPF_XOR | BPF_X:
 	case BPF_ALU | BPF_LSH | BPF_X:
-		emit_alu_r(ctx, dst, src, BPF_OP(code));
+		emit_alu_r(ctx, dst, src, BPF_OP(code), false);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = dst >> src */
@@ -733,7 +752,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU | BPF_MOD | BPF_X:
 		emit_sext(ctx, dst, dst);
 		emit_sext(ctx, MIPS_R_T4, src);
-		emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code));
+		emit_alu_r(ctx, dst, MIPS_R_T4, BPF_OP(code), off == 1);
 		emit_zext_ver(ctx, dst);
 		break;
 	/* dst = imm (64-bit) */
@@ -770,9 +789,9 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU64 | BPF_MUL | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
-		if (!valid_alu_i(BPF_OP(code), imm)) {
+		if (!valid_alu_i(BPF_OP(code), imm, off == 1)) {
 			emit_mov_i(ctx, MIPS_R_T4, imm);
-			emit_alu_r64(ctx, dst, MIPS_R_T4, BPF_OP(code));
+			emit_alu_r64(ctx, dst, MIPS_R_T4, BPF_OP(code), off == 1);
 		} else if (rewrite_alu_i(BPF_OP(code), imm, &alu, &val)) {
 			emit_alu_i64(ctx, dst, val, alu);
 		}
@@ -799,7 +818,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_ALU64 | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		emit_alu_r64(ctx, dst, src, BPF_OP(code));
+		emit_alu_r64(ctx, dst, src, BPF_OP(code), off == 1);
 		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */

base-commit: d1f4b56417a3dc1a0600f960b14f46bd25eda89d
-- 
2.34.1

