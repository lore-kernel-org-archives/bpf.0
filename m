Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8B3CF1F8
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438453; cv=none; b=L9yiZO8SX2yoIDhFCHKJCKCQL6KTt4Yg1oEXQp+dJF2YvBtl4MBeP0QHDCrnpNGsitWritXnL2yv6w2uov5qCvvni8xXjD0SL9eSrur9x5JNIGjboxHG8dB7DMs6CCOA2oaPCaWtUSk2oaZAuK3jRkYnSjHY0M9sJnJL7q8jxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438453; c=relaxed/simple;
	bh=ZDux8IWKTR+nMiDaW8QlWTXplfoJrXXpLbQBsYiak+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrMAADDRaj1vx26yqgMF0moJcRg3PeOmvX4f2guA/0Dl6BfJMx7bkfuPykuJPVqn+cmMjLpMYLiQEfEGaxlEqyweZ01dI7uGpjgKCOrgmb/sHsvJAyab0/U0WHuFKsA5rzpF/YWOBN/BpDC3hcCKtb4oohI97KiuTKytSnYMx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiOLVFo9; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiOLVFo9"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0bso35615346d6.3
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789438450; x=1790043250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HuFmciVjVBaKzPczWLuz+SOkqXuntlpMYqQwvPavVgE=;
        b=MiOLVFo9jPrdk6TvdKflUMp7YIGRImk7AJMAqH+E5IWo7E9qPFjfMd6YdE9ytre+yB
         Vx2uP+Pel/KV9Lf5A4jMZHBJXbFjLySiG1wINdkxbyonHp7H1wwwVYM+2Oq0Jhev79Yb
         CjFNa+Jvlmd6l6uHZCgo3k4K9hOxttXRoMyYgBhz0uCtbXF+ky4xWLVWr2vpNzSp972b
         sQJCRTS3+6sxyf8ESAzayjrnugyyzr/qZTg3NaTul5VY2VqeMGqxoHhOGwklZGi8JfoM
         z8wG3UUfEOAM0d3QKsgmrnudZuVD4ig+V+PvD5j2nH3EdHGyoFzDIYWg78mDeQulfEv4
         jZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789438450; x=1790043250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HuFmciVjVBaKzPczWLuz+SOkqXuntlpMYqQwvPavVgE=;
        b=KLdoQVqhIfYemqPcRPpTBSGZX8W981bAOYYKqCl9exGC/nRBy9mDt1qEsu6+kTZOpo
         bYt8tJ9T0yF44Xo5rZu+3BCS1JX8x5aMhhQg20rFUO4MZ5dU+sOC5fDdlC2Cn669HH8f
         OtT22SzL/0VmeA7x30SGRrY0fbSU1zvveiiquk6f+kz9VU9EJ9ZGPCJHMZ602feGJTmt
         uwUKSj+bpJbPuojarv02cjurRbmqqNCiO8FWkKH0x+IXT1tXMNaoWNJBMyseWS5Jut9K
         KRPyO034m7AfxbXnXZ3BOUzSoi0oa5zOZVPu3etRfbA5C2KWi+zjAoCM6ZbeUHnMQHB4
         gwDQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/sAIKy/IcDg99IX4N+y+OiRZgDBRDPvgkQdt9QEiq5VOWowZOi8rfWJ9V/CkRyljDll8=@vger.kernel.org
X-Gm-Message-State: AFuF++m1YwTaPfZdfydY+PCh2Hwc86qkntBzd4DwG+lvmpLtB+T0KyrM
	uN6ghd7XlpPCiOsHxLY2cAfvabVESYNEsDdzaVsdylpBwun66tagiUH0
