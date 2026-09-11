Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169F486420
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 21:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162440; cv=none; b=f0Duwvfdlbio70t0XWTZn6L2tVTt8FgaaP/5aOBZc9o865smy6+vJ1WlBHnPiK5hDoWzUTPQWabKGJ+NZwtyPPlM9jHaWfxmqR9a+CearoH90Qps/+3Ftu/PQiSc+1+TOWXxTkQMecRy00t9PFJdUn+dJdNP1PWddU7d/o4DVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162440; c=relaxed/simple;
	bh=KXU0dEULBLMG2eQ2TXVrJNDUpRxLI4gG/Rawcj/EfCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuqOZafASAsAJlcW4dLz2LrTDBO8Vvnbm14Erlehn1hlaftm6zqbCSh7Ox62PJVopFwRCty2jD4BEcPzF6CnL5qHIIRjnaefJ78GHAKATUiUgWEt//YJ3DC1NA7/GuHWG7TxOjnQxvxa4x8VBbVnV6625yaP1izatJO2T3w66C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StKJVxVD; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StKJVxVD"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90cc39e06bdso14818526d6.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789162438; x=1789767238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rWWlWLFADBsCkSr4cxa/Iolx0HAZzLibqF5JxnIfQmw=;
        b=StKJVxVDhPBabD9yFkbQe2c1+VNNrZZlWnhGyUnCCNnBce5K1FfH3m7CdI7kq4sqaT
         ibgpSQXpdeCvi5l2CzQR5PTidGm7lF7dMuiWFAtqMkECoXCj4gvz3tGx/zCS6bspveV8
         OcOyUJnkucuFfdj8rgt9IC0+4j6e1TNms9+m3fimNWXtAgpivk4ECDpN7RNS9MXoiy08
         PJgbZ5qC2a136Z4c+zjizd16ofA0AkU7GW5yEF9KdYNKArOFTQGcwcoZm2pjP7d7DU1x
         9NZz8fAmtIiVTptM8PFKF5sYGhf4ALacDCKHbwq9Oqw9l31+MMc/I2vInyX9WAgwXkKn
         MrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789162438; x=1789767238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rWWlWLFADBsCkSr4cxa/Iolx0HAZzLibqF5JxnIfQmw=;
        b=jL14HGisCNcar5LEezGfp952BF52kWa84juVXsEdZ+TFIf0LLMA9xrjRykGWvRtY/f
         bAHo1I65fAVsQ/70JOx8A4T197RdxOAvTRYi5wtUwQ4Dee55AV5bZR0n6gomEKZDwkL3
         G8z8bxq2+XROz2qJIoc4QykbpNGFPs9Di1lKhCsM+IgI54YV0hIaifXIrrSVXu6n32ol
         9V0FxAD3A7H417Dhq7YAKSokXUmkfIldQRfeSMyinHgX4o6NtUi7fUAbaOf1VnRfoRU0
         eJ8f8MDFYzJPpycVCnmeEhdz8D+0IJwes0gU1V01jpI7TDMb38DymnyMI9AsY7BEPBfA
         CbHA==
X-Forwarded-Encrypted: i=1; AKwUvBz9UVXUF3RH0OuCsxl0z8dk795w3i8qrEDZG30a9+o5kPV90O9gzuYPTFz98gzy3rZZf9I=@vger.kernel.org
X-Gm-Message-State: AFuF++mxBFNI3FvmKMHBXrDUKjMNwRpAaju/vl53WrL5AHz2iUKUf0Ks
	ykUW2dJApPCpd78ZGP2w6wBPHoL0eFvcUuhcG93hgsut09IspjC6/KGr
X-Gm-Gg: AYBFou3RltWVVABNMpbvbCF/dmULeXEcV7O2nNlVe2cLocxZKDhDbgLeXu0fE25AkUp
	kWhV3lroW20/HEQ36DxarN1WGX6Pr1/76BcKuvg2ZEg1q2TNPwRpzb2zJWa5TybesSziEe+CBma
	eGaoIiNKRkRMM+rsAloRmbuICh0Gadu8kRBmsMGb1j3b7e8JEWCAFdFyhxBrGJJDpFWkrezlWBp
	3RgSKHh7XGh6+i4HZaLqqhk0f1tDiGwF81lYDK846N+6dAEYalqyDz5aXzdChlLT+4kY7e/A+hm
	PZMgA+uFUOo52dqoVZ5QEJtG4Mh90+ZUkKyyBl67GN2U5en2MGTOU0SbhFsNiVxBWaGtFN1ndi7
	9vd6t0KeualTzuzaNa/0PEVp5FltUKQkgmF8dsY/Xe8xxMtAbuHF1l+zbXx7U5oVa8/6Mrbb9Bn
	UZ0hoCoxnTq6RaNrsN4YdHb5Hbx2ex0iN+etzBpNZ0k+WKRfz5Ytg5DAOweP5B7hIL6BcDPRUGu
	n6R
