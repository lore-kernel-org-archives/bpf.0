Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520005;
	b=bJU14uiMQPZ93AimvmtXxD3mdTA3rvP4tyEbDrnaLDxkWtJgmzYb0OFTigIpkegRG1uG
	 e01EZUHJ8MhczsQlbDKgbyTJrn2rzUnsRUcE2slKlz7E88rzIUHNBnjYSoKu6BEUuxDRD
	 a12H3p/rgD7nGkIGL5S2HcoqJb0bNfOamYcrrAqDnuImVuHISSCAGM2Epo2BgPgymf5T7
	 sicSe+cfXBqfEWW0W7muURIAMbnzydgQESVKF3b8v1cxH4TLSu1irKnIg3rUi927xs3bj
	 Y6S9JKGniS+R8FeDCSTpbdE2n97vuGzbaqS7cBYRD3vDaegamftzOr9DcT1f47sarpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zgQ0ojURyS78+DigRZVTrWR5e++EKJNgiMmsMqmQ1QU=;
	b=ddWIvg6C94k5vwcKY4OXLUdeQFcum29rjFPCsiSTLwAALK+x70UWVPf7qK5pD9M730gW
	 NSZNAx6v7Z2xvFPS5LjVTWCX3sC6lPQZxVHEH4R4aHACPEAgSdkdHFP6og7oK/gXv1d63
	 2UohKn7X1kwuQtewi+efPBhW9Vbq1SayjxIvOUwG9R2ErhrBy9X11XmAH6++6o6stVJKq
	 n/7Zz2QwKQOBIigUvKllLomBf8/9gM1W/05vj+Zo2ywiVt/iMeMArKt11pHwpcLO18JYk
	 aH4W8c1kjPcUvp1M+5AH3lV/wc+/rcRSll38WbTuFKOVsVmieZqfF0H8b4eyGTvpLig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RMd8T2fD;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260A606A321
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7260A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RMd8T2fD
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso2119797a91.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520005; x=1793124805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zgQ0ojURyS78+DigRZVTrWR5e++EKJNgiMmsMqmQ1QU=;
        b=RMd8T2fDz+FzEBZJbJiE1uMY004dzgSrD/IREN+vivM43mdIaeK9f6CGFBMaMnTlx6
         cPtpjE9T6uxz9S0JCXSzXfsk5QLaBWvVbB4TeGIqdOiAvPvnpFWYcHQ3j3ZXAkNIPKyK
         R/jPJoVQKpPYJaPpZrTvSSjmEDno3Vb7QyojFIiaOH7xmgfg1+fabutCHAjZjnzDeySP
         FXmDv41faDpnmoHiSZs6cndjJM0wtl8+BQ7KZS5ZysN5EBvQ+8TOZwB4IF13sIm4brnS
         sA9+skmM2b0Q1PdtJr9/3lGdtiYweN9ip2yvRFIDUntqqN7kKooLpeyRsCq0wnrLEbqx
         nCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520005; x=1793124805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zgQ0ojURyS78+DigRZVTrWR5e++EKJNgiMmsMqmQ1QU=;
        b=QI84akuuasS9gOnBqCiVHZqBveBW2wS11CJO1czseH44891lrmcZ/MaXD4f0MwoYcw
         zPZm0OhwJUdWLKMn65N3C1txaUNXkvcpW3GOrLUxYUH+CDMUwnN+7jD8W0VTTKviUIb/
         tiEi2K6Hrtvpow/3Chvg51mOVBZl18kJygLoSKPNyrEDC4s1NXM1d7gAhXZpOhF0gZXT
         ImqnMOlmUeVD2L1oeMGIWnL5xRxXgLJNvdmxL2jSP8CUxN8oMrSq/5sBKiwmUruUDFhS
         SoODo7MMIgqlbfnYvxNIIXM8ujnJmULY1k+XCqp6ObFY2+0i3h/3a0ClBHY8mKOhNzWG
         v7XQ==
X-Gm-Message-State: AFq9FYIFrvb3VjfU3Zymk85qOXvB/+ayvBXZ9ZrfOvfpi48kZYKSu60r
	hbjAkpUIo1JlomiaTGvkmJs3f+pUYbNbAOqOaLYSI9USeRKsePaeLffx8ZlUhA==
