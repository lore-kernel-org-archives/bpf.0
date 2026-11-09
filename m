Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206851;
	b=XlaaLVvhy+inG3Q5QMHPqe4WfWb5Tvqur3J4xQ9ALm/Qld7JG4EVb16zLNjc5xbYmdci
	 UH3/KZ9dt5B8994A02um2qeCydYZ1x1O9sugib1QrMvuyfJtU4R5utW/1EO5FnOM4wsvs
	 y83KlLd1XZVjFfpNol5tVckOfnfvFYe7M+uQcsw4SABd30XHuYk1stlevw3KU/LIu2bxH
	 HXiLCnJuCl15yt7ejGfs9+qx9wwqDWr71GUIpZjLAXQweWqzCVdulm+ogQGhwpcnrlpB5
	 4OkuJarn7qUJPoRBcI4bVgcc2sO8duStmKupNlxN9NYbI4TP1EqXCvDMLL86XG1Bygg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CuQGUO3HgDYryc7TdjxUhpjCaJJIEeYTBw9wB5talj8=;
	b=z5Ak1VTDkN+SXpJn/+D00lMLie61CTs+5SFfGjFhOIhAKLFcmaKCUXb8GfVyw2ekZ6vG
	 k9HE1Lzs3H0omOItP0WNFHdhDcl+XUVq2xZ9HFXemgWUp6n9tLdTXk0uWDK7GH/cc1QxG
	 8mjR0ShJkvQNdgav/JYqGcRcHnYGL1FuLIdQZUK1D13AuUMdtU98fQTO+8Ra2pK0lLlnP
	 2q9bZ8EBHeGaAe/Iu+jwE+zZuzTFZ+fkrkaa6skGxhiuLNeopnf0sfPa8Knm7tbDRfGk2
	 Lu9H5gH7KMIwhC1jDbgd7l/OFcU14TKeLHJy0BnnVJESd2Dlvj4/nCzVAzwKSya6pJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XW2V0w87;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80C606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A80C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XW2V0w87
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so186881a12.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206850; x=1794811650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CuQGUO3HgDYryc7TdjxUhpjCaJJIEeYTBw9wB5talj8=;
        b=XW2V0w87uR4J9GtebpcY+XJiFR+9iTA0192nRRoHJnQ6IxJlhk5ojD3YWwFjM+UWe7
         ej593FbYU2wBh0aJb6wlIzXKnhkucnU1OwIl6yaAmpPAeNFH1DgcwZzQPJdczC+1IceO
         NHeacxDKHZctc6E12RAqXnlEPH45lWE6hFjqap0ac6VH4N8ViyvtKHItu83JXq09Jaq8
         uj5uI6ApnYpQ9bJLkI3oCB3UjO0raAegymQV4QJxqba6gm6kC/eDpt27ClzYU9W9Xpnu
         OyYZdUCl2G3UV6beykR9S5+ILJgsWRoVxA8ZT9M1lWC4N1HLi8p3rOpUnx+ptWFrv6yb
         e+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206850; x=1794811650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CuQGUO3HgDYryc7TdjxUhpjCaJJIEeYTBw9wB5talj8=;
        b=2fmd3sqDWU6XttKBMYPfFq/L+UQYo283YDGbxdNrwuPIA2lsZLbK+CI3UAn/YMKx9k
         cz2Ix256p+laM8yIpCDoe8I6s3ksdo6IheWqdwXvo96gN4m3RMbck7Q7tKGPN5a7GGhW
         HIwAVTX296dCmnGIuJEA3Wf9ghxppZp/n41DF7Pn9kO6bq1sfSydUsYTEVBz9ruEhCyA
         qAkcAUE87thG3PUa+9ESm/7yrgOx6IDh18G5vL8bvlNVLyYR39fZ+mcIvCuysl9ZhwTH
         yscXQ22u+vfzBG2zBrHMA0Re2/nvCPXi2g+abo3/GTA4ck3q82Kp2TbnR7WSMLtpLP32
         7qhg==
X-Gm-Message-State: APuU4Z9Pe4KlhSBrLBYf+Ygig8wHzpZaXIMOrjpKbOp/OPfKBAhAZB3E
	zM5NhFN9VAbBsOQKjqQQGels/Zw/Oo2LlYMzEWp/eYbi/1e4ZJeysuynIP6ohA==
