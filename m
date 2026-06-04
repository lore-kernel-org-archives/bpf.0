Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24733ED3B9;
	Thu,  4 Jun 2026 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604553; cv=none; b=bk9qqEQkVLOFndHJbkjnpeUYrKY41kcIa6naxh0WFzA8Rn4jZbBT6xKvS0r41oowihbEA5jrHFOzq96svb5qq+6drb6RebkOWV16pp7Owa+kyT2D2r4VkZ01c0qmz3jiNTyCxuZ3N+HC33bPDbmeAVXVOo6bXZGv9T5p4PCMXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604553; c=relaxed/simple;
	bh=aD7bdn0WaicpdxZnovk0HTTlEvleBbMpw3agPNkM8tk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jXkjR7RgqvNfeoZ/dwCVuXc8qpGSBQqXz6d4nLn7H8Wr1NqrCWt/hXc7C21FYst5mLYv+zFRJKIHFXfw8JuSsWMYYZGKLqR91727Pulfd/fcinbv4VW8V86jhX1r4y3cuiiFGb+e0XJkPLrf3NC+ewH/Kle7ZfjkZD/qllJFI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GvDDw8u3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GvDDw8u3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EC96A4E406AC;
	Thu,  4 Jun 2026 20:22:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A651F5FED1;
	Thu,  4 Jun 2026 20:22:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8E11106A19CA;
	Thu,  4 Jun 2026 22:22:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780604544; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=wOljlMat6RAb/iGwhJiSN0/00+BKRzGXIX9CN4zoVrw=;
	b=GvDDw8u35k8xGEs3fqF3paacKHdP03w3PMEwyMaIVfGX75EedJ8YWBTHTKad7ujmELnH2j
	80H7knPMdmUaEK11JcRfoeBv+W1qgm2Wkgf8OkrEhwdUAq7AkM0q9GT/mDJXaL5v73eBd6
	JzxtWYB0/xdr5UA47rO6IbWcGp1smjMqQO47xFGChHMsy8VmHx0h43u0PiA0r0eJiW4bBl
	y/iGHkmjGLzOYIdeepjsDwpX3OcGVAhZWB4BcoOhm+B8Oyb/sQZXZHRdUhY98YlpalQKT5
	aWLmUYma0sCV9myA3ZuGLD7c6mo8UOijyvfT75GeEdsJBnTYDRrpeEjQGO4u4g==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v2 0/8] bpf: add support for KASAN checks in JITed
 programs
Date: Thu, 04 Jun 2026 22:21:58 +0200
Message-Id: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQ7CIBAFf6XZsxiWVmw8+R+mB6BgNyo0QJqah
 n+XEI+TeZl3QLKRbIJbd0C0GyUKvoI4dWAW5Z+W0VwZBBeSo5DspZLyzJlZjk4OZr5qqNs1Wkd
 76zxAr455u2eYqlko5RC/7WDD5ltrwP7f2pBxhuoy9ih6Pgq86xDym/zZhA9MpZQf6CODbqYAA
 AA=
X-Change-ID: 20260126-kasan-fcd68f64cd7b
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

Hello,
this series aims to bring basic support for KASAN checks to BPF JITed
programs. This v2 drops the RFC prefix and brings many updates regarding
the topics and issues mentioned on the RFC or at LSFMMBPF. Thanks to
Ihor's update on CI, the instrumentation can now trigger properly in CI
as well.

"Traditional" KASAN allows to spot memory management mistakes by
reserving a fraction of memory as "shadow memory" that will map to the
rest of the memory and allow its monitoring. Each memory-accessing
instruction is then instrumented at build time to call some ASAN check
function, that will analyze the corresponding bits in shadow memory, and
if it detects the access as invalid, trigger a detailed report. The goal
of this series is to replicate this mechanism for BPF programs when they
are being JITed into native instructions: that's then the JIT compiler
that is in charge of inserting calls to the corresponding kasan checks,
when a program is being loaded into the kernel. This task involves:
- identifying at program load time the instructions performing memory
  accesses
- identifying those accesses properties (size ? read or write ?) to
  define the relevant kasan check function to call
- just before the identified instructions:
  - perform the basic context saving (ie: saving registers)
  - inserting a call to the relevant kasan check function
  - restore context
- whenever the instrumented program executes, if it performs an invalid
  access, it triggers a kasan report identical to those instrumented on
  kernel side at build time.

As discussed in [1], this series is based on some choices and
assumptions:
- it focuses on x86_64 for now, and so only on KASAN_GENERIC
- not all memory accessing BPF instructions are being instrumented:
  - it discards instructions accessing BPF program stack (already
    monitored by page guards)
  - it discards possibly faulting instructions, like BPF_PROBE_MEM or
    BPF_PROBE_ATOMIC insns

---
Changes in v2:
- declare asan functions as extern in JIT compiler rather than exposing
  them in kasan header
- invert stack-accessing instructions marking to make sure not to skip
  instructions that could end up accessing to-be-checked memory
- fix stack accesses marking when verifier patches instructions
- add best effort marking for cBPF
- add missing call depth accounting in jited instrumentation
- skip unused registers in kasan instrumentation save/restore
- remove faulty stack align in kasan instrumentation
- drop commit skipping some jit-related tests
- cover missing instructions: BPF_ST and atomics
- completely rework tests: directly tune shadow memory, increase
  coverage, do not consume kernel logs
- Link to v1: https://patch.msgid.link/20260413-kasan-v1-0-1a5831230821@bootlin.com

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
To: Shuah Khan <shuah@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org

---
Alexis Lothoré (eBPF Foundation) (8):
      bpf: mark instructions accessing program stack
      bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs
      bpf, x86: add helper to emit kasan checks in x86 JITed programs
      bpf, x86: refactor BPF_ST management in do_jit
      bpf, x86: emit KASAN checks into x86 JITed programs
      bpf, x86: enable KASAN for JITed programs on x86
      selftests/bpf: add helper to check whether eBPF KASAN is active
      selftests/bpf: add tests to validate KASAN on JIT programs

 arch/x86/Kconfig                                   |   1 +
 arch/x86/net/bpf_jit_comp.c                        | 209 +++++++++--
 include/linux/bpf.h                                |   2 +
 include/linux/bpf_verifier.h                       |   2 +
 kernel/bpf/Kconfig                                 |   9 +
 kernel/bpf/core.c                                  |  17 +
 kernel/bpf/fixups.c                                |  16 +-
 kernel/bpf/verifier.c                              |   9 +
 tools/testing/selftests/bpf/prog_tests/kasan.c     | 356 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/kasan.c          | 382 +++++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  22 ++
 tools/testing/selftests/bpf/unpriv_helpers.c       |   5 +
 tools/testing/selftests/bpf/unpriv_helpers.h       |   1 +
 13 files changed, 994 insertions(+), 37 deletions(-)
---
base-commit: b1c85ee71e2ab9ed7a12d7f3ee38988509baa368
change-id: 20260126-kasan-fcd68f64cd7b

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

