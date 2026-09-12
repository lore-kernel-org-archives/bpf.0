Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863437B41E
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789186358; cv=none; b=R61qeK3B0EBcQu+Fzgwk//ZhttvFL/UZzF5waTcNaiaMniI8Xi5rnDhw4tVkleoOgo6jLKaSjv/a6iW8Qjd8cJDATVlki+Pp+V3BVh34alxvfTC/sSe9op5Y2DaUVWPJTv6aMYY68R51EHArbG2NvaCAjHg1JaVYyChU6Hmb1lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789186358; c=relaxed/simple;
	bh=7COibI29Ach+wbwW+uNXJ3Z1CLlszRI6kx/mtrLZat0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUdGqREHw83+raM/VN+HqWxhwv9UhzAZkVpNrQxZif8WfMZmHkOdCLKMf2StVJHSfzkMLFE9nkao0l7M2nXkoWid6WfS7P3bGwdPjomu5LwQ+BM2xV1HGYxrat9LDXWvEwwAobI5YWEfpT1v4lA/VCbPtqpm/bQsJgXL4UpuTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyx7U8os; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyx7U8os"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb4so83816585a.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 21:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789186356; x=1789791156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGYx9/EEnOrP1Jo1+EaxuAffL25XtyIjkiW/sdlTsx0=;
        b=eyx7U8osowJ/70Vf4xTgGsxygBkJY7+5T/J58fpCYL4K+SD2OGoy8snRFmFEG3ZLz+
         S33LfJrbnmoGX6tDoQ1J6OwE70w9AAFGZDDcV0OvCdI6I655DqUf6xnzqX8PCPOhv+H9
         xCxTjBO1k9Zn/jxoRGbrp79X8U3dPkkV9eGmWCEsfaYilvAp3ZPXLuo3HI8IEsUAiIrP
         0rObR2B/yY+3NYPmBJlUBF1a6VeLoX/oRAi5n06FOF1uuQuwozDhl/HGMUN9iGGVwEMi
         kl+JbHOOW/fuC5znJcdxp24WPD8Hrlz0sM5aX0KhZWCPNUmD/++/N5zhZhYpv5quJz/w
         7hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789186356; x=1789791156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oGYx9/EEnOrP1Jo1+EaxuAffL25XtyIjkiW/sdlTsx0=;
        b=dy6NoMK9acM7aFy7OHNaMSt52XhG7z8aO1bl1MKimgeNUm3LA+wlgbbtcQvBWtDsT8
         2i13TRtDNhFtYwjAfRmDuFAoQkOPN7LOvzVGJNpOc3NAlzJHmIKHHPTKFhJ7+M6kGNF3
         dnW7xNPDNJWMWkh/wZp9N0LDtq/iUOHDO8iglBRGyIIB4Wzd5HoEo1dyKfk2HpcKGdfa
         4xaR+HyUNK4z8ia01aV7GdXFH21bOjU0azBNpdUgfnnHwRoc3SwyGl9LyDZelOUp6yw9
         UmlYBV5o26ea9CpsVBwTAEDNuus+IDa6mFDpBuegPD29awil/ZHPOQsx51D1JoCzbmaT
         a9NA==
X-Forwarded-Encrypted: i=1; AKwUvBxP2fubWnD5mrtWsv54ijuT7MaV3CaIb/7WVJiaQoyd25RRZHwXVUocb4dLxiLIabgbQLs=@vger.kernel.org
X-Gm-Message-State: AFuF++m+bTwJCd4BF/TXLBhs5K4+uxSR2JjPvnRzh3My7KMaj7XbtRh4
	92Xmg5EtD9dJz7FBWxKA816ILdqEFxLjUgHHjCmz9ZAgqYoVATF4YNIz
