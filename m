Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470803;
	b=ZF+wu0dltHVIdhL7yTKV9zkzldosNkkcgKr1CqavnWu5ZPMUi2TXEZWA8Fg9NOtkxn2L
	 7UIt/UsURbCC/UMo/Yk3ckTqcBYNbwYpdJtJBNQV0s+rfzTxVgZbzuj4kEAJC3+R6nuzL
	 0+E2oRjcIuVLY+VRjJf4RDgvRh3shahH/EMWCdA/djKlQeXdsRbsUg2DEmKCeqb/Msr9j
	 9RFz5a9Rtq1/UCWzcZs+KAl5YjKP3LGezlJk46rqXU/iJVUP/XQpfY3qpbtiDl8ElxCcc
	 bJCsUiewjoMcx2MYyr8v1IgajKmdYAL0FtueZr4NDIHSYQLXgB8qi/FC05xnSgBGpVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VsVEdp4ZOQtnsYLmDVhWY6aNbvMkUWMhEpG1reJvAtE=;
	b=0nN6mQoQ1N2/dOWQfVjKn3C42gVaphX6br4DwGARbsItv/TznAe5jIyswjWmyI0iqgAB
	 32anSTzuX4uGNlsz76EwjybhGBc0TUpsALIVNP0L9+InnKvC8I7hpMZzLpjUIjMgtxHp1
	 oEZhFy+THVSg7lyT91M0L9uvTWJpt6wMpu7KSDjsx2+wiq+Fj6GQVxJokvXBvYKMZjdfU
	 R46zF6OOwOSgs9eiOMD9XLTINaQAUJXf+LeffQ/53a35hciIWruLv+9SrcGKmPunjYdd4
	 VXDiqdseuSk25Rby0DKDPluPU3k71V0GnJAf1A6q/fGwgcIGsJ6cKsu0U2u+ADT3YVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ibzjiafr;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C33606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12C33606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ibzjiafr
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc147d86bebso227327a12.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 21:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792470802; x=1793075602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VsVEdp4ZOQtnsYLmDVhWY6aNbvMkUWMhEpG1reJvAtE=;
        b=IbzjiafrMlslyOD4D0rBnSh0vfuxfivwC8oN1EeJ2NOGcqMoO6IP2lEMKlH1xm0CYe
         KKxGJO+QEKiL9gDM8lQ79U0Cf1kbff44CzqPwEAe+zpMsHifnCX76VFc+xIXL8wwu6xv
         9ACFB61brcI8c8Nmgv/8ELy1ukHItSyokKaQaUg3qr2M6inzgifud57YuFG+YIPnR//4
         usNi3jjwQCY6aD+eJucxwqAgwF+XIwwAzxe+5KwtUz6yEPVJFRqVVo6aUDwk30Uz/B6K
         EPT6WtIBvYurX9FYjtvIuwY42tHYwtz3sK1ZtC3Z0WROHIaI9MkZDbRojtwAdvLDskji
         y4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792470802; x=1793075602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VsVEdp4ZOQtnsYLmDVhWY6aNbvMkUWMhEpG1reJvAtE=;
        b=ArtyO7iHcU1jgVWZ2MSowYeKoUDHQDmeTTKtNj9Wt3J7iO/ZjRiMKT0vkFpfjqXubp
         y6SB9BO6qfJoHhKiI0iGHD6hk0SnZc3d7Ebd1sLT+1H/biiFzu4nB8beYVshIdqHST/D
         7q+1cE38ps57aHXLsVTaqO8vXsVHuUmDpqIA/e8AqSBhfVKvlE3ChWNVlPJb5xGUeOpr
         OcvQrVt+oBpPU9IplGHfeoAIfZjZXfy33Si+ERULn9gfKX5Pqf02X4T/eKIdT0yzjE3J
         8K2Q6yNXR96gLkKxtcEHohR8SmLLuPcILiSaOJpRgEC6nF+1ZtXdeAqq4F25JB+lPxfG
         VkeA==
X-Gm-Message-State: AFq9FYKDhWkPNqyl0MjeAdNMrltoSX8CNVLKWSV7jt6HNFO1dXKrqabG
	ez8fb8T9v8BwOJcwnbuNarYjXWNP13im0b5VX+FlwPAAu5KW/IjyX21gy4pWZA==
