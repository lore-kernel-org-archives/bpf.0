Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583593CFF55
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 02:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439356; cv=none; b=d1n2bK0IwWEqILlhXhZTPuzOn2tx4i22NR8/d7LP00vLlpZczjD9pHujO4UvT83w45rvCC+x3xSA18DRyO9X7YVKx1aJI49DUX41GhSQTUPGDVsDTEFM83VDk/IHJSTCI5gWCLbS7eYGlR90xEHfxGyBhNuJYHp24FY+nr5gjPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439356; c=relaxed/simple;
	bh=Cn5e8xZQRc6b8WoFy3hCWfwv30WkooJ5m58H2SQg+WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKCB9IXelgmA3/W78bHR23WpxdcMxEZQwChEpDa6Q7HLaeV5LXJOEQFQix19/Zg9mL0Nj3/IOkSLFYOWdZq/mDxwQyO/GJ0CY0PjRhZaf8UpsVR77ry8q3p1GHQdZr+Cxgh7C9V89cMgSFibI1+MCYw/InHTR24kMsLiZpi0cR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPfWgx3R; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPfWgx3R"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-9103228ef53so46659286d6.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 19:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789439353; x=1790044153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbifEBXXlaTPl7iHr8VuKt08GP8Un/dGLxM2o5dy9WQ=;
        b=RPfWgx3RJjQ8ZziZrwWz7sAQLJrG2i1VH320m6YovRQsK+GeM3f7amy0vpK42gPm05
         fw6gbnSjc2rV7w8ROsSPuEBKJluo2H4u6U2a+pWTm2+KhITv7mTdDfCTHn8kaZdps+bt
         rmhxMXZtTX+bN1JKujFrgl0Sy/FmyCKq8FHdkIztLO/kZ9zFEU7hbkSB2aQseEWhiLyj
         hGIeXiIz643tnlPAbuiB/Up+cuf0AZhCDi09dm2IUwCB8jmmNd9ReBIhpCoEQqJwS3nE
         vuvHBHf4woQvcGTBWKP6epZ9Zx0UzVOWJrVWzheZMCPZwUXpOMfNz0ubavhUcQGz7jLu
         MSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789439353; x=1790044153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbifEBXXlaTPl7iHr8VuKt08GP8Un/dGLxM2o5dy9WQ=;
        b=LTy5yW1iJAwtI9rqZ4bON91yNbu5r2VUojBaSlzvCi9ZY+nunJqu99EtOpHb+y4qI7
         5IqQjPntUD8ga0/de9RJ+T2vSYSZO22OTB+6gQSWa2FiO6eGdy3WJQnfI20JuVgHMZvR
         SIOz/GOFPhINN1OQgod1TudjxfOuzlxTdvWmbqauscDkjigy6giUpCHKKIyyKbBWbVKC
         2fi/0N8rtrWa5TMDl4nvOCmSAVOlF+uBCax6Gzl5UxPZlzkaQwZF/9iFxa7SfQSg6tWu
         k3F/kVIxsFaqxH3aWMtvcQdbZbMRwOhgvpAtvSNte+y9XiQU4fWWi3Xbr25d4xuv3mz4
         oxjw==
X-Forwarded-Encrypted: i=1; AKwUvBxCZLvlDDsd49BOb6RDvWq/iHk2OUefo+dREbATi6Z32yMD138r95Ob9FfZv721Xi+CRYU=@vger.kernel.org
X-Gm-Message-State: AFuF++lr7Svg0en+ueolB6zq24KHvIiLhX3LPP7YboZQSXsJHpBcc123
	CuGeVfZIgXR5Npq7VzUugjAIxHr1yGkGM7hysCpKhCM0eoZE6vn7aBs4
