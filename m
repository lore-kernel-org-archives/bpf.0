Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D83E7BB3;
	Wed,  8 Jul 2026 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497766; cv=none; b=cq/LXb71mqIDAH3CTcIW7ExKfC9V0EdG7TVvFeeo+zPQPjLF94ZRs792toDU3/Bay2MrydzbXyBwPyjFxdoysy+e6aTen1qxWBCHGSXde1/YDCGgYTw3tSFxDya+XDt7YkP1tj7hupu7wYsUyKX8EVB+8x25w1QF/IKHuLBHp2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497766; c=relaxed/simple;
	bh=ZMXpIwtRPGuItKuwPGD+cnFe6Bfbsj4bYITDtDaXM+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6VYx+wkaPjmP5cle+1VXzA+ZcUqy0/MNXXb5URyIWk4QXADQUSD2kdW5KHnb1O4mRkAMKtg74A/VS7BicL2+zZNF8AL4C0VyJxZX5IETiM9FuHUGeZ9YJtG3GHK0MoD5kF5dUrLQNom/+zUDZh8l73GDA9YQgPN9QBt5cuZAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=enIZzpnX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="enIZzpnX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 68F57C8F456;
	Wed,  8 Jul 2026 08:02:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8EF4D60337;
	Wed,  8 Jul 2026 08:02:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A801C11BC3255;
	Wed,  8 Jul 2026 10:02:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783497756; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IgEGaHgPaHPFltZQfwQboKseBVstr+JlNLLPyKGo1GU=;
	b=enIZzpnX/rzJv6MqXybPnZWjgxOc8A2ecTeV2dDvYsQVX/f1nrkX0hPSlMfMzghnABN6SH
	8OzU1hsB1INP60UzbPBwgCfGHfvSlMJYOFeJdxyeEGRj5YFmM2zUOtgQo6D3jhbLjgvzTe
	u+fpPf8jMyP23wfKsrKATnhsxC23/nvt/at/cUoDssLU8Cw/P8n0uuht4OcymiRi6WUflf
	g/AyDBB53i6hC794aTjEKz5f5mouwDm+cRGWFyk30LZ0jb88xXoOF/jFGl+yOcLgl86/Dl
	oKYY1rwtImeki3YjTuTUs6++ocae58LPxGdN+uKC3/E5ISEOdO5bf9lVwq45Pw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 08 Jul 2026 10:00:28 +0200
Subject: [PATCH bpf-next v4 05/10] bpf, x86: refactor BPF_ST management in
 do_jit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-kasan-v4-5-d5c177ab8227@bootlin.com>
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
In-Reply-To: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

In order to prepare for KASAN checks insertion before every
memory-related load or store, group all BPF_ST instructions that indeed
access memory in a single helper to allow instrumenting those in one
call, rather than having to instrument all cases individually.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- new patch
---
 arch/x86/net/bpf_jit_comp.c | 99 +++++++++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 39 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d35f58350d71..959fcaa0cde9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1410,6 +1410,64 @@ static void emit_st_index(u8 **pprog, u32 size, u32 dst_reg, u32 index_reg, int
 	*pprog = prog;
 }
 
+static void emit_st(u8 **pprog, struct bpf_insn *insn, int dst_reg,
+		    s32 outgoing_arg_base, u16 outgoing_rsp)
+{
+	s32 imm32 = insn->imm;
+	u8 *prog = *pprog;
+	s32 insn_off;
+
+	switch (BPF_SIZE(insn->code)) {
+	case BPF_B:
+		if (is_ereg(dst_reg))
+			EMIT2(0x41, 0xC6);
+		else
+			EMIT1(0xC6);
+		break;
+	case BPF_H:
+		if (is_ereg(dst_reg))
+			EMIT3(0x66, 0x41, 0xC7);
+		else
+			EMIT2(0x66, 0xC7);
+		break;
+	case BPF_W:
+		if (is_ereg(dst_reg))
+			EMIT2(0x41, 0xC7);
+		else
+			EMIT1(0xC7);
+		break;
+	case BPF_DW:
+		if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
+			/* Arg 6: store immediate in r9 register */
+			emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31,
+				       (u32)imm32);
+			*pprog = prog;
+			return;
+		}
+		EMIT2(add_1mod(0x48, dst_reg), 0xC7);
+		break;
+	}
+
+	insn_off = insn->off;
+	if (dst_reg == BPF_REG_PARAMS) {
+		/*
+		 * Args 7+: reverse BPF negative offsets to
+		 * x86 positive rsp offsets.
+		 * BPF off=-16 → [rsp+0], off=-24 → [rsp+8], ...
+		 */
+		insn_off = outgoing_arg_base - outgoing_rsp -
+			insn_off - 16;
+		dst_reg = BPF_REG_FP;
+	}
+	if (is_imm8(insn_off))
+		EMIT2(add_1reg(0x40, dst_reg), insn_off);
+	else
+		EMIT1_off32(add_1reg(0x80, dst_reg), insn_off);
+
+	EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
+	*pprog = prog;
+}
+
 static void emit_st_r12(u8 **pprog, u32 size, u32 dst_reg, int off, int imm)
 {
 	emit_st_index(pprog, size, dst_reg, X86_REG_R12, off, imm);
@@ -2302,49 +2360,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			EMIT_LFENCE();
 			break;
 
-			/* ST: *(u8*)(dst_reg + off) = imm */
 		case BPF_ST | BPF_MEM | BPF_B:
-			if (is_ereg(dst_reg))
-				EMIT2(0x41, 0xC6);
-			else
-				EMIT1(0xC6);
-			goto st;
 		case BPF_ST | BPF_MEM | BPF_H:
-			if (is_ereg(dst_reg))
-				EMIT3(0x66, 0x41, 0xC7);
-			else
-				EMIT2(0x66, 0xC7);
-			goto st;
 		case BPF_ST | BPF_MEM | BPF_W:
-			if (is_ereg(dst_reg))
-				EMIT2(0x41, 0xC7);
-			else
-				EMIT1(0xC7);
-			goto st;
 		case BPF_ST | BPF_MEM | BPF_DW:
-			if (dst_reg == BPF_REG_PARAMS && insn->off == -8) {
-				/* Arg 6: store immediate in r9 register */
-				emit_mov_imm64(&prog, X86_REG_R9, imm32 >> 31, (u32)imm32);
-				break;
-			}
-			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
-
-st:			insn_off = insn->off;
-			if (dst_reg == BPF_REG_PARAMS) {
-				/*
-				 * Args 7+: reverse BPF negative offsets to
-				 * x86 positive rsp offsets.
-				 * BPF off=-16 → [rsp+0], off=-24 → [rsp+8], ...
-				 */
-				insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
-				dst_reg = BPF_REG_FP;
-			}
-			if (is_imm8(insn_off))
-				EMIT2(add_1reg(0x40, dst_reg), insn_off);
-			else
-				EMIT1_off32(add_1reg(0x80, dst_reg), insn_off);
-
-			EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
+			emit_st(&prog, insn, dst_reg, outgoing_arg_base,
+				outgoing_rsp);
 			break;
 
 			/* STX: *(u8*)(dst_reg + off) = src_reg */

-- 
2.54.0