X-Gm-Gg: AYBFou2C+2TuQPE9ok5QqWZTd08m76A2YlhLHDK7bLQmUaKPPj9o7g44oLZlv3YDSMU
	JAtZ4hqIUkFaH1mNMsyBYFJxdiJV+eMFaQVum/3xFNt3MBuYIDMUEbzQw+1KmyLotIuu7lz2vCN
	xhtPaG0v1y2tq0DyPFFyOmlaWgUkZHI9l50MwanYYRsrKxXaFbxA6ojkDR93qs9Cxnb0r401XRI
	R0RXphAQA6o4Qc0PnHx8zCw5/0g5y73ECnKnHN37nQp0Miu/71aZRXatEZoPDhdYziOvsyf3tlQ
	2DckqiKf/iphejqiyzg23ZIcVBG1yMCqewaW8mhmCTz6Lln5ZB0yTzkPKMcTvegqFN4jC4EuY2U
	OayH87h68fOVT9hYBisqOEqJSWwYu2mOUTDzy49pdJ4s/6FUtxP5Fu0E9ojWVv6NKbSQZnBcdSj
	e8+zuGgIhmGZNcmsHGygA8F9gdX+TiwR4wb5vSDFrpVl0Kov/aM3ZUKAjQ4Ke/IHSjCrROR14HZ
	QQz72WIodJ7qzWUon4rmD5jpOoyKwOelBrql+xsPlqWCKVCyTTxZlOKS6f1sigIWbkjs7hLggCd
	E3atR9XpPjE6pILsTVrK0AGWiA05bFTZUbIBCIUrfOY=
X-Received: by 2002:a17:90b:4ac9:b0:3a0:cca0:4a8c with SMTP id 98e67ed59e1d1-3ad64b90b64mr632731a91.7.1792470802240;
        Mon, 19 Oct 2026 21:33:22 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5df5be7asm2163810a91.16.2026.10.19.21.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 21:33:21 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v3 bpf-next 0/6] bpf: Unwinding with unwind_goto and unwind_exit
Date: Tue, 20 Oct 2026 04:33:13 +0000
Message-ID: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
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
190 lines in patch 1 and 100 lines in each JIT.

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

v2: https://lore.kernel.org/bpf/20261019051846.3012089-1-alexei.starovoitov@gmail.com/
v1: https://lore.kernel.org/bpf/20261018010246.1643877-1-alexei.starovoitov@gmail.com/

Tested in qemu, x86-64 and arm64 with and without pointer authentication:
the selftests, C, C++ and rust progs built with [3], with and without
bpf_jit_harden=2, and on x86-64 with retbleed=stuff. test_progs was run
on x86-64. On arm64 the same objects were loaded and run by a small loader.
freplace was not run on arm64. v2 passed test_progs on arm64 in CI.

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

 arch/arm64/net/bpf_jit.h                      |    2 +
 arch/arm64/net/bpf_jit_comp.c                 |   93 ++
 arch/x86/net/bpf_jit_comp.c                   |  100 +-
 include/linux/bpf.h                           |    1 +
 include/linux/bpf_verifier.h                  |    3 +
 include/linux/filter.h                        |   20 +
 include/uapi/linux/bpf.h                      |   11 +
 kernel/bpf/const_fold.c                       |    2 +-
 kernel/bpf/core.c                             |    6 +
 kernel/bpf/disasm.c                           |    7 +-
 kernel/bpf/fixups.c                           |    7 +
 kernel/bpf/states.c                           |    3 +
 kernel/bpf/syscall.c                          |    6 +
 kernel/bpf/verifier.c                         |  115 +-
 tools/include/uapi/linux/bpf.h                |   11 +
 tools/testing/selftests/bpf/Makefile.skel     |   11 +
 .../selftests/bpf/prog_tests/unwind_attach.c  |  111 ++
 .../selftests/bpf/prog_tests/unwind_cxx.c     |   98 ++
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/unwind_attach.c       |   43 +
 .../selftests/bpf/progs/unwind_cxx.cpp        |  150 +++
 .../selftests/bpf/progs/verifier_unwind.c     | 1182 +++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |    3 +-
 23 files changed, 1981 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_cxx.cpp
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unwind.c


base-commit: f25f6319e248034f3df83352e450ab3172eece43
-- 
2.55.0

