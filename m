Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708866;
	b=Tz79KKOYKgUHAouGWaNxLBm5ISMPej3SNQq8U4Oe86diYGvqxw/+TYcc2uQUnMZo2u5V
	 650epe8w/YHmhv8UtzX5y/khBNBhGwZFPv1BfaM8L2kXPkU7d5EO4Grd1HLOmA6pL+gXX
	 WDk1b4+nHpqfGh8vzHevmeREBoKaDDj0IjUf4qQbhLmloRSneL660VFh+dpCZlhOmd4V4
	 7AuKSFq72pr1t69kWrr4yx4carZknZKczMzP5D2JfXhoUV3VhL44lF2E1tYkeqVKGemLZ
	 8LRhknBj6KvteCsmhPpJMaCzEMj0pQiLlTjlA8ljI7WIevEf7opyzjprH7ZjwQMLSMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708866;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=MuXA1ohJKLQqa/WxQWWqzuM/rgJpedWr3Yq4M6+2RoY=;
	b=xH77dvnCFwshjsFzK6MXuUryMvWPlnUqyDfER+t64LH8qzxEZOsghqAjb/QuQzW0C6mc
	 4K8sk9bFHMI3DbPcVLiNw4KucIksLLK4bH8KL4vjgHoR2QsLed5echVblmoJTObUqI9Rb
	 jrMNUYMlOUD+4a/oAiCR2eAiRbXdcDOYsIq3Lozf1vebExt6EDs+cMhhlqxTUTxWdJoeq
	 qriqVNDI/Mz9pG/yp45zpuhUnOKjR4lOFBz+1+yTbjBgJnZQ5xOVjT/VJIN3eq64jCh1u
	 EDFngmrd0uL8UFmdBUL2p5qJjsH3K2d57slojxf617up2mvGaenPJuIzJTyhhoNCYYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b="k7hTlH/N";
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2D606A332
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D2D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=k7hTlH/N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MuXA1ohJKLQqa/WxQWWqzuM/rgJpedWr3Yq4M6+2RoY=; b=k7hTlH/NUhD5Zmz76aetcGthz4
	lGLEXLdEXDSrCPsQ/L9JBeFFB16z9LprNV1iyWdyAqbt1zzeyIr7rcoTJwJJh0hM32ksU8ENT9Jxd
	4sKlCyhCCitEKlGXLPfbkNCJ1/fdhMzQ9FrB/WGcP8bPy2MoeRiMVyGnE063eGtLvnTZoWh4HyQGl
	XLE2LUh2iH0xqJD8XS6UML0WXLaFKY0XDCw1l+hPITuq9m/2qR14cSH5Bxxy9F91fE2qvvlaTegeu
	809nz6xiqIKyULIuPgUiMam6Mz8HUhfXtcFw22It0xZezCySkHFfHvFmdzJ2uPs+qGtgBpnHqlrbb
	PsIPWWAA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc6-000MRs-2D;
	Tue, 03 Nov 2026 13:27:42 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 14/20] bpf, arm64: Shorten the tail call sequence
Date: Tue,  3 Nov 2026 13:27:27 +0100
Message-ID: <20261103122733.1383002-15-daniel@iogearbox.net>
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

The tail call moved the offsets of max_entries and ptrs of the array and
of bpf_func of the prog into a temporary before using them, and the tail
call limit before its compare, although all of them fit the immediate
forms, and it zero extended the index before shifting it and loading the
prog through the sum. Use the immediate forms and the register offset
load, which zero extends and scales the index in one, six instructions
fewer for every tail call.

