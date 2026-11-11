Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374038;
	b=Tf2gx8f9NoMfkxQTPP0yfrgEQ3bBhnzDroXDdMLKrtllaZfMQmvxsYP0cK1JEtuZcU++
	 7Zil5iYt8tjEI5xLBOQbZb0RbgC2lS/rSaBsRnVzQu22VpknsdiDGL0X9T/iTaeV+SCLn
	 1TUd3zVKMI/V49oPLyboP7RT+df59v9iL1PH0PPOuS0Y1xKhah5Sp6dXQOMHzIW1nv6YA
	 caMleBDmhtj3yUF1Lnqe/JyK5gg2fMUmg14C2yDV97uNxIvTtsIRjfbzUfSVYcyRWzWjF
	 7JU8PPU8g1cbwqIc9Vi+mdFskBEh0E/GAPtd5EjRha9Gh/+cVppLoSoJ/M4wwZKK22g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CuQGUO3HgDYryc7TdjxUhpjCaJJIEeYTBw9wB5talj8=;
	b=cft03hA7A9h8KGXl1KU9F3ZRhfiifFySxpCyPqfkCHfln27qZYHMKbTuPMYQLr5qDblp
	 BTe26rzsaaH2b82c+WXcZMRC8uybBctglLFjhh+EDO0xPGmioin2QsO89SyafK30kthyi
	 5/FEQBLqWAWIqdrmSuH6RXb1wrG+WagzeABws8kxSz6RtY+2Dkk5T0epE7wmg6XSPowq8
	 sqQxgIoLnLAf467wz29miRjmexjZwNsX8acssPt4YhK/s7w7QgRhNU8T9VCNFaR9UKBnq
	 5+xe5a6Xllz/NvpJKKVMxV3cEGbJVjY54hN7CYE94EUyVL7tWa78CWZxKWVY8YibVdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HogxbxBy;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92052606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92052606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HogxbxBy
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a60f90a924so1136335b3a.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374037; x=1794978837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CuQGUO3HgDYryc7TdjxUhpjCaJJIEeYTBw9wB5talj8=;
        b=HogxbxByirWYqsEuY0yvdzDSoqN2aJrPF37fdJBcwfXkow3ZZgvEP54pi/y9sPvmvW
         DmeHC0WsBtZ/lizyvkao5j0GZ3fV4qH4ERKQMReVq8umdwn09j8W/g2VRmUBaKQgAPUc
         VVUubEtJL7wgHggFmzEo91CZ8Ehsiif7nAV1xd4ttHX/kVAhOWXR/V5u/piSlkpzoAmc
         rnokf3Blsj+mL31DTh5xHSvfI52f5JPEFip0rXO6CkuKu0yz4GwVGg5NCejDS5RqlsvJ
         //fPucynaVmV5LGNxFYWBHMLAsLdyHhSHncmhEZ3AOHRErynhbyF/ao5ZoQc6op/dhlm
         rOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374037; x=1794978837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CuQGUO3HgDYryc7TdjxUhpjCaJJIEeYTBw9wB5talj8=;
        b=TCc70HA0BT+8bDwuI99ssGIt86GpIJuicMSC9uaMyNWcHAjqsz27jtoud5fEq3G2l5
         izQN1hUcBCyjjTjA2EkQI4p9L6rp7uusL4nyKhLBH0cXGE9kx9QGlEFxPuRSTu1rXoQu
         naz6WnIUQDhbTOdCokZsDs3Py3wdcPHOkFACJOfO8BvQTuJVpsfdIrhKKcKDDeW6Z0wD
         2h0Ph+I8D99J/2oMuYXnn0yL44SixtYTpO0hUmIz6yIIn1wheULHygHUhRVEoLgpjIhN
         /4imGCvrk2v//4m5c0RLgunpZoiha+2CkLz5+5vSNmxzYv/IhFRS/VsPsZBKEgPnevNk
         AYKg==
X-Gm-Message-State: APuU4Z+O13I8pDbmE+LtsKagEV+hezr61a9CUB01OcrzGtPBmt5BNOsF
	CrNj4mSRT5N96WLJIZjjwSllnf+FenGhJPbiAid65ldHsT1fUv0FCnktNIeHaw==
X-Gm-Gg: AYBFou06cH3JkgQ4/oYdeLwIf1uPBBJelJSM4yQWJ1yt2jeRQN79kf8ZczADNdGw9ih
	+zwfSr6uPXIoXVAVm+l91TtPsgOGJ2kCA/TqwDnPTdD65YZbE9XTq4pCrpKpavOggzkutbVT1gz
	2F0qk1UhWkUDDA2AURZcCgwaosR9/itWV7StpkINiUURnAiEWZ8GUVWQD2NXxGyNuIZZ6mbcmbP
	Q98UvA/P+HrgBa/aK6ihk/eMUmcrFDW0FwIa5VKadUKHmMiUMPA7apO3MP1gxOKlFeWIRE+jAkW
	uL3L+O3RukdDn3kpVVnAuY6/oUdWR/SHqsG6Ar/UC6yV94mT1JrsE7sz6HLv0o/TkiVeB2AU2Ch
	H8ha4bh09Dcot7U24C4XFGTNkxBTNuEVLiHYJddH1tajZ0MNFQERFN5W5TVd42LHwAThp9kJ97u
	sPfsdnGDl9/TbAawvM/YzyMBurLw7WGEBLTqAAz3QEd4iQQs6m3Qhr1/na1Y/ShKAMXL2kaEJc7
	z8DaPPUIHyf7xfRbbJKf3hACVbcQNRiOfZ3+l8+J6bFWQBrDyNlx4R6KAr3ra822jw3W/czUeH/
	c2S5nrs2/E66HcbkAlL+F72DVWdxSx/vsYf+yvG9ADiiK18K8TgeshkKZb787gmJvwDO8erbPZk
	e0VotpBAhHx2FzZ1ibyYRgJWKqc12Tjr+ENigRSB2TKLys724vMppmCuWjO55lBxHYf7Sa31gR5
	k=
X-Received: by 2002:a05:6a21:692:b0:3e1:e53b:5005 with SMTP id adf61e73a8af0-3f2febde44amr1614684637.65.1794374036621;
        Tue, 10 Nov 2026 21:13:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab5f1effsm1662545b3a.49.2026.11.10.21.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:13:56 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 02/29] bpf: Model 32-bit shifts and divisions exactly in scalar evolution
Date: Wed, 11 Nov 2026 05:13:13 +0000
Message-ID: <20261111051341.2800252-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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

