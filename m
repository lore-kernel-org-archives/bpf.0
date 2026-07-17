Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64BC33F38B
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315180; cv=none; b=h0fULNqb4SXLo0zSazQQHD24TrL5HBS+8SXCduEnYDR7HG4SZ1qz7ddiEXPWUAF/vv/dd2QefXlqFnxAfqTWeYHhWN/7MOj8fGNNQ3mgTj4e1EgYnivxSR7zjnEnidAhXdlskRfR9L6G9FXtNmdzWMt3cGtG0toXE6VROvPYUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315180; c=relaxed/simple;
	bh=8KfC1Q+hVlMgx18fEn+5U56IOcMygoLf8d8VPItiBVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OsGeLVnT3ejxquDEPGyARAwbhAM1jvDXmx04HI7LYCpsW/qOXowBdCpV9uIvuUcKKmlVfyK/FabXoLJloOuVtpv/Bmb2vDUMxG4P7t7u3g47I+o1ScIWr2w+QzuWDGQ0wZH9kTR1DtPM9XqfhDW885bLJiqJLC7YSJ+iPmrIg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCbzFftE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCbzFftE"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so56992436d6.1
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784315178; x=1784919978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REAtAr9MF3gwMGff8xpP1gOdx32tZ9rS1fvQIY3YEN4=;
        b=XCbzFftEvZRpCsjwHq8kSdNz1+a+FyuP3HKcDnYgiBatkY38b30UixH+oT34jzR/0I
         jQ8FHu4L5xj4Y8rhH4rK8b4/rX58cPC4nehN/agdjWLCIi906ic3Wr4ob0meVuqs8BaQ
         ymyZXCB+2ojTzwS+Z+GIJe1AvHssC9E77Xrmqqr4C1Yz0ea/L/RjPcIvx4U5LLpXO71B
         Tfy9wZk59ri9jbLcRRHXJnIbT2tXR5AQIArmOghGxAXggB7O0qVSV8ASTSsnMhibnUHq
         chj4AaV8ISxqasBdd5E2iM/49N2dwlQEcR/mopW2/6R6N5XflLlTYQKIX8APNGilUAyM
         5MGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784315178; x=1784919978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=REAtAr9MF3gwMGff8xpP1gOdx32tZ9rS1fvQIY3YEN4=;
        b=L7uSKzfZCmEKc/zBrRY1rMx0kv9+WB46fSix9vbNzNZF9jYuiEp/6KNwF7Lr7TiAdj
         N47DfinIcpdakoQKYi/8I7hlgPLCTuIaFhm74zttR2vBOcx7rd8xrFNFpVHbsWGbvjn+
         YTlcfTBD91c9rlEH1xb1uAtGPrq9a/azUcwboisUUFccGDHtxMb5Z9mEdgGiu2bpKg+0
         UakD7vazcd3RxrYcM7U8Hncreeh99qKl1ZnzBt5eEFD3UELlsHA7154gUuAuMRQN6w14
         wsh9ZtyK7aQfjbT98KPcUMifFqLIo13So2y7JIK6ZPoI/IbN2FWEdGleFidLFYuxdDYf
         bovQ==
X-Gm-Message-State: AOJu0YyH7NczF0+nX2yhWoVbTZ38xTjmTD6W7fUdxGXag+BxonTmkRtR
	CDT2ymKWOw1zPMhc/g/vwrEtQOXX/TWDo6vsndWn5+PuRjGJ1wIi8CsG
X-Gm-Gg: AfdE7clbil0mFdm6uikSgADQJK7QQu+PI3MZXqhK6rFwECdqFKzWxzI7hNmOXEYczPO
	nzr3hJzxuhM7XHt1OT19Br2o8UuCPOPMiRVECZrrDeDabu7ZL1cIQEIn89Z4hFERnpBhuXFJWXK
	MdG++0oawS6yXJlCRy387x0KBtYOl6tCInHRaRafAV4ouPYqK56wXtyMHgvRWD9wZODvXXRbKZ8
	wqhayGzZ6T/4sh6G62X02IXF1p6FTiswwEBHiVD7d+Auf/wBFnapeF7yFEwzEUeXnFH1j/kvkOZ
	njRSWF1tWL/4jG6YqiH/BRavrJWeiGU304PTWjW8GxGuLTdhUxJC/8SGWiXgzLnfndHeRbiht4y
	A3Ndih4V7p6x06amz+VzrhZ8jAx8km7kQldilVNskMNbfGFSfsRwanmx2qXTDdk60xKnG69vWEg
	PJGAn2rsAfSQUH4/2jZJs=
X-Received: by 2002:a05:6214:1305:b0:8ee:a2f3:af32 with SMTP id 6a1803df08f44-907784dd1a9mr49578396d6.38.1784315177508;
        Fri, 17 Jul 2026 12:06:17 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077871d06csm24035606d6.43.2026.07.17.12.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:06:13 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	deller@gmx.de,
	James.Bottomley@HansenPartnership.com
Cc: bpf@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com
Subject: [PATCH bpf-next 1/2] bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc64 JIT
Date: Fri, 17 Jul 2026 15:05:43 -0400
Message-Id: <20260717190544.257306-2-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717190544.257306-1-main.kalliope@gmail.com>
References: <20260717190544.257306-1-main.kalliope@gmail.com>
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

Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 arch/parisc/net/bpf_jit.h        |  2 ++
 arch/parisc/net/bpf_jit_comp64.c | 35 ++++++++++++++++++++++++--------
 arch/parisc/net/bpf_jit_core.c   | 14 +++++++++++++
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/arch/parisc/net/bpf_jit.h b/arch/parisc/net/bpf_jit.h
index 8b8896959f04..074115c93c90 100644
--- a/arch/parisc/net/bpf_jit.h
+++ b/arch/parisc/net/bpf_jit.h
@@ -467,6 +467,8 @@ static inline u32 hppa_t21_insn(u8 opcode, u8 r2, u8 r1, u8 ext8, u8 t)
 
 u64 hppa_div64(u64 div, u64 divisor);
 u64 hppa_div64_rem(u64 div, u64 divisor);
+u64 hppa_sdiv64(u64 div, u64 divisor);
+u64 hppa_sdiv64_rem(u64 div, u64 divisor);
 
 /* Helper functions that emit HPPA instructions when possible. */
 
diff --git a/arch/parisc/net/bpf_jit_comp64.c b/arch/parisc/net/bpf_jit_comp64.c
index 54b0d5e25e02..c326fa737ec8 100644
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
index 172770132440..a2f93202a2ef 100644
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
-- 
2.34.1

