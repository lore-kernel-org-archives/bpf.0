Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807DB3CF68E
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438457; cv=none; b=D+scFtFWGiDS6vv+VB3kU1H/dsVC4bIW6B44Vv4rqC6xXiUlEdqbLAqPqnEOGjUqNBIuCUeodKzGN7XgAwK5MLc/Pul95uK90shSKCT1pcyxwuYP7325BpKopKX7Myejnogz9eLTWLW62iBzLrHC6QVXGqhHq2ibjen3ELgccVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438457; c=relaxed/simple;
	bh=TdqvwGyPTSdjX8dTecFU8bgsVtp8D+qt1YBdhE4JhsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9Fhz9LWlRahIMhK3eEugFukFo1nPq+MqR5HjsRgIuGHsYIGnLY+bdA5lmxhfuR671vfW9ciD1dLha6axJ7dT+vYvU9y+mR9JxVpnMhuS5nfNi8KoAeS2WFjTc8BnEQXjeUxTtOR7LBJz4mWHp2AjFckudP7Jj+3AbsNsT07Wng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOXQJcnO; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOXQJcnO"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfe60d5fso38744826d6.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 19:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789438453; x=1790043253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U2Vegq3Ok1ZpjxSq9TiA3YgOUyAjEHN8flyn+dvT4jU=;
        b=iOXQJcnOj3ZYKBpYqoSVup3V6JBEb2k7+QNojlfaQBdzh81vzoxqjkHMRgYwjIxBBO
         zXF/PB4t6i3qR6RIm2ZelkkhktJ+oVB/JSdgH87rkUXhj/G1M1feiTBRiPAImDlEkVpA
         DmGrICof+9XlCgot3vai/rOZyvU1pMpMFeUSMNXwyMN+xRnGg5EYblfUoh0Zujxuas+z
         oGbYHqpj8lTXxDAoTuoCjNr32kKRY8O3tIVkr+uPt1cmeVQkX+TWPUakBQZrgi+mq18Z
         vAAM+Wkk+MCT+oPmA8bNIWb8NlDhzft7p66UCGbCSw9q8HaKVNrQ15OOYVYYqTCwyglE
         k//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789438453; x=1790043253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U2Vegq3Ok1ZpjxSq9TiA3YgOUyAjEHN8flyn+dvT4jU=;
        b=PwToyPlGk8bvZ1L6EeXMmzbFkKAGtwx3fxVOM29lQK/tup/tLu7tO7+UaDMKXjUIwC
         C2FXpt9h7kwz2ryY+ehr4tKWEqPtAxseIrBReernmSHz1sP/+NeVg/cBZT/+mpAQ6+Hb
         lvEVsJw0/7RJrGa3D7Sgo5DryfPoxYVAw4Y1FgWc3wPaxY4uk/ME4v5dzUs5DTN+aUJy
         Wp8T00Nniv8c0d4rVjXACDVmP9AaY/eGfj+nVKf9L5mdaQQfrLraGwygJYjVZD5AhXNR
         U1v67biEs09zLgnn2t8VqajEgCI4p3X2kODXHPbE5GYQZIPQfYRZhjwEAWtUtaxH3RdA
         VQzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOK4adE3qH59DY7qEBPr5gGywaWRaKEgbpA0MLr7Ff+JPJGRlE+PlEzkTq5i2qzm0/+Ac=@vger.kernel.org
X-Gm-Message-State: AFuF++lw6hCvzOnQ+2ZE6tNtB6Y34kS1PkpJHFK3IG/aXMrCytnAkszI
	8sBjsJTFAZ24oUKOjC2iTb0ltkXgvb42MTbZNaOdmVHfHeKSs0t4Ab/6
X-Gm-Gg: AYBFou11qPz/bcAFBAzW2lgIaBX7lgl391EjCdYQtt4GSnm2J2NqEm16aOxJEJzS9un
	aSDEAAMrmz1vMBC1hyPc0lpVhjtA40xfUiiT7Y7hUs2ePbbo7Bo/6BkcTSfhzV9Kib8dReeCbeY
	8GBx2AuwmAC4Hz8rXJzXe7qyA4t5Q7XLIrjkzEbphlqM5QWBsd/jDf+vzlVzkfOpFvqM9MmLtpU
	7QM0/devPo90R2QqPecd0KNm0h2oB8+APeRe9J9Y2/Y+4JotdEKrcUlWGQD8yzWTGwKwdu+1KG3
	zdhfAFpnsJSoXjtfwQWMulq07uC6kZS3iqoQ30tiUDa5xE0Vae3/UrRpPx1NbDtlwavLF9dvJnf
	pdNOIeJnC9t+zWF248WJ5gaLisvcyzv6KI7/m6NQ09EhYaxeYfvVUbOg5o4/VZ+6wsr1P4xqW6F
	HNQmQd4D/l4D6FFMHD6c5BPMK//CV4hnnKuwguQKnCRInNdB3bOanH9Y6Vimlbnxvv
X-Received: by 2002:a05:6214:5f11:b0:912:bd1:49f5 with SMTP id 6a1803df08f44-9122e4e2154mr80192546d6.10.1789438453123;
        Mon, 14 Sep 2026 19:14:13 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f47e800sm113147306d6.27.2026.09.14.19.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:14:12 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/5] bpf, x86: Add BPF_MEMSX support to the i386 JIT
