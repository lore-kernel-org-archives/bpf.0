Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708869;
	b=GQX1CmpBZTIMwrbs6/8cuJ7lZjxeQp83vwEk4WoRse0eCrWX6+8CWIZSlw9C1JMBzdy9
	 PkaypWCSCzURwl2mo9JLgG3Mux79GcCt4wUzYXWLrD4TE0j9C7tOKh2DuMd5fjAg4QWCd
	 o8iAWw8MuFC6V5zabeps+2DzXXw0pnYhewLJsvXGMHaTPxwrXExQk7Q4CaKT4c/BoA1+A
	 68hJiAK/M0JgGKRL+X4+SDz24iL8edsaV9qI+OdupYmiwCPl5r5k3N+EDef32nFO37SQT
	 pVhR0orOxptE/5pMoLKokWTnqU3vMoJP1RmYBE7jTqRONACtVC7eaXGphsZVey9uzuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708869;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=ZNmfE7/tODJY2myHab+mHI6MlDALaaFgzpv4MQXfWBo=;
	b=dRraoc10KsLHH/7nmh8MYXEqTOmxOFiLTq1d1tCjZkdN/qTNaD4aQQKDUAZSJr3dkP/Y
	 MhQFpEDhbbWWliyENS6rBMEu4j5DITmES8VQSaE1e+ZUdU9tZdEdcjZO0Zo5O2W6CkrLF
	 7ctZDun7vVrcenBnnbdzQfWEO78/0Jkfx7YESIc0wSnZ4Nkm2u4wPYAGjStrH28CvedlC
	 h5nx6H9exRvSRoDVLVpQU9WXrGj46A/90NfaknFWIQ30qrtlY2mlt1aF5BiJsf4H7x1mN
	 RNHXSrOrniR42zY3uSGXnDRttWtOOEhKJaIhI/D8GSzwZdTiyyBamfnbusObGauOGDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=nmn7M93b;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA4606A32F
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51DA4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=nmn7M93b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ZNmfE7/tODJY2myHab+mHI6MlDALaaFgzpv4MQXfWBo=; b=nmn7M93bqN02qsFxe0twtgMXhb
	pkICmnD3866TIjZesChsJAYs6s8cQ3nfgy65S1sPbzLZRJEwT8XMMuJv611rYaDptagp99eggD9T7
	P+Ditsl1/opwwAdTEulD19FkMiyNjMNrSQNb61doiqPckIkQP1BpGVhIWdwTpq4ecIEVHlrwWBvnb
	/FoFDy8dhcY7T1p4tcBZRIqpW1rr94PB3/6YtOhekBxsKRZqaj5mBZ4he+PmmAzsN8KwIgxH16ji/
	zUWZIjm59eP0HeJ0/68sqlC4RhNd2al8nzM6jTawWrKEQ/ndVWlspONbPNmz5PAoOIs2QpPuIRztX
	8goJhwuw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc5-000MRh-26;
	Tue, 03 Nov 2026 13:27:41 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 12/20] bpf, arm64: Adjust compares with unencodable immediates by one
Date: Tue,  3 Nov 2026 13:27:25 +0100
Message-ID: <20261103122733.1383002-13-daniel@iogearbox.net>
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

cmp and cmn take a 12-bit immediate, optionally shifted by 12, so a
compare against any other constant moved the constant into a temporary
first. LLVM canonicalizes x <= C to x < C + 1 and x >= C to x > C - 1,
so compares against a power of two or a mask, such as a length against
a page size or a 16-bit limit, reach the JIT as compares against their
neighbors and took the extra mov. When the neighbor fits, compare
against it with the adjusted condition instead, x < C as x <= C - 1 and
x > C as x >= C + 1, unsigned and signed alike.

Before/after for if r1 < 4097 goto ... and if r1 > 65535 goto ...:

  d282002a  mov x10, #0x1001
  eb0a001f  cmp x0, x10
  54000063  b.lo ...
  f140041f  cmp x0, #0x1, lsl #12
  54000049  b.ls ...

  d29fffea  mov x10, #0xffff
  eb0a001f  cmp x0, x10
  54000068  b.hi ...
  f140401f  cmp x0, #0x10, lsl #12
  54000042  b.hs ...

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 86 ++++++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index af0b05036d09..606e788facd0 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -477,6 +477,76 @@ static void emit_arena_ldst(const u8 code, const u8 rt, const u8 reg, const s32
 					     a64_ldst_type(code, A64_LDST_REG)), ctx);
 }
 
