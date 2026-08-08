Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DFB223DE7
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149584; cv=none; b=gdWRZqccdMsmuH3lKt7oZfZ5lmkJKDKy4Q7+t3XBTvFyW3vlKFtIEiqLDDpmJnAIRGU3vdg5eJDA5YIuxAOjyOSi9MSHUWr7kf9oQWClMvfH4DQHU7aEwblekKhgfEMpR7AYIAjSCSH8ZD4J2DylMLNLrAAFYK6cFzvgn/T0qt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149584; c=relaxed/simple;
	bh=53bqa2q6JGpwPo7T1yMvAQy2o0uYQYfS/HaRXzJ+rWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qBuRE2VYvswi6Nfxqw9cx6oTWwshKewAG9ewpxWZKCdRiPNZiYbhJNtKCu2bL2C+q5yp53mQ4LRm49YBEm4j/5DE+P7GXg65NgJsNAP6Rm14kNoN1XziE9bzJxpcgqWL1Ki/oARAOJE+3cjbtmGgaMi8ZfcuQOvGVm/BCq0TSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez7ROqCS; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez7ROqCS"
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-456f7012050so2088141fac.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149582; x=1786754382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fo4D08QrOnJ4yVtRlJsB8WdrPLGoHVWKF6ZalGmzyjU=;
        b=Ez7ROqCSfKsgGRZZSNgPZ37Vw/M/LbI683IQ2g2W+7ekilv6JceUMGC33f2okJSbH2
         vlMEY5AA7QiL+jBueK2r7NUwtDUy9sg9nzyLBywEhofRoGp+JJ+7jybhHq/cpypmjeYC
         0OxoeeQyvzhKpJLf1AC4GnqQNMhE2190xvjMeXJwW9DFaJQRzlf6Uwp7Nkm+LrnA+7/S
         zLKwGRs1fR9Yo5aU2mo9zgawwLqF3mnBDjaGPtKOCMnV8BMAbVLPg0EJ77imPYKW3kjL
         8uBspTkSYoFLggWi+me1sYuWO7N1+FgOiLAbkqHZJqN4uZQI1bVsP06nkMmH8mo/egVX
         fCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149582; x=1786754382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fo4D08QrOnJ4yVtRlJsB8WdrPLGoHVWKF6ZalGmzyjU=;
        b=fQZVRNMgyZ34Dp57ld1lTZWvhDZYGSFwws/1qBKN7kMhUMeR044uEA8G2Dx9PuLxN5
         UD597nTaofFhqcVF6nkmkSZpzudElrOLcbeUmQ5xKNrDboxQVBZYwcJsIjZJLhdrPhEn
         c3sD+kd8p3Cc3Fp6lYNg6qorhXqqPW8WeAPUAv3zPPWwP7xpYE8aLpvwIOyJyYd9+NJ6
         CPwQdXFz4tsqCa/Mb0b8nfFbanDvWEO+VaSKIOJCseYQ5HftnZTpnsRAmzAh+s9A/pNj
         a5xuPZViOfLGUkSVpnxjMbG9DtwUNaSSthFV5Ot238S9kb4JAVWsT7xHHX3pjRcf+TTf
         YOFQ==
X-Gm-Message-State: AOJu0YwVWE0a5CuPcfZmuoF6C9xYENidsVT6kwmlg41XZjW2YZkBxgXu
	FtI6oGAo1egyy1lAX57pfyQo8cT6ExYxfq80kL8C6kRQ3XYDYo9E0Mg7bXxAxTI1t10=
X-Gm-Gg: AR+sD12TISNiQwPiYY6rdmUHNGTfPxtohP56bNQs5wUxbDkCZ1WxEbmcQv4L8oHzKP2
	SKrEwhabJYE6rTpA9xln50gghO37wiY+0yyDgasWQtxOrw5oYLqfaXNr5giq8oDZb/lBjNU0sKo
	LYknKoZpsQh0mlgGwKwmHUxxs0Hn5YzNbjutaqEvaIFAxgXEP2tbjoZ/rMjSNmbIA5fZmX+eKaW
	TjAAK79F7FEVCpD9UVxm+qPgts/QNSr6GHAC9/GyV/peMKDB2x9IivnOrZ4EEr0ujUlcd/1iPQA
	gEt8ildZF/HL1F62LMTNiCe8kJadz9TrYJoUhmwjBeIRlAGJY4eCTWiAvGKvDOnFODokURc7qFx
	SMVLbVUroUWfqQAZxwS43emJokt9byCZ2QTdri1ul8D48TpQUi/pmL0G+lhNBlBgPIz2iAQGpVG
	lR4a/MeRhDRiVPiGIjg4NnBYAV7FODS9jlVun6lf1uluMtBus0cZiTApi9XV0lTdBMDJomstvCn
	ovkr9tacyzi0ckoxi3RuX1X/wXv0ZoUr6EqIzIKinTqSXuMGqAGMynQSri9AsqEOdqBUqg=
X-Received: by 2002:a05:6808:4f68:b0:495:ca1b:7865 with SMTP id 5614622812f47-4b1af83fb11mr1422529b6e.11.1786149581633;
        Fri, 07 Aug 2026 17:39:41 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af6856f9sm834827b6e.18.2026.08.07.17.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:39:39 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 00/14] Add arena argument support to kfuncs and struct_ops