X-Received: by 2002:a05:622a:313:b0:519:efea:cf41 with SMTP id d75a77b69052e-530c869dabamr92604001cf.28.1789162437757;
        Fri, 11 Sep 2026 14:33:57 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f496598sm30170196d6.35.2026.09.11.14.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:33:57 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/3] MIPS: uasm: Add signed div/mod and sign-extension emitters
Date: Fri, 11 Sep 2026 17:33:39 -0400
Message-ID: <20260911213340.3767930-3-main.kalliope@gmail.com>
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

Add uasm emitters for the signed DIV, MOD, DDIV, and DMOD
instructions. Provide both pre-R6 and R6 division forms so users can
select the instruction appropriate for the target ISA.

Add SEB and SEH emitters for R2-or-newer CPUs. These will be used by
the follow-on BPF_MOVSX series.

Assisted-by: Codex:gpt-6
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Link: https://lore.kernel.org/bpf/CAM1=_QS79dDBfaaNQXnWd61AqHd1M4o9aDMMiftnoJveNr=FZg@mail.gmail.com/
Link: https://lore.kernel.org/bpf/CAM1=_QTN3JJ6jtckf32F8wxBzLDbHSrzUttyMBWNqZKmRe=2rg@mail.gmail.com/
---
 arch/mips/include/asm/uasm.h |  8 ++++++++
 arch/mips/mm/uasm-mips.c     | 12 ++++++++++++
 arch/mips/mm/uasm.c          | 24 +++++++++++++++++-------
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index b43bfd44525..adea35df0f8 100644
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
@@ -156,6 +162,8 @@ Ip_u2s3u1(_sb);
 Ip_u2s3u1(_sc);
 Ip_u2s3u1(_scd);
 Ip_u2s3u1(_sd);
+Ip_u2u1(_seb);
+Ip_u2u1(_seh);
 Ip_u3u1u2(_seleqz);
 Ip_u3u1u2(_selnez);
 Ip_u2s3u1(_sh);
diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
index e15c6700cd0..2d1668b58dd 100644
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
@@ -177,6 +187,8 @@ static const struct insn insn_table[insn_invalid] = {
 	[insn_scd]	= {M6(spec3_op, 0, 0, 0, scd6_op),  RS | RT | SIMM9},
 #endif
 	[insn_sd]	= {M(sd_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
+	[insn_seb]	= {M(spec3_op, 0, 0, 0, seb_op, bshfl_op), RT | RD},
+	[insn_seh]	= {M(spec3_op, 0, 0, 0, seh_op, bshfl_op), RT | RD},
 	[insn_seleqz]	= {M(spec_op, 0, 0, 0, 0, seleqz_op), RS | RT | RD},
 	[insn_selnez]	= {M(spec_op, 0, 0, 0, 0, selnez_op), RS | RT | RD},
 	[insn_sh]	= {M(sh_op, 0, 0, 0, 0, 0),  RS | RT | SIMM},
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 125140979d6..139afb0e14c 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -49,19 +49,21 @@ enum opcode {
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
-	insn_scd, insn_seleqz, insn_selnez, insn_sd, insn_sh, insn_sll,
+	insn_mflo, insn_mod, insn_modu, insn_movn, insn_movz, insn_mtc0,
+	insn_mthc0, insn_mthi, insn_mtlo, insn_mul, insn_multu, insn_mulu,
+	insn_muhu, insn_nor, insn_or, insn_ori, insn_pref, insn_rfe, insn_rotr,
+	insn_sb, insn_sc, insn_scd, insn_seb, insn_seh,
+	insn_seleqz, insn_selnez, insn_sd, insn_sh, insn_sll,
 	insn_sllv, insn_slt, insn_slti, insn_sltiu, insn_sltu, insn_sra,
 	insn_srav, insn_srl, insn_srlv, insn_subu, insn_sw, insn_sync,
 	insn_syscall, insn_tlbp, insn_tlbr, insn_tlbwi, insn_tlbwr, insn_wait,
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
@@ -353,6 +361,8 @@ I_u2s3u1(_sb)
 I_u2s3u1(_sc)
 I_u2s3u1(_scd)
 I_u2s3u1(_sd)
+I_u2u1(_seb)
+I_u2u1(_seh)
 I_u3u1u2(_seleqz)
 I_u3u1u2(_selnez)
 I_u2s3u1(_sh)
