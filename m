Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB15401484
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900216; cv=none; b=r2bVXiA/2nlIf6mthmG6EquH1v4n+jaPWa/Yc8IvpmojCJEWfGT7Nskk20WYiSnSRa5AFdg5oUo1kLCSD45oJmb3Q5ebgfHxMRo5pcRicsyp6ZLHc5rmG+9cqhYUf4lnB2yJOv78ZlBtF+wXuJtxq9sh1ZYOXFWdR4lDA10cvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900216; c=relaxed/simple;
	bh=71miEVOaFg2Y7FjIopkNQzpqW3JD5JeS+IMA42kXnE0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zq8KGxmFQMVS6vwIcBDIggU/SijGhI1gRGof+tGaqSHOmCoiYa9VVi4aAlH+fQ1LT5aNG+4FZYdpXqKTLYBJpUb704D+J3wD49hl5UsXT3kO/T73mZLVZZbuAhTOvmpWJjySsRhsxjA+7ZkvIFggEqXjwv4NkTV2w8VjgO6XreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C+IDpFmX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C+IDpFmX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 319011A0DAD;
	Wed,  1 Jul 2026 10:03:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0378F60288;
	Wed,  1 Jul 2026 10:03:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6E7D104C9A7E;
	Wed,  1 Jul 2026 12:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782900205; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=s3JpcmCquF/2Y4MJWThqNNHt39jHUKW7ZiL/aV2W7SA=;
	b=C+IDpFmX3xVwRlmJDSTzvSmKKmiU3ElYsdt/s1gEh724TxkEQ1Np/b6dosYtIMubLK3nb4
	PgnjICi1uZT7WU8gSHTb5mGDNM3VDkViyMFWOIGry/NWIoakZZUAD6GWsjbbgeUzgxzLFM
	2QZW6JTWB/L3Tf357x3fQczsa9i5aCLu+J9r3+RvvJMrCsLAcaVWBaR3BKzjb+YeJkEP/P
	GwCKs2TyxNMd8Kd/9lMOv5qS+mthBAcNfsHI+hVlIz4OhKiLbVc2muFsYpVv8yIuoc5Lbr
	pCkojg5f3WU1vRUo/x9DBOATQqClvdygp3ZneEdK23VJ/nm2vuszyh57+WGIsQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v3 00/10] bpf: add support for KASAN checks in
 JITed programs
Date: Wed, 01 Jul 2026 12:02:48 +0200
Message-Id: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNyw7CIBREf8XctRi4VEpc+R/GBeVhiQoNNKSm6
 b9LiMa4nMycMytkm7zNcNqtkGzx2cdQA9/vQI8q3CzxpmZAioIyFOSusgrEaSOkE502/QB1OyX
 r/NI8FxgmR4JdZrjWZvR5junVDgprfXN1jH9chRFKmDpKzpBTiew8xDg/fDjo+GyOgj+ukl8OK
 6epEFZg74yS/9y2bW9WIy/63gAAAA==
X-Change-ID: 20260126-kasan-fcd68f64cd7b
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

Hello,
this is v3 of the series aiming to bring basic support for KASAN checks
to BPF JITed programs. Aside from the comments from Alexei, Yonghong and
Sashiko, the most notable update in this revision is the stack-accessing
instructions marking which has been reworked quite extensively to better
track stack accessing instructions. As a side effect, instructions being
generated by the verifier's patches are better covered.

Original cover letter:

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

The series comes with new selftests programs that generate a wide
variety of kasan reports: those need the kernel to be running with
kasan_multi_shot enabled.

As discussed in [1], this series is based on some choices and
assumptions:
- it focuses on x86_64 for now, and so only on KASAN_GENERIC
- not all memory accessing BPF instructions are being instrumented:
  - it discards instructions accessing BPF program stack (already
    monitored by page guards)
  - it discards possibly faulting instructions, like BPF_PROBE_MEM or
    BPF_PROBE_ATOMIC insns

---
Changes in v3:
- Do not insert KASAN instrumentation when dealing with cBPF
- Fix stack-accessing insn tracking for verifier patches, as original
  instruction location in the generated patch may vary
- drop cBPF support for stack-accessing insn marking
- make sure to flag correctly memory access if different verifier states
  involve different memory types (eg: stack in one path, non-stack in
  another path)
- refactor BPF_ST handling in x86 JIT compiler
- improve tests coverage (cover instrumentation for a few patches
  emitted by the verifier)
- Link to v2: https://patch.msgid.link/20260604-kasan-v2-0-c066e627fda8@bootlin.com

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
To: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
To: Shuah Khan <shuah@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Alexis Lothoré (eBPF Foundation) (10):
      bpf: propagate original instruction offset when patching program
      bpf: mark instructions accessing program stack
      bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs
      bpf, x86: add helper to emit kasan checks in x86 JITed programs
      bpf, x86: refactor BPF_ST management in do_jit
      bpf, x86: emit KASAN checks into x86 JITed programs
      bpf, x86: enable KASAN for JITed programs on x86
      selftests/bpf: add helper to check whether eBPF KASAN is active
      selftests/bpf: move bpf_jit_harden helper into testing_helpers
      selftests/bpf: add tests to validate KASAN on JIT programs

 arch/x86/Kconfig                                   |   1 +
 arch/x86/net/bpf_jit_comp.c                        | 264 ++++++++++---
 include/linux/bpf_verifier.h                       |   2 +
 include/linux/filter.h                             |  10 +-
 kernel/bpf/Kconfig                                 |   9 +
 kernel/bpf/core.c                                  |   2 +-
 kernel/bpf/fixups.c                                | 128 ++++--
 kernel/bpf/verifier.c                              |   9 +
 .../selftests/bpf/prog_tests/bpf_insn_array.c      |  41 +-
 tools/testing/selftests/bpf/prog_tests/kasan.c     | 437 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kasan.c          | 394 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/kasan_harden.c   |  41 ++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  22 ++
 tools/testing/selftests/bpf/testing_helpers.c      |  32 ++
 tools/testing/selftests/bpf/testing_helpers.h      |   1 +
 tools/testing/selftests/bpf/unpriv_helpers.c       |   5 +
 tools/testing/selftests/bpf/unpriv_helpers.h       |   1 +
 17 files changed, 1273 insertions(+), 126 deletions(-)
---
base-commit: 3b5b67d773976a25737940ed9081a29632a30f8c
change-id: 20260126-kasan-fcd68f64cd7b

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