X-Gm-Gg: AYBFou3Ohimdv7LfAd3W3iqs8wI5bfq+iXo7SuTDX26a+OC9VJEEfQ37ejL38/i0ztL
	eqa2N6R7T050UtQ/vkDIiXPBEiDa2ZxhN3Ae/ffDqjV6IBSOGoDjcdPRNvPmGbZDTeUOpUzxx12
	DS/kVDTMTDzkbprJWb1jg324XU2PBG15uGflFelPPI7KGtxdFdUYDjDF6gjF6/GL0lPuV/hTvzG
	U6sHXpUib99p6nBQoy8QzNDXxUDNJ2NuhVXXZWIXnZm1RCAvURJw20hLH/2OxX40AUt1DVBL2Bn
	1RgL3FpneG3HcHGltAoM7+QjbloYwGlwRjBEPbj+scxQnXDLrMwY2IBYJXFGAGooBTt2t8H55JI
	D54w0tEBkhqKWI2rgL5G2nIWxq9CKsx0yUD0dckdP7bHJq7SMTj0hxUHlsvFtcRYm9vbPLM+bE/
	aMyBgv32sTc7aOUU12dTUA/cb2PjRQgou5BuX0i6EnE6fqsPsx1Qmtgz5VlQx5mYJR
X-Received: by 2002:a05:6214:5c08:b0:910:345c:b7e5 with SMTP id 6a1803df08f44-9122e69758cmr88235586d6.36.1789439353357;
        Mon, 14 Sep 2026 19:29:13 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9121a4fb3e4sm90358906d6.24.2026.09.14.19.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:29:12 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com
Subject: [PATCH bpf-next v2 1/2] bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc64 JIT
Date: Mon, 14 Sep 2026 22:29:04 -0400
Message-ID: <20260915022905.1535566-2-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915022905.1535566-1-main.kalliope@gmail.com>
References: <20260915022905.1535566-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

emit_call_libgcc_ll() zero-extends the ALU32 operands and calls the
unsigned hppa_div64()/hppa_div64_rem() helpers regardless of the BPF
instruction's signedness, so the parisc64 JIT does not implement
signed BPF_SDIV and BPF_SMOD (off == 1). Signed ALU32 and ALU64
div/mod get an unsigned quotient and remainder rather than the
verifier's and the interpreter's signed result for negative operands.

Add hppa_sdiv64()/hppa_sdiv64_rem() wrapping div64_s64(), thread
is_signed = (insn->off == 1) through the div/mod emit sites, and on the
signed path sign-extend the ALU32 operands (and the immediate divisor)
instead of zero-extending them before calling the signed helpers.
bpf_do_misc_fixups() rewrites the zero-divisor and INT_MIN/-1 cases out
of the instruction stream before the JIT runs.

Acked-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/parisc/net/bpf_jit.h        |  2 ++
 arch/parisc/net/bpf_jit_comp64.c | 35 ++++++++++++++++++++++++--------
 arch/parisc/net/bpf_jit_core.c   | 14 +++++++++++++
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/arch/parisc/net/bpf_jit.h b/arch/parisc/net/bpf_jit.h
index 8b8896959f044..074115c93c909 100644
--- a/arch/parisc/net/bpf_jit.h
+++ b/arch/parisc/net/bpf_jit.h
@@ -467,6 +467,8 @@ static inline u32 hppa_t21_insn(u8 opcode, u8 r2, u8 r1, u8 ext8, u8 t)
 
 u64 hppa_div64(u64 div, u64 divisor);
 u64 hppa_div64_rem(u64 div, u64 divisor);
+u64 hppa_sdiv64(u64 div, u64 divisor);
+u64 hppa_sdiv64_rem(u64 div, u64 divisor);
 
 /* Helper functions that emit HPPA instructions when possible. */
 
diff --git a/arch/parisc/net/bpf_jit_comp64.c b/arch/parisc/net/bpf_jit_comp64.c
index 54b0d5e25e024..c326fa737ec8c 100644
--- a/arch/parisc/net/bpf_jit_comp64.c
+++ b/arch/parisc/net/bpf_jit_comp64.c
@@ -502,14 +502,19 @@ static void emit_call(u64 addr, bool fixed, struct hppa_jit_context *ctx)
 	emit_hppa_copy(HPPA_REG_RET0, regmap[BPF_REG_0], ctx);
 }
 