X-Gm-Gg: AYBFou2JCkGkXSQ3dO24694PwjZk2wH8w/KrFKpRxrOm9LB7qg5gXNxqzvP4nQGT5HG
	Yoe0lJGmdYjlSdNGTVx4RJfHy+2xkRI0KocVtKGY1/uE6/kklLu1vsDZtUOpcKcMOcKNsBuElSW
	c0Ah+UH4hExE0ANj35yLOOJq8CZ5QPsCDyP3vlOWhg0lLjcA4SZOZaZykAWDo+ha7eJ97s1hV7J
	BMhxsh1SibljBpafE3+GYArfVKJIat/K1xYPPFgJ//1PqZnJ+F868xLlZohyVCe4Us42QSKrgq8
	xZjCbUCZsCG6AfIGkZZqI2WKqA1FuBWsMFy0UE7syWGK9O9W4TVOEDmCXyK3Y+BeEVtQCar9AXr
	urG3lEqr98Sn7nz52UVuxK9bmqMB40Xm+SAhfsnEhgMEztjMFFyisDDGfse4p6yu1JGTpotYtS7
	c+DVFjWZs1kuW7LEIz4eFR+24k9PRZ+WXBKCJKzFW+tH+1kLe65+Rc2FpQT5LOXzlR
X-Received: by 2002:a05:6214:4289:b0:910:63b6:fc60 with SMTP id 6a1803df08f44-9122e4ec8f2mr115365286d6.11.1789438449826;
        Mon, 14 Sep 2026 19:14:09 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f47e800sm113147306d6.27.2026.09.14.19.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:14:09 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	udknight@gmail.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com
Subject: [PATCH bpf-next 2/5] bpf, x86: Extract the i386 JIT load emitter
Date: Mon, 14 Sep 2026 22:13:35 -0400
Message-ID: <20260915021338.1520964-3-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915021338.1520964-1-main.kalliope@gmail.com>
References: <20260915021338.1520964-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move ordinary LDX lowering into an instruction-owned helper. Keep address
staging, displacement encoding and register-pair completion together,
including verifier-managed zero extension for narrow loads.

Use the helper for the existing BPF_MEM cases before adding signed loads.
This separates the code movement from the MEMSX instruction handling.
The emitted instructions are preserved.

Assisted-by: Codex:gpt-6
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/x86/net/bpf_jit_comp32.c | 148 +++++++++++++++++++---------------
 1 file changed, 84 insertions(+), 64 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 9cbeabac4f27..6839c233cb73 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1214,6 +1214,89 @@ static inline void emit_ia32_mul_i64(const u8 dst[], const u32 val,
 	*pprog = prog;
 }
 