X-Gm-Gg: AYBFou26RYgr4xOpsIi8Q9OXWdAho4zT3HHw9UvC9W4zUi1qXE1hYNHlVuA3GMmJDXl
	gE77eseI/wQ9dptM802JA/eCE3Qchp4fMNjh7I6TgUoCUnZ9QuWD+VFUZD44+6xskbafSoprekj
	EtrgEE0hNsyXwKOlu9jorle//ws9KWEjsRa07axV04plMbLCBD4AhThUyjLhanUkwxmVhEEgo/V
	ffY06zVj8X/ULvlwCSNlf4GDWUUJ6+pgBl7Bs5Kylzr82wPVkKWzjsNOUhbllO759UABCtSzOzA
	a4b7/+8M2stBxPpR+5OmRGw1VxHtAJ3UTLk/1LXBCwDQehmdCWJwoW9EjDLWFreygguCo6VwVya
	bheouPtpJtce+dN0V6daHWMQszq2rXSn+MIO9qC33IiZIBEoWFaNJrXY5Qn03UEykhjTvSMZ+EH
	NHr6aA0K3ahYH0R3kajGhDFn+2pesE2njNBu/Mpm3NgfLIa7dftmyHws02YiOWzQUdNaT6kPbtK
	+WcDmlIYT6OZnNdi1NCLLfZOZ0T7RTlzHuGJryikrUWMrtQ7wjQSKrBflS8VO4L9V6WNZkusQxp
	JvUhlgEapbeHTvCqXZrhwRlDI+JZb0LqCIeVu0SZmuM=
X-Received: by 2002:a17:90b:574b:b0:3ac:9717:afd1 with SMTP id 98e67ed59e1d1-3acef589989mr9733817a91.63.1792520004656;
        Tue, 20 Oct 2026 11:13:24 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8021d29bsm619158a91.4.2026.10.20.11.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:13:23 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v4 bpf-next 0/6] bpf: Unwinding with unwind_goto and unwind_exit
Date: Tue, 20 Oct 2026 18:13:14 +0000
Message-ID: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

1. What is the problem?

A rust panic or a C++ exception has to run Drop impls or destructors of
every frame it passes through. bpf_throw() discards the frames, so the
verifier doesn't let a frame that owns a lock or a reference throw. In rust
every index and every unwrap() can panic.

2. Is it worth solving?

Without it rust-bpf [1] drops all landing pads and a panic is bpf_throw().
A prog that can panic with a guard held doesn't load.

3. Is there a simpler way?

[2] keeps the normal path free of unwind code. llvm emits a table, libbpf
passes it to the kernel, bpf_unwind() walks the stack and rewrites return
addresses, and the verifier models hidden edges from calls to pads. That's
1400 lines in the kernel, with new uapi and two kfuncs, and 440 lines in
libbpf.

Here the edge from a call to its pad is an insn, and so is the other way
to leave a frame [3]:

  ret                            exit
  invoke foo unwind pad          call foo; unwind_goto pad
  resume                         r0 = 0; unwind_exit

Pads are ordinary code. The verifier learns one bit: how the callee left.
The normal path is free of unwind code too: JITs emit nothing for
unwind_goto, and exit is what it was.
200 lines in patch 1 and 100 lines in each JIT.

4. Will the api and the layers last?

Two new insns: one more kind of BPF_JCOND and one more kind of BPF_EXIT.
No kfuncs, no BTF, no changes in libbpf and other loaders.
The source level entry point is _Unwind_RaiseException() of the Itanium
ABI. It's what the runtimes of rust and C++ call on other architectures.
unwind_exit returns r0 like exit does. Today it's 0. That's where an
exception object would go.

5. Is it good taste?

Every frame returns through its own epilogue. The only question is where it
returns to. That's one bit, and it's a bit of control flow. v1 kept it in
a register.

It's not specific to rust. A C++ prog with throw, catch and destructors
compiles, loads and runs. It's a selftest in patch 5.

The llvm side is a new PR [3]. It replaces [4].

v3 -> v4:
- CI stayed red on x86-64. Call depth accounting was not the reason. CI
  builds x86-64 with KASAN, where the JIT wraps a load in pushes, a call
  and pops. The patterns of two __jited tests took that call for the call
  of the subprog. Now they start after the loads.
- When the callee never exits, what follows unwind_goto is seen only
  speculatively. It was removed as dead code, and other code moved to where
  the cpu predicts the return. Now 'goto pc-1' is there (sashiko).
- unwind_exit of an async or an exception callback is exit, like in the
  main prog. It was rejected. A sync callback still cannot unwind.
- arm64: no autia1716 and pacia1716. The address of the pad isn't signed.
  The epilogue authenticates LR as it is, and the offset of the pad is
  added to it afterwards.
- BPF_UNWIND_EXIT is enum instead of #define.
- unwind_attach and unwind_cxx skip when JIT is disabled, and don't define
  ENOTSUPP (bpf-ci).

v2 -> v3:
- bpf_unwind_target() is back in the JITs. In core.c it broke the build on
  MIPS, where struct exception_table_entry has no fixup (sashiko, bpf-ci).
- CI was red on x86-64: two __jited tests didn't expect call depth
  accounting in front of a call (bpf-ci).
- A global subprog that returns 16 bytes couldn't unwind: the verifier
  checks r0 and r2 at unwind_exit, and llvm set r0 only. Fixed in llvm.
  Patch 6 is Kumar's test.
