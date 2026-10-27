Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125495;
	b=xYAIY8SEUDO8GBx9LpevUQ9oKQ/ohWYDRKXVSkLcHpCu97NOrhd2FQORgnfBH+iOywvf
	 HH+hjRe5EV7g+VAG+2zM9BiLk6CAjgf5EoyO1/Xrc4e6iO0K3fu96PaVKjgaIQL8JmaTq
	 inFITRn350KSAIh+U/CoFC3macehk57iI9H8V6se7cybgAkiuboL4lC4n/fDDpUfnA+vO
	 R6I2D1230HkH4l4IjK1aqxn7hxi06B/ylclCSwkyhRtWmd3PhA5j/BM39lroWfppyG3br
	 SJvlmwqW4eNoY+0a6fi9/HlqZgJ8vGUEtgz1Xzz5Q4Xpw5mXAqQghJJncxa1anTnOtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125495;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=7+u5JS9SN4F6yEyIt5LXOQwLnP7nletznnTudZ5DLo8=;
	b=k9vcVjCNIUIOFBKzz+3wc7AwtlsLQMUnyeaQC1pZVdH25NIm4XE5f3Hhfjz6uvEzgM9G
	 TUMeqw/X+D9dgdG9f02G0fiOGsDUU2mNLFZXzqBVtlC9NiBxDZgZIj3SfMb2SBIaLBhKd
	 MCOQx4NJFW05s/sdGDUxd4+OpjYYX/RcEj7+qRF0jG7eucIm0k3LfcPDZc24Z/RJUGrJb
	 dEWtid7xhT/8jiiAUm0K+Hy5Gorch+yUuC+sqjIEEEHE4EB0QepY/1dSl4Lp+cNF/BaRf
	 uRtFFsX7sm6r/UqrOudn1BOfZ6E1WrHgVXVmqBcZaOpsu7MyzamjVeTlSxl+EOh38Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=EawOxmBB;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA66F606A332
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA66F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=EawOxmBB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7+u5JS9SN4F6yEyIt5LXOQwLnP7nletznnTudZ5DLo8=; b=EawOxmBBiv0xQ27RyT9hFCNTLV
	7LfFqf70Y1F0HE5pF53M5VsPiks0ryCUWPqkhARYVwC3LLSIfFvBFtLuSDM9woZuLGICsU9tYnW88
	y4x/Obwi8yYEjUccYXLY6OdnZNDovB7OEdoxFGgtiufzZHcyJZVGnSU87fUlG1+McB7ZX6dEDA0JC
	J946WTv4KOnri12tpA8hQ0A6xnbguXSXL5hkdZdLdxKIsUw7WvvPQXG0xa1P5GWyd1ZIXaCab7AVD
	WLV8Nn/bPDI5GWcCHsTS+Z/uWvYRWybGmLLv+SX0Moaamm0R9b35FQBrEB+C7BGS2tkelY7a0qv66
	b4b+9Okg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqv-000Ilp-0h;
	Tue, 27 Oct 2026 19:24:53 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 12/21] bpf, arm64: Adjust compares with unencodable immediates by one
Date: Tue, 27 Oct 2026 19:24:36 +0100
Message-ID: <20261027182445.1156335-13-daniel@iogearbox.net>
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
index 8b416c74858e..90cbde8f96b6 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -466,6 +466,76 @@ static void emit_arena_ldst(const u8 code, const u8 rt, const u8 reg, const s32
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
@@ -1589,6 +1659,8 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	const int i = insn - ctx->prog->insnsi;
 	const bool is64 = BPF_CLASS(code) == BPF_ALU64 ||
 			  BPF_CLASS(code) == BPF_JMP;
+	u8 jmp_op = BPF_OP(code);
+	s32 cmp_imm = imm;
 	u8 jmp_cond;
 	s32 jmp_offset;
 	u32 a64_insn;
@@ -1865,7 +1937,7 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 emit_cond_jmp:
 		jmp_offset = bpf2a64_offset(i, off, ctx);
 		check_imm19(jmp_offset);
-		switch (BPF_OP(code)) {
+		switch (jmp_op) {
 		case BPF_JEQ:
 			jmp_cond = A64_COND_EQ;
 			break;
@@ -1927,12 +1999,14 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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