X-Gm-Gg: AYBFou2NqqQZJDmCdg9ujXHZ5ZG0iyvi3em/QUJ4MhU7AFoZK2eReUBWU3Np/G9W5WV
	vBCI1sXSUkfTiyzBdNjUdpUb56Hp7OeXcjiwxTu2vI9OqQFvJSt2snjWa33BIgcG69NMnQOTU+a
	1nhghz+WZO4V71+V45ZlkqOktv/ofZffVaMoAf6TQL7BHpuq/G6i5er/nGhxOrA5X46SY6JSEg6
	QKSS0JrZtizRHNkNEUUQuMeq4tVw545R9Lm78GVYYbr6BkHrbtTkNt8eqLTG9bPE/kBrWY4/tCG
	WfRgtNNribu8XpRpvrxAC+YHi6yvxMi+BmzJNpJIK84SrqCF5JNGPpukC9cy5JGik+rE/BO5gut
	5qnuLtPxNtutW5nRYJWUmcscQPX8HZObmf6VNF61/uzmmabnQBsloDJ//bHGMC20Q4kRPf8idG1
	h/FcsZ+1oMCfPejdGlPHKlfy0x/fbJIX30dsIx8At2OfU6Wc0Qu78FxkC91X0rlYXmJNmG2jilf
	0CPDEXSMzF1PBCi/XE+DESuLWRuxeKHM/dO55SEaiEKsWqqK4a8Wy4ncSRkR49m5KUrXxd1QI2P
	TnN519897PjVpUc4LGYHCOaqxl6tr54bRJG30QsCq2zKMKcKRK3uM5VLmQzDVP3S5EV7/3xK+Pn
	uVLIjGfX/tWuHFkHlKQF+Jl2eog2Jox41hYgSZMd9WI1RgtzUMXB8abisbunYz5qTKXBUTRQw0A
	==
X-Received: by 2002:a17:90b:2890:b0:3aa:fc22:8aad with SMTP id 98e67ed59e1d1-3b12d3d02ccmr3089170a91.54.1794206849804;
        Sun, 08 Nov 2026 22:47:29 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a80a1sm10335226a91.12.2026.11.08.22.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:47:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 02/26] bpf: Model 32-bit shifts and divisions exactly in scalar evolution
Date: Mon,  9 Nov 2026 06:46:46 +0000
Message-ID: <20261109064715.2382452-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

A fix of the representation, for the patches that take two registers with
the same expression for the same value. Today two insns that compute
distinct values get the same expression:

	r5 >>= r4; w5 = w5     (zext32 (>> r5 r4))
	w5 >>= w4              (zext32 (>> r5 r4))

The second one shifts the low 32 bits of r5, by r4 & 31. Nothing goes wrong
so far: the code that analyzes loops does not look into a shift or
a division. cubic_root() of bpf_cubic.c is going to depend on it:

	shift = (a >> (b * 3));
	if (shift >= 64)
		return 0;
	x = ((__u32)(((__u32)v[shift] + 10) << b)) >> 6;

GCC tests one register and uses another one as the index:

	r5 >>= r4
	w2 = w5
	if w5 > 0x3f goto ..
	r4 = v ll
	r4 += r2

The prog loads because r5 fits in u32 in the state: 'w2 = w5' assigns one
scalar id to r2 and r5, so the jump bounds both. Without scalar ids it is
going to load because r5 is (>> a b) and r2 is (zext32 (>> a b)), which is
r5 truncated to 32 bits.

An ALU32 insn is (zext32 (op a b)) with the 64-bit expressions of its
operands. That is exact for + - * | & ^ and for the value that << shifts:
the low 32 bits of the result depend on the low 32 bits of the operands
only. It is not exact for a right shift, a division, a modulo and a shift
amount. Zero or sign extend these operands, mask the shift amount:

	w5 >>= w4     (zext32 (>> (zext32 r5) (& r4 31)))
	w5 s>>= 3     (zext32 (s>> (sext32 r5) 3))
	w5 /= w4      (zext32 (/ (zext32 r5) (zext32 r4)))
	w5 s%= w4     (zext32 (s% (sext32 r5) (sext32 r4)))

Every expression is a 64-bit operation now. (>> x 32) shifts by 32. Before
the patch it could also be 'w1 >>= w2' with 32 in w2, which shifts by 0.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 46 +++++++++++++++----
 .../selftests/bpf/progs/verifier_scev.c       | 26 +++++------
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 4187ce955be9..1cb4bc7c0f96 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -686,6 +686,38 @@ static int maybe_load_fp(struct scev *scev, struct env *e, struct bpf_insn *insn
 	return replace_reg(scev, e, insn->dst_reg, id);
 }
 
