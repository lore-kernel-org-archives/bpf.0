Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB93546C1
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783969139; cv=none; b=cHyhYqvX8gEiJ2thdTcD9otPEVzqoDJB5VieB5es52XLTMygIyFQEUhRzOjRFOHe171ns+O6ik3v9XYoF/kUb3rtdlcJZK9Nm/y28pKr1afYaLCxvYNsi3cLqVU2g7H41hatPLewkhPYkvdSPMvzKZMywOqbZWg2hqbyckNcZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783969139; c=relaxed/simple;
	bh=Bec2ps2CjNlhIZvtY1rPZu6qox9XqKP8Kz9Wfex95XI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OKTTzN1fk2VgM1dCz42EvwstUcjwJjj8dqvjeGG9NCW4es7HVk+sbv63Gs4QD69ew6hgCQ17sRPI3SKq9P/gkU2rCwvBbP1pnEiCtUL0K0LTYAoAJwEtuZ4hyisDujR08dSVE0ZYanygaCChQ0k7Pqg0R1p929re9OvDViXebnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chBilgjF; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chBilgjF"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9061a795d76so1998826d6.3
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783969137; x=1784573937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wgADp8c7zjm6mmwgMM8pxNjOo3KpVBZONQXuti31+4E=;
        b=chBilgjFZMnxglfGR90rQTfhxbsKbQIrX5JpG9of4wCKI8BQU40CjKfBK6ahAmWGOe
         w8zvZOkVUAqzJSw2ZlaMOKIkVuMGuqDDyNl5G0hgKgR2A0HWtOV6Ek/gfWkoXtDnxA/C
         qkzAilQmW9v4aI/+p8xIqtfBdvIow2IAAZNk+cxKLyMIOGo3EQJ0WHAGHerVyNzUdL15
         J4gQdXA04vzPE/hmyUXHvvEeLEVQwXi/R18E4cQm8XGTUxYm4mdV0dpg0bqCeQvyOKmP
         PCxxCAFdCBQASMDsGiAAEta+0N/mg4R8nsWjcPIbky/vJCwvXMlMh6VwrvNKxhLaF+Cg
         WBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783969137; x=1784573937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wgADp8c7zjm6mmwgMM8pxNjOo3KpVBZONQXuti31+4E=;
        b=dufwVa6ZMfG2kUVuXr1UjlM175k3j5bbEHzk6FDZq6RZa2/D762DeyXJWiHODcKvzs
         wdfBl2GlrLcH4D3O66Vbi4hZ5rZ2Ln9gbCltYMUhNWDj5sCrMyIm13zR+E8XsZOItwV2
         /TmX9Ta0jdkZwq7GQTrTqPQ4td7n+VsIuyxwgTRnwwB9NN1arcLFb1fmGyHDgPRlxjGE
         DGwDjLQyqbt1lrrIiK0bWoms2UAfeirllT6UmTvzTi2WafoeEJEpKOwhMEDS9iwouPVB
         /OUhm7ofCmTtneSHvUI/KPnnhxynknjgpM8KWPK4xDwRo29/QGf0gh041YAKFQHkyuk6
         QqHg==
X-Gm-Message-State: AOJu0YyE9wudZsvjIDsI89IEXFKZw0cY/eE1OouidypQ+xuqqRNORfVi
	pcEuywv1hT1fewsdtdKHq3Pz2HJztWIq3Km+ng96mvWwijNjuNrQgwAyW0ZI+w==
X-Gm-Gg: AfdE7cnbrl9ZHQcleT6qFCn15WaHsCH9Pb93AsVm9mCSqP+hx8I46KTz4xoCMCEx0ih
	cyp6Q/YOc6ABrOCnbGCmPaYLWXSDtyMkyKPDA8jrLOZSsQ/ObnavN5mucmoJ6tkrFKrT0vP4ab3
	FJuKGaJuuaQq6hdBJv7jsFJxtlTnaepuwSYLhIEjRY65HPAYM1OfUESByVfwQRDR6G7tqPM6eJh
	ko/snYtwOosUUpJIhsBcI0c2vA3BTS3Y32Tzzwjs+1F/F61lhOn4cj1o+5LgX/i6zgLPEhsejr6
	VguesBVAFMezXLBQxINRdPfxRVQGjPnfDkOVySKeAGRzLe1YIR4NBzWX67qwNg4C30PQM7lPkpJ
	0Jx7W7ecO2T3oM5+xD1/+PnJdGAlYl/3rgwtW+rD9l6TukabtD5+10iesJehFWEmYs4KKh7NI2q
	7sXXZ4fUBYGsBvX5dr
X-Received: by 2002:a05:6214:451a:b0:8ef:6102:7ff3 with SMTP id 6a1803df08f44-9040395e09dmr113384266d6.44.1783969137323;
        Mon, 13 Jul 2026 11:58:57 -0700 (PDT)
Received: from TurinLinux.. ([37.19.213.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-902de1fdb3bsm111305516d6.23.2026.07.13.11.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 11:58:56 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: bpf@vger.kernel.org,
	udknight@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	visitorckw@gmail.com
Subject: [PATCH bpf] bpf, x86: Fix signed 32-bit div/mod in the i386 JIT
Date: Mon, 13 Jul 2026 14:58:48 -0400
Message-Id: <20260713185848.120137-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

emit_ia32_div_mod_r() always emits an unsigned divide (xor edx,edx +
div ecx), regardless of the BPF instruction's signedness. Signed
ALU32 BPF_DIV and BPF_MOD (off=1) therefore get an unsigned quotient
and remainder in the i386 JIT, diverging from the verifier's and the
interpreter's signed result for negative operands.

Thread is_signed = (insn->off == 1) into emit_ia32_div_mod_r() and
emit cdq + idiv ecx on the signed path, xor edx,edx + div ecx
unchanged on the unsigned path, mirroring the cdq/idiv-vs-xor/div
split the x86_64 JIT uses for the same instructions. bpf_do_misc_fixups()
rewrites the zero-divisor and INT_MIN/-1 cases out of the instruction
stream before the JIT runs.

The RV32 JIT has the same gap.

Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 arch/x86/net/bpf_jit_comp32.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 852baf2e4db4..46b47432f50a 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -433,7 +433,8 @@ static inline void emit_ia32_to_be_r64(const u8 dst[], s32 val,
  * dst = dst (div|mod) src
  */
 static inline void emit_ia32_div_mod_r(const u8 op, const u8 dst, const u8 src,
-				       bool dstk, bool sstk, u8 **pprog)
+				       bool dstk, bool sstk, bool is_signed,
+				       u8 **pprog)
 {
 	u8 *prog = *pprog;
 	int cnt = 0;
@@ -454,10 +455,17 @@ static inline void emit_ia32_div_mod_r(const u8 op, const u8 dst, const u8 src,
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
@@ -1796,7 +1804,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			switch (BPF_SRC(code)) {
 			case BPF_X:
 				emit_ia32_div_mod_r(BPF_OP(code), dst_lo,
-						    src_lo, dstk, sstk, &prog);
+						    src_lo, dstk, sstk,
+						    insn->off == 1, &prog);
 				break;
 			case BPF_K:
 				/* mov ecx,imm32*/
@@ -1804,7 +1813,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 					    imm32);
 				emit_ia32_div_mod_r(BPF_OP(code), dst_lo,
 						    IA32_ECX, dstk, false,
-						    &prog);
+						    insn->off == 1, &prog);
 				break;
 			}
 			if (!bpf_prog->aux->verifier_zext)

base-commit: 7cbd0c4cebe4c9f678d15e6b9ba975e1155a107f
-- 
2.34.1

