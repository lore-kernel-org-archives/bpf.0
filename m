Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCE54CA273;
	Thu,  4 Jun 2026 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604562; cv=none; b=FNT5AaD8AUeYSIXF+JmzLgYzP4t5D73OClm1ocek7Py7870dGEE9+75mFT90jSGxwvuqmkoE7BxKnyXG8DlOPVhvPADISyDVrJuqyUGrREk/LuOAItFsTrBlE7E6ia0fBxlCXaJw0XeohzSyi9vCETtZVsFtDMBAHv0l4GXV/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604562; c=relaxed/simple;
	bh=tA/J+y0IViZ+5uj14534YohZ6eRZGM36o/SwEt6cL1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0ygMeucvzfw2r+/gMsdOcGjBEeCHFhmpLvciVMHUFRjSTqMqRJkxykjd6/JEvvEB0KVGDogQO+4PPLp4VyJhddb3fBJg1l1zbyFBn42oAvwGooj3MUNCljx0orVPqYInsHRKKB/GoaSLZPO/bDiP2Mtf+9xA1kQFMDLqufiVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DmC5uD7U; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DmC5uD7U"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 713A4C63453;
	Thu,  4 Jun 2026 20:22:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 13DA95FED1;
	Thu,  4 Jun 2026 20:22:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3C85106A1D2C;
	Thu,  4 Jun 2026 22:22:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780604558; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RfWDnkDwkkfbnuCPMrlh9TY6xMPQgUKPCYmPMT1bj3Y=;
	b=DmC5uD7Ufj+9BtNRuy5VfbgxYZpX1m4cXOJ8liQembdGsvxTu8kssq/pi6HlrhNOWCiWaB
	Tb6vGElU2Vlafl9+fpmnZhj1IaXDxPnt+cjEkjVeABuufocl2HUs3JJhAX2QX+Fj3PpUh3
	g4sZpGl6prt/hZCI+kKP5oS5xY9j0fSYd/Df7hfxqJwlzL0ITG/Z+Ixck7kHpjniNJIMEW
	wt6XfQs3M8gOKP26Y0CMmp/njdD+dyBiKSyFGOMe9GdVDbeYaON6mF9aeyzZjvKbYbgGRJ
	VOkK+/Va/TqY9jKJhpOc2+P4SHS6KNoJZSMU+c85ZaJQKneIcU9Zyt9Gp8xb+A==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 04 Jun 2026 22:22:02 +0200
Subject: [PATCH bpf-next v2 4/8] bpf, x86: refactor BPF_ST management in
 do_jit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-kasan-v2-4-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
In-Reply-To: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

In order to prepare for KASAN checks insertion before every
memory-related load or store, group all BPF_ST instructions that indeed
access memory in a single block of fall-through cases to allow
instrumenting those in one call, rather than having to instrument all
cases individually.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 arch/x86/net/bpf_jit_comp.c | 53 ++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 0981791014eb..943a0f315cf2 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2300,41 +2300,50 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
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
+			switch (BPF_SIZE(insn->code)) {
+			case BPF_B:
+				if (is_ereg(dst_reg))
+					EMIT2(0x41, 0xC6);
+				else
+					EMIT1(0xC6);
+				break;
+			case BPF_H:
+				if (is_ereg(dst_reg))
+					EMIT3(0x66, 0x41, 0xC7);
+				else
+					EMIT2(0x66, 0xC7);
+				break;
+			case BPF_W:
+				if (is_ereg(dst_reg))
+					EMIT2(0x41, 0xC7);
+				else
+					EMIT1(0xC7);
+				break;
+			case BPF_DW:
+				if (dst_reg == BPF_REG_PARAMS &&
+				    insn->off == -8) {
+					/* Arg 6: store immediate in r9 register */
+					emit_mov_imm64(&prog, X86_REG_R9,
+						       imm32 >> 31, (u32)imm32);
+					break;
+				}
+				EMIT2(add_1mod(0x48, dst_reg), 0xC7);
 				break;
 			}
-			EMIT2(add_1mod(0x48, dst_reg), 0xC7);
 
-st:			insn_off = insn->off;
+			insn_off = insn->off;
 			if (dst_reg == BPF_REG_PARAMS) {
 				/*
 				 * Args 7+: reverse BPF negative offsets to
 				 * x86 positive rsp offsets.
 				 * BPF off=-16 → [rsp+0], off=-24 → [rsp+8], ...
 				 */
-				insn_off = outgoing_arg_base - outgoing_rsp - insn_off - 16;
+				insn_off = outgoing_arg_base - outgoing_rsp -
+					   insn_off - 16;
 				dst_reg = BPF_REG_FP;
 			}
 			if (is_imm8(insn_off))

-- 
2.54.0

