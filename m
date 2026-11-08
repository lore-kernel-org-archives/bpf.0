Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166098;
	b=FhHSFegFO8uapulpyZ7XrckSaI/ZnNf6HUKvpgD/pnoK+sePs/DTwQ+e16GwC6ItMadX
	 KExwrRQ12E+veqE/pdLg3JcLnqSFLyVXWe/4Hqdi2EpW3VMNAj/6QUFZJnHFDTmPE7KXk
	 FasqGhzPWTT/2lugETg2DyBnqf+QaVmlFgK/NcWICHeLUdGTryy4IIgYa7vF9UJIUl158
	 AuXyxwh3cgvNttI8sJmUZYuFKWFIGol0GFtXwZP5F3JXpnTcdvReej3KNVz4tTvdJgOaY
	 1EeruC83/qZ8Gl83wYAyjL2zH1NhdlKqu4Ccm3xLu6EGTktQl35a9zn1J4l+b3ceF9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166098;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=UZHz/YYF40ysOlO1P8FkK9mGRHSPy23ea68RgH6tOkk=;
	b=rVDI5e4LCmGV3PowdbAKw44zLYkI9rFaWm1XCi8lZuBRiCfvyYEra+9xF8NT+cdxpz3b
	 P6xHioyP2cMi18TYpKnxjY+D2B9bmnqLljzxroEYro3L3VeyGSqlmb2k63EfVOEz4aqyj
	 OOHcBrUN7cbbAIyC77r1WDjGGFunIiMwe4IAWwjVbFAJwOiWjl+VmxF/EiTgtSQiOBTrT
	 4rw39tTOfPUZi321cWEKVOF5ZcU3eLrR7aq7Rjnst4hBeIcsHiXKYQUXLVewg1v5DKiTI
	 K/lboCs2eUZuqmFzR+xU3mDKxmcbIwi3ND48D2mLGPdsA7s3Z1YaBCCcbqDkNzyXEKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=egzg3BvI;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5C606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AD5C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=egzg3BvI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=UZHz/YYF40ysOlO1P8FkK9mGRHSPy23ea68RgH6tOkk=; b=egzg3BvINTwo2whysWzG07HM7f
	VMubJK/kS8X04Db268lArTVGfN38U0e4d6yJ3CrsLhF7lIWMyL521qDhpfsTm4obAWDnTG4JaQomc
	EyEn+nmCVMQWsh3g2e5z79tmJgFDYlLypWWNXBiXpB2rtMP0xBUHEwhOWP72Rg3PH/Co97sb8Ypwi
	V1XfTjU+F70mUVGw2Z0iBrzGFW0DVKozofxw0h0PDETQMBvy0708rb/+b+sBwjQP/zdvaq5smWHW2
	bNAup/z/witCRBOBx80fATLa9taGvbKCX+UVcUC6PkAzq3fFCsYIq+p9/9jg7fXofEKgdhQNazfc+
	7ukjy9rA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Yq-000PrN-06;
	Sun, 08 Nov 2026 20:28:16 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 17/24] bpf, arm64: Materialize immediates with fewer instructions
Date: Sun,  8 Nov 2026 20:26:43 +0100
Message-ID: <0da11680b3d4524536f633f2e33d847f7db7035d.1794165614.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

A 32-bit immediate with a zero or all-ones low half often took two
moves where a single shifted movz or movn does. A bitmask immediate,
32 or 64 bits, took two or more moves where a single orr does.

A 64-bit immediate with a repeated 16-bit chunk now takes one orr of
that chunk replicated, if that is a bitmask immediate, plus a movk for
each other chunk. The verifier's magic numbers for dividing by 3, 5, 15
and 17 have that form.

Before/after for w1 = 0x10000, r1 = 0x7fffffff, r1 = 0xffffffff00000000 ll
and r1 = 0xcccccccccccccccd ll:

  52800000  mov w0, #0x0
  72a00020  movk w0, #0x1, lsl #16
  52a00020  mov w0, #0x10000

  d29fffe0  mov x0, #0xffff
  f2afffe0  movk x0, #0x7fff, lsl #16
  b2407be0  mov x0, #0x7fffffff

  d2ffffe0  mov x0, #0xffff000000000000
  f2dfffe0  movk x0, #0xffff, lsl #32
  b2607fe0  mov x0, #0xffffffff00000000

  d2f99980  mov x0, #0xcccc000000000000
  f2d99980  movk x0, #0xcccc, lsl #32
  f2b99980  movk x0, #0xcccc, lsl #16
  f29999a0  movk x0, #0xcccd
  b202e7e0  mov x0, #0xcccccccccccccccc
  f29999a0  movk x0, #0xcccd

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 75 ++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 5a88740d9d0c..62d2f70cc412 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -125,24 +125,47 @@ static inline void emit_u32_data(const u32 data, struct jit_ctx *ctx)
 	ctx->idx++;
 }
 
