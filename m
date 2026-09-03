Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8D54AF9D9;
	Thu,  3 Sep 2026 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443523; cv=none; b=YHHVGoPlDn4AGLuh2+INOGJaRr6Vwe0a1Wa3MBvRJFLMB5pK/GzVYmz4DAGRLvpTK8AMYcpPs/VDmpLYSXGIJR6tiCvySI3aTYIvtv8MqNrA0fuObaWPvc7KH7EyF3wgooMhg5bIAl7rc0hJ0uLfXlRBWjPaBAZ9Mt4o/+qPLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443523; c=relaxed/simple;
	bh=3wMHQHAuVEp+zkRp00jmp9q+KrzX0BdH7/qtyshseIM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZqBDyZOjr+yYOJFhWkVK0Zt1MBhITzYK05CIdr1u34HseQLEv3tPHZ/TrM752n4etTWThB4qKgs33mF84D47leO1YVT5V7wrqUIxdYg7CxT+qRi+qUIoF+fq2IHHInsnLvLMIjxoY84TRTGVNGJbGp4dhgD5f46Cs9r6rlCSfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UzGWj5B4; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UzGWj5B4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4D5F71A197C;
	Thu,  3 Sep 2026 13:51:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1B3AE602B8;
	Thu,  3 Sep 2026 13:51:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A55E711C7A1BC;
	Thu,  3 Sep 2026 15:51:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788443498; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=e4/g7C+nn1NCPTrqUZ6cb3e/lNKmPgdm2SIBxtjFAPA=;
	b=UzGWj5B4rY2piKFldFWDqCFXbwfJgSBHYFUILJ0OboGRgfuNtqw7k+OQ1uYmGfPdpSOt9o
	lgArGN+eUAVMo868Fh8NQNr7p9MRATl3S2LWuAGlLLFOLyPjPdPQYwvjLjwh/m4em+hI5d
	NQwpCiw4gyP+Cl3+7LH9w2+jzIAFhWnyuuL7zRhZggTbM6bHsY3cEh0Auknxfipzixq2OT
	CJh3CQcuFPwJjk6iVOOvC/lIMUqZBuiFLMnWdpgk50diRyuNF5epSuIW8GQBQTwXJZtId/
	9Y1i/L1qTh/gIffXGM/z/uQdUK99x2ft5HKJnOQ9luCxHQowtKLjSfzv6Tjp1Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v9 0/8] bpf: add support for KASAN checks in JITed
 programs
Date: Thu, 03 Sep 2026 15:51:29 +0200
Message-Id: <20260903-kasan-v9-0-2407fe99255a@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Qy07EMAwF0F8ZZU1Q4uY5K/4DscjDZiKgHbVVN
 WjUfydUlBaVpeWcG13f2YB9wYGdT3fW41SG0rV18A8nli6hfUVecp0ZCDBCguFvYQgtp5SNI6N
 StpHVt9ceqdyWnGcWr8RbvI3spW4uZRi7/nP5YJLLfslSsvnJmiQXXAbtGgmNcCCfYteN76V9T
 N3HkjHB5qpcHVSXhDFowFIO7uiazVkhV9dUF7PwMXoF2ZmjU3vnVqeqyzpJa0N0APbo9N751en
 vfsmoQA4VSjw6szm39TPVaeWRnNKk/D93sTsHsDpbnfeBEA1SvczRub377eeqs0kmQTn6bOmvm
 +f5C4MDot0uAgAA
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
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Yafang Shao <laoar.shao@gmail.com>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Hello,
this is v9 of the series aiming to bring basic support for KASAN checks
to BPF JITed programs. Among a few minor optimizations, this revision
fixes some wrong kasan instrumentation on some unwanted stack access
(stack access ending up being instrumented AND targeting the wrong stack
offset). To mitigate this risk further, this revision introduces a
systematic KASAN check skip when (addr_reg == BPF_REG_FP || addr_reg ==
BPF_REG_PARAMS) in emit_kasan_check. This secondary check (on top of the
non_stack_access flag), should hopefully prevent the issues raised in
v8. I've also reworked the emit_st refactoring to realign it with
BPF_STX management in the x86 JIT compiler, as the "arguments on stack"
feature made me realize that it could be kept more symmetric with
BPF_STX; so I've dropped Ihor's Acked-by on this.

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
Changes in v9:
- make non_stack_access a bit field
- do not process BPF_ST|BPF_NOSPEC as a memory-accessing insn
- do not flag non_stack_access if check_mem_access is called for a
  non-memory accessing insn