Before/after for the checks and the lookup of a tail call:

  5280088a  mov w10, #0x44
  b86a682a  ldr w10, [x1, x10]
  2a0203e2  mov w2, w2
  6b0a005f  cmp w2, w10
  54000282  b.hs ...
  5280042a  mov w10, #0x21
  f940034c  ldr x12, [x26]
  eb0a019f  cmp x12, x10
  54000202  b.hs ...
  9100058c  add x12, x12, #0x1
  5280440a  mov w10, #0x220
  8b0a002a  add x10, x1, x10
  d37df04b  lsl x11, x2, #3
  f86b694b  ldr x11, [x10, x11]
  b400014b  cbz x11, ...

  b940442a  ldr w10, [x1, #68]
  6b0a005f  cmp w2, w10
  54000202  b.hs ...
  f940034c  ldr x12, [x26]
  f100859f  cmp x12, #0x21
  540001a2  b.hs ...
  9100058c  add x12, x12, #0x1
  9108802a  add x10, x1, #0x220
  f862594b  ldr x11, [x10, w2, uxtw #3]
  b400012b  cbz x11, ...

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit.h      |  2 ++
 arch/arm64/net/bpf_jit_comp.c | 26 ++++++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index b5e26cb1e753..5d48a365b43c 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -77,6 +77,8 @@
 #define A64_LDRSW(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 32, SIGNED_LOAD)
 #define A64_STR64(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 64, STORE)
 #define A64_LDR64(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 64, LOAD)
+/* Xt = *(Xn + ((u32)Wm << 3)) */
+#define A64_LDR64_UXTW3(Xt, Xn, Wm) A64_LS_REG_EXT(Xt, Xn, Wm, UXTW, true, 64, LOAD)
 
 /* Load/store register (immediate offset) */
 #define A64_LS_IMM(Rt, Rn, imm, size, type) \
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a327c90fe2c7..bc1ec8b179b2 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -905,13 +905,19 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	__le32 *branch2 = NULL;
 	__le32 *branch3 = NULL;
 
-	/* if (index >= array->map.max_entries)
+	/* The struct offsets fit the immediate forms, the count fits cmp */
+	BUILD_BUG_ON(offsetof(struct bpf_array, map.max_entries) % 4 ||
+		     offsetof(struct bpf_array, map.max_entries) > 0xfff * 4);
+	BUILD_BUG_ON(offsetof(struct bpf_array, ptrs) > 0xfff);
+	BUILD_BUG_ON(offsetof(struct bpf_prog, bpf_func) % 8 ||
+		     offsetof(struct bpf_prog, bpf_func) > 0xfff * 8);
+	BUILD_BUG_ON(MAX_TAIL_CALL_CNT > 0xfff);
+
+	/* if ((u32)index >= array->map.max_entries)
 	 *     goto out;
 	 */
 	off = offsetof(struct bpf_array, map.max_entries);
-	emit_a64_mov_i64(tmp, off, ctx);
-	emit(A64_LDR32(tmp, r2, tmp), ctx);
-	emit(A64_MOV(0, r3, r3), ctx);
+	emit(A64_LDR32I(tmp, r2, off), ctx);
 	emit(A64_CMP(0, r3, tmp), ctx);
 	branch1 = ctx->image + ctx->idx;
 	emit(A64_NOP, ctx);
@@ -920,9 +926,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 * if ((*tail_call_cnt_ptr) >= MAX_TAIL_CALL_CNT)
 	 *     goto out;
 	 */
-	emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT, ctx);
 	emit(A64_LDR64I(tcc, ptr, 0), ctx);
-	emit(A64_CMP(1, tcc, tmp), ctx);
+	emit(A64_CMP_I(1, tcc, MAX_TAIL_CALL_CNT), ctx);
 	branch2 = ctx->image + ctx->idx;
 	emit(A64_NOP, ctx);
 
@@ -934,10 +939,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 *     goto out;
 	 */
 	off = offsetof(struct bpf_array, ptrs);
-	emit_a64_mov_i64(tmp, off, ctx);
-	emit(A64_ADD(1, tmp, r2, tmp), ctx);
-	emit(A64_LSL(1, prg, r3, 3), ctx);
-	emit(A64_LDR64(prg, tmp, prg), ctx);
+	emit(A64_ADD_I(1, tmp, r2, off), ctx);
+	emit(A64_LDR64_UXTW3(prg, tmp, r3), ctx);
 	branch3 = ctx->image + ctx->idx;
 	emit(A64_NOP, ctx);
 
@@ -955,8 +958,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 
 	/* goto *(prog->bpf_func + prologue_offset); */
 	off = offsetof(struct bpf_prog, bpf_func);
-	emit_a64_mov_i64(tmp, off, ctx);
-	emit(A64_LDR64(tmp, prg, tmp), ctx);
+	emit(A64_LDR64I(tmp, prg, off), ctx);
 	emit(A64_ADD_I(1, tmp, tmp, sizeof(u32) * PROLOGUE_OFFSET), ctx);
 	emit(A64_BR(tmp), ctx);
 
-- 
2.43.0