+/*
+ * A 32-bit immediate, sign extended for the 64-bit variant: one movz, movn or
+ * orr where one encodes it, else a movz or movn and a movk.
+ */
 static inline void emit_a64_mov_i(const int is64, const int reg,
 				  const s32 val, struct jit_ctx *ctx)
 {
 	u16 hi = val >> 16;
 	u16 lo = val & 0xffff;
+	u32 insn;
+
+	if (hi == 0xffff) {
+		emit(A64_MOVN(is64, reg, (u16)~lo, 0), ctx);
+		return;
+	}
+	if (!hi) {
+		emit(A64_MOVZ(is64, reg, lo, 0), ctx);
+		return;
+	}
+	/* The 64-bit variant has the upper half set or clear with the sign */
+	if (!lo && (!is64 || !(hi & 0x8000))) {
+		emit(A64_MOVZ(is64, reg, hi, 16), ctx);
+		return;
+	}
+	if (lo == 0xffff && (!is64 || (hi & 0x8000))) {
+		emit(A64_MOVN(is64, reg, (u16)~hi, 16), ctx);
+		return;
+	}
+
+	insn = A64_ORR_I(is64, reg, A64_ZR, val);
+	if (insn != AARCH64_BREAK_FAULT) {
+		emit(insn, ctx);
+		return;
+	}
 
 	if (hi & 0x8000) {
-		if (hi == 0xffff) {
-			emit(A64_MOVN(is64, reg, (u16)~lo, 0), ctx);
-		} else {
-			emit(A64_MOVN(is64, reg, (u16)~hi, 16), ctx);
-			if (lo != 0xffff)
-				emit(A64_MOVK(is64, reg, lo, 0), ctx);
-		}
+		emit(A64_MOVN(is64, reg, (u16)~hi, 16), ctx);
+		emit(A64_MOVK(is64, reg, lo, 0), ctx);
 	} else {
 		emit(A64_MOVZ(is64, reg, lo, 0), ctx);
-		if (hi)
-			emit(A64_MOVK(is64, reg, hi, 16), ctx);
+		emit(A64_MOVK(is64, reg, hi, 16), ctx);
 	}
 }
 
@@ -170,10 +193,42 @@ static inline void emit_a64_mov_i64(const int reg, const u64 val,
 {
 	u64 nrm_tmp = val, rev_tmp = ~val;
 	bool inverse;
-	int shift;
+	u32 insn;
+	int shift, blocks;
 
 	if (!(nrm_tmp >> 32))
 		return emit_a64_mov_i(0, reg, (u32)val, ctx);
+	if ((s64)(s32)val == (s64)val)
+		return emit_a64_mov_i(1, reg, (s32)val, ctx);
+
+	/* A bitmask immediate in a single orr */
+	insn = A64_ORR_I(1, reg, A64_ZR, val);
+	if (insn != AARCH64_BREAK_FAULT)
+		return emit(insn, ctx);
+
+	/*
+	 * A 16-bit chunk occurring more than once whose replication is a
+	 * bitmask immediate comes from one orr, with a movk for each of
+	 * the other chunks, when that beats the moves of the chunks.
+	 */
+	blocks = min(i64_i16_blocks(nrm_tmp, true), i64_i16_blocks(nrm_tmp, false));
+	for (shift = 0; shift < 64; shift += 16) {
+		u16 chunk = val >> shift;
+		int i, n = 0;
+
+		for (i = 0; i < 64; i += 16)
+			n += (u16)(val >> i) == chunk;
+		if (n < 2 || 1 + 4 - n >= blocks)
+			continue;
+		insn = A64_ORR_I(1, reg, A64_ZR, chunk * 0x0001000100010001ULL);
+		if (insn == AARCH64_BREAK_FAULT)
+			continue;
+		emit(insn, ctx);
+		for (i = 0; i < 64; i += 16)
+			if ((u16)(val >> i) != chunk)
+				emit(A64_MOVK(1, reg, (u16)(val >> i), i), ctx);
+		return;
+	}
 
 	inverse = i64_i16_blocks(nrm_tmp, true) < i64_i16_blocks(nrm_tmp, false);
 	shift = max(round_down((inverse ? (fls64(rev_tmp) - 1) :
-- 
2.43.0

