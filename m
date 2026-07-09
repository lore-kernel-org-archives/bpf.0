Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B70D3BFE4F
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591398; cv=none; b=pCzttBvLfndSNc5q1OveSu/PAzL/zkjVWFSpQr+H5lnde64asufL/sQSP1+u+wr3+Ze9U7YMlcbN9JvN3YHmL7U2OgGJaMWqsd2HGr6OPq+DnwFsNRjVVv8qHu8Iq/i48gR5blcJetryMOZ5DHh1HHARA+fWSEA5MQzP91YN26M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591398; c=relaxed/simple;
	bh=2yi1AIreDfbfLC82t3O2dQa6CCAV6BYRbNdcYJV/L9Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fCaIpiDKkrcYsFb0717b4IlWB0D8FYK087KbY3eXodVmFN12r7ucJc0dK8IFPyiM1I2YG7OvPb1nxFheeE12T703eLq9PUCLucdtz1JC0JxlScloTpOBWm7xwzdLoVPpW5LGbMfbkdE++MGhyxr+ofi3zRUGaG8tqZugHHHdUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dTZqK+gd; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dTZqK+gd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9B5A21A0F04;
	Thu,  9 Jul 2026 10:03:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6C1A85FF03;
	Thu,  9 Jul 2026 10:03:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37C2411BC373F;
	Thu,  9 Jul 2026 12:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783591391; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=cVBE1aiZ3HG5WuEi1Kbl3vGiCq8T4ImIrpSHvZbX6Hs=;
	b=dTZqK+gdLi8BsOyPfPTXgxMg6BhJaQgBPhqfyBhtRL/Zftsddim+AG2EvqjrmzAiGvYgW2
	D0NBt272g5KGbHbZcDHX5EJteXkpDevtTNaxmjW6wGbdtCVnf5C2Kdvnkw5b6NUpE2REgG
	dn3KQ7+WTNGtInwW8v04GFc4T8FAb2hIfwPE0+8NGGxpwVWon2PoYh/x4EfxKOE0402iFL
	7z+aRieJEvrNVhJajX3hVVV/jSqad1mVKKQ6scI7arMyL6RCQbmCn2VwiIVFZShZWbkifU
	Ry1A8SVnTJO1+XlpfUWsrKfQ718UXMhDSh0Kf71IXSZO2oB7J7sfJJd4gXP8fg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v5 00/10] bpf: add support for KASAN checks in
 JITed programs
Date: Thu, 09 Jul 2026 12:01:41 +0200
Message-Id: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNTY4CIRAF4KsY1oOhChrQlfcwLvgdycyAaTodj
 em7S4gdnbh8efW9upMaxhQq2W/uZAxzqqnkFoavDXFnk78DTb5lggwlA5T0x1STaXRe6iiF88q
 SdnsZQ0zXvnMk9hJpDteJnFpzTnUq460/mKH3fUsAf27NQBkFM2gOyJlGONhSpt+Ut6789Y0ZX
 67J1WFzjkkZJKrojf50/OUUg9Xx5qxnO2t3Ar2Wn068O7060ZwfHChlrEZU/92yLA9YKMWJTgE
 AAA==
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
this is v5 of the series aiming to bring basic support for KASAN checks
to BPF JITed programs.

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
Changes in v5:
- fixed a few instruction offset for generated fixups
- fix insn marking for single insn patches
- enforce more checks in tests
- skip tests if kasan_multi_shot isn't enabled
- Link to v4: https://patch.msgid.link/20260708-kasan-v4-0-d5c177ab8227@bootlin.com

Changes in v4:
- fix insn_offs_in_patch leakage in bpf_convert_ctx_access
- handle BPF_ATOMIC in is_mem_insn
- correctly mark fixup instructions if a single insn is generated
- clarify new kconfig (Andrey) and drop VMAP_STACK dep
- refactor BPF_FETCH atomic handling in JIT loop
- make kernel log reading resilient to unrelated, interleaved logs in
  the selftests
- make new test kfuncs depend on BPF_JIT_KASAN rather than KASAN_GENERIC
- Link to v3: https://patch.msgid.link/20260701-kasan-v3-0-bd09bb942d86@bootlin.com

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
      selftests/bpf: add helpers for KASAN in JIT testing
      selftests/bpf: move bpf_jit_harden helper into testing_helpers
      selftests/bpf: add tests to validate KASAN on JIT programs

 arch/x86/Kconfig                                   |   1 +
 arch/x86/net/bpf_jit_comp.c                        | 271 ++++++++++---
 include/linux/bpf_verifier.h                       |   2 +
 include/linux/filter.h                             |  10 +-
 kernel/bpf/Kconfig                                 |  17 +
 kernel/bpf/core.c                                  |   2 +-
 kernel/bpf/fixups.c                                | 132 +++++--
 kernel/bpf/verifier.c                              |   9 +
 .../selftests/bpf/prog_tests/bpf_insn_array.c      |  44 +--
 tools/testing/selftests/bpf/prog_tests/kasan.c     | 430 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kasan.c          | 394 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/kasan_harden.c   |  41 ++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  22 ++
 tools/testing/selftests/bpf/testing_helpers.c      |  32 ++
 tools/testing/selftests/bpf/testing_helpers.h      |   1 +
 tools/testing/selftests/bpf/unpriv_helpers.c       |  10 +
 tools/testing/selftests/bpf/unpriv_helpers.h       |   2 +
 17 files changed, 1288 insertions(+), 132 deletions(-)
---
base-commit: 950d646b505ae37ee75f4c2b11d41e7190036c42
change-id: 20260126-kasan-fcd68f64cd7b

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

