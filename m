Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567E356748
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792387133; cv=none; b=bHM9XMxJCh1Qs1Y8UcuKLYziM0JjUBJ5x03ppQJmjkuVbxoSh2JTqsOd9PjLqTOEj27wLQTpn0FPX0UVD+mTLtEGfjF6NfHagkenbs0Je11VlGXwOJvnkFRsgSWQfXsVtgjyWX73w+y5nduiPjQ1R+sRxvj+L+0FFYbYF66EnD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792387133; c=relaxed/simple;
	bh=tnsn3aIwkiHHL/XJvjQ3qhRsV8194f7HA/ecnMRGn6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkQEPhkW6HEEybYdZqB6IkQSn+44FOwuUnCX3l1XBoXy63RdVjYE5hk37soWdeszU/GLKGNVza+H0QtZL3y5NbrcwNkTHmQhhTSXZfib+cCzLVC1vFYFp66PmKj4MaBgpgtUfE7J5MARuQYpynJkYEefMJxd/ta5lQ151T6AA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFnHJ2l2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFnHJ2l2"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso621870a12.2
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 22:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792387130; x=1792991930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ybCsopGMj5e5nRo1pXBaH0VN9+twDO40UVj2z9EZ6NA=;
        b=NFnHJ2l2t4WGYqFp/zJPHHKeDBxUxypqzxt9pwRmdMa1cpL31EDScDiBByL13bQjuC
         LQ/6LXrUGaR539Hv0wkoj3cp7Om0KYeRdO9SVfRmC6JlawRe8oXSpuG+k0ZLuWT/v4bq
         jfKXdbtCwZ5FeyHErkvZGqzGdduKBwMJUIwOIISAbAzGdf8wp3WTOhDFgVwoMQWcQYjS
         lb0YExMm856Q1nhFvOtGs7UMWUkJH/MHgKfAgJYi/NQTx09vJhnRRqK2DxzQwJSK6PcV
         WHaNknnw12w7i/HOBgQKrsbx2v2lmVpuJWXZu/KKqp1guPTk4yN+NqAy1fpgsSgXCirU
         aVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792387130; x=1792991930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ybCsopGMj5e5nRo1pXBaH0VN9+twDO40UVj2z9EZ6NA=;
        b=CE1qavw+RORD78Uf/mPE2TBGsoeOUq++1b1bgOnJfHXbkbwYN9T9tsdd824J94jo1m
         t6sMz9WzoGDlrv1xFGL8bkKnP45xtHad2njy19TrZQlkAazFg24wIimiWcITcUS6gMOj
         tQVd5JkiJH6AMySg5vFvUmaTodDB5zFdjoEkm6Zo9eKeHuBrmPiYKAT+uUADjQfh9PQj
         Q1AQuZjI+K+/Wq9tZaegbB8DJumbDND11hRlYLIqkQFz99A4QeM2dmQuEUXTXtwiMk0j
         aCGWFcvrAoy/Pl7m8GEQV/xNZV3p/CO9WyIqJeuwtfhqXtgod+0FVbI2KnoAw4Vg5lej
         BfGQ==
X-Gm-Message-State: AFq9FYJrwGdycXYuU+rt7AoGDVMuATyDPgvNdASZnQurQ48XCLBEd6MN
	loRZK7WRxxYS5AOTG6Z567uZFmc5EkLabMZMNrDFUgUpiPp6BQ9725/lnGeRiw==
X-Gm-Gg: AYBFou0tHQ4O+3ifa/ppEg2+bMVrPh4L8sdH7Im+TzmlpicdtmSisfKmJzoG6hU+eyI
	YPmusfnx2vDo40SkZs/wPMHFlRFmUPkqcqmQPnGTHbqeXitQVHkTYDInm84UYkkYQRvBhmMerSa
	oDKdn2DPsfEtNFkmCqkQz7BMVw/v7+cwZlqxOvpNY0roIQdALZju2fgZKNr0cL7k22y5CSxjaXL
	Lzw5HTU9HUnDbgl1UQyMrOKwoqu8Z18Yxs/hFXjT9oldenq6ElBuw8995uYRn+LhqZpRb2eZiUB
	qP1bfVC8bbJJ43YbpdaYQe6N0tXW4hmgD6czoFN+Kc2ZTDHRSn9h+cWZdilrDSb5imNR2qX03ym
	GCOQOTmx9utFBQnfJrEjQbVhVitUjzkrVXFw8cESJ5BnjmGihpfyGxFJjzNmuRn7wUmAkwFX7Gq
	Cr2dieso2P6Mt1nchrJp2yo6tHo42qmBfntWkj0P0COcdQPGZeH6S4QDBWhg8pmxX+VyP4wefMI
	mB052zwRyjni/sDcuzxlbPYNfHz1c7r30T3AOpHwQTTVLJc/HlBSHJWVWh0jx+NMgs4KPWAcwS4
	rafrino50TKzLyfkpGNwnther3orR61aL8hCGfZAv0wp99AD26CkcQ==