+/*
+ * A compare against an immediate neither cmp nor cmn can encode is one
+ * against its neighbor with the adjusted condition when that one fits:
+ * x < C is x <= C - 1 and x > C is x >= C + 1, for the unsigned as for the
+ * signed conditions, as long as C - 1 or C + 1 does not wrap. LLVM
+ * canonicalizes x <= C to x < C + 1, so the compares against a power of
+ * two or a mask plus one arrive here.
+ */
+static bool adjust_cmp_imm(u8 *op, s32 *imm)
+{
+	s64 c = *imm;
+	u8 new_op;
+
+	switch (*op) {
+	case BPF_JLT:
+	case BPF_JGE:
+		if (!c)
+			return false;
+		fallthrough;
+	case BPF_JSLT:
+	case BPF_JSGE:
+		c--;
+		break;
+	case BPF_JGT:
+	case BPF_JLE:
+		if (c == -1)
+			return false;
+		fallthrough;
+	case BPF_JSGT:
+	case BPF_JSLE:
+		c++;
+		break;
+	default:
+		return false;
+	}
+	/* Past a signed limit the neighbor does not fit the 32-bit immediate */
+	if (c != (s32)c || (!is_addsub_imm(c) && !is_addsub_imm(-(u32)c)))
+		return false;
+
+	switch (*op) {
+	case BPF_JLT:
+		new_op = BPF_JLE;
+		break;
+	case BPF_JGE:
+		new_op = BPF_JGT;
+		break;
+	case BPF_JSLT:
+		new_op = BPF_JSLE;
+		break;
+	case BPF_JSGE:
+		new_op = BPF_JSGT;
+		break;
+	case BPF_JGT:
+		new_op = BPF_JGE;
+		break;
+	case BPF_JLE:
+		new_op = BPF_JLT;
+		break;
+	case BPF_JSGT:
+		new_op = BPF_JSGE;
+		break;
+	default:
+		new_op = BPF_JSLT;
+		break;
+	}
+	*op = new_op;
+	*imm = c;
+	return true;
+}
+
 /* generated main prog prologue:
  *      bti c // if CONFIG_ARM64_BTI_KERNEL
  *      mov x9, lr
@@ -1600,6 +1670,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	const int i = insn - ctx->prog->insnsi;
 	const bool is64 = BPF_CLASS(code) == BPF_ALU64 ||
 			  BPF_CLASS(code) == BPF_JMP;
+	u8 jmp_op = BPF_OP(code);
+	s32 cmp_imm = imm;
 	u8 jmp_cond;
 	s32 jmp_offset;
 	u32 a64_insn;
@@ -1876,7 +1948,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 emit_cond_jmp:
 		jmp_offset = bpf2a64_offset(i, off, ctx);
 		check_imm19(jmp_offset);
-		switch (BPF_OP(code)) {
+		switch (jmp_op) {
 		case BPF_JEQ:
 			jmp_cond = A64_COND_EQ;
 			break;
@@ -1938,12 +2010,14 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_JMP32 | BPF_JSLT | BPF_K:
 	case BPF_JMP32 | BPF_JSGE | BPF_K:
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
-		if (is_addsub_imm(imm)) {
-			emit(A64_CMP_I(is64, dst, imm), ctx);
-		} else if (is_addsub_imm(-(u32)imm)) {
-			emit(A64_CMN_I(is64, dst, -imm), ctx);
+		if (!is_addsub_imm(imm) && !is_addsub_imm(-(u32)imm))
+			adjust_cmp_imm(&jmp_op, &cmp_imm);
+		if (is_addsub_imm(cmp_imm)) {
+			emit(A64_CMP_I(is64, dst, cmp_imm), ctx);
+		} else if (is_addsub_imm(-(u32)cmp_imm)) {
+			emit(A64_CMN_I(is64, dst, -cmp_imm), ctx);
 		} else {
-			emit_a64_mov_i(is64, tmp, imm, ctx);
+			emit_a64_mov_i(is64, tmp, cmp_imm, ctx);
 			emit(A64_CMP(is64, dst, tmp), ctx);
 		}
 		goto emit_cond_jmp;
-- 
2.43.0