X-Gm-Gg: AYBFou1i3TJ1LGqXn785jn6RdtFvWVQHPV+tc5AAkKKPtA0qVbx0yI9fUBIIZrYVqZO
	wW+6AA/9jIwbLcbiSIYKcQQimJOAd72HkfC1Vo+2CuG0hwUdhl+azOlgvSELC0E7pzC5i9PIiut
	yDXyC7w3g6/XtpPOBaXDvs5R0ZAa0mvc3zlXoqgIA0gznlO0mg1FulcL/puEfbFSXh/Pim+a/bQ
	zGiJOBMoMrA2NLvd7aXIz5oPjjbhbam+Qn3pYsWMSXKVm4Jn+OySNBfFpUV0I9FX2rf9oL+J6q8
	dd6+/DzrJD0m63shIM4YfFhg5BfUzGDpZiE/6eIduZ0ItCVRP0J7wFF6rd1qubBOZ1o2V7WfsyZ
	R21v52P7AKLEJbQic1ekWqBMNWf6U1g1aDFJ2RE5XWkpL0r+WGLdEx3yPR+ggl3G1v0UsjWHYeM
	3TX/7rBKA8A/5MVU+bSZ5g9Ft1hqOFlk/vGwSkZkBpEOS44UQC7TmNeuH6bay8uFRJ
X-Received: by 2002:a05:620a:468b:b0:930:9585:e08e with SMTP id af79cd13be357-939ea037950mr1090670185a.10.1789186351356;
        Fri, 11 Sep 2026 21:12:31 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a09b85dadsm18463485a.34.2026.09.11.21.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 21:12:30 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org,
	tsbogend@alpha.franken.de
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] bpf, mips: Add support for BPF_MOVSX in the JITs
Date: Sat, 12 Sep 2026 00:12:20 -0400
Message-ID: <20260912041220.444715-3-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912041220.444715-1-main.kalliope@gmail.com>
References: <20260912041220.444715-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both MIPS JITs ignore insn->off when lowering register MOV
instructions, so BPF_MOVSX is emitted as an ordinary move. Since
build_insn() accepts it, affected programs are silently miscompiled
instead of falling back to the interpreter.

Decode the MOVSX width from insn->off in the register-move helpers.
On MIPS32, propagate the sign into the high word for ALU64 while
preserving the existing ALU32 zero-extension handling.

Use seb/seh on MIPS32 R2-or-newer CPUs and shift pairs otherwise.
On MIPS64, seb/seh require a sign-extended 32-bit source. Normalizing
an arbitrary BPF register first would cost another instruction, so
retain the doubleword shift pairs.

Assisted-by: Codex:gpt-6
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/mips/net/bpf_jit_comp32.c | 65 +++++++++++++++++++++++++++++-----
 arch/mips/net/bpf_jit_comp64.c | 55 +++++++++++++++++++++++-----
 2 files changed, 103 insertions(+), 17 deletions(-)

diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 6d603d9eeb1..8f1ab851863 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -190,20 +190,67 @@ static void emit_zext_ver(struct jit_context *ctx, const u8 dst[])
 	}
 }
 
-/* Register move operation (32-bit) */
+/* Sign-extend an 8- or 16-bit field into a native register. */
+static void emit_movsx_r(struct jit_context *ctx, u8 dst, u8 src, s16 off)
+{
+	int shift;
+
+	if (cpu_has_mips32r2 || cpu_has_mips32r6) {
+		if (off == 8)
+			emit(ctx, seb, dst, src);
+		else
+			emit(ctx, seh, dst, src);
+	} else {
+		shift = 32 - off;
+		emit(ctx, sll, dst, src, shift);
+		emit(ctx, sra, dst, dst, shift);
+	}
+}
+
+/* Register move operation (32-bit), optionally with sign extension */
 static void emit_mov_r32(struct jit_context *ctx, const u8 dst[],
-			 const u8 src[])
+			 const u8 src[], s16 off)
 {
-	emit_mov_r(ctx, lo(dst), lo(src));
+	switch (off) {
+	case 8:
+	case 16:
+		emit_movsx_r(ctx, lo(dst), lo(src), off);
+		break;
+	default:
+		/* off == 0 is MOV; the verifier rejects other offsets. */
+		emit_mov_r(ctx, lo(dst), lo(src));
+		break;
+	}
+	clobber_reg(ctx, lo(dst));
 	emit_zext_ver(ctx, dst);
 }
 
