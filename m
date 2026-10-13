Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0F528432
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913038; cv=none; b=q6Qy1RISvD7nxSm00I99AUsMeUcjmRNISti8tIw5bIQxAyALosWuqeDG/kA+GWohEN9lzv4tRUBaGcRExapALptemVkTz3n75o2IuQ1A8pDzZeLoEqgzPmatPx+BYJY3tKWkG1AofP5Ja+ljDjFQO7hjJ36FtS42A2G9GDCnQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913038; c=relaxed/simple;
	bh=Bl47Z4c9N1ilbIxsCm7XLyXyEisGwpx6c8NwrKcr8O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gth1B74oN3vqo2PXzN5YaRL3QX+FLhQv3uQsu+oM6Rcjx4yry1feQPbs6Uj9ND9U4wEShAnXMWYAhB+0EtGEdAx4m7W5WVloIg1LThHJLfW445I7jEHJyoezk6J/ff7D73+Kv84IxHh68QkfecfttcvA7Ufe3YZ+xLrRY2kQxdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=XP0s6/R6; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="XP0s6/R6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=69WyyDsoY8wEos/2sJrYzmpEoY8mO3YUcIb6t84M7h0=; b=XP0s6/R6E2Tgwblpgst6fYaBPn
	emqsQzbeCf1Rhsj3zYis9UzeHRi1S0+f7asFYIFfzalaVQa6gG+ErlEuOSMaCZKGoIu96sQFVz8rW
	+lTfDAOZPS0TlgYaMs1RE12qmcuQ44HaZIJbiWhBEvPZHZwHricaZwsetTUBp+6nAaE7nu9iLeFJb
	B22njN6Psd1JXgCQOwe2jj9L55xd5ji12uNQw7owY9pkFSHmnvsUBXHhvsqGsZ5T0CW5rXzU+3Ete
	qnC6ROpvrw9lQsmdzJfGy5ryAy5yQvocx3d9uCa/CaS/ac+6GcBCeS2uFf9j3L7UKQWpp9NfwBvAw
	YA9jgXCw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3G-000PQi-2c;
	Tue, 13 Oct 2026 19:12:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 06/18] bpf, x86: Use movzx for byte and word masks and a not for xor with -1
Date: Tue, 13 Oct 2026 19:12:18 +0200
Message-ID: <20261013171230.523677-7-daniel@iogearbox.net>
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

LLVM lowers u8 and u16 truncations to r &= 0xff and r &= 0xffff, and
a bitwise not to r ^= -1, since BPF has neither a zero extending move
from a sub-register nor a not instruction. On x86 these masks need the
imm32 form of and as they do not fit into a sign-extended imm8. Emit
a movzx from the low byte or word instead, which is 3 to 4 bytes and
zero extends into the full register for both the 32 and 64-bit variant,
and a not for the xor with -1. Both are single cycle instructions on
Intel and AMD cores.

Before/after for r1 &= 0xff, r1 &= 0xffff and r1 ^= -1:

  48 81 e7 ff 00 00 00  andq $0xff,%rdi
  40 0f b6 ff           movzbl %dil,%edi

  48 81 e7 ff ff 00 00  andq $0xffff,%rdi
  0f b7 ff              movzwl %di,%edi

  48 83 f7 ff           xorq $-1,%rdi
  48 f7 d7              notq %rdi

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 70473cd43aa8..e7439fb5037d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1129,6 +1129,20 @@ static bool base_needs_disp(u32 reg)
 	return reg2hex[reg] == 5;
 }
 
+static void emit_movzx_reg(u8 **pprog, int num_bits, u32 dst_reg, u32 src_reg)
+{
+	u8 *prog = *pprog;
+
+	/* movz[b,w]l dst, src */
+	if (is_ereg(dst_reg) ||
+	    (num_bits == 8 ? is_ereg_8l(src_reg) : is_ereg(src_reg)))
+		EMIT1(add_2mod(0x40, src_reg, dst_reg));
+	EMIT3(0x0F, num_bits == 8 ? 0xB6 : 0xB7,
+	      add_2reg(0xC0, src_reg, dst_reg));
+
+	*pprog = prog;
+}
+
 /* Emit the suffix (ModR/M etc) for addressing *(ptr_reg + off) and val_reg */
 static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
 {
@@ -2312,6 +2326,21 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_ALU64 | BPF_AND | BPF_K:
 		case BPF_ALU64 | BPF_OR | BPF_K:
 		case BPF_ALU64 | BPF_XOR | BPF_K:
+			if (BPF_OP(insn->code) == BPF_AND &&
+			    (imm32 == 0xff || imm32 == 0xffff)) {
+				/* movzx dst_reg, dst_reg8/16 */
+				emit_movzx_reg(&prog, imm32 == 0xff ? 8 : 16,
+					       dst_reg, dst_reg);
+				break;
+			}
+			if (BPF_OP(insn->code) == BPF_XOR && imm32 == -1) {
+				/* not dst_reg */
+				maybe_emit_1mod(&prog, dst_reg,
+						BPF_CLASS(insn->code) == BPF_ALU64);
+				EMIT2(0xF7, add_1reg(0xD0, dst_reg));
+				break;
+			}
+
 			maybe_emit_1mod(&prog, dst_reg,
 					BPF_CLASS(insn->code) == BPF_ALU64);
 
@@ -2573,11 +2602,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 				 * Emit 'movzwl eax, ax' to zero extend 16-bit
 				 * into 64 bit
 				 */
-				if (is_ereg(dst_reg))
-					EMIT3(0x45, 0x0F, 0xB7);
-				else
-					EMIT2(0x0F, 0xB7);
-				EMIT1(add_2reg(0xC0, dst_reg, dst_reg));
+				emit_movzx_reg(&prog, 16, dst_reg, dst_reg);
 				break;
 			case 32:
 				/* Emit 'mov eax, eax' to clear upper 32-bits */
-- 
2.43.0

