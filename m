Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708869;
	b=n3ts8I+1XJUP43IYTUdl1N52ZtpyOMTA3aaAqFri7c7EAxfvhU+yJOmZYC/o0a/K/Q5a
	 daZaO3s4iLri3HL9Xls0PdlfZ5h1UjHZ5nF6VIWW8Zf2kB2GEEYA86/96BmwTSbgT4HzX
	 r0Hm/KLKTJQ0HHbQ3GXG1r88CReGvEw62/NiBjhVZZQpJeogCsRFvVYCE3TFT0z6TaIUY
	 kzWDs4K6Fd4UpzXbAp22Oc7ZPlN3oSdtGo34WbGf0TSWhcr/PG7ZRVksUb4sA+okfyvEF
	 yU6EjcanUox40+Pj8LiE2e7hq71e/fPPYGAykK9bv4TZe1yQCXCNxFHasxr9TRWGWuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708869;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=Qnxtzk2ImrlemXDiyeHHiCh401z/ByOby8f46r4xupk=;
	b=Nydp/I3UVr3Tg7uu7J6+8UvXJf3U3g6JoZH032SwAgnRETQpMHhcA4hshWeU1orwjTbW
	 ozbUNajWY4Q6IXZ2UFgnnwZ44IBYiX5NujLfcXlwSXXEhH5MrGOQtfyezNL7S8BInj6Pa
	 P3HjbhFSwuQA/2wpclaieF8NNbZXeJ+Qx1wkZMCFE0+GUo6UGl8emcRt0p6mJ+4mtqdyv
	 ddVL2jZbzDwBLrsTQUIjPFfi9sExfiyH+P3BP2s93sHTq9tbC3pam0a2MsXk9NN/h46o7
	 TTMimOrZcxkU4SMifovj13e+Ar3i3V/B6LAKH21fwUWJ0bKjXKMYDgRLjIvBpJjwMwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=TpenASMu;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427D606A334
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5427D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=TpenASMu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Qnxtzk2ImrlemXDiyeHHiCh401z/ByOby8f46r4xupk=; b=TpenASMurNu/ADKmYyZuif6jNP
	kXQIrgrpvnTz5GtQbAtEoyicccLUmkYQeMxmHEt7Wdsf19gyCe1ZQu3wBjAFHN4HycN22EobIM9SG
	ndbFeld+Fx3/Wfx7ZEClKfO//FhpHAciBaAuw+jsTDAfnlXea/D9Rwt5D4/fZ8IxgwreXPxQrvR6F
	Wkq96fJrZCjL0uqYaWM9WvN4jdJj4g53nqqtNwIvAz5h3d9AiHgJxouiBdryK0gjkp3gpfMhaIWv3
	mLoiGBY7W0qLs0Ne059ezZqxW/i0H6H2tOyGT/0LLAzsUU3FE3AEKM5jXPCXYvPzRIctccwf3WQbE
	I3XrsbAg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc6-000MRn-0W;
	Tue, 03 Nov 2026 13:27:42 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 13/20] bpf, arm64: Materialize immediates with fewer instructions
Date: Tue,  3 Nov 2026 13:27:26 +0100
Message-ID: <20261103122733.1383002-14-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103122733.1383002-1-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

A 32-bit immediate with a zero or an all ones half took a movz or movn
and a movk even where the shifted movz or movn alone produces it, and a
bitmask immediate, a run of ones or a repeating pattern such as all but
the sign bit, took two moves where an orr with the zero register does it
in one, at the same single cycle of latency. A 64-bit immediate with a
16-bit chunk repeating, whose replication is a bitmask immediate, takes
that orr and a movk per other chunk, which is the form of the magic
numbers of the divisions by 3, 5, 15 and 17, among others, that a later
patch emits. Try these forms before falling back to the move pairs.

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
 arch/arm64/net/bpf_jit_comp.c | 77 ++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 606e788facd0..a327c90fe2c7 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -123,24 +123,49 @@ static inline void emit_u32_data(const u32 data, struct jit_ctx *ctx)
 	ctx->idx++;
 }
 
+/*
+ * A 32-bit immediate, sign extended for the 64-bit variant: a single movz
+ * or movn when one half is zero or all ones and the other half agrees with
+ * the sign the 64-bit variant extends, a single orr when it is a bitmask
+ * immediate, and the pair of a movz or movn with a movk otherwise.
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
 
@@ -168,10 +193,42 @@ static inline void emit_a64_mov_i64(const int reg, const u64 val,
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
+	/* A bitmask immediate in one orr rather than two or more moves */
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

