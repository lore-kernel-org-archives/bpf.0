Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125495;
	b=N3LrmRCHkFJBsCbsK+qFi1AxSK+tIR7ZT43T/UrowFKJbSMKYtBPsh8q+uVadWMMloS0
	 AtgkWLrvUA8aZRFZsJQV0H7rvYX+EgEpdwGJCRso56thdX9UebXMLQ5pfAQZy4WIhXYiW
	 Md4wR35Ci4+tB0cUupn907vxS7lugYsu000KoffAIdg6diEnlHbcE4bYGMo7mJZqgu4OT
	 0LGZ8f4YjlutUKg9jVTIO68aOpYS0OwK655ezLyOxXRfARHYWU++ai4+AMnwhDUzkumhH
	 9Zl4ZYSg7I+MJyT+15lKslrbbBZyLau6z2XP7aCcyEh7nHH+cXPvxx4XR1HHASPQLuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125495;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=HfbgDfRq134wFFT3rhMzzpUyQYCIi8oAOpRqk/4/Ogk=;
	b=m/1UkwEIJspIOlvcdp7wjMISWrxWr7wcTeTY3XKj0TxTo7kwJfpMSBCS88xA3vJu3OA+
	 /tnGreKiNDMfErjQ7cFbKffxM48XMhjt4YSKW3K4zJEDgYDqdH8VXMM2KS19LDiq7QfFg
	 B5ibbV6vToDRzNltX5mqcdbjffPtAMy4+ohIhfsWgABaDN7knPjMkxqGw9yHO5ZN/zU17
	 ZjXF5rEqNRwWJowE70YAnZnsXhw0vLT6aWm/lhO9tQCXihN3nht62p1JhvZTHq0qBPeyG
	 YW/+vXq/pIfoPj2M/8q2Af4KUZxZU4NPRyMxjA+eXKFWpTcdLTocQAGPzPJrR3HTG+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=GdWT2Fal;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F9606A334
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D3F9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=GdWT2Fal
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=HfbgDfRq134wFFT3rhMzzpUyQYCIi8oAOpRqk/4/Ogk=; b=GdWT2FalyqIaIC70OvzNSFEfjs
	W5BHYd+JoLwBhGKYu7hlwaoMxynIVBOvDWY2mzispXR+szFyuoLYQhm/BS9flqNeUn4waHTaGOmGO
	g+5mFzmmxBvx4QduCkv+O0L9u1LchDNzsv579WFG42AGvwoZu6mP+phL2n68g5kFJy1F7PajvzHsG
	gv76FGKU1RpOoOO+eZMRMyw7ijY0/RgCbLHQgzQlylrC0Y/wOYizxAajukWPRSQPjZVrwL7pYQ3H/
	xaegXMQ01Kk3AF8Bl8hB3BB38xd4z91h57D63sUehn8Ou/9mqrQHKdqDJbYTJYLX83SopHC/2w5DP
	LyHfKE8A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqv-000Im3-2H;
	Tue, 27 Oct 2026 19:24:53 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 13/21] bpf, arm64: Materialize immediates with fewer instructions
Date: Tue, 27 Oct 2026 19:24:37 +0100
Message-ID: <20261027182445.1156335-14-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182445.1156335-1-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

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
index 90cbde8f96b6..d1cea58ca8ee 100644
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
 
@@ -157,10 +182,42 @@ static inline void emit_a64_mov_i64(const int reg, const u64 val,
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

