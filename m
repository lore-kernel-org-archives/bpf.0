Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB7744160C
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390965; cv=none; b=c40bQTsiTOj+eriYY+5mHdvIQF1WUc2qhR4GXNs/p8WZML3sYdCD5YxpU91Qdk3+qiu7tcUkAwZArBu9wwANlr6A/jD5BCfOiMlwVIilh/l2tkJ8euZsMEoTMXj0m6f0nORqYNyBI5nP1Cr+pcbXckFjuA12TtCVjt5olKpJKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390965; c=relaxed/simple;
	bh=W485Ps4F9bQqeQYrJN3IRGl+zarYhizxFCivRtuP0Xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qs02j8FyifBVo/T1TKnKRJAH1PGeWJknp82BzHyI5c7H87mZ8rChjf9+y3zmwuD8j62crGd7Wwft9FfCwjFF7OiMua8fdJi3x7HaCF0DVmIys2k4AfGDfjVtJPsigxtk6ZI9HOtIjbpldZMWJ2thhx2k4C2sZaSuz4weH/8pC5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jfx4Ymtk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfx4Ymtk"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1671ec8692so273869066b.0
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390952; x=1786995752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gNL8jc0H9XgLIgF8wMon/ay6lTwqg54F4SvS6jfnRF0=;
        b=Jfx4YmtkEgC/z5PA8rGdI+2vGhrxjXmqaElM4a4d8T7CnXPfCbBDHko5HHO52Mwm5Y
         qAhH67ZFQeQiMLXceVd0+dEv6gpFRH9bc2bMWyfyq20YGNw5L25AnZsLhrg9MhB9Slwl
         H65Rr9tdQ0lJddkA6SbXybZl8sYVYcFPAVsvCg2noSllBfmRYlwhQQuLzAe/a51AXJOB
         l6LnS2TGMNlYMkglOkfM6/GKAFX1rHxydwhpDpd6M6DCDudkDOd/LymyHAgLs5YS+yoB
         UPcRoPKCNw9z5g46nExGrTgkyawtxFLw7jln/rzKbun4EXkLM7U5YbwaXl5EMtEE2dgF
         u00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390952; x=1786995752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gNL8jc0H9XgLIgF8wMon/ay6lTwqg54F4SvS6jfnRF0=;
        b=pTqwWq3ODm3VuYz5TnU8BFyrHY4OwzvtBzkf2yGN4f1u07lUi+pzT9h4O8dslTXI9T
         2v9bL5AWQgf4HmKL8ZN4GdzHiAiE+/BcrKI0Iwy4cJu4dKyJ7j0H6l+mdPzItwz4p6n1
         MERUJKsmXUGhNi9W88PCUEjTh8/6LxX1AD8f+UJk1wj5UHjALCVi+uGDjuwQ/O7l7bXl
         Q49pW5L42VyAqbLZRACIas1R+X+BbDfRzkFSbD1+T2867/h+SgiE8bw3VFh2mby0XMZe
         q5lA3+Lhw6HLrVvztS/MDJ6hU8sK5eVilW+atzLKbEU+GaaHk1tbagl9ne4h2rUvFjOm
         ceIA==
X-Forwarded-Encrypted: i=1; AHgh+RoH4zNgPLTht6LYLhbeURXwdCRP52tWVuWXQsOJreSiJH1VIMtqnP3IvOt5n+wHOmlxWSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJkKyza267QWbn8+HFmPJuVO/6lFaN6S3ki1MM6kqw/XX5SDyJ
	ykl0TIZbIu6L/smWxn4OEQ+ndwoYnbdLvC5+ZYsmgzGgqqNJbeF0Lu78
X-Gm-Gg: AR+sD13iZS0vRcLDmCxXyRFsB82jlCRk5y8FKByo1rY2WtH2x0ijP0ndXln4Fet4s/s
	bIUjYJXQUebSncYM+Du3LdAIxEG5vEhBHv6V07upDV8jA2kagxrlhQJC5wpRfbzHKq7xqoOA+GH
	ngllIRq6lvlnNqrxHOdqZY08Tg29Ut2vdrAiNqsl3Df5CDMKtsK/82BhngpMrcN6w+08ZrzJIhN
	Rtr0gXrq58s2UgTbQFo1Aq2eC8SsdS38ly0NWHSEK/ZeX5kAziE7DOTKezjjgSjBCvlBPIPXthD
	T31LLwkwXjYg+4BTdA9kEKznPC3MOhtD6buX4Bm9SXblsOIa8Bv3Oh7DidZcJisMXk77ZHnwx3A
	RdecWvBuSSRJ3/svw4008mmzdniGXxxM7rqNZGzuUzdEJMIOsLG0t//51zjbjK15Y77BoHAZUng
	d7zTRvnmuwZDxGq2MF5BQ2J3Q8lTOF0TFs/7aZmEIATXHtO2ORX7wFAZP4cCERphLH
X-Received: by 2002:a17:907:3c86:b0:c12:7f25:cc59 with SMTP id a640c23a62f3a-c20c68e5809mr218216066b.16.1786390951475;
        Mon, 10 Aug 2026 12:42:31 -0700 (PDT)
Received: from TurinLinux.. ([187.15.140.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a6f414sm430309066b.17.2026.08.10.12.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:42:31 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/3] MIPS: uasm: Add signed div/mod emitters
Date: Mon, 10 Aug 2026 15:42:14 -0400
Message-Id: <20260810194215.3754591-3-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810194215.3754591-1-main.kalliope@gmail.com>
References: <20260810194215.3754591-1-main.kalliope@gmail.com>
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

Assisted-by: Codex:gpt-5.6-sol
Link: https://lore.kernel.org/bpf/CAM1=_QS79dDBfaaNQXnWd61AqHd1M4o9aDMMiftnoJveNr=FZg@mail.gmail.com/
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/mips/include/asm/uasm.h |  6 ++++++
 arch/mips/mm/uasm-mips.c     | 10 ++++++++++
 arch/mips/mm/uasm.c          | 20 ++++++++++++++------
 3 files changed, 30 insertions(+), 6 deletions(-)

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
index 125140979d62..06d722665451 100644
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
