Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125496;
	b=5Dj15R8q1XLHthiPc7j4Mly3Bp+htz3znT4mJPeqg2i48SubF9hZlWZA57I9D0RmAHkZ
	 Vg1oPuiuy5PJQPMma84iRvsoWVVB1gONMV+9FOMtmGjF1QNhrnMycwkM0/+ECex2mS0AX
	 7PcLjIP53+QrCDRcflB763FjLboFmHySNB6MfR73oEpgpRCNg2BRm1WFBZlRuATZkwH0P
	 wrwbix9oH3j8hm7xVXbhnkuOJCAInVvzNdKVkv5+CJ0Z+XgGUCHHYaytfvwzP/yVXNnXC
	 6uL4nWqeoeKRGriiDCbMe7Wur8mdqKu/2KvO9g5HQTyOx+4Xlj+pnrkby8t28HeNvNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125496;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=Z6OWUH0tjk+4Fx3e06E5Q4g48HPPR9gBzDIvo5gPyXc=;
	b=dMv2UQpFYRDQYuyV3DHFdWynfLDjZxK6u7h0DqI3Oj8NomwhSmGWV5A7cZ3a7xjSgUXx
	 9cDeggI/SNuR7+3zqyUDPpRWy+qxtKUr3tRuFAsy118TugVygLYcPNwaHkrcNK2W/azkW
	 uEetUl1Afty4htng3yyar3m33681qnZRhKLSgkwWoGzEMg/cuLjaW7eu3MOSc8VQPm02y
	 eNrdLOjwCjOayBbakfpje3dWa5pndxeHoslbOXZKwyZvA1iizlqq1h2x6tf3cI3wuYOMg
	 lNzN+1JZ1zL6GCczpsbVMz8Sfhvfo9hbsP5YyR87BbT9F0BoVHv9s4VBBPgSh0EZ2ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=P1tDSucP;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD7060A2619
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD7060A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=P1tDSucP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Z6OWUH0tjk+4Fx3e06E5Q4g48HPPR9gBzDIvo5gPyXc=; b=P1tDSucP+rQH9yqN+tCIdD3D1T
	2M9+MCVQoJGdbc/dJDuJSLj6PETytnaR2u/P+Ke/NMVFrsNiPuYpK9rIVYkzpJMQAC/4CbUvHm5kz
	Jb4Qrqmck9pf718Qt6ocWAfhXszH4gG0V8DVaqAl/bmuj8TL6HHPtsKifRXf6U6eMGfV+WNdXAG9V
	K/YoxC4AQYZnvLes3YcG5azMPBkWTutwzMK9qFbNdEEbDp1FLwnSqkGJlS9VZvPYQLHZNeQRauygu
	/jriSIAD0eyoQCLXgG463VgRcL1Z5AEU8AKgHoh+5ZK85yQ+2YL/onk0duIdPiwbJKoB8mABunpYv
	9kWmA5Cw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xLlqx-000Imf-0T;
	Tue, 27 Oct 2026 19:24:55 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: puranjay@kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 16/21] bpf, arm64: Use a move or mvn for the and and xor with all ones
Date: Tue, 27 Oct 2026 19:24:40 +0100
Message-ID: <20261027182445.1156335-17-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027182445.1156335-1-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)

The logical immediates cannot encode all ones, so the and, or and xor with
-1 moved the constant into a temporary and used the register form. LLVM
lowers a bitwise not to r ^= -1, as BPF has no not instruction, which the
Cilium datapath does hundreds of times. The xor with all ones is an mvn,
the 32-bit and with all ones a 32-bit mov of the register to itself and
the 64-bit one emits nothing, as the le64 of this JIT already does, and
the or with all ones a mov of -1.

Before/after for w1 &= -1 and w1 ^= -1:

  1280000a  mov w10, #0xffffffff
  0a0a0000  and w0, w0, w10
  2a0003e0  mov w0, w0

  1280000a  mov w10, #0xffffffff
  4a0a0000  eor w0, w0, w10
  2a2003e0  mvn w0, w0

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index d14a5cf6e032..c49f962ac229 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2030,6 +2030,12 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_AND | BPF_K:
 	case BPF_ALU64 | BPF_AND | BPF_K:
+		/* All ones only zero extends the 32-bit variant */
+		if (imm == -1) {
+			if (!is64)
+				emit(A64_MOV(0, dst, dst), ctx);
+			break;
+		}
 		a64_insn = A64_AND_I(is64, dst, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
 			emit(a64_insn, ctx);
@@ -2040,6 +2046,11 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_OR | BPF_K:
 	case BPF_ALU64 | BPF_OR | BPF_K:
+		/* The or with all ones is the move of -1 */
+		if (imm == -1) {
+			emit(A64_MOVN(is64, dst, 0, 0), ctx);
+			break;
+		}
 		a64_insn = A64_ORR_I(is64, dst, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
 			emit(a64_insn, ctx);
@@ -2050,6 +2061,11 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		break;
 	case BPF_ALU | BPF_XOR | BPF_K:
 	case BPF_ALU64 | BPF_XOR | BPF_K:
+		/* The xor with all ones is the not */
+		if (imm == -1) {
+			emit(A64_MVN(is64, dst, dst), ctx);
+			break;
+		}
 		a64_insn = A64_EOR_I(is64, dst, dst, imm);
 		if (a64_insn != AARCH64_BREAK_FAULT) {
 			emit(a64_insn, ctx);
-- 
2.43.0