- freplace: unwind_exit of an extension was exit, so the exception was lost
  (Eduard). Now the extension returns to the pad of the caller of what it
  replaced. An extension that can unwind replaces only a subprog that can.
  fexit cannot attach to such an extension.
- unwind_exit makes the cpu mispredict the return. Without CAP_PERFMON
  the verifier looks at what follows unwind_goto as a speculative path
  (bpf-ci).
- unwind_goto was 'call pc+0' in the xlated dump: BPF_JCOND is the same
  opcode as BPF_CALL_ARGS.
- selftests: 'the callee never returns' looks at xlated insns, and 'the way
  the callee left is a part of the state' has BPF_F_TEST_STATE_FREQ.
  Neither tested what it said (bpf-ci). New tests for async and exception
  callbacks, speculation and freplace. Every check that the series adds
  was removed in turn to see that a test fails.
- llvm: a pad doesn't set r0 when it only writes w0. Yonghong's callx case
  from [4] is a lit test.
- Rebased.

v1 -> v2:
- unwind_goto and unwind_exit instead of 'if r3 != 0 goto pad' and
  'r3 = 1; exit' (Kumar).
- JIT support is not an optimization anymore. There are no shape tests, no
  look at jump_target, which was stale (sashiko), no exit that looks at r3
  and no fallback to a branch.
- r3 is an argument again and nothing else. In v1 a subprog that didn't
  write it passed it through, and fentry didn't restore it (bpf-ci).
- Async and exception callbacks cannot unwind (sashiko).
- No BTF decl_tag, which was matched by prefix (bpf-ci). It works without
  BTF.
- x86 private stack is supported.
- Tail call and ld_abs are allowed.
- selftests: no #ifdef by arch, which broke the build on the rest of them.
  The messages are checked. fentry is attached and the target is run.
  Skips say why (bpf-ci).
- clang defines __BPF_FEATURE_UNWIND.

v3: https://lore.kernel.org/bpf/20261020043319.3031996-1-alexei.starovoitov@gmail.com/
v2: https://lore.kernel.org/bpf/20261019051846.3012089-1-alexei.starovoitov@gmail.com/
v1: https://lore.kernel.org/bpf/20261018010246.1643877-1-alexei.starovoitov@gmail.com/

Tested on x86-64 in kvm with KASAN, like CI does: test_progs,
test_progs-no_alu32, test_progs-cpuv4 and test_verifier, all of them in
full. The new tests also with retbleed=stuff. C, C++ and rust progs built
with [3] were run on x86-64 and arm64, with and without bpf_jit_harden=2.
arm64 is qemu, with and without pointer authentication, and a small loader
instead of test_progs. v3 passed test_progs on arm64 in CI.

[1] https://github.com/4ast/rust-bpf
[2] https://lore.kernel.org/bpf/20261017025129.1914859-1-yonghong.song@linux.dev/
[3] https://github.com/llvm/llvm-project/pull/233649
[4] https://github.com/llvm/llvm-project/pull/233140

Alexei Starovoitov (5):
  bpf: Add unwind_goto and unwind_exit insns
  bpf, x86: Support unwind_goto and unwind_exit
  bpf, arm64: Support unwind_goto and unwind_exit
  selftests/bpf: Add tests for unwind_goto and unwind_exit
  selftests/bpf: Add a C++ prog with exceptions

Kumar Kartikeya Dwivedi (1):
  selftests/bpf: Test unwinding from R0:R2 subprog

 arch/arm64/net/bpf_jit_comp.c                 |   97 +-
 arch/x86/net/bpf_jit_comp.c                   |  101 +-
 include/linux/bpf.h                           |    1 +
 include/linux/bpf_verifier.h                  |    3 +
 include/linux/filter.h                        |   20 +
 include/uapi/linux/bpf.h                      |   13 +
 kernel/bpf/const_fold.c                       |    2 +-
 kernel/bpf/core.c                             |    6 +
 kernel/bpf/disasm.c                           |    7 +-
 kernel/bpf/fixups.c                           |   18 +
 kernel/bpf/states.c                           |    3 +
 kernel/bpf/syscall.c                          |    6 +
 kernel/bpf/verifier.c                         |  109 +-
 tools/include/uapi/linux/bpf.h                |   13 +
 tools/testing/selftests/bpf/Makefile.skel     |   11 +
 .../selftests/bpf/prog_tests/unwind_attach.c  |  112 ++
 .../selftests/bpf/prog_tests/unwind_cxx.c     |   99 ++
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/unwind_attach.c       |   43 +
 .../selftests/bpf/progs/unwind_cxx.cpp        |  150 ++
 .../selftests/bpf/progs/verifier_unwind.c     | 1211 +++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |    3 +-
 22 files changed, 2021 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_cxx.cpp
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unwind.c


base-commit: f25f6319e248034f3df83352e450ab3172eece43
-- 
2.55.0

