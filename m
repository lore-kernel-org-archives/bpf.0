Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FE351DDE7
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913021; cv=none; b=ZdXzcXk14E4PM/wxI1bUEcuG/ZsDG3YHh7qY0wepYKqS0Y/qBvFtE5gB1Ca+O44vU8rjFUfysDAe1bmwNXrhIwMPEFvcpQnQB4Bs30LRF8pVTLgex+jn556KOZIhCee8Q1aV8qcmu8y0pg7j4pkdQ2A7XMIKkIyw3327drkvVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913021; c=relaxed/simple;
	bh=r3RzNmui3U7E24h3lALlDaVlaW2s7XQcD8KkjlvuHjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0m/6pxaTb2GNDPvxZsbTjA9bkQAWlhEFsheo1q2V8Q1ZuxxT0cH4HiMi2/F+IgA8mLMkCdwr66fZc9zIosULUU2CUby+lEl7Fd5WHZo/FS0v07LCfaZFAzKhto3Y8XCtxidQbvrgPBePAQzergEw/Ujnudm//+5/q+OO4KhmPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=f0ZTzLBv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="f0ZTzLBv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sL+tph62UBNmG+ZD4TEbojI4CoaQ6TI+EnYRO4Kl/+4=; b=f0ZTzLBvVPLq/KpP5PPLLWCHL1
	JDdlPQwtW4a78Ac/Pb/sPKveXlDsPT+E85A4hShqlHCMKQaOjyLWUYF4Y4B5y9QIJD44DIG4mtVRz
	w6qNDV5i96TjbfqwsWXnz+Aw/gWrze11CdMSZ73EQS2/Xsj+jRw73RsxYE3gXboBKZQnGpJgzo1ve
	X6LXKf9sl51/x6XerEKPoD/sunQV9wJzpKAOTbAPWf+d8FtmNyJR/FR0US2k7sf5iN4tCme7fjShw
	tnhcP8lFtf8XLo5nI6meBvcTiUjZk7xRLJsCdHVwRE/PUfu9lsJlhaaN80YyZotuKsO0Yzb37UCJy
	DO82VJRQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3F-000PQL-2D;
	Tue, 13 Oct 2026 19:12:33 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 04/18] bpf, x86: Use shorter test and cmp encodings for immediates
Date: Tue, 13 Oct 2026 19:12:16 +0200
Message-ID: <20261013171230.523677-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013171230.523677-1-daniel@iogearbox.net>
References: <20261013171230.523677-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28152/Tue Oct 13 08:26:14 2026)

test has no sign-extended imm8 form, so a JSET against a constant was
always emitted as a 6 to 7 byte test with imm32. When the mask fits
into the low byte, the result only depends on that byte, so test the
8-bit register instead, which takes 2 to 4 bytes. Reading the low byte
of a register that was written as a whole has no partial register
penalty on Intel or AMD cores. Also use the one byte shorter accumulator
forms of test and cmp with imm32 when the destination is r0, like the
ALU immediates already do.

Before/after for if r1 & 0x40 goto ...:

  48 f7 c7 40 00 00 00  testq $0x40,%rdi
  40 f6 c7 40           testb $0x40,%dil

Before/after for if r0 == 0x1000 goto ...:

  48 81 f8 00 10 00 00  cmpq $0x1000,%rax
  48 3d 00 10 00 00     cmpq $0x1000,%rax

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c6e814f7c806..079703c173a5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3080,10 +3080,26 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_JMP | BPF_JSET | BPF_K:
 		case BPF_JMP32 | BPF_JSET | BPF_K:
+			if ((u32)imm32 <= U8_MAX) {
+				/*
+				 * test dst_reg8, imm8: with the upper bits of the
+				 * mask clear the result only depends on the low byte.
+				 */
+				if (is_ereg_8l(dst_reg))
+					EMIT1(add_1mod(0x40, dst_reg));
+				if (is_axreg(dst_reg))
+					EMIT2(0xA8, imm32);
+				else
+					EMIT3(0xF6, add_1reg(0xC0, dst_reg), imm32);
+				goto emit_cond_jmp;
+			}
 			/* test dst_reg, imm32 */
 			maybe_emit_1mod(&prog, dst_reg,
 					BPF_CLASS(insn->code) == BPF_JMP);
-			EMIT2_off32(0xF7, add_1reg(0xC0, dst_reg), imm32);
+			if (is_axreg(dst_reg))
+				EMIT1_off32(0xA9, imm32);
+			else
+				EMIT2_off32(0xF7, add_1reg(0xC0, dst_reg), imm32);
 			goto emit_cond_jmp;
 
 		case BPF_JMP | BPF_JEQ | BPF_K:
@@ -3120,6 +3136,8 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 			if (is_imm8(imm32))
 				EMIT3(0x83, add_1reg(0xF8, dst_reg), imm32);
+			else if (is_axreg(dst_reg))
+				EMIT1_off32(0x3D, imm32);
 			else
 				EMIT2_off32(0x81, add_1reg(0xF8, dst_reg), imm32);
 
-- 
2.43.0

