Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220133;
	b=11f6fIy1bXvrXG+bnvJ+4YdTC4Ixz04sRiasCBSf5tAbsUq21WSE1qi4uX3bthNnIsUb
	 4L1ZrDQ7jAuLIR8C/nGXs9B3BZKA5/r9VZIerjs7neARZlhz3QoG94rh+N+0i79eQRlDt
	 yCXZFOooCXT2L5oJtcWpe7HOqQo9cg+tzmqGvU+Jj6xkbhCnCuT3ppsybmJNZq0ykRpDH
	 BPnJdJ036Hf8NUJIE0NoAoeSzsMNqoS893V/m2V9Ueu7pJSOOfpszy89CUsC7V9ZX7nu0
	 ZneJVFnVZmJa/dWUhMPSjQHNnqJOLwXSqMFH7GnTbzv3DuxLRbHcfX/zwgGVRmNkWLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220133;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9+L3F6PvJYpWz7z90k/2mwyiOdExYFj/IBI6IUm2p+Q=;
	b=Q67kB4x4v56OheqAaPzN/ZpCiMh9lKQ7SQqVd3PfgkqhPnk6V8CXHJabg6BVRlwhyGCp
	 wOOk9omqoSQbEK2yHY6ujy0fBa4hcgsJFzE3mipIXef4JSOilq6rlwCG4i4cWe2n2nZbM
	 4k4m5IqYQRd5kXpJUE/6eenfvGypD/ndNecWVHLY9pTsGc9rhdwiwdOtDvHyndx5GnCCS
	 4gKTlI+cbQbutk/LCT5V2rj1nFX2nUoyb1lLNdro+ejtwUZbMjFJE9DARxAEM/6m7kpHS
	 WueEPiiJ3mCIaMgc055RHnVvpzmvBadufehVgqTiAzHOI/9qsOFyudzxUm4U12/pgMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.196