X-Received: by 2002:a17:90b:3889:b0:3ac:17c:6e85 with SMTP id 98e67ed59e1d1-3acef0ffa0fmr5619389a91.47.1792387130088;
        Sun, 18 Oct 2026 22:18:50 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9e47588sm8105232a91.1.2026.10.18.22.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 22:18:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf-next 0/5] bpf: Unwinding with unwind_goto and unwind_exit
Date: Mon, 19 Oct 2026 05:18:41 +0000
Message-ID: <20261019051846.3012089-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v1 [1] said in r3 how a subprog returns. v2 has two new insns instead,
as Kumar suggested.

1. What is the problem?

A rust panic or a C++ exception has to run Drop impls or destructors of
every frame it passes through. bpf_throw() discards the frames, so the
verifier doesn't let a frame that owns a lock or a reference throw. In rust
every index and every unwrap() can panic.

2. Is it worth solving?

Without it rust-bpf [2] drops all landing pads and a panic is bpf_throw().
A prog that can panic with a guard held doesn't load.

3. Is there a simpler way?

[3] keeps the normal path free of unwind code. llvm emits a table, libbpf
passes it to the kernel, bpf_unwind() walks the stack and rewrites return
addresses, and the verifier models hidden edges from calls to pads. That's
1400 lines in the kernel, with new uapi and two kfuncs, and 440 lines in
libbpf.

Here the edge from a call to its pad is an insn, and so is the other way
to leave a frame [4]:

  ret                            exit
  invoke foo unwind pad          call foo; unwind_goto pad
  resume                         r0 = 0; unwind_exit

Pads are ordinary code. The verifier learns one bit: how the callee left.
The normal path is free of unwind code too: JITs emit nothing for
unwind_goto, and exit is what it was.
170 lines in patch 1 and 80 lines in each JIT.

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
- Tail call, ld_abs and freplace are allowed.
- bpf_unwind_target() is in core.c. num_exentries is counted in
  jit_subprogs().
- selftests: no #ifdef by arch, which broke the build on the rest of them.
  The messages are checked. fentry and freplace are attached and the
  target is run. fmod_ret is gone, it didn't test anything new. Skips say
  why (bpf-ci).
- clang defines __BPF_FEATURE_UNWIND.

Tested in qemu only, x86-64 and arm64 with and without pointer
authentication: the selftests, C, C++ and rust progs built with [4],
with and without bpf_jit_harden=2. test_progs was run on x86-64. On arm64
the same objects were loaded and run by a small loader, and __jited
patterns were matched against the JIT output by a script.

[1] https://lore.kernel.org/bpf/20261018010246.1643877-1-alexei.starovoitov@gmail.com/
[2] https://github.com/4ast/rust-bpf
[3] https://lore.kernel.org/bpf/20261017025129.1914859-1-yonghong.song@linux.dev/
[4] https://github.com/llvm/llvm-project/pull/233140

Alexei Starovoitov (5):
  bpf: Add unwind_goto and unwind_exit insns
  bpf, x86: Support unwind_goto and unwind_exit
  bpf, arm64: Support unwind_goto and unwind_exit
  selftests/bpf: Add tests for unwind_goto and unwind_exit
  selftests/bpf: Add a C++ prog with exceptions

 arch/arm64/net/bpf_jit.h                      |    2 +
 arch/arm64/net/bpf_jit_comp.c                 |   78 ++
 arch/x86/net/bpf_jit_comp.c                   |   83 +-
 include/linux/bpf.h                           |    1 +
 include/linux/bpf_verifier.h                  |    3 +
 include/linux/filter.h                        |   12 +
 include/uapi/linux/bpf.h                      |   11 +
 kernel/bpf/const_fold.c                       |    2 +-
 kernel/bpf/core.c                             |   24 +
 kernel/bpf/disasm.c                           |    7 +-
 kernel/bpf/fixups.c                           |    7 +
 kernel/bpf/states.c                           |    3 +
 kernel/bpf/verifier.c                         |   93 +-
 tools/include/uapi/linux/bpf.h                |   11 +
 tools/testing/selftests/bpf/Makefile.skel     |   11 +
 .../selftests/bpf/prog_tests/unwind_attach.c  |  102 ++
 .../selftests/bpf/prog_tests/unwind_cxx.c     |   76 ++
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/unwind_attach.c       |   29 +
 .../selftests/bpf/progs/unwind_cxx.cpp        |  115 ++
 .../selftests/bpf/progs/verifier_unwind.c     | 1047 +++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |    3 +-
 22 files changed, 1716 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_cxx.cpp
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unwind.c


base-commit: 27dc4fc4ae7b01efb68561f98c5f373e55fb71c2
-- 
2.55.0