+/*
+ * The low 32 bits of a + b depend on the low 32 bits of a and b only: 'w1 += w2' is
+ * (zext32 (+ a b)). That doesn't hold for a right shift and for a division. Their operands are zero
+ * or sign extended and a shift amount is masked, so that every expression is a 64-bit operation.
+ */
+static void alu32_operands(struct scev *scev, u32 op, int *a, int *b)
+{
+	s64 imm = 0;
+	bool imm_b = *b >= 0 && is_imm(scev, *b, &imm);
+
+	switch (op) {
+	case BPF_RSH:
+	case BPF_ARSH:
+		*a = expr1(scev, op == BPF_RSH ? ZEXT32 : SEXT32, *a);
+		fallthrough;
+	case BPF_LSH:
+		*b = imm_b ? imm_expr(scev, imm & 31) :
+			     expr2(scev, BPF_AND, *b, imm_expr(scev, 31));
+		break;
+	case BPF_DIV:
+	case BPF_MOD:
+		*a = expr1(scev, ZEXT32, *a);
+		*b = imm_b ? imm_expr(scev, (u32)imm) : expr1(scev, ZEXT32, *b);
+		break;
+	case SDIV:
+	case SMOD:
+		*a = expr1(scev, SEXT32, *a);
+		*b = imm_b ? imm_expr(scev, (s32)imm) : expr1(scev, SEXT32, *b);
+		break;
+	}
+}
+
 static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 {
 	const bool little_endian = htons(0x3412) == 0x1234;
@@ -700,7 +732,7 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 	u32 src = insn->src_reg;
 	u32 op, sext, l, r;
 	bool need_bswap;
-	int i, id;
+	int i, id, a;
 	s64 imm;
 
 	/* reg2expr[12] is a stack slot, not r12 */
@@ -764,19 +796,17 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 			else
 				goto mark_dst_unknown;
 
-			/*
-			 * 'r1 <<= 32; r1 >>= 32' is (u32)r1 for cpu v1 and v2. Only here both
-			 * shifts are known to be 64-bit ones: the result of a 32-bit shift is
-			 * (zext32 ...), and (>> x 32) is 'w1 >>= w2' with 32 in w2 as well,
-			 * which shifts by 0.
-			 */
+			/* 'r1 <<= 32; r1 >>= 32' is (u32)r1 for cpu v1 and v2 */
 			if (class == BPF_ALU64 && op == BPF_RSH && id >= 0 &&
 			    is_imm(scev, id, &imm) && imm == 32 &&
 			    is_binop(scev, BPF_LSH, reg2expr[dst], &l, &r) &&
 			    is_imm(scev, r, &imm) && imm == 32)
 				return replace_reg(scev, e, dst, expr1(scev, ZEXT32, l));
 
-			id = expr2(scev, op, reg2expr[dst], id);
+			a = reg2expr[dst];
+			if (class == BPF_ALU)
+				alu32_operands(scev, op, &a, &id);
+			id = expr2(scev, op, a, id);
 
 			if (class == BPF_ALU)
 				id = expr1(scev, ZEXT32, id);
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 5c9c832fbbe0..f2a53fe5f6ad 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -334,20 +334,20 @@ __msg("w1 *= 2 {{.*}}; r1 r6 -> (zext32 (* r6 2))")
 __msg("w1 *= w7 {{.*}}; r1 r6 -> (zext32 (* r6 r7))")
 __msg("r1 /= 2 {{.*}}; r1 r6 -> (/ r6 2)")
 __msg("r1 /= r7 {{.*}}; r1 r6 -> (/ r6 r7)")
-__msg("w1 /= 2 {{.*}}; r1 r6 -> (zext32 (/ r6 2))")
-__msg("w1 /= w7 {{.*}}; r1 r6 -> (zext32 (/ r6 r7))")
+__msg("w1 /= 2 {{.*}}; r1 r6 -> (zext32 (/ (zext32 r6) 2))")
+__msg("w1 /= w7 {{.*}}; r1 r6 -> (zext32 (/ (zext32 r6) (zext32 r7)))")
 __msg("r1 s/= 2 {{.*}}; r1 r6 -> (s/ r6 2)")
 __msg("r1 s/= r7 {{.*}}; r1 r6 -> (s/ r6 r7)")
-__msg("w1 s/= 2 {{.*}}; r1 r6 -> (zext32 (s/ r6 2))")
-__msg("w1 s/= w7 {{.*}}; r1 r6 -> (zext32 (s/ r6 r7))")
+__msg("w1 s/= 2 {{.*}}; r1 r6 -> (zext32 (s/ (sext32 r6) 2))")
+__msg("w1 s/= w7 {{.*}}; r1 r6 -> (zext32 (s/ (sext32 r6) (sext32 r7)))")
 __msg("r1 %= 2 {{.*}}; r1 r6 -> (% r6 2)")
 __msg("r1 %= r7 {{.*}}; r1 r6 -> (% r6 r7)")
-__msg("w1 %= 2 {{.*}}; r1 r6 -> (zext32 (% r6 2))")
-__msg("w1 %= w7 {{.*}}; r1 r6 -> (zext32 (% r6 r7))")
+__msg("w1 %= 2 {{.*}}; r1 r6 -> (zext32 (% (zext32 r6) 2))")
+__msg("w1 %= w7 {{.*}}; r1 r6 -> (zext32 (% (zext32 r6) (zext32 r7)))")
 __msg("r1 s%= 2 {{.*}}; r1 r6 -> (s% r6 2)")
 __msg("r1 s%= r7 {{.*}}; r1 r6 -> (s% r6 r7)")
-__msg("w1 s%= 2 {{.*}}; r1 r6 -> (zext32 (s% r6 2))")
-__msg("w1 s%= w7 {{.*}}; r1 r6 -> (zext32 (s% r6 r7))")
+__msg("w1 s%= 2 {{.*}}; r1 r6 -> (zext32 (s% (sext32 r6) 2))")
+__msg("w1 s%= w7 {{.*}}; r1 r6 -> (zext32 (s% (sext32 r6) (sext32 r7)))")
 __msg("r1 |= 2 {{.*}}; r1 r6 -> (| r6 2)")
 __msg("r1 |= r7 {{.*}}; r1 r6 -> (| r6 r7)")
 __msg("w1 |= 2 {{.*}}; r1 r6 -> (zext32 (| r6 2))")
@@ -363,15 +363,15 @@ __msg("w1 ^= w7 {{.*}}; r1 r6 -> (zext32 (^ r6 r7))")
 __msg("r1 <<= 2 {{.*}}; r1 r6 -> (<< r6 2)")
 __msg("r1 <<= r7 {{.*}}; r1 r6 -> (<< r6 r7)")
 __msg("w1 <<= 2 {{.*}}; r1 r6 -> (zext32 (<< r6 2))")
-__msg("w1 <<= w7 {{.*}}; r1 r6 -> (zext32 (<< r6 r7))")
+__msg("w1 <<= w7 {{.*}}; r1 r6 -> (zext32 (<< r6 (& r7 31)))")
 __msg("r1 >>= 2 {{.*}}; r1 r6 -> (>> r6 2)")
 __msg("r1 >>= r7 {{.*}}; r1 r6 -> (>> r6 r7)")
-__msg("w1 >>= 2 {{.*}}; r1 r6 -> (zext32 (>> r6 2))")
-__msg("w1 >>= w7 {{.*}}; r1 r6 -> (zext32 (>> r6 r7))")
+__msg("w1 >>= 2 {{.*}}; r1 r6 -> (zext32 (>> (zext32 r6) 2))")
+__msg("w1 >>= w7 {{.*}}; r1 r6 -> (zext32 (>> (zext32 r6) (& r7 31)))")
 __msg("r1 s>>= 2 {{.*}}; r1 r6 -> (s>> r6 2)")
 __msg("r1 s>>= r7 {{.*}}; r1 r6 -> (s>> r6 r7)")
-__msg("w1 s>>= 2 {{.*}}; r1 r6 -> (zext32 (s>> r6 2))")
-__msg("w1 s>>= w7 {{.*}}; r1 r6 -> (zext32 (s>> r6 r7))")
+__msg("w1 s>>= 2 {{.*}}; r1 r6 -> (zext32 (s>> (sext32 r6) 2))")
+__msg("w1 s>>= w7 {{.*}}; r1 r6 -> (zext32 (s>> (sext32 r6) (& r7 31)))")
 __msg("r1 = -r1 {{.*}}; r1 r6 -> (- r6)")
 __msg("w1 = -w1 {{.*}}; r1 r6 -> (zext32 (- r6))")
 __msg("r1 = 42 {{.*}}; r1 r6 -> 42")
-- 
2.55.0

