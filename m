Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22B2DB789
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792285371; cv=none; b=f3u5wI07s7I4Q2DCuG3QJz6dmBVJV41zPub/ySA0XQhuW+pyzCzCdBBVe1V4sRU0YiRsujkiI8AQ8UBdnbxshv9aEaQ0UwNhkoZxbYc4+J83cMu268UGzb2uESf2DUBcZU70SVxY0alBUNdd8jvHIxynvaixRzWOQWly6CLZeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792285371; c=relaxed/simple;
	bh=3uEa4ZFLcvbFe181GbJ9aegm/+A3nZlkaC5RGlN9A2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5OCLFDP/vkW88fHN3mrDjOHRwyyvxoY4XoWZePO+seQ6c9eKqGaUTwnwA+ODyTCj3Cm+HlXnO23gs3tC+oUznkKSUpxzAZP+y3Gc/XZYN0cF3utotVRIk2+8YByhQVgnPLExq1jq9MnUVyUshKulsQAwcvgfJ8pMr82PrThJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIpEVlg2; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIpEVlg2"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc147d86bebso667204a12.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792285368; x=1792890168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Vp05muOT4Nx0fg/ey18lPqt3vV3rvfbsrOvPrZxnEE=;
        b=sIpEVlg22zyXZbYFknOtv65brqVaW2UgVZKwU6wUifQayJKN9ulhwVs7ExwsIodEjc
         Tgm6eE88y+t2DXdDNybqzG1q9tGu6rcpvaXbYCwvkP7Cdi/SDSM+RPIu0lliyfJD88Dx
         YLxBjaQJaZJtQWF07wi63FWyVHg9CF9blTezVJFmK53/mypth6mdPwIcj/mdKWBBaNBz
         FcQs/6tmyEaUDzjLksnVlx0LnEBpzCcS8u3XeAEingb6ism5B1SKuPWZKnTecD9lkfEq
         43OrPVAs7XctS44UHXq23kizoZ5blxji0WynaLKX5qoV+JK9gw6s6KLRm8q4m+voWmZk
         Bi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792285368; x=1792890168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Vp05muOT4Nx0fg/ey18lPqt3vV3rvfbsrOvPrZxnEE=;
        b=oV4BkupQvnkI5toaSlPWJ4uZq/UgPao3a5p77cWvep11lsQmNg8yzpgc/LRjzVLekQ
         +4gjalqzZEj4LcU+/KHCW+gt5eYgJ3VaA2aumLlHU5coH85vQ+zzPf+9egzS2faBBe+B
         bR7GZsnTTpcwvAnj3F2CUgc/aCcFl7nqF/0f9F2qUxIJ03xsKvqPuMuorbbU63qq6UTl
         NwtgC0/XrrCqwyN38TqXfpKoqItP8q9OgrsYtt9HcvVFbWu0qVrmWfZOM+wFXXfCs061
         k9FtmT8GyIjNW1Px1YO7NKXOtRvXbLVPtTDA8gbW0BEq8ZiIv7YT2+dJFkMJZxTqKfoR
         lrtg==
X-Gm-Message-State: AFq9FYJAqQPr7BiBCSR4iSmRJDtKw2668jF0NJE0gwd409lCaB6r1ZWB
	b1dHGo/WoyK9oYQgXtu9wdDbsg8bAGYkKsmE4F/8Gyb3bCugGdmQpHkw36SSzA==
X-Gm-Gg: AYBFou3MXYGfr5l1E6jDhkSG1Yp2BCNKFuEo6ZsHmP+4XaB2l9y9jatbZqi3epAFbsh
	ohikFgL2BGn6aVZkgiNdBf4xio0RI9unZEkJ0qvvrjE7LPbxPpB+X5lRTiUlJ7sScbYkBAg+65J
	k1p2Tohx8m6Z7PR3BJ3n2REHrb4/5V8GqZOSIbMWC1CJe10Zwp6Kx1gi1t1nYmC11XYaYSzHy2k
	peWlPh5jNZQIp+Us1jiekksBY0C8d9ViLe19Lx+pnuY/XQ2kCZhkbSSt7W3RGwSvp52cnhj2vqY
	Rm+yaWwk4qGvNDg+K5k7mSbI1++4W3poNmJg96JAMcjFBQxf6Phhg9gIVAijFLoPgx3fJYKoa7V
	6KQFBYaAdRlFIqDefyYb3ma3G3SqvmB8QBvbJJfNNUlNilrWyLBDwoGGL3rktvfVJkQeobizmxD
	G90gdg+wgG7FVKdfXzNIX/8Qk9Q0jHGZD3nVl56NZvOTLjCohadvLJWs089w6VEVOXqI6/8qFyi
	f3HH9EeYEfvXPvzToPSuSVWjDdc8cv3N7XXbzeWNojYoy7oi4BACIqLLNjxuo1q+prvHC4JrBgW
	O57bon066StOI8rBWrn3i6tseJxef+XI1CrbCw1O7x3gKgL9+Ihn+w==