Received: from mta0.migadu.com (out-196.mta0.migadu.com [91.218.175.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A6606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 20:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 515A6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wbDp2i491BJUVcDRh2mIF/bP03SRaMIW/mz/8Ve9bXs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793220129; v=1; x=1793824929;
 b=Dt8eFk+RkKO8DpQWYwD56KFCnWDTed5mOl5TDmF6P9zphr50foCDbM9r0wzsds1xxKYMl7D3
 s8tjxXV8Ovzxj49RCiXDqnI54VkIsi0HxZVvMya9z7fntgKB2ENDw6f/CNz+alLsUKMOgi4eJKt
 Xd6dbzn9YK5taGs72zN9xhD8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 11b38d0d6da9c9e4;
	Wed, 28 Oct 2026 20:42:09 +0000
X-Mizu-Trace-ID: 11b38d0d6da9c9e4
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jose.marchesi@oracle.com,
	david.faust@oss.qualcomm.com,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v2 0/8] selftests/bpf: cleanup bpf-gcc runs
Date: Wed, 28 Oct 2026 13:41:50 -0700
Message-ID: <20261028204158.1021284-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series came out of testing a still in-works __arena support for
BPF_GCC and anomalies seen in the A/B reports.

BPF_GCC selftest builds reports a number of things that are not true.
 - Tests the compiler cannot build do not appear at all, so the
   report is silent about them
 - Others are compiled down to an empty body and report OK despite
   not even been executed
 - Two programs that fail to verify take four unrelated tests down with
   them, because everything in that object is loaded together.
 - Unconditional gating on __clang__ when newer GCC support for those
   is coming online.

Only 7/8 needs the in-works arena support to be exercised at all; the
rest are measured below with a stock bpf-gcc.  Nothing in the series
changes what clang emits.

What each patch does, and what it measurably changes.  Numbers are
test_progs on bpf-next with a stock bpf-gcc:

 1/8: Gate the callx tests on CAN_USE_CALLX, which also accepts a GCC
      defining __BPF_FEATURE_CALLX.
   -> 76 subtests newly visible, 75 OK and one @unpriv SKIP; the two
      dummies retire; callx_rodata_lskel SKIP -> OK.

 2/8: Keep clang-only warning flags out of GCC builds.

 3/8: Add __skip_without_arena, and give each arena guard an #else
      dummy carrying it.
   -> 7 subtests newly visible, all SKIP; arena_kfunc_jit OK -> SKIP.

 4/8: Make arena_base() opaque to GCC's -Warray-bounds, behind
      #ifdef __clang__ since clang does not warn.
   -> no verdict change.  +35 insns over 20 call sites under GCC;
      clang output unchanged, bit for bit.

 5/8: Tag the tests whose body dereferences an arena pointer, and only
      those; drop the in-body guards.
   -> 13 subtests OK -> SKIP, check_arena_arg_ret FAIL -> SKIP, and
      verifier_arena itself FAIL -> OK.  The rest now actually run.

 6/8: Cast explicitly with bpf_addr_space_cast() in the arena subprog
      and callback faults, as the sibling tests already do.
   -> 15 FAIL -> OK, and 5 subtests newly visible.

 7/8: Write the mixed arena/scalar ALU tests in asm, rather than a
      volatile register variable GCC may optimise away.
   -> not exercised by a stock bpf-gcc.

 8/8: trigger() in the four struct_ops arena progs is guarded in-body
      and test_loader does not drive them, so the tag cannot reach
      them; use the flag-in-.data pattern from linked_externs.c.
   -> 2 tests stop reporting a vacuous OK.  The other two need a
      testmod BTF carrying the arena tag, so are unreached here.

Totals for the series.  Nothing regresses:

  FAIL  473 -> 456        OK -> FAIL regressions:  0
  OK   7027 -> 7104
  SKIP  761 ->  787

Two things worth re-iterating explicitly:

 - 1/8 needs a GCC defining __BPF_FEATURE_CALLX, in bleeding-edge
   but not released yet.

 - 7/8, needs a GCC with arena support; that work is coming along
   but not yet ready for public review.

v1 -> v2:

 - 1/8: the __skip() reason named only x86/arm64 while CAN_USE_CALLX
   also accepts riscv64.  Say "arch JIT" instead of listing them, so
   the string cannot go stale the next time an arch is added.  (bot)
 - 3/8: jit_insns_arena.c was missed.  Both of its programs are inside
   the guard, so without arena support the object has none at all and
   RUN_TESTS(jit_insns_arena) ran zero subtests without saying so.
   (bot)
 - 5/8: commit message only.  It cited arena_types to argue the kfunc
   tests need no cast, but the address parameters carry the __ign
   suffix, so get_kfunc_arg_type() returns ARG_IGNORE and
   check_func_arg() returns before any register type check.
   Conclusion unchanged, for a better reason.  (bot)
 - 5/8: arena_kfunc.c, verifier_arena_globals1.c and
   verifier_arena_globals2.c had the same empty-body shape and were
   missed; nine more guards go and seven more tags arrive.
   arena_kfunc.c alone had eight subtests reporting a vacuous OK.
 - 8/8: new patch, for the four struct_ops arena progs.

The three bot findings prompted a sweep of every prog with an arena
guard, which is where the last two came from.  The totals above were
re-measured on the series as posted.

Link: https://lore.kernel.org/bpf/20261028000411.4010967-1-vineet.gupta@linux.dev/

Vineet Gupta (8):
  selftests/bpf: Build callx tests with GCC that defines
    __BPF_FEATURE_CALLX
  selftests/bpf: don't pass clang-only warning flags to GCC
  selftests/bpf: report SKIP for arena tests a compiler cannot build
  selftests/bpf: make arena_base() opaque to GCC's -Warray-bounds
  selftests/bpf: don't report arena tests as passing with an empty body
  selftests/bpf: cast explicitly in the arena subprog and callback
    faults
  selftests/bpf: write the mixed arena/scalar ALU tests in asm
  selftests/bpf: skip the struct_ops arena tests without compiler
    support

 tools/testing/selftests/bpf/Makefile          |   8 +-
 .../testing/selftests/bpf/Makefile.buildvars  |   6 +-
 .../bpf/libarena/include/bpf_arena_common.h   |  16 +++
 .../bpf/prog_tests/callx_rodata_lskel.c       |   2 +-
 .../bpf/prog_tests/test_struct_ops_arena.c    |  27 ++++
 .../testing/selftests/bpf/progs/arena_kfunc.c |  18 +--
 .../selftests/bpf/progs/arena_kfunc_jit.c     |   9 ++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  21 +++
 .../selftests/bpf/progs/callx_rodata.c        |   4 +-
 .../bpf/progs/compute_live_registers.c        |  10 ++
 .../selftests/bpf/progs/jit_insns_arena.c     |  10 ++
 tools/testing/selftests/bpf/progs/stream.c    |   7 +-
 .../selftests/bpf/progs/struct_ops_arena.c    |  10 ++
 .../bpf/progs/struct_ops_arena_autobind.c     |  10 ++
 .../bpf/progs/struct_ops_arena_member.c       |  10 ++
 .../progs/struct_ops_arena_member_render.c    |  10 ++
 .../selftests/bpf/progs/verifier_arena.c      | 125 +++++++++---------
 .../bpf/progs/verifier_arena_globals1.c       |   6 +-
 .../bpf/progs/verifier_arena_globals2.c       |   3 +-
 .../bpf/progs/verifier_arena_large.c          |  24 ++--
 .../selftests/bpf/progs/verifier_callx.c      |   5 +-
 .../bpf/progs/verifier_callx_rodata.c         |   5 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |   9 ++
 .../selftests/bpf/progs/verifier_zext.c       |   9 ++
 24 files changed, 247 insertions(+), 117 deletions(-)

-- 
2.53.0-Meta