-/* Register move operation (64-bit) */
+/* Register move operation (64-bit), optionally with sign extension */
 static void emit_mov_r64(struct jit_context *ctx, const u8 dst[],
-			 const u8 src[])
+			 const u8 src[], s16 off)
 {
-	emit_mov_r(ctx, lo(dst), lo(src));
-	emit_mov_r(ctx, hi(dst), hi(src));
+	switch (off) {
+	case 8:
+	case 16:
+		emit_movsx_r(ctx, lo(dst), lo(src), off);
+		emit(ctx, sra, hi(dst), lo(dst), 31);
+		break;
+	case 32:
+		emit(ctx, move, lo(dst), lo(src));
+		emit(ctx, sra, hi(dst), lo(dst), 31);
+		break;
+	default:
+		/*
+		 * off == 0 is ordinary MOV. The verifier rejects other
+		 * offsets; defined exceptions require
+		 * bpf_jit_supports_percpu_insn() or bpf_jit_supports_arena(),
+		 * neither implemented by MIPS.
+		 */
+		emit_mov_r(ctx, lo(dst), lo(src));
+		emit_mov_r(ctx, hi(dst), hi(src));
+		break;
+	}
+	clobber_reg64(ctx, dst);
 }
 
 /* Load delay slot, if ISA mandates it */
@@ -1510,7 +1557,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			/* Special mov32 for zext */
 			emit_mov_i(ctx, hi(dst), 0);
 		} else {
-			emit_mov_r32(ctx, dst, src);
+			emit_mov_r32(ctx, dst, src, off);
 		}
 		break;
 	/* dst = -dst */
@@ -1579,7 +1626,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = src (64-bit) */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		emit_mov_r64(ctx, dst, src);
+		emit_mov_r64(ctx, dst, src, off);
 		break;
 	/* dst = -dst (64-bit) */
 	case BPF_ALU64 | BPF_NEG:
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 92df2eba139..4507841a922 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -120,17 +120,56 @@ static void emit_zext_ver(struct jit_context *ctx, u8 dst)
 		emit_zext(ctx, dst);
 }
 
-/* Register move operation (32-bit) */
-static void emit_mov_r32(struct jit_context *ctx, u8 dst, u8 src)
+/* Sign-extend an 8- or 16-bit field into a native register. */
+static void emit_movsx_r(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
-	emit_mov_r(ctx, dst, src);
+	/* seb/seh would need a sign-extended 32-bit source first. */
+	int shift = 32 - off;
+
+	/* dsll32 and dsra32 add 32 to the shift argument. */
+	emit(ctx, dsll32, dst, src, shift);
+	emit(ctx, dsra32, dst, dst, shift);
+}
+
+/* Register move operation (32-bit), optionally with sign extension */
+static void emit_mov_r32(struct jit_context *ctx, u8 dst, u8 src, s16 off)
+{
+	switch (off) {
+	case 8:
+	case 16:
+		emit_movsx_r(ctx, dst, src, off);
+		break;
+	default:
+		/* off == 0 is MOV; the verifier rejects other offsets. */
+		emit_mov_r(ctx, dst, src);
+		break;
+	}
+	clobber_reg(ctx, dst);
 	emit_zext_ver(ctx, dst);
 }
 
-/* Register move operation (64-bit) */
-static void emit_mov_r64(struct jit_context *ctx, u8 dst, u8 src)
+/* Register move operation (64-bit), optionally with sign extension */
+static void emit_mov_r64(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
-	emit_mov_r(ctx, dst, src);
+	switch (off) {
+	case 8:
+	case 16:
+		emit_movsx_r(ctx, dst, src, off);
+		break;
+	case 32:
+		emit_sext(ctx, dst, src);
+		break;
+	default:
+		/*
+		 * off == 0 is ordinary MOV. The verifier rejects other
+		 * offsets; defined exceptions require
+		 * bpf_jit_supports_percpu_insn() or bpf_jit_supports_arena(),
+		 * neither implemented by MIPS.
+		 */
+		emit_mov_r(ctx, dst, src);
+		break;
+	}
+	clobber_reg(ctx, dst);
 }
 
 /* dst = imm (64-bit) */
@@ -694,7 +733,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			/* Special mov32 for zext */
 			emit_zext(ctx, dst);
 		} else {
-			emit_mov_r32(ctx, dst, src);
+			emit_mov_r32(ctx, dst, src, off);
 		}
 		break;
 	/* dst = -dst */
@@ -779,7 +818,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = src (64-bit) */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		emit_mov_r64(ctx, dst, src);
+		emit_mov_r64(ctx, dst, src, off);
 		break;
 	/* dst = -dst (64-bit) */
 	case BPF_ALU64 | BPF_NEG:
