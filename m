Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415572;
	b=IyqY4gnkCI2AwgJh4+TMkIFG8eZUKFK2FI6PqtH3pRgQEapvGHnzhwypDyqaWi+jenqY
	 Dhe60dSXTiGy8w1ncZds2rOdAW+gks2SQlpRVCHTeJir6RJkPjO2X4cSY5PzKHfdZ/62k
	 YXe9QHmICyt/KS349xkP0iiHhZcYxzvGeevItcebSVxzgMTHer3e4qfA7gAC8V+vID3u8
	 qpWSR8KJSOAoFk0PvkQmcJt0dTnGkQPsD/bMIJ0/t5CxtR/yV2Hmv0Dxp1aTDhbdzZM9e
	 RKU2OgOkKw7UGIUQybf/OrObYz/g/dK0JuJTaNfCfuAfSrlZYd7cxHTR2aqed7iJQnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CuQGUO3HgDYryc7TdjxUhpjCaJJIEeYTBw9wB5talj8=;
	b=qkuAIgfOPsdYKojApXhaJ7rYfZEDAb42rC6urWWQIwwLnMY/GCBQO6xA7EWWgBIGorSy
	 6vxC25wCfxVS8uT3g8FWxITUsruxOI41BkdtcpaeGw3xWS1PuEsk+E+gogtspyjN+vueg
	 YezAaw1AhhGhJf2wB20LbUTPwrO58gzvkJ735NTv5T/9ataprQKI8jRUgSaXlblE5YTuj
	 b6Z1Uz26k5YJveYFqT2ZhgMNqOLP8Sb0i6y7ey42qyJAJE8EaQxn2Z0Zw7O+puo+rjrAU
	 Ittpn3rO3EWmK6zAhb8BdIrkcopoCxgZjjh2AVhXpUunNI9UdNq0STDBLUQ0r19hprw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QO/IeUcs";
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44469606A32E
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44469606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QO/IeUcs
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ede7cb02daso79345ad.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415571; x=1795020371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CuQGUO3HgDYryc7TdjxUhpjCaJJIEeYTBw9wB5talj8=;
        b=QO/IeUcskTATA1JW4O+MMN+pkJaIL1qNSMIV/P7E7BOnuBFZaBXf9MSTpeAHp/3K+D
         9nK4faZyTBDIbk56lfCr3M/gyZQMwrAbGaoDkvaPleztf/alT5nhsoxlbioh1lZrOt5W
         cbJKS3Fqh9ASO8G4CeMyGPtKO5MFLh3HMQ1GmrlBCHOH9lytdbGLnNT+80gzf/h+3bp6
         P4oDcqaSv93j1Si/uzfZ9CayTIWBGr5VMDPNO6kON9M3DR2cKMDcv7BDRLpVIUUBzBk1
         Hm0yMTwoY0t/nJmD7A51Mpsn59+mBTvUKLkoORrCILA7fdiXLYiCskWmHZBxavgZzcWm
         D10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415571; x=1795020371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CuQGUO3HgDYryc7TdjxUhpjCaJJIEeYTBw9wB5talj8=;
        b=PchJvcTNZQBiMw9Jdd5tBtWnoDwxvRrCLi25YvavOPEZS3+KRuHagK5Laa6Kb4Wos4
         Q435af9QRHMK/H62R1OOfUPMUPZ3RWUgnShVq2sykCa9AuU+eRAnl1eEOmgUOHjWN/Ot
         60mTVNQLyVE4tNFtCQlv9euOB7lCmHKlA0Nt833KXevsCCY1xfeF87MXzPeuPTbMifIh
         i4bNgPsljj9gD1edX+CJ66vJndXmF9Opvy+KwEFYpMiZSPqNESJ95SqyW5g2KwluoVcy
         D5jhBZZa4XOthER+b3N3UqIZlO2STs0HWPqzslzOZejsvS9CmcOboVdvKORSikwU8bug
         SeQA==
X-Gm-Message-State: APuU4Z/wx0CBU7/sJM7M+tTs41jeJxOkG4ORq99a9+H6urKjxcD2xY0n
	GAJOBIy/MpkUEjNhCqV2+2mvERgF1acaNxs6USKn3Jc5YqZk6MAQjJoJK9QXTw==
X-Gm-Gg: AYBFou3NX7XRufBYJNl5FjW3g+yFdwN6qqnjpqegQ6b4EjTGGl6rlVepOwHngufYw+Y
	fh2UfrjXFq7GAooovSMJaeu2XCF8hERwukVvhhWW74YeZ2dQzlRusIRzweW5pxlv0xGESRpzYGQ
	QPBxxW/zsQBul3RgBLvDwiR/W/OwoNJJbVbvnBFNiAztga3A8cqjz+0/aUvelSP/qPkDkScQcpL
	1GZMtnhjnQDXzJVbgs1fPerPDtYjYkVuZqpRsSurwB+e0cb92hJj0fH9HuRKvJiKe6X7ylbvdOl
	0yJScP5Qm9cD7ke9AfBM/IyoMaUpJ9ZYNGlDvMxeXnVGpto6zRS7iYE0fIOeDNHGlDU0syQ0Qu5
	n1zevmYpNHNX4CbGObiAC0mSkz+M+PxubUgDZwW40O8WTaq8b4PRtMj9muc0xV6QJYBkaByCGE7
	MlT/wAehlfDJX7HH/nd50x2X2KBkmnmg4ZJcVZlb3WfdOWre7sfJN8AGk5iJcPuhakIx713vkoz
	cMIVDHr4QjrkhQ9Mmu1AvoG3qCLelQuoSMyyFTcMaTxx5m1Pclbnqp2TvTfLqd/2xl5g7IFqBaA
	vqzmEsOzszz3GEsrGizmX1Fq+pz/CEcNT5ZREgXoTNZoGyr6Mvhw2/LNyfH0qxWMgBI2yoU98MA
	sMJl55qw9x4RNcrMruqPn4HPzVr/g0+4gS+PSmjTA3THTqYyzJ1FaAzckWnlaJxE3aluj0bsSsa
	Q=
X-Received: by 2002:a17:902:c401:b0:2e8:3a42:7edf with SMTP id d9443c01a7336-2edd3ecf5e0mr30048825ad.12.1794415571290;
        Wed, 11 Nov 2026 08:46:11 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d906f2sm21288955ad.38.2026.11.11.08.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:46:10 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 02/29] bpf: Model 32-bit shifts and divisions exactly in scalar evolution
Date: Wed, 11 Nov 2026 16:45:25 +0000
Message-ID: <20261111164557.2659679-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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

