Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148F329E5A
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145908; cv=none; b=NJzO1mNRKkKjPkQNBj1yiwurSODbwsKeVP7zHWu+Ia5TAqkhTMqDD96HYxfPVKtxUEG6gCcGHZF5Yb/FYD1TGuvHCUxWjfRfQiY3BMHGCZePmxup2sVj/Y+d5YNnFWb+0V7G+ybtJc9BmpavHuWM1xQ5PiRFsfkhCt4M8RBkzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145908; c=relaxed/simple;
	bh=EKZNaCUoVsloJrR0ctZ5NuUakQh3rpQH3ohwly6jIjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McHlIHeQfwM/4S6YGbVEkggeWiqJdRgbd0plspAnTBRz/7SVOO2ej0b/EBv/JJBpwLxJxSJjW0Zy57YhOo9/Mgu+sMP8AQazzaSxGD8hjuzuL1tb5ov2J57Iq7OrpjpLMhUlzAWd0twVshRDHhKe95uip8rlodrs0PWiWhzuEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=doN8hzlo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="doN8hzlo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9MAel8xEdgMxoz8sMR/FGI9bWpXYQxXgdG3/38Heakk=; b=doN8hzloQ9Z4k7ZDPgczxKugHm
	wnPGgf7i/1YInhbcpQYyqjv6asW8tJBqWlw6ppcgWF1m/NA+LSjElIVUhjkbZSiOMutMrsBxm5EZO
	KJa8V8Lu+Vj3evTRnQ7LTMgMFOZzteiKGhCvV6C/N8K87e6sfXt1sOw4FO/SYtC57fWIFdkA3JaXR
	s+30CzKGLoX9pS3ILAZX0XGFYzJdwTtMMOtrYEkpNrhwHy6G66jNTlxY/Kd7gAZ4Q/IEfx0+XV2FC
	dH2bP4O+CJKgSs4C+SreQ7mWZ0kKkHfsm8ApAwgYVrW9JpJ9VFeFQlS1gFxDEJF+vSY1VqLMxD9vF
	n5/9YhZw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHf15-0009jf-22;
	Fri, 16 Oct 2026 12:18:23 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Restore the je <-> jmp distance in convergence check
Date: Fri, 16 Oct 2026 12:18:21 +0200
Message-ID: <20261016101822.632891-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101822.632891-1-daniel@iogearbox.net>
References: <20261016101822.632891-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28155/Fri Oct 16 08:24:17 2026)

The bpf_jit_convergence je <-> jmp test reproduces the cycle fixed by
commit c8831bdbfbab ("bpf, x64: Fix a jit convergence issue") with 125
bytes of x86-64 code between the je to l0 and l0 when the last goto l9 is
two bytes and 128 when it is five, so that the je fits into an imm8 only
while the jmp does not and the two flip each other's size from pass to
pass.

The recent JIT changes shortened that code by five bytes: the three loads
and stores with a zero offset lost their displacement byte with commit
44df4d88aa63 ("bpf, x86: Omit the displacement byte for zero offsets"),
and r2 += 0x1 became an inc and r3 &= 0x1 an and without REX.W with commit
d59f47e031ae ("bpf, x86: Use shorter and faster forms for some ALU
immediates"). At 120 and 123 bytes the je fits either way, nothing flips,
and the test passes without exercising the fix.

Add a five byte mov to the region to get the distance back. The je is
forced into its long form again as the fix intends:

  # ./vmtest.sh -- ./test_progs -v -t verifier_jit_convergence
  [...]
  96:	0f 84 7d 00 00 00 	je	L14
  117:	eb 83 	jmp	L6
  119:	bf 03 00 00 00 L14:	movl	$0x3, %edi
  [...]
  #668/1   verifier_jit_convergence/bpf_jit_convergence je <-> jmp:OK
  #668     verifier_jit_convergence:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0/0 FAILED

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../testing/selftests/bpf/progs/verifier_jit_convergence.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_convergence.c b/tools/testing/selftests/bpf/progs/verifier_jit_convergence.c
index 9f3f2b7db450..4fd717334858 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jit_convergence.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_convergence.c
@@ -68,6 +68,13 @@ __naked void btf_jit_convergence_je_jmp(void)
 	"r3 &= 0x1;"
 	"r2 *= 0xa8;"
 	"if r3 == 0x0 goto l2_%=;"
+	/*
+	 * The x86-64 code from the je to l0 up to l0 has to be 125 bytes with
+	 * the last goto l9 at two bytes and 128 with it at five, so that the
+	 * je fits into an imm8 only while the jmp does not and the two keep
+	 * flipping each other's size. The mov pads the region to that.
+	 */
+	"r3 = 0x1234;"
 	"r1 += r2;"
 	"r1 -= r7;"
 	"r1 += 0x8;"
-- 
2.43.0