X-Received: by 2002:a05:6a20:2591:b0:3e2:335b:1a62 with SMTP id adf61e73a8af0-3e2335b24b8mr1311607637.49.1792285368226;
        Sat, 17 Oct 2026 18:02:48 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549fb561sm2645087a12.23.2026.10.17.18.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 18:02:47 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/5] bpf: Unwinding via r3
Date: Sun, 18 Oct 2026 01:02:40 +0000
Message-ID: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@anthropic.com>

This is the r3 alternative from the discussion of v12 of Yonghong's series
[1] as patches, with x86-64 and arm64 JITs and selftests.

1. What is the problem?

A rust panic or a C++ exception has to run Drop impls or destructors of
every frame it passes through. bpf_throw() discards the frames, so the
verifier doesn't let a frame that owns a lock or a reference throw. In rust
every index and every unwrap() can panic.

2. Is it worth solving?

Without it rust-bpf [2] drops all landing pads and a panic is bpf_throw().
A prog that can panic with a guard held doesn't load.

3. Is there a simpler way?

[1] keeps the normal path free of unwind code. llvm emits a table, libbpf
passes it to the kernel, bpf_unwind() walks the stack and rewrites return
addresses, and the verifier models hidden edges from calls to pads. That's
1400 lines in the kernel, with new uapi and two kfuncs, and 440 lines in
libbpf.

Here llvm emits plain insns [3]:

  ret                            r3 = 0; exit
  invoke foo unwind pad          call foo; if r3 != 0 goto pad
  resume                         r0 = 0; r3 = 1; exit

Pads are ordinary code, so the verifier part is 96 lines in patch 1.
The price is a branch after a call that may unwind. Patches 2 and 3 take it
off the normal path in the JITs without telling the verifier. 360 lines
with them.

4. Will the api and the layers last?

No uapi, no kfuncs, no changes in libbpf and other loaders.
r3 and BTF decl_tag "unwind" become an ABI between llvm and the kernel.
The source level entry point is _Unwind_RaiseException() of the Itanium
ABI. It's what the runtimes of rust and C++ call on other architectures.

5. Is it good taste?

Every frame returns through its own epilogue. The only question is where it
returns to. That's one bit.

It's not specific to rust. A C++ prog with throw, catch and destructors
compiles, loads and runs. It's a selftest in patch 5.

Since the sketches in [1]:
- bpf_unwind() is gone. _Unwind_RaiseException() starts an unwind.
- llvm applies the convention to functions with uwtable only, so C progs
  are not affected.
- JITs opt in. A JIT that loses r3 would skip a pad.
- A subprog with the tag has to exit with a scalar in r3.
- A callback that doesn't set r3 was hitting verifier_bug().
- The extable lookup is search_bpf_extables().
- 'Functions end with exit' was not quite right. A function can still end
  with a call of a noreturn function that cannot unwind, like bpf_throw().
  rust-bpf adds 'exit' after it.

Tested in qemu only, x86-64 and arm64 with and without pointer
authentication: the selftests, C, C++ and rust progs built with [3],
with and without bpf_jit_harden=2. test_progs was run on x86-64. On arm64
the same objects were loaded and run by a small loader, and __jited
patterns were matched against the JIT output by a script.

[1] https://lore.kernel.org/bpf/20261017025129.1914859-1-yonghong.song@linux.dev/
[2] https://github.com/4ast/rust-bpf
[3] https://github.com/llvm/llvm-project/pull/233140

Alexei Starovoitov (5):
  bpf: Support unwinding via r3
  bpf, x86: Replace 'if r3 != 0 goto pad' after a call with an extable
    entry
  bpf, arm64: Support unwinding via r3
  selftests/bpf: Add tests for unwinding via r3
  selftests/bpf: Add a C++ prog with exceptions

 arch/arm64/net/bpf_jit.h                      |   2 +
 arch/arm64/net/bpf_jit_comp.c                 | 110 +++
 arch/x86/net/bpf_jit_comp.c                   | 107 ++-
 include/linux/bpf.h                           |   1 +
 include/linux/bpf_verifier.h                  |   5 +-
 include/linux/filter.h                        |  11 +
 kernel/bpf/backtrack.c                        |  10 +-
 kernel/bpf/core.c                             |  53 ++
 kernel/bpf/fixups.c                           |   1 +
 kernel/bpf/liveness.c                         |   7 +-
 kernel/bpf/verifier.c                         |  66 +-
 tools/testing/selftests/bpf/Makefile.skel     |  11 +
 .../selftests/bpf/prog_tests/unwind_attach.c  |  67 ++
 .../selftests/bpf/prog_tests/unwind_cxx.c     |  76 ++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/unwind_attach.c       |  32 +
 .../selftests/bpf/progs/unwind_cxx.cpp        | 117 +++
 .../selftests/bpf/progs/verifier_unwind.c     | 759 ++++++++++++++++++
 18 files changed, 1427 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_cxx.cpp
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unwind.c


base-commit: c058636f788f8751e419b407206516280226e568
-- 
2.55.0