- refactor a bit further the BPF_STX | BPF_ATOMIC | ... branch in JIT compiler
- Link to v8: https://patch.msgid.link/20260828-kasan-v8-0-7c1c0fdb9d7f@bootlin.com

Changes in v8:
- Make sure that test programs involving STX are not turned into ST on
  cpuv4
- Execute ST tests only when compiler can emit ST (ie: cpuv4)
- make sure to test the reg type before the verifier can alter it (eg an
  on_stack access with dst_reg = src_reg)
- Add new test for the case mentioned above, ensuring that a pure stack
  access with dst_reg == src_reg is not instrumented
- add back save/restore logic for r10 and r11 in emit_kasan_check
- make the new kasan test serial to avoid side effects due to
  bpf_jit_harden being toggled
- dropped the set_bpf_jit_harden helper, as there is already a
  sysctl_set helper
- Link to v7: https://patch.msgid.link/20260822-kasan-v7-0-99afee6ef7fd@bootlin.com

Changes in v7:
- Rebase series on top of current bpf-next_base, fixed conflict with
  7ce090afbf72 ("bpf: Infer zext_dst based on static register liveness
  analysis")
- Link to v6: https://patch.msgid.link/20260804-kasan-v6-0-549ef845f491@bootlin.com

Changes in v6:
- dropped instruction original offset tracking
- when patching instructions, track former non_stack_access flag by
  passing original insn to adjust_insn_aux_data
- drop unecessary dep on CONFIG_KASAN in Kconfig
- fold patch adding the emit_kasan_helper into the patch actually
  calling it, to avoid an unused static function warning
- move stack access check out of emit_kasan_check
- replace hardcoded ip value by a computed value
- add OoB testing
- add fix commit to make cmdline_contains stricter

- Link to v5: https://patch.msgid.link/20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com

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
To: Emil Tsalapatis <emil@etsalapatis.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ebpf@linuxfoundation.org
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Alexis Lothoré (eBPF Foundation) (8):
      bpf: mark instructions accessing program stack
      bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs
      bpf, x86: refactor BPF_ST management in do_jit
      bpf, x86: emit KASAN checks in x86 JITed programs
      bpf, x86: enable KASAN for JITed programs on x86
      selftests/bpf: make cmdline_contains stricter
      selftests/bpf: add helpers for KASAN in JIT testing
      selftests/bpf: add tests to validate KASAN on JIT programs

 arch/x86/Kconfig                                   |   1 +
 arch/x86/net/bpf_jit_comp.c                        | 268 +++++++++--
 include/linux/bpf_verifier.h                       |  16 +
 kernel/bpf/Kconfig                                 |  17 +
 kernel/bpf/fixups.c                                |  33 +-
 kernel/bpf/verifier.c                              |  10 +
 tools/testing/selftests/bpf/prog_tests/kasan.c     | 479 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kasan.c          | 502 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/kasan_harden.c   |  52 +++
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  55 +++
 tools/testing/selftests/bpf/unpriv_helpers.c       |  19 +-
 tools/testing/selftests/bpf/unpriv_helpers.h       |   2 +
 12 files changed, 1403 insertions(+), 51 deletions(-)
---
base-commit: 8ea8efd114bdfdd4cd26958b52955739f2153f63
change-id: 20260126-kasan-fcd68f64cd7b

Best regards,
--  
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

