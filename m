Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125495;
	b=OwIUEixQ532rBQhHmefciYF9MSefnzqCGF6ERnpj26Rzej2jW7sj5VXvPhfbZ7wGfptK
	 RWP49c/NHx39yW+KWajeTfMvfDA0lytVFqPG8rmm7LOq6NmZIrB5+Z7034TF9sGZGdhH6
	 Xq4oTLD7E8Csq+hQRH7oADnaTUYRLPspeLf+WBsCSb7WxgPQLN/xxsnUimHGKqoDgA8K0
	 +rj5QMbAcmvxvCzBsnrUQbCh00uNEEgcWlN6NfAG5rF/AZuq1NI69opOWKg4/Q5ofGiSJ
	 GC437RBAcQobBtOykNsiiehVd62Tf2WgbuMwKCx2CkEc+Jp7wFYK0HqSJP6Fb7QB4Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125495;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=LSA9AjROYme1mlG8ziAcFvIxL9ANXFP8u30TOeLmOQk=;
	b=GWIqBiFx8n1M3TJsQ8hIX9hF8MpfliOZoXJX8ufdCCL8GOHspUEAFSu26EAixYn1P2ug
	 uIxksVqgFK4KKNKd5XleC5dIxyIwNLwaDqPr3a8l6qO4E6lUzJLz0NeBDNE1a4x8Hc0/A
	 FOZRmm8cZ8NspTH4IXSQy3+D2MZAnHJF/9WVuTVf2/iUvZg82Bac0k/KasqTfTR1rZl0C
	 RQUu7QHIIETB611JQ7YuatoKpJkzdIr+Trse71P/5dOYstxUjYCRaL5UhVMIVDuPOPw9Y
	 wInZ1Q+btOqYMCdyO+ZiHudYIORXI0PL2SPgNc3MsheRIfiC14h4iuk4xgYfAjU9Dvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=bbjtCjfT;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A47606A339
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93A47606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=bbjtCjfT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=LSA9AjROYme1mlG8ziAcFvIxL9ANXFP8u30TOeLmOQk=; b=bbjtCjfTc1LwORKhQcEvjdcmZn
	9RfgbrMLrokdyYUWqI+dLmLJkf8iPp4TlXHt2P6zoSuIYv44sfAdXBFGUUMG7/zUQ8GaUZp/hgrPX
	ZMqsuKHEO6nBKEZ2z1B2mdipzCDeCaDlgZR6jdCiz9H9hC1PjqJVCzW2SQFW3vi4YAXuz5glbU8jX
	uliDugNfUWqBTyX7/Yw+kHYJi6GYLu2bXBqghigEnlrT3y+0CO5lt3pjqzt3vCGfmz3HBiAsjNEwf
	YdtGv1FKtxWA4ELGcWB0cESh/pcTdUJkvhjFXDeWAFPXP+lLv3IHruRcQn2jUI2YRwMwrHCoTAePX
	lffprHqA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqw-000ImA-0d;
	Tue, 27 Oct 2026 19:24:54 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 14/21] bpf, arm64: Shorten the tail call sequence
Date: Tue, 27 Oct 2026 19:24:38 +0100
Message-ID: <20261027182445.1156335-15-daniel@iogearbox.net>
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

The tail call moved the offsets of max_entries and ptrs of the array and
of bpf_func of the prog into a temporary before using them, and the tail
call limit before its compare, although all of them fit the immediate
forms, and it zero extended the index before shifting it. Use the
immediate forms and a ubfiz, which zero extends and scales the index in
one, five instructions fewer for every tail call.

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
  54000222  b.hs ...
  f940034c  ldr x12, [x26]
  f100859f  cmp x12, #0x21
  540001c2  b.hs ...
  9100058c  add x12, x12, #0x1
  9108802a  add x10, x1, #0x220
  d37d7c4b  ubfiz x11, x2, #3, #32
  f86b694b  ldr x11, [x10, x11]
  b400012b  cbz x11, ...

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit.h      |  3 +++
 arch/arm64/net/bpf_jit_comp.c | 23 +++++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index fa2a57e6d90d..a6dfff8c645f 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -220,6 +220,9 @@
 /* Zero extend */
 #define A64_UXTH(sf, Rd, Rn) A64_UBFM(sf, Rd, Rn, 0, 15)
 #define A64_UXTW(sf, Rd, Rn) A64_UBFM(sf, Rd, Rn, 0, 31)
+/* Rd = (Rn & (2^width - 1)) << lsb */
+#define A64_UBFIZ(sf, Rd, Rn, lsb, width) \
+	A64_UBFM(sf, Rd, Rn, (unsigned int)-(lsb) % ((sf) ? 64 : 32), (width) - 1)
 
 /* Sign extend */
 #define A64_SXTB(sf, Rd, Rn) A64_SBFM(sf, Rd, Rn, 0, 7)
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index d1cea58ca8ee..b21e744dab6a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -894,13 +894,19 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	__le32 *branch2 = NULL;
 	__le32 *branch3 = NULL;
 
+	/* The struct offsets fit the immediate forms, the count fits cmp */
+	BUILD_BUG_ON(offsetof(struct bpf_array, map.max_entries) % 4 ||
+		     offsetof(struct bpf_array, map.max_entries) > 0xfff * 4);
+	BUILD_BUG_ON(offsetof(struct bpf_array, ptrs) > 0xfff);
+	BUILD_BUG_ON(offsetof(struct bpf_prog, bpf_func) % 8 ||
+		     offsetof(struct bpf_prog, bpf_func) > 0xfff * 8);
+	BUILD_BUG_ON(MAX_TAIL_CALL_CNT > 0xfff);
+
 	/* if (index >= array->map.max_entries)
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
@@ -909,9 +915,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 * if ((*tail_call_cnt_ptr) >= MAX_TAIL_CALL_CNT)
 	 *     goto out;
 	 */
-	emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT, ctx);
 	emit(A64_LDR64I(tcc, ptr, 0), ctx);
-	emit(A64_CMP(1, tcc, tmp), ctx);
+	emit(A64_CMP_I(1, tcc, MAX_TAIL_CALL_CNT), ctx);
 	branch2 = ctx->image + ctx->idx;
 	emit(A64_NOP, ctx);
 
@@ -923,9 +928,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 *     goto out;
 	 */
 	off = offsetof(struct bpf_array, ptrs);
-	emit_a64_mov_i64(tmp, off, ctx);
-	emit(A64_ADD(1, tmp, r2, tmp), ctx);
-	emit(A64_LSL(1, prg, r3, 3), ctx);
+	emit(A64_ADD_I(1, tmp, r2, off), ctx);
+	emit(A64_UBFIZ(1, prg, r3, 3, 32), ctx);
 	emit(A64_LDR64(prg, tmp, prg), ctx);
 	branch3 = ctx->image + ctx->idx;
 	emit(A64_NOP, ctx);
@@ -944,8 +948,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 
 	/* goto *(prog->bpf_func + prologue_offset); */
 	off = offsetof(struct bpf_prog, bpf_func);
-	emit_a64_mov_i64(tmp, off, ctx);
-	emit(A64_LDR64(tmp, prg, tmp), ctx);
+	emit(A64_LDR64I(tmp, prg, off), ctx);
 	emit(A64_ADD_I(1, tmp, tmp, sizeof(u32) * PROLOGUE_OFFSET), ctx);
 	emit(A64_BR(tmp), ctx);
 
-- 
2.43.0

