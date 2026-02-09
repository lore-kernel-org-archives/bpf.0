Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D73137FF60
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652780; cv=none; b=hn+pI/B18eEtymqhK4+QXx8+U1zr4ziy6kL4txmfJvchP+ORf7jGbziU6EsH9++Y5hdn/OdmYYtnFobUb0CAGcF/SHUeKJPXsxmI46wxOfhnSvp0TtBDFr4U7MJ46+oCjOlICCYFpu8yOB/ThVoGrq5AEeVHA/9CTXvbW9+D00A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652780; c=relaxed/simple;
	bh=K6WNaD0QWtzVv/2S0kU1InILrac/s7pTLmMl/dBuuDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5frNydZE7/z9okMhRx/41LNrNysKHtiG2+1HZT6WjjO9ucLC/DmVByKaDo1vlnPGDqUVZSlsuITbhv7DRPoMY+lCEsjChzDKGweuSTpOEOYQ8122mM1EL365rflYam6IAnXwXdOls4z8qXSOVkcuMjEDey47vg9enPeuE3JaL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZltqXyv7; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZltqXyv7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770652776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fKF09HgFo19fC7Meo2q4ZqVctHzj0xpagvYwN81q4uA=;
	b=ZltqXyv7YuJOp7WQ4U/jRcpzn90AnoLnuOA6Opo2K+yLVYmTRoEAxgP8irqOZnE0a2OUWU
	hSmcG+Sri1spRFjFSmwcK0CkQ3EK070KkuahqSxK0/JdHFkzI3ZkVDA+otWOTvOXkYL1g4
	jea8z+xa/EyWOGA9wd8/MpqP/ouS5fE=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 0/4] bpf: Introduce 64bit bitops kfuncs
Date: Mon,  9 Feb 2026 23:59:11 +0800
Message-ID: <20260209155919.19015-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce the following 64-bit bitops kfuncs for x86_64 and arm64:

* bpf_clz64(): Count leading zeros.
* bpf_ctz64(): Count trailing zeros.
* bpf_ffs64(): Find first set bit, 1-based index, returns 0 when input is 0.
* bpf_fls64(): Find last set bit, 1-based index.
* bpf_bitrev64(): Reverse bits.
* bpf_popcnt64(): Population count.
* bpf_rol64(): Rotate left.
* bpf_ror64(): Rotate right.

Especially,

* bpf_clz64(0) = 64
* bpf_ctz64(0) = 64
* bpf_ffs64(0) = 0
* bpf_fls64(0) = 0

bpf_ffs64() was previously discussed in "bpf: Add generic kfunc bpf_ffs64()" [1].

Background

In the earlier bpf_ffs64() discussion, the main concern with exposing such
operations as generic kfuncs was ABI cost. A normal kfunc call follows the
BPF calling convention, which forces the compiler/JIT to treat R1-R5 as
call-clobbered, resulting in unnecessary spill/fill compared to a dedicated
instruction.

This RFC keeps the user-facing API as kfuncs, but avoids the ABI cost in the
fast path. The verifier rewrites supported bitops kfunc calls into a single
internal ALU64 encoding (BPF_BITOPS with an immediate selector), and JIT
backends emit native instructions directly. As a result, these kfuncs behave
like ISA operations once loaded, rather than real helper calls.

To make this contract explicit, the kfuncs are marked with a new
KF_MUST_INLINE flag: program load fails with -EOPNOTSUPP if the active JIT
backend cannot inline a particular operation. This keeps the cost predictable
and avoids silent slow fallbacks. A weak hook, bpf_jit_inlines_bitops(),
allows each JIT backend to advertise support on a per-operation basis
(and potentially based on CPU features).

Most operations are also tagged KF_FASTCALL to avoid clobbering unused
argument registers. bpf_rol64() and bpf_ror64() are the exception on x86_64,
where variable rotates require CL (BPF_REG_4).

Selftests output

On x86_64:

 #18/1    bitops/clz64:OK
 #18/2    bitops/ctz64:OK
 #18/3    bitops/ffs64:OK
 #18/4    bitops/fls64:OK
 #18/5    bitops/bitrev64:SKIP
 #18/6    bitops/popcnt64:OK
 #18/7    bitops/rol64:OK
 #18/8    bitops/ror64:OK
 #18      bitops:OK (SKIP: 1/8)
 Summary: 1/7 PASSED, 1 SKIPPED, 0 FAILED

On arm64:

 #18/1    bitops/clz64:OK
 #18/2    bitops/ctz64:OK
 #18/3    bitops/ffs64:OK
 #18/4    bitops/fls64:OK
 #18/5    bitops/bitrev64:OK
 #18/6    bitops/popcnt64:SKIP
 #18/7    bitops/rol64:OK
 #18/8    bitops/ror64:OK
 #18      bitops:OK (SKIP: 1/8)
 Summary: 1/7 PASSED, 1 SKIPPED, 0 FAILED

Open questions

1. Should these operations be exposed as a proper BPF ISA extension (new
   ALU64 ops) instead of a kfunc API plus verifier rewrite? This RFC takes
   the kfunc route to iterate without immediately committing to new uapi
   instruction semantics, while still ensuring instruction-like codegen.

2. For operations without a reasonable native implementation on some
   targets (e.g. bitrev64 on x86_64; popcnt64 on arm64 without touching
   SIMD registers), should we allow a true generic fallback by dropping
   KF_MUST_INLINE for those ops, or keep the "no-inline == reject" behavior
   for predictability?

Links:
[1] https://lore.kernel.org/bpf/20240131155607.51157-1-hffilwlqm@gmail.com/

Leon Hwang (4):
  bpf: Introduce 64bit bitops kfuncs
  bpf, x86: Add 64bit bitops kfuncs support for x86_64
  bpf, arm64: Add 64bit bitops kfuncs support
  selftests/bpf: Add tests for 64bit bitops kfuncs

 arch/arm64/net/bpf_jit_comp.c                 | 143 ++++++++++++++
 arch/x86/net/bpf_jit_comp.c                   | 153 ++++++++++++++
 include/linux/btf.h                           |   1 +
 include/linux/filter.h                        |  20 ++
 kernel/bpf/core.c                             |   6 +
 kernel/bpf/helpers.c                          |  50 +++++
 kernel/bpf/verifier.c                         |  65 ++++++
 .../testing/selftests/bpf/bpf_experimental.h  |   9 +
 .../testing/selftests/bpf/prog_tests/bitops.c | 186 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bitops.c    |  69 +++++++
 10 files changed, 702 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bitops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bitops.c

--
2.52.0