+static void emit_ia32_ldx(const struct bpf_insn *insn, u8 **pprog,
+			  const struct bpf_prog_aux *aux)
+{
+	const u8 *dst = bpf2ia32[insn->dst_reg];
+	const u8 *src = bpf2ia32[insn->src_reg];
+	bool dstk = insn->dst_reg != BPF_REG_AX;
+	bool sstk = insn->src_reg != BPF_REG_AX;
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	/* Stage the address in EAX; dst may alias src. */
+	if (sstk)
+		/* mov eax,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
+		      STACK_VAR(src_lo));
+	else
+		/* mov eax,src_lo */
+		EMIT2(0x8B, add_2reg(0xC0, src_lo, IA32_EAX));
+
+	switch (BPF_SIZE(insn->code)) {
+	case BPF_B:
+		/* movzx edx,byte ptr [eax+off] */
+		EMIT2(0x0F, 0xB6);
+		break;
+	case BPF_H:
+		/* movzx edx,word ptr [eax+off] */
+		EMIT2(0x0F, 0xB7);
+		break;
+	case BPF_W:
+	case BPF_DW:
+		/* mov edx,dword ptr [eax+off] */
+		EMIT1(0x8B);
+		break;
+	}
+
+	if (is_imm8(insn->off))
+		EMIT2(add_2reg(0x40, IA32_EAX, IA32_EDX), insn->off);
+	else
+		EMIT1_off32(add_2reg(0x80, IA32_EAX, IA32_EDX), insn->off);
+
+	if (dstk)
+		/* mov dword ptr [ebp+off],edx */
+		EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EDX),
+		      STACK_VAR(dst_lo));
+	else
+		/* mov dst_lo,edx */
+		EMIT2(0x89, add_2reg(0xC0, dst_lo, IA32_EDX));
+
+	switch (BPF_SIZE(insn->code)) {
+	case BPF_B:
+	case BPF_H:
+	case BPF_W:
+		if (aux->verifier_zext)
+			break;
+		if (dstk) {
+			/* mov dword ptr [ebp+off],0 */
+			EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
+			      STACK_VAR(dst_hi));
+			EMIT(0x0, 4);
+		} else {
+			/* xor dst_hi,dst_hi */
+			EMIT2(0x33, add_2reg(0xC0, dst_hi, dst_hi));
+		}
+		break;
+	case BPF_DW:
+		/* mov edx,dword ptr [eax+off+4] */
+		EMIT2_off32(0x8B, add_2reg(0x80, IA32_EAX, IA32_EDX),
+			    insn->off + 4);
+		if (dstk)
+			/* mov dword ptr [ebp+off],edx */
+			EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EDX),
+			      STACK_VAR(dst_hi));
+		else
+			/* mov dst_hi,edx */
+			EMIT2(0x89, add_2reg(0xC0, dst_hi, IA32_EDX));
+		break;
+	default:
+		break;
+	}
+
+	*pprog = prog;
+}
+
 static int bpf_size_to_x86_bytes(int bpf_size)
 {
 	if (bpf_size == BPF_W)
@@ -2065,70 +2148,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_LDX | BPF_MEM | BPF_H:
 		case BPF_LDX | BPF_MEM | BPF_W:
 		case BPF_LDX | BPF_MEM | BPF_DW:
-			if (sstk)
-				/* mov eax,dword ptr [ebp+off] */
-				EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
-				      STACK_VAR(src_lo));
-			else
-				/* mov eax,dword ptr [ebp+off] */
-				EMIT2(0x8B, add_2reg(0xC0, src_lo, IA32_EAX));
-
-			switch (BPF_SIZE(code)) {
-			case BPF_B:
-				EMIT2(0x0F, 0xB6); break;
-			case BPF_H:
-				EMIT2(0x0F, 0xB7); break;
-			case BPF_W:
-			case BPF_DW:
-				EMIT(0x8B, 1); break;
-			}
-
-			if (is_imm8(insn->off))
-				EMIT2(add_2reg(0x40, IA32_EAX, IA32_EDX),
-				      insn->off);
-			else
-				EMIT1_off32(add_2reg(0x80, IA32_EAX, IA32_EDX),
-					    insn->off);
-
-			if (dstk)
-				/* mov dword ptr [ebp+off],edx */
-				EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EDX),
-				      STACK_VAR(dst_lo));
-			else
-				/* mov dst_lo,edx */
-				EMIT2(0x89, add_2reg(0xC0, dst_lo, IA32_EDX));
-			switch (BPF_SIZE(code)) {
-			case BPF_B:
-			case BPF_H:
-			case BPF_W:
-				if (bpf_prog->aux->verifier_zext)
-					break;
-				if (dstk) {
-					EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
-					      STACK_VAR(dst_hi));
-					EMIT(0x0, 4);
-				} else {
-					/* xor dst_hi,dst_hi */
-					EMIT2(0x33,
-					      add_2reg(0xC0, dst_hi, dst_hi));
-				}
-				break;
-			case BPF_DW:
-				EMIT2_off32(0x8B,
-					    add_2reg(0x80, IA32_EAX, IA32_EDX),
-					    insn->off + 4);
-				if (dstk)
-					EMIT3(0x89,
-					      add_2reg(0x40, IA32_EBP,
-						       IA32_EDX),
-					      STACK_VAR(dst_hi));
-				else
-					EMIT2(0x89,
-					      add_2reg(0xC0, dst_hi, IA32_EDX));
-				break;
-			default:
-				break;
-			}
+			emit_ia32_ldx(insn, &prog, bpf_prog->aux);
 			break;
 		/* call */
 		case BPF_JMP | BPF_CALL:
