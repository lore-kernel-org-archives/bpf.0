Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C1250BF2
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785457804; cv=none; b=lzPNKM0LkElywZLqFW1F94jcJFv1QE7v4O4Sf6I7Fkvc4Si4hXWig61ftuXKzHzCprlzV/U+QtYPmShigUCG0n6RYdItakMQde1L9vvxp3PLKRePzv0zDe1eqP7aPQTjp9vitHnDBNUAMFzIZFlpATDPyjy9/QM8fGvvKwuopjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785457804; c=relaxed/simple;
	bh=mSA3vRjYQjkXAyBy0gklxrbC1mTx7y/m2jr4N1Je8Os=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OvcpPlm4HxJoWBHde3Z4Px3XNekadIUHKIrdmD82CBE6FBh0ggQJX0zHWTxHywwJOQSuE9mbpUBcq6AYoSpv5GoDHQDf+WhTjpKlwnQj8oYwmFMIVzpI7zpCaS6pHMNiyugjkgrnEdZh71BuRwZm3SSLiq6/JDTuvKMp6c0bMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwxqFIMF; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwxqFIMF"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e6f2ee60bso19975997b3.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 17:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785457801; x=1786062601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QRMRalxGkRReFOWmTtsSnVADD1z6LkTNb+5taBWJoZU=;
        b=EwxqFIMFvVUmFVdYV5X440E85cyFAcPSUY2+eXVBkCulCL2ViBocSBzLREXA+liC85
         kMsCV8YkNLf08UP7KXFtZae6Yr+Cpk5Auq+Ena8CqScIlF7bOgLTpO9p02dNWG4zgnKD
         Q1AP/OzJu2USsiwRmkL7vwxqrsv7C5b+b52D9Xbb6ccxrBZyUUuuym+CGiAJBZZi7uCw
         4zdyRGMvvH/lmAvCVdjg70+All/gdaPxvhD9H1x9DUPhb5zZ2J72TQzoGCtlhtihbtrn
         S5zn5rt+FyjUrLI19qr8qF9I1zWVceq/wLzfUP0+QSLne15v5uybxm38zcWkdxDYlV5r
         +MAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785457801; x=1786062601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QRMRalxGkRReFOWmTtsSnVADD1z6LkTNb+5taBWJoZU=;
        b=TkFOrPCujR86VelcolhZVqvV35ZMU8vwOgC2R5X6HFU7WPfE+QvrI1Lm5tVWBsgxbT
         EejqSrijgL0rl8+5EBUhRFBGPGVwVE5jfcHCiHvRz4Ggl4J4XCEmppMgdOy3eN/Q0HK3
         d5B4uilsMlJpIua+TMPG0ngn5IxrUyrFIL0FZ4w415Trt+Yv4+LGZcvAY0jaF7K2L13+
         UT9D6NPKvk/18Umsi3uO5TAWLwH90jy+Dh5dEi2ubJXTR9MEcExrcUT+dYumk62DfZ2z
         SZLjfSRn82RMvxauzIeL3QwRmZq8XyCi/zIREn86dNK/Jd3+XBeVtyd0Sql1sCOMM5+b
         y4CA==
X-Gm-Message-State: AOJu0Yz/bjCcKU0UsGRjkxcbcf6CzLwjZNW6myGLtMwjOEIyGF8MGG2q
	LasSNSndmG7njZL5795CAaSAOliUY1FNl5I1iZ2t5k1gtS6Gt+pOHTwgdwqjsP09
X-Gm-Gg: AR+sD13Kpd+BS8pLDt/GfEJ+CrANbH86BxrWYBlruLiIm0yEKhrYknWKMIIH1vOGlSO
	L30GQ8iJrbk5TM948R0wjty/UPKhmsWwM5NOBMGCW8WqR8ZGYOroEnHBON4CLvUWjIZx+n4uIvp
	dJoJjHkExEljcdXCdcY3Nb47o2EoShMdV3naGe7+//XXw2rpkA3OldkA3tKrhQ1h5vb5hlclx56
	z+tu7GqE0Yv4r4g389UAwAvDqDuPqMIW6j+dMhBSZxr42fU9bhg79ZB0JGBKMc9w7lPM+jo3elk
	LjfG5aWG6o1UxmyECtAHtVf6OsSIBvCjBS6XBQw3W5UgV2s8DPtHQkfUpoAQWdrmtS6ZCCxAKRB
	hvvMxAPIkjohFAQy0gVHRQm5ce3OPg3kD1w3hFJwiNBT7JTBIFvUiGXt9GhsC+UFD8UkZTSA3w6
	1I5zUBwK1EI2pAiUAFhtlZcysDp03LILJwb6yBAOV5NpdoJpo88ij9Mw4iHIo2kc5TrUYUkw==
X-Received: by 2002:a05:690c:a01b:b0:81e:94bd:6473 with SMTP id 00721157ae682-81fc1896b01mr15268507b3.30.1785457801138;
        Thu, 30 Jul 2026 17:30:01 -0700 (PDT)
Received: from TurinLinux.home ([187.15.144.227])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c6e8de7sm2355997d50.4.2026.07.30.17.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 17:30:00 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: bpf@vger.kernel.org,
	udknight@gmail.com,
	x86@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com
Subject: [PATCH bpf-next v3] bpf, x86: Add support for BPF_SDIV and BPF_SMOD in the i386 JIT
Date: Thu, 30 Jul 2026 20:29:50 -0400
Message-Id: <20260731002950.179573-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

emit_ia32_div_mod_r() emits an unsigned divide (xor edx,edx + div ecx)
for BPF_DIV and BPF_MOD regardless of the instruction's signedness, so
the i386 JIT does not implement signed BPF_SDIV and BPF_SMOD (off == 1),
which get an unsigned quotient and remainder rather than the verifier's
and the interpreter's signed result for negative operands.

Add signed support. Pass the instruction to emit_ia32_div_mod_r() and,
on the signed path (off == 1), emit cdq + idiv ecx instead of
xor edx,edx + div ecx, mirroring the cdq/idiv-vs-xor/div split the
x86_64 JIT uses. bpf_do_misc_fixups() rewrites the zero-divisor and
INT_MIN/-1 cases out of the instruction stream before the JIT runs.

The RV32 JIT has the same gap.

Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
v3:
- Correct the incomplete recipient list.

v2:
- Frame as adding support and drop the Fixes tag, per Pu Lehui [1].
- Pass struct bpf_insn * to emit_ia32_div_mod_r() rather than separate
  op and is_signed parameters, per Kuan-Wei Chiu.

v2: https://lore.kernel.org/bpf/20260714023939.616686-1-main.kalliope@gmail.com/
v1: https://lore.kernel.org/bpf/20260713185848.120137-1-main.kalliope@gmail.com/
[1]: https://lore.kernel.org/bpf/fa8a040f-64c4-484f-9538-fb0ec287639f@huawei.com/

 arch/x86/net/bpf_jit_comp32.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 852baf2e4db4..012161da3e82 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -432,11 +432,13 @@ static inline void emit_ia32_to_be_r64(const u8 dst[], s32 val,
  * ALU operation (32 bit)
  * dst = dst (div|mod) src
  */
-static inline void emit_ia32_div_mod_r(const u8 op, const u8 dst, const u8 src,
-				       bool dstk, bool sstk, u8 **pprog)
+static inline void emit_ia32_div_mod_r(const struct bpf_insn *insn, const u8 dst,
+				       const u8 src, bool dstk, bool sstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
 	int cnt = 0;
+	const u8 op = BPF_OP(insn->code);
+	const bool is_signed = (insn->off == 1);
 
 	if (sstk)
 		/* mov ecx,dword ptr [ebp+off] */
@@ -454,10 +456,17 @@ static inline void emit_ia32_div_mod_r(const u8 op, const u8 dst, const u8 src,
 		/* mov eax,dst */
 		EMIT2(0x8B, add_2reg(0xC0, dst, IA32_EAX));
 
-	/* xor edx,edx */
-	EMIT2(0x31, add_2reg(0xC0, IA32_EDX, IA32_EDX));
-	/* div ecx */
-	EMIT2(0xF7, add_1reg(0xF0, IA32_ECX));
+	if (is_signed) {
+		/* cdq */
+		EMIT1(0x99);
+		/* idiv ecx */
+		EMIT2(0xF7, add_1reg(0xF8, IA32_ECX));
+	} else {
+		/* xor edx,edx */
+		EMIT2(0x31, add_2reg(0xC0, IA32_EDX, IA32_EDX));
+		/* div ecx */
+		EMIT2(0xF7, add_1reg(0xF0, IA32_ECX));
+	}
 
 	if (op == BPF_MOD) {
 		if (dstk)
@@ -1795,14 +1804,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_ALU | BPF_MOD | BPF_X:
 			switch (BPF_SRC(code)) {
 			case BPF_X:
-				emit_ia32_div_mod_r(BPF_OP(code), dst_lo,
+				emit_ia32_div_mod_r(insn, dst_lo,
 						    src_lo, dstk, sstk, &prog);
 				break;
 			case BPF_K:
 				/* mov ecx,imm32*/
 				EMIT2_off32(0xC7, add_1reg(0xC0, IA32_ECX),
 					    imm32);
-				emit_ia32_div_mod_r(BPF_OP(code), dst_lo,
+				emit_ia32_div_mod_r(insn, dst_lo,
 						    IA32_ECX, dstk, false,
 						    &prog);
 				break;

base-commit: 863f3ddd0b8ac65abfb50d3be0869268ac0e277b
