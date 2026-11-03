Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708866;
	b=nZFehBe7gWTK3cSJ/1uRIOilGtbl8f4VqTTxf0HTU/A2a1dOSU0aS/ffsVy2+n/HyCB/
	 WGXU6PBW/BDHRwHuWN1Dnh8bS/p+zLuxnVdbgfBK541OUgP7Gugw3kB/lZP1N+U3wl2Rg
	 gA1J7c8WcOqM0qKcx0Oy3o+DJJUZAqbrp7M8Orf0LBG9WvyE6NufaHOpF1edD7TRH0Qk8
	 mJSycPQ+p3lz4IUth3r2SZfaf20OWJrJsfcOqcgLUvYPRysHV6kNNxsFC8KRP4Fzvsn//
	 zt6ho2shfqI937i3Tr9AgVbRzOuNKz+lAUQ1n1ZttjtAZwewl5HRIv4R1oo10bMWSrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708866;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=4vVIeiM+PvJrN1rUVz6OIxF4KoUJPYy12pjxSOk6DPk=;
	b=MtzoVGmDBAwK1g4x5+d258uwe3ZDAn3gOnB8GeDYG2gT8K8lwVND5ok0Xg1Wh6bPTQ35
	 IshZFhPeTqPA0e6g8OyjalEDYAtY/3Q8goACh6mqUGSRZxEtxl7l52xXul7jsZZ3YoXJ6
	 LnU7i1v3OgXvpPk49Q89S0S4GO3BpY7JsYb2BRKW+ElznwvnvbDtiT4tjhKr4BkSxfK+w
	 KAtZaz5jD0Hic/FOeOYCC9/hyFNzTZSz98bI+YvToUpCZ/uAK/Hs+Erw2Ajah8jIrEPAy
	 hx4IRrLQxlmxJ1oFliw9r4tJGEolN5LYFlkDEJ7CGhjMafu9Ut53UmoD+SKiU/dI89A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=hyrdXBZZ;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608ED606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 12:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 608ED606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=hyrdXBZZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4vVIeiM+PvJrN1rUVz6OIxF4KoUJPYy12pjxSOk6DPk=; b=hyrdXBZZVhJXHl67nn2V7yComa
	wqyqPIGgim0ApPGa5M0YTKZ/HxuDpv6sU+IM7UYWgWmXUmrpG2orS2lFhbaLN5WEpaADzvnNOS3Pi
	q14RbCupIXh8tfeQP9VwEVDHU9s0F1bpeQEAHIhOq80jALWO2XxiPtMJyl2DYcAoozZNkS8++NEPY
	Y/2map0EjvydAGYnymrypO5xMdJi1x21pYg8c1uJYMUL0wtArpVHgQe+YR0JhL7OBcqb2MUagjaJ/
	2ODYJIXm+VLMNz+EjIZGsK/YS1mFxLXoIMsh5gxVT1P/3MjE4gX668SD1ikgJq8BaWiqRo4ylb7ks
	G5ZURw4g==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xODc7-000MSA-2I;
	Tue, 03 Nov 2026 13:27:43 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 16/20] bpf, arm64: Use a move or mvn for the and and xor with all ones
Date: Tue,  3 Nov 2026 13:27:29 +0100
Message-ID: <20261103122733.1383002-17-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103122733.1383002-1-daniel@iogearbox.net>
References: <20261103122733.1383002-1-daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28173/Tue Nov  3 07:27:52 2026)

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
index 3c53caf63b04..37fb1df53e30 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2015,6 +2015,12 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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
@@ -2025,6 +2031,11 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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
@@ -2035,6 +2046,11 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
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

