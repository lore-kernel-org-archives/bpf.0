Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166094;
	b=jQ8tRgeMVUuk6g/STetDqvxAQAL1Y65cA1rFQlz62BOfhbUFr5nZJBWNJwRdna0xdwX7
	 QwTdS1o/ihL1gCBf+vqKpJCJeKksiWHaRQ+uB813gbHdB/44PuVRekvf+ZQYoYPKFmlX8
	 Y0nDw8fLVLkKvHzBlDkzG53+UUO1VcIvaimKWvWtqZYBqh9BNWMAsk7jXMKEmyQO/jyg/
	 0MX2J+sAp9yJ4y6hnYPp3u7QtiiiltiPBoKIvy62HBW59Yna1RP9FDN9PRmGWPDYAMPh4
	 FvF/WsVSwmxIiyztxxM9DTqomeHR7Y4cPar8hC1nsev8XQRqktl35q2wwZrNQ9XmaTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166094;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=XxHfSjYWPj/DntxO/hPPNxeUfYeeYJdsGFtO8ooE0U0=;
	b=Gio6crgzJzc07CVTor4uXcoepeUTneXMOgJlJZzun1s0oiW+G3Kfo6zOMs/073yM8loT
	 utU8PpJzDoZYC0VxgEuXtgsZjL4f9RSScnsWyH1nctmn5HoZlW3GkXuyQplC0eXO9e0YC
	 +cit2IwdlN6A5WNsQC24F0mDDHSS1MfI6oixmOvfvzVpefEMYlG2QNtfXoYNWFvPhPEzu
	 rhvHLL4F6YyjxsgzCfg+6PUKQfhYGZsCXSzpZQNFH9d9bM1LRMCcJ9U/0y+k9utR5e2mx
	 MRVIQOOW69D5CybFdfYvd5vhfPm/sgdnUeIIrA6TVOasLffuStp028VWtKxhcAqxv4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=HSZEB0C0;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940F6606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 940F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=HSZEB0C0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XxHfSjYWPj/DntxO/hPPNxeUfYeeYJdsGFtO8ooE0U0=; b=HSZEB0C00u7iLfNUln8uhYSoZd
	UcLyeNqQXBINkQO+6DJgnkFHXxXgiEQun9HdVJsateHibIlDMXB8AXDvtNDKo0SEC6cedgQf9c4vI
	uwnH6wpHjDilmP0ei0lyhavmdnLuXM9oAKMEoD9QMJqEHooVs5J7CJPqzg9JzIQyM40F6ffRrA1M1
	7hJ/MdAjwXPcQZksX0ihiCCx2HWtg03+cqCrgmzvaxY8lYgLnfvfqil0c8a9WqGPfTaxjhB3UPX93
	S1ppZLtbiOkRDuUt+ERRLpEyoGOuBeoVRudxFoBmojlm1ZOn/vUM8TRsr6aKW12ft8x+IvMPY/X4E
	37kqT2eQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8Yl-000Pqz-1e;
	Sun, 08 Nov 2026 20:28:12 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 16/24] bpf, arm64: Adjust compares with unencodable immediates by one
Date: Sun,  8 Nov 2026 20:26:42 +0100
Message-ID: <087e9606132fb246b8e05b65ccaf67a524e7fecc.1794165614.git.daniel@iogearbox.net>
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

cmp and cmn take a 12-bit immediate, optionally shifted left by 12.
LLVM turns x <= C into x < C + 1 and x >= C into x > C - 1, so a
compare against a power of two reaches the JIT as one against a power
of two plus one, or against a mask. Those often do not encode and
needed a mov.

When the immediate does not encode but its neighbour C - 1 or C + 1
does, compare against the neighbour and adjust the condition. This
covers <, <=, > and >=, both signed and unsigned.

Before/after for if r1 < 4097 goto ... and if r1 > 65535 goto ...:

  d282002a  mov x10, #0x1001
  eb0a001f  cmp x0, x10
  54000043  b.lo ...
  f140041f  cmp x0, #0x1, lsl #12
  54000049  b.ls ...

  d29fffea  mov x10, #0xffff
  eb0a001f  cmp x0, x10
  54000048  b.hi ...
  f140401f  cmp x0, #0x10, lsl #12
  54000042  b.hs ...

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 83 ++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index fb56b439ee20..5a88740d9d0c 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -481,6 +481,73 @@ static void emit_arena_ldst(const u8 code, const u8 rt, const u8 reg, const s32
 					     a64_ldst_type(code, A64_LDST_REG)), ctx);
 }
 
+/*
+ * Compare against C - 1 or C + 1 with the adjusted condition when C does not
+ * encode, for the masks and powers of two plus one that LLVM's x >= C to
+ * x > C - 1 and x <= C to x < C + 1 bring here.
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
@@ -1609,6 +1676,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	const int i = insn - ctx->prog->insnsi;
 	const bool is64 = BPF_CLASS(code) == BPF_ALU64 ||
 			  BPF_CLASS(code) == BPF_JMP;
+	u8 jmp_op = BPF_OP(code);
+	s32 cmp_imm = imm;
 	u8 jmp_cond;
 	s32 jmp_offset;
 	u32 a64_insn;
@@ -1886,7 +1955,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 emit_cond_jmp:
 		jmp_offset = bpf2a64_offset(i, off, ctx);
 		check_imm19(jmp_offset);
-		switch (BPF_OP(code)) {
+		switch (jmp_op) {
 		case BPF_JEQ:
 			jmp_cond = A64_COND_EQ;
 			break;
@@ -1948,12 +2017,14 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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

