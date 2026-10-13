Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AB652758C
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913026; cv=none; b=glm32TjXoFnkjjsHNco6JoyHWZSzLq+df5DS6ZX7N3E0A9ilC7nkqThB2Gpkcmr+rSkOhyOTSc9IuyeOfLDAO+MQsN0IkM9TkHwG28CM6fRV4j+qclj4vU1eaRnF9bnGH99ZmB3PysLFmo4PFP/8PLbNJ/sz8oQizSPyUiVRZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913026; c=relaxed/simple;
	bh=6N4P2uMFn75irRAdHC/oaUPUhwSWunGrIiQHwzyzSUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVpRnC+LPkuCZlrTCl5UPuu+Gdm9m3+iO4Xk7scMuv9mhnEMaDECWFSXM8Ab/Am/AhZZl1kE7haxNhFd6QnEjC4kEOD2rmVmXEjT7vv52keKLudlu9rsy4fOL4IvXI7hSOzmimGaBLqdBrwFNLTr1uLQeHcxoYZ/4M1DzLWCXDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=SXmhjWOb; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="SXmhjWOb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XwmLGVZk2Uotv6Xtbtydpse1jdA60roKoRAZ+iijc+A=; b=SXmhjWObC0MnU7yB1DYFUbjM9Z
	KiugYKDiGMukVPR1A3oKHA1FOjISfx9yGJF2FJR+b3WYm54ZmgODoDLUT63XrW3YyElXeIQLt+wCw
	rdftjIWjaiR6XIPVM+tz5sFuj72uF4FHn+xhQ65q8Ly+zBoAhC6GtHsCriheQ7yuh5i39rUWhgh5X
	MIu2TJ0pA5+nHeMw0alugyT14CbiFQnqBIUFl66zNabO0Iz6lOw89lrL9ZI6H4vth0HXeJTvJ/zid
	CQQY4STKG+svbMzGSSWOVlYy6rnSuHybPQaZz8c+eakS1k9LLi3KjNwAUidDd4REfZFhejFkKijUD
	JZrVUsMA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xGg3J-000PRS-0D;
	Tue, 13 Oct 2026 19:12:37 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 10/18] bpf, x86: Use BMI2 shifts also when the count is in rcx
Date: Tue, 13 Oct 2026 19:12:22 +0200
Message-ID: <20261013171230.523677-11-daniel@iogearbox.net>
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

Commit 77d8f5d47bfb ("bpf,x64: use shrx/sarx/shlx when available") kept
the legacy shift by cl when the count already is in rcx, since that
encoding is two bytes shorter. However, shl/shr/sar r,cl are 3 uops on
Intel from Haswell through Skylake and still 2 uops on Ice Lake, as a
zero count must leave the flags untouched, whereas shlx/shrx/sarx are a
single uop with a latency of 1. On AMD both forms are a single uop, so
the two extra bytes are the only cost there. Use the BMI2 form whenever
it is available. LLVM keeps the count in whichever register it was
allocated to, r4 included.

Before/after for r1 <<= r4:

  48 d3 e7        shlq %cl,%rdi
  c4 e2 f1 f7 ff  shlxq %rcx,%rdi,%rdi

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/net/bpf_jit_comp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 50158d4b85b2..de49d7f51a54 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2539,8 +2539,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		case BPF_ALU64 | BPF_LSH | BPF_X:
 		case BPF_ALU64 | BPF_RSH | BPF_X:
 		case BPF_ALU64 | BPF_ARSH | BPF_X:
-			/* BMI2 shifts aren't better when shift count is already in rcx */
-			if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg != BPF_REG_4) {
+			/*
+			 * BMI2 shifts take the count from any register and,
+			 * unlike the cl forms, are a single uop on Intel, so
+			 * prefer them also when the count already is in rcx.
+			 */
+			if (boot_cpu_has(X86_FEATURE_BMI2)) {
 				/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
 				bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
 				u8 op;
-- 
2.43.0