-static void emit_call_libgcc_ll(void *func, const s8 arg0,
-		const s8 arg1, u8 opcode, struct hppa_jit_context *ctx)
+static void emit_call_libgcc_ll(void *func, const s8 arg0, const s8 arg1,
+		u8 opcode, bool is_signed, struct hppa_jit_context *ctx)
 {
 	u64 func_addr;
 
 	if (BPF_CLASS(opcode) == BPF_ALU) {
-		emit_hppa64_zext32(arg0, HPPA_REG_ARG0, ctx);
-		emit_hppa64_zext32(arg1, HPPA_REG_ARG1, ctx);
+		if (is_signed) {
+			emit_hppa64_sext32(arg0, HPPA_REG_ARG0, ctx);
+			emit_hppa64_sext32(arg1, HPPA_REG_ARG1, ctx);
+		} else {
+			emit_hppa64_zext32(arg0, HPPA_REG_ARG0, ctx);
+			emit_hppa64_zext32(arg1, HPPA_REG_ARG1, ctx);
+		}
 	} else {
 		emit_hppa_copy(arg0, HPPA_REG_ARG0, ctx);
 		emit_hppa_copy(arg1, HPPA_REG_ARG1, ctx);
@@ -600,6 +605,8 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct hppa_jit_context *ctx,
 	u8 rd = -1, rs = -1, code = insn->code;
 	s16 off = insn->off;
 	s32 imm = insn->imm;
+	bool is_signed;
+	void *func;
 
 	init_regs(&rd, &rs, insn, ctx);
 
@@ -656,29 +663,39 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct hppa_jit_context *ctx,
 		fallthrough;
 	case BPF_ALU | BPF_MUL | BPF_X:
 	case BPF_ALU64 | BPF_MUL | BPF_X:
-		emit_call_libgcc_ll(__muldi3, rd, rs, code, ctx);
+		emit_call_libgcc_ll(__muldi3, rd, rs, code, false, ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_DIV | BPF_K:
 	case BPF_ALU64 | BPF_DIV | BPF_K:
-		emit_imm(HPPA_REG_T1, is64 ? (s64)(s32)imm : (u32)imm, HPPA_REG_T2, ctx);
+		is_signed = (off == 1);
+		emit_imm(HPPA_REG_T1,
+			 is64 || is_signed ? (s64)(s32)imm : (u32)imm,
+			 HPPA_REG_T2, ctx);
 		rs = HPPA_REG_T1;
 		fallthrough;
 	case BPF_ALU | BPF_DIV | BPF_X:
 	case BPF_ALU64 | BPF_DIV | BPF_X:
-		emit_call_libgcc_ll(&hppa_div64, rd, rs, code, ctx);
+		is_signed = (off == 1);
+		func = is_signed ? &hppa_sdiv64 : &hppa_div64;
+		emit_call_libgcc_ll(func, rd, rs, code, is_signed, ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
 	case BPF_ALU | BPF_MOD | BPF_K:
 	case BPF_ALU64 | BPF_MOD | BPF_K:
-		emit_imm(HPPA_REG_T1, is64 ? (s64)(s32)imm : (u32)imm, HPPA_REG_T2, ctx);
+		is_signed = (off == 1);
+		emit_imm(HPPA_REG_T1,
+			 is64 || is_signed ? (s64)(s32)imm : (u32)imm,
+			 HPPA_REG_T2, ctx);
 		rs = HPPA_REG_T1;
 		fallthrough;
 	case BPF_ALU | BPF_MOD | BPF_X:
 	case BPF_ALU64 | BPF_MOD | BPF_X:
-		emit_call_libgcc_ll(&hppa_div64_rem, rd, rs, code, ctx);
+		is_signed = (off == 1);
+		func = is_signed ? &hppa_sdiv64_rem : &hppa_div64_rem;
+		emit_call_libgcc_ll(func, rd, rs, code, is_signed, ctx);
 		if (!is64 && !aux->verifier_zext)
 			emit_zext_32(rd, ctx);
 		break;
diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_core.c
index 172770132440d..a2f93202a2ef9 100644
--- a/arch/parisc/net/bpf_jit_core.c
+++ b/arch/parisc/net/bpf_jit_core.c
@@ -190,3 +190,17 @@ u64 hppa_div64_rem(u64 div, u64 divisor)
 	div64_u64_rem(div, divisor, &rem);
 	return rem;
 }
+
+u64 hppa_sdiv64(u64 div, u64 divisor)
+{
+	s64 sdiv = div64_s64((s64)div, (s64)divisor);
+
+	return (u64)sdiv;
+}
+
+u64 hppa_sdiv64_rem(u64 div, u64 divisor)
+{
+	s64 sdiv = div64_s64((s64)div, (s64)divisor);
+
+	return (u64)((s64)div - sdiv * (s64)divisor);
+}