Date: Mon, 14 Sep 2026 22:13:36 -0400
Message-ID: <20260915021338.1520964-4-main.kalliope@gmail.com>
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

The i386 JIT rejects BPF_MEMSX byte, halfword and word loads.

Use signed byte and halfword loads, then extend the loaded low word's
sign into the upper word for all three MEMSX widths. MEMSX defines a
64-bit result, so complete both halves regardless of verifier_zext.
Ordinary loads retain their existing zero-extension handling.

Assisted-by: Codex:gpt-6
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/x86/net/bpf_jit_comp32.c | 71 ++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 6839c233cb73..bbe48b15850f 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1221,6 +1221,7 @@ static void emit_ia32_ldx(const struct bpf_insn *insn, u8 **pprog,
 	const u8 *src = bpf2ia32[insn->src_reg];
 	bool dstk = insn->dst_reg != BPF_REG_AX;
 	bool sstk = insn->src_reg != BPF_REG_AX;
+	bool sign = BPF_MODE(insn->code) == BPF_MEMSX;
 	u8 *prog = *pprog;
 	int cnt = 0;
 
@@ -1235,12 +1236,12 @@ static void emit_ia32_ldx(const struct bpf_insn *insn, u8 **pprog,
 
 	switch (BPF_SIZE(insn->code)) {
 	case BPF_B:
-		/* movzx edx,byte ptr [eax+off] */
-		EMIT2(0x0F, 0xB6);
+		/* movsx/movzx edx,byte ptr [eax+off] */
+		EMIT2(0x0F, sign ? 0xBE : 0xB6);
 		break;
 	case BPF_H:
-		/* movzx edx,word ptr [eax+off] */
-		EMIT2(0x0F, 0xB7);
+		/* movsx/movzx edx,word ptr [eax+off] */
+		EMIT2(0x0F, sign ? 0xBF : 0xB7);
 		break;
 	case BPF_W:
 	case BPF_DW:
@@ -1262,26 +1263,10 @@ static void emit_ia32_ldx(const struct bpf_insn *insn, u8 **pprog,
 		/* mov dst_lo,edx */
 		EMIT2(0x89, add_2reg(0xC0, dst_lo, IA32_EDX));
 
-	switch (BPF_SIZE(insn->code)) {
-	case BPF_B:
-	case BPF_H:
-	case BPF_W:
-		if (aux->verifier_zext)
-			break;
-		if (dstk) {
-			/* mov dword ptr [ebp+off],0 */
-			EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
-			      STACK_VAR(dst_hi));
-			EMIT(0x0, 4);
-		} else {
-			/* xor dst_hi,dst_hi */
-			EMIT2(0x33, add_2reg(0xC0, dst_hi, dst_hi));
-		}
-		break;
-	case BPF_DW:
-		/* mov edx,dword ptr [eax+off+4] */
-		EMIT2_off32(0x8B, add_2reg(0x80, IA32_EAX, IA32_EDX),
-			    insn->off + 4);
+	/* MEMSX defines both halves, regardless of verifier_zext. */
+	if (sign) {
+		/* sar edx,31 */
+		EMIT3(0xC1, add_1reg(0xF8, IA32_EDX), 31);
 		if (dstk)
 			/* mov dword ptr [ebp+off],edx */
 			EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EDX),
@@ -1289,9 +1274,38 @@ static void emit_ia32_ldx(const struct bpf_insn *insn, u8 **pprog,
 		else
 			/* mov dst_hi,edx */
 			EMIT2(0x89, add_2reg(0xC0, dst_hi, IA32_EDX));
-		break;
-	default:
-		break;
+	} else {
+		switch (BPF_SIZE(insn->code)) {
+		case BPF_B:
+		case BPF_H:
+		case BPF_W:
+			if (aux->verifier_zext)
+				break;
+			if (dstk) {
+				/* mov dword ptr [ebp+off],0 */
+				EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
+				      STACK_VAR(dst_hi));
+				EMIT(0x0, 4);
+			} else {
+				/* xor dst_hi,dst_hi */
+				EMIT2(0x33, add_2reg(0xC0, dst_hi, dst_hi));
+			}
+			break;
+		case BPF_DW:
+			/* mov edx,dword ptr [eax+off+4] */
+			EMIT2_off32(0x8B, add_2reg(0x80, IA32_EAX, IA32_EDX),
+				    insn->off + 4);
+			if (dstk)
+				/* mov dword ptr [ebp+off],edx */
+				EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EDX),
+				      STACK_VAR(dst_hi));
+			else
+				/* mov dst_hi,edx */
+				EMIT2(0x89, add_2reg(0xC0, dst_hi, IA32_EDX));
+			break;
+		default:
+			break;
+		}
 	}
 
 	*pprog = prog;
@@ -2148,6 +2162,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_LDX | BPF_MEM | BPF_H:
 		case BPF_LDX | BPF_MEM | BPF_W:
 		case BPF_LDX | BPF_MEM | BPF_DW:
+		case BPF_LDX | BPF_MEMSX | BPF_B:
+		case BPF_LDX | BPF_MEMSX | BPF_H:
+		case BPF_LDX | BPF_MEMSX | BPF_W:
 			emit_ia32_ldx(insn, &prog, bpf_prog->aux);
 			break;
 		/* call */
