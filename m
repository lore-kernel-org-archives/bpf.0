Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166102;
	b=ssDty2vd7qFlsV/Z1477E+DDsn05PkQi7V5mhzoYZBVjYXnCiPQxpPLDsO8fb0oD8z7R
	 gSgtqumqe4NJHZAfkdTGKa8nLw37WE899IkU+IP8NHI1zgwH+ebKAxbc3xoqV2HxXBzYX
	 JlEs8ShuxJrycST204t3QDmjzRNfGFUdWTgV6of8eUFPpfoLm2r8hsrThBlpotzSYBLNE
	 zQuiVUJqSlBVzVmTxoTpSPqMjmhAIEM9cLxoDHLOKbsjmlzreNjXn3sgc2f30i85AlVb5
	 wLxnda+yod1W6H1k1jcsW5ymZ//6jhz+cJSh05Y0cWX/C9JVF2dteZdbM4GJHQsZyZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166102;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=pTnDMGCMrZKR1B9ZQq3EXtLdxGpgUidHEc3HuTP2vKo=;
	b=UPjknhjMyzoPH8zf3Te4GS2eectyD3zrbAN9qbxstKuEeVudGfTqtBdISH22nlmZHo+F
	 VlxWno0i9cfxbiMXVubUo9+S9XraGdfp60dWHqDFDxOxq+EE3YdNmVpkqTCric9sMdMdH
	 qn9wvACj9p585v+oMxcw8q9Yrv3e34V48LgKcKo2dEkL5Y824eG+VMXiQfTyWbhJ+b2jB
	 kuzP+DJnSNIOE4XLJ1VLq1oqIfx8N7ATXQyY3GMYZav9pyZo8YSRpqy04WcG5gQ3p8EtT
	 +sAvpKxBRMYcTKphOKugxJs2r/smGe+qFYZ0+ra7OYy7bFhbiXkGJ6BDwABxbQKUzew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=DlXSb5JG;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D011606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D011606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=DlXSb5JG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pTnDMGCMrZKR1B9ZQq3EXtLdxGpgUidHEc3HuTP2vKo=; b=DlXSb5JGFBfJfD3NeYCx0b6EBl
	iRHSE53L6LmYgG0ARlEKhpI/QPPH4eBShTI6Qi/CZXjG9z5zhbGbEXibEC3rHrHSj+wKeEpZjAdTT
	PcJzAt4KBNLdr4shJNuucrvcDA7BBSk3jRZjGRD6o60VixLGUD/ORqg/sLygSaQMrVYygBiE0yuR1
	ys+yPLyrXk4TfpynJx03GckVm2ae0w+YXNJlkqPjLBjLcUS1QnLeKl/8vqSg3KYW9RaHNS+c3Q+rX
	AFlpXhDkd91n1Hn+/YZnIgb+bq6ZcgkqaDf/5Ou4p5SIdHoJ99Q8mp5ue3Dda56fAaeBAIGQAha1b
	uHGWhQfQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Yu-000Prh-15;
	Sun, 08 Nov 2026 20:28:20 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 18/24] bpf, arm64: Shorten the tail call sequence
Date: Sun,  8 Nov 2026 20:26:44 +0100
Message-ID: <5f7973c448f56ec92f8984076ada417ca06615d5.1794165614.git.daniel@iogearbox.net>
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

The tail call sequence moved the offsets of max_entries, ptrs and
bpf_func, and the tail call limit, into a temporary first, although
they all fit the immediate forms. It also zero extended and shifted the
index in separate instructions before the load. Use the immediate forms
and a register offset load with UXTW #3 instead.

That saves six instructions per tail call. A64_LDR64() loses its last
user and is removed.

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
 arch/arm64/net/bpf_jit.h      |  3 ++-
 arch/arm64/net/bpf_jit_comp.c | 27 +++++++++++++++------------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index 882404b884e1..16c690c6cae9 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -63,7 +63,8 @@
 #define A64_LS_REG(Rt, Rn, Rm, size, type) \
 	A64_LS_REG_EXT(Rt, Rn, Rm, UXTX, 0, size, type)
 #define A64_LDR32(Wt, Xn, Xm) A64_LS_REG(Wt, Xn, Xm, 32, LOAD)
-#define A64_LDR64(Xt, Xn, Xm) A64_LS_REG(Xt, Xn, Xm, 64, LOAD)
+/* Xt = *(Xn + ((u32)Wm << 3)) */
+#define A64_LDR64_UXTW3(Xt, Xn, Wm) A64_LS_REG_EXT(Xt, Xn, Wm, UXTW, 3, 64, LOAD)
 
 /* Load/store register (immediate offset) */
 #define A64_LS_IMM(Rt, Rn, imm, size, type) \
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 62d2f70cc412..a79c401c5262 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -909,13 +909,20 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
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
+	/*
+	 * if ((u32)index >= array->map.max_entries)
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
@@ -924,9 +931,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	 * if ((*tail_call_cnt_ptr) >= MAX_TAIL_CALL_CNT)
 	 *     goto out;
 	 */
-	emit_a64_mov_i64(tmp, MAX_TAIL_CALL_CNT, ctx);
 	emit(A64_LDR64I(tcc, ptr, 0), ctx);
-	emit(A64_CMP(1, tcc, tmp), ctx);
+	emit(A64_CMP_I(1, tcc, MAX_TAIL_CALL_CNT), ctx);
 	branch2 = ctx->image + ctx->idx;
 	emit(A64_NOP, ctx);
 
@@ -938,10 +944,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
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
 
@@ -959,8 +963,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 
 	/* goto *(prog->bpf_func + prologue_offset); */
 	off = offsetof(struct bpf_prog, bpf_func);
-	emit_a64_mov_i64(tmp, off, ctx);
-	emit(A64_LDR64(tmp, prg, tmp), ctx);
+	emit(A64_LDR64I(tmp, prg, off), ctx);
 	emit(A64_ADD_I(1, tmp, tmp, sizeof(u32) * PROLOGUE_OFFSET), ctx);
 	emit(A64_BR(tmp), ctx);
 
-- 
2.43.0

