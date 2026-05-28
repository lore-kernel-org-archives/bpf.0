Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE093CE0B8
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974857; cv=none; b=XBJH+0bOzLldDLRn3xvoEeN2+JmHiXX/e0E6Y5OYQkoixZQT4MI53QkNYiQkQwwrZZpVgvGvWT0leEbnMaaBDwXEWAtLmiPeee06k01t5TcSVW7zSa7DVilHkTuZQpdZsUxPOWBJS/1B74jiy6ECDNTuIX6r987W8hcWqy+9CSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974857; c=relaxed/simple;
	bh=ErEADfQOwDlWtt6JS5EWWVcHvzZmKepOIS+pG6dpPG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E2GEKM5M6q6CUVjipoCruTqN39pyiGCc5I8qV7z3rokqRkXtXuTwqIaMcGC9ElM3GoN528Bgi3A70r8boYm3boRwWx9gXVRKVqO0lYYyaN/PMryFX/ZAZpy8IAwxTGhUn+SKWJqQwS6Bqv7sZ7To5s8Tqu3O2keZNV78jEwVQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HJkD2tJQ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HJkD2tJQ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 95E771A370B;
	Thu, 28 May 2026 13:27:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D5F460495;
	Thu, 28 May 2026 13:27:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEA0E10888651;
	Thu, 28 May 2026 15:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779974846; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=bUCYTw5/XnfGzC1/mlK4v3TBgGjqIbE2kIxY+RaExGo=;
	b=HJkD2tJQJs1+Na8iUH1RTqRtv55zWLu7gx2GXSuyGU18WvD2LUv9Gfca+RoURgDJ6CDb6J
	GcUZfDMHarZDzV14TN6Mp/J3ACkLbWILQ2pQyGfB+Jdkyqaw2DNwWIA0mmRAR8JYCnkL6S
	2RcVnbNxpihfzyAcx1jvRuevd4na82qoZ5FKrv2/8yFTh6rfJwvCPjykO3VfQl6zdxdMz6
	mvtety8vujMgwqvlKomPJiXaGozqOd3hPOlC2kG2QoGw9GR+GIlQqYMloRhWV3SBf6pRhW
	jqEUR9SN4QjY+4z67e6tjDjFvgFARc064vupKEae/l+DY0xlfuaSf9GF9RLAmg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 28 May 2026 15:27:14 +0200
Subject: [PATCH bpf-next] selftests/bpf: ignore call depth accounting for
 retbleed in verifier tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260528-fix_tests_for_retbleed_stuff-v1-1-c2022a1f3bee@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQrCMBCE4auUfTYQU2qjVxEJTTrRiKQlu5VC6
 d2N+vgzw7cRoyQwXZqNCt6J05RrHA8NhceQ71BprE1Gm5PujFUxrU7Awi5OxRWIfwGjY1liVKE
 N9uz71qLXVIm5oP5//JX8HFXGKnT7L7z4J4J8ddr3DyY30keKAAAA
X-Change-ID: 20260528-fix_tests_for_retbleed_stuff-c3c89b738e70
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

When running the selftests on a retbleed-affected platform (eg:
Skylake), with call depth accounting enabled
(CONFIG_CALL_DEPTH_TRACKING=y) _and_ with retbleed=stuff, some verifier
selftests fail to validate the jited instructions. For example:

  MATCHED    SUBSTR: '	endbr64'
  MATCHED    SUBSTR: '	nopl	(%rax,%rax)'
  MATCHED    SUBSTR: '	xorq	%rax, %rax'
  MATCHED    SUBSTR: '	pushq	%rbp'
  MATCHED    SUBSTR: '	movq	%rsp, %rbp'
  MATCHED    SUBSTR: '	endbr64'
  MATCHED    SUBSTR: '	cmpq	$0x21, %rax'
  MATCHED    SUBSTR: '	ja	L0'
  MATCHED    SUBSTR: '	pushq	%rax'
  MATCHED    SUBSTR: '	movq	%rsp, %rax'
  MATCHED    SUBSTR: '	jmp	L1'
  MATCHED    SUBSTR: 'L0:	pushq	%rax'
  MATCHED    SUBSTR: 'L1:	pushq	%rax'
  MATCHED    SUBSTR: '	movq	-0x10(%rbp), %rax'
  WRONG LINE  REGEX: '	callq	0x{{.*}}'

Those affected selftests allways fail on some call instruction: this
failure is due to the JIT compiler emitting call depth accounting for
retbleed mitigation (see x86_call_depth_emit_accounting calls in
bpf_jit_comp.c), resulting in an additional instruction being inserted
in front of every call instruction, similar to this one:

  sarq    $0x5, %gs:-0x39882741(%rip)

Fix those selftests by allowing them to ignore this possibly present
call depth accounting instruction.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/progs/verifier_private_stack.c | 5 +++++
 tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index 046f7445a458..bb8206e10880 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -94,6 +94,7 @@ __jited("	addq	%gs:{{.*}}, %r9")
 __jited("	movl	$0x2a, %edi")
 __jited("	movq	%rdi, -0x200(%r9)")
 __jited("	pushq	%r9")
+__jited("...")
 __jited("	callq	0x{{.*}}")
 __jited("	popq	%r9")
 __jited("	xorl	%eax, %eax")
@@ -153,11 +154,13 @@ __jited("	endbr64")
 __jited("	movabsq	$0x{{.*}}, %r9")
 __jited("	addq	%gs:{{.*}}, %r9")
 __jited("	pushq	%r9")
+__jited("...")
 __jited("	callq")
 __jited("	popq	%r9")
 __jited("	movl	$0x2a, %edi")
 __jited("	movq	%rdi, -0x200(%r9)")
 __jited("	pushq	%r9")
+__jited("...")
 __jited("	callq")
 __jited("	popq	%r9")
 __arch_arm64
@@ -199,6 +202,7 @@ __description("Private stack, exception in main prog")
 __success __retval(0)
 __arch_x86_64
 __jited("	pushq	%r9")
+__jited("...")
 __jited("	callq")
 __jited("	popq	%r9")
 __arch_arm64
@@ -246,6 +250,7 @@ __success __retval(0)
 __arch_x86_64
 __jited("	movq	%rdi, -0x200(%r9)")
 __jited("	pushq	%r9")
+__jited("...")
 __jited("	callq")
 __jited("	popq	%r9")
 __arch_arm64
diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
index 8d60c634a114..48fa34d2959f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
@@ -56,6 +56,7 @@ __jited("L1:	pushq	%rax")			/* rbp[-16] = rax         */
  * (cause original rax might be clobbered by this point)
  */
 __jited("	movq	-0x10(%rbp), %rax")
+__jited("...")
 __jited("	callq	0x{{.*}}")		/* call to sub()          */
 __jited("	xorl	%eax, %eax")
 __jited("	leave")

---
base-commit: 4a8eaccfdd6f4ae4b0e8735664e9d3e5ce826329
change-id: 20260528-fix_tests_for_retbleed_stuff-c3c89b738e70

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