Date: Sat,  8 Aug 2026 02:39:20 +0200
Message-ID: <20260808003938.3486067-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5641; h=from:subject; bh=53bqa2q6JGpwPo7T1yMvAQy2o0uYQYfS/HaRXzJ+rWM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqsK2cWb4zZrkO8IqzwuTTJXi+j5s9J8kmndWa5ZnawBf 2cyOUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATEQ/kpFhfirXZqZzewPr9es/i7smze M2jOZ6oJ4rv8CkcONO9XJtoAqhjDyNqb4fO+d8nKJUtdbjepaylcFz94eT39ZK5h7ewgYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

This is a continuation of patches in [0], with mostly minor changes and
reordering. The motivation is covered in that link. A major change is
moving to two tags (__arena and __arena__nullable) and moving the changes
to JIT to emit more optimized sequences.

Please see commit logs for details.

  [0]: https://lore.kernel.org/bpf/20260713024414.3759854-1-tj@kernel.org

Changelog:
----------
v4 -> v5
v4: https://lore.kernel.org/bpf/20260805210427.3218326-1-memxor@gmail.com

 * Remove the redundant patch-8 capability comment and duplicate
   nullable kfunc test coverage. (Eduard)
 * Introduce the final bpf_tramp_arena_base() interface directly with
   function-model argument flags, avoiding temporary slot bitmaps and
   arena_nullable state; simplify struct_ops pointer validation. (Eduard)
 * Simplify kfunc arena nullability classification by using the common
   nullable path for both arena suffixes while leaving the function model
   to distinguish JIT NULL preservation. (Amery)
 * Keep bpf_prog_has_arena_ctx_arg() in bpf_verifier.h from its
   introduction so trampoline and verifier users share one inline
   definition, avoiding BPF_JIT/BPF_SYSCALL link dependencies.
   (Eduard, BPF CI Bot)
 * Reject both tracing and extension attachments to struct_ops programs
   with arena context arguments, and add fentry, fexit, and freplace
   rejection tests. (Eduard, Sashiko)

v3 -> v4
v3: https://lore.kernel.org/bpf/20260803125115.2264733-1-memxor@gmail.com

 * Rename __arena_nullable to __arena__nullable and prioritize the
   composite suffix over __nullable during argument classification.
   (Sashiko, Eduard)
 * Resolve instructions before collecting subprograms and kfuncs so kfunc
   prototype validation can use associated arena state.
 * Move the arena kfunc and JIT-sequence test entry points into
   prog_tests/verifier.c. (Eduard)
 * Match the generated L0 target and call in nullable JIT assertions.
   (Eduard)
 * Route arena kfunc validation through the common argument-checking path.
   (Amery)
 * Reuse btf_func_model argument flags for struct_ops arena arguments
   instead of maintaining separate trampoline slot metadata. (Eduard)
 * Check the generic-trampoline arena argument invariant at link time and
   warn once on violations. (Eduard)
 * Reject tracing attachments to struct_ops programs with arena context
   arguments whose indirect trampolines convert the pointers. (Sashiko)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260726013105.3689867-1-memxor@gmail.com

 * Rebase onto current bpf-next to resolve conflicts.

v1 -> v2
v1: https://lore.kernel.org/bpf/20260715220052.1590783-1-memxor@gmail.com

 * Fix documentation to only mention x86 for now. (Sashiko)
 * Move arg bitmap from insn_aux_data to kfunc descriptor. (Eduard)

Kumar Kartikeya Dwivedi (5):
  bpf: Rename 'early' BTF checking as a preparation phase
  bpf: Split subprogram and kfunc collection
  bpf: Collect kfuncs after resolving program resources
  bpf: Reject tracing/freplace progs for struct_ops with arena args
  selftests/bpf: Test attach rejection for struct_ops arena programs

Tejun Heo (9):
  bpf: Support __arena and __arena__nullable kfunc argument suffixes
  bpf: Support __arena and __arena__nullable on struct_ops arguments
  bpf, x86: JIT __arena kfunc argument rebasing
  bpf, x86: Convert struct_ops arena arguments in the trampoline
  selftests/bpf: Add kfunc __arena and __arena__nullable argument tests
  selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments
  selftests/bpf: Add struct_ops __arena and __arena__nullable argument
    tests
  bpf, x86: Fix stack-passed arguments for indirect trampolines
  selftests/bpf: Test stack-passed struct_ops arena arguments

 Documentation/bpf/kfuncs.rst                  |  39 +++
 arch/x86/net/bpf_jit_comp.c                   | 122 ++++++++-
 include/linux/bpf.h                           |  15 ++
 include/linux/bpf_verifier.h                  |  14 +-
 include/linux/filter.h                        |   1 +
 kernel/bpf/bpf_struct_ops.c                   |  56 +++--
 kernel/bpf/btf.c                              |  28 ++-
 kernel/bpf/check_btf.c                        |  14 +-
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/trampoline.c                       |  37 +++
 kernel/bpf/verifier.c                         | 125 ++++++++--
 .../bpf/prog_tests/test_struct_ops_arena.c    | 128 ++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   6 +
 .../testing/selftests/bpf/progs/arena_kfunc.c | 234 ++++++++++++++++++
 .../selftests/bpf/progs/arena_kfunc_jit.c     |  98 ++++++++
 .../selftests/bpf/progs/struct_ops_arena.c    | 115 +++++++++
 .../bpf/progs/struct_ops_arena_attach.c       |  25 ++
 .../bpf/progs/struct_ops_arena_fail.c         |  20 ++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  82 ++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   6 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  12 +
 21 files changed, 1123 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c


base-commit: 51476f6a06ef55cecf785ae1622c638fa8cfb846
-- 
2.53.0-Meta

