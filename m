Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145870;
	b=db4xWxEh4asok9XMdEH7ZuJONkXPMW+xLQSuItkA3navSVjqBxFkgFMPW4CSzkONVVL2
	 DMa8wAeoZDUkDFKwjd3QKIZ6ycFGLgCVlenvuNEbhNf3HS/3HuFBZOhb4Qcqzi9mk8WHM
	 iAKTYBVecKFO3X2RxN5xlh71JdeakGEkEA7IemnkCM4U9s3SEOGXxLgwt8Dfh7Kg2GqoI
	 LEmbc0zA+FOTh9osA0nmzt2VJq0KooCl9WQHzdW3YzTYId27hsnvSZ57hCKZIs/2CDGtU
	 AHdYvNOr9Z3ByFDdoWbOcD+gCggkrE1w+6X9FEShDd7xs01kDamRIWyaFNSZTWFDSPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145870;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=d7xxkmrhVlvt5/TRl88Hkz9V8i0VIv+XKRzCGOfjkEU=;
	b=fMR5UZmE7cNFfiBt6pMUcXMU3T5XQ1HjosNEoDja0oTEcQIq4wVpchnYGCUu/HOxQr2c
	 31k5HwonbN96Bk0kzY25APu4hTNYQDjFP72dMwDEVnf8mSvURRZIK6qCLBs3b0a3KjYZ/
	 YKQEhYNtV5d99Zts61oShGHGGVrULrQiyIVdD8k8O/UCzcjwJBeo3e4UfHI1tVu8jZDfb
	 bWnMMw2j7IC5brKz9nZL3baV+5K/Ui3+A+I3fqwM48/GXRkNaQAkHyS42i9854MqwqKn4
	 TuHdgL6Ng1xQJR4JIb82z3RzR3Wd+x7wyrXu7EGwtS1cZMOq4jU4H/ct6Y7uHlM7i3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pOKdUupy;
	arc=none smtp.remote-ip=91.218.175.224
Received: from mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F30606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60F30606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pOKdUupy
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+pomd5tsjWCxsXfslLB6Fa2ZM+55T6NDsvVY+vukgfs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793145866; v=1; x=1793750666;
 b=pOKdUupya+uss2HGmXEkPlbWOA9oOuNBpjGuxbRwrKWN+C3ga1LN2RGwHLsC5jQzSQFcQ0Zg
 vaOpiDcP0Gt9Tm9zWkF4IkDaNGWwwFyD6Owf4D2euNzaINz9+JBNQzZgWDtUg4zmJ8fP7iqvllV
 XgpwqC1GVzMSx78hLKsw02UY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 774be511d486f9d5;
	Wed, 28 Oct 2026 00:04:26 +0000
X-Mizu-Trace-ID: 774be511d486f9d5
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
Subject: [PATCH bpf-next v1 0/7] selftests/bpf: cleanup bpf-gcc runs
Date: Tue, 27 Oct 2026 17:04:04 -0700
Message-ID: <20261028000411.4010967-1-vineet.gupta@linux.dev>
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

Only 7/7 needs the in-works arena support to be exercised at all; the
rest are measured below with a stock bpf-gcc.  Nothing in the series
changes what clang emits.

What each patch does, and what it measurably changes. Numbers are
test_progs on bpf-next with a stock bpf-gcc, before and after:

 1/7: Gate the callx tests on a CAN_USE_CALLX macro that accepts a GCC
      defining __BPF_FEATURE_CALLX, in addition to clang.
   -> 76 subtests run that were absent from the report entirely,
      75 OK and one @unpriv SKIP, no failures. The two dummy
      placeholders retire; callx_rodata_lskel SKIP -> OK.

 2/7: Move clang-only warning flags out of GCC builds.

 3/7: Add a __skip_without_arena tag, and give each
      #if __BPF_FEATURE_ADDR_SPACE_CAST guard an #else with a dummy
      carrying it, so a compiler that cannot build those tests says
      so instead of staying silent.
   -> 6 subtests newly visible, all SKIP; arena_kfunc_jit OK -> SKIP,
      every subtest it has being one of them.

 4/7: Make arena_base() opaque to GCC's -Warray-bounds, which fires
      because the macro reads a member of struct bpf_arena through the
      much smaller map definition.  A build failure today for any GCC
      with arena support, and for everyone once 5/7 drops the guards
      that were hiding those calls.  Behind #ifdef __clang__, since
      clang does not warn and the barrier is not free.
   -> no verdict change.  +35 instructions over 20 call sites in five
      progs under GCC; clang output unchanged, bit for bit.

 5/7: Put __skip_without_arena on the tests whose body dereferences an
      arena pointer -- and only those; drop the in-body guards.
   -> 6 OK -> SKIP, check_arena_arg_ret FAIL -> SKIP, and
      verifier_arena itself FAIL -> OK.  The 11 that never dereference
      stay OK, having gone from an empty body to actually running.

 6/7: Cast explicitly with bpf_addr_space_cast() in the arena subprog
      and callback faults, instead of leaving it to the compiler, as
      the sibling tests in the same file already do.
   -> 15 FAIL -> OK, every test that loads that object rather than
      just the arena ones, and 5 subtests newly visible.

 7/7: Replace a volatile register variable GCC is entitled to optimise
      away with the asm the mixed arena/scalar ALU tests actually need.
   -> not exercised by a stock bpf-gcc, which compiles both out with
      the rest of the arena block.

Totals for the series.  Nothing regresses:

  FAIL  473 -> 457        OK -> FAIL regressions:  0
  OK   7027 -> 7115
  SKIP  761 ->  775

Those numbers were taken on a revision that suppressed the warning
per-file instead of carrying 4/7; the series as posted was re-run and
gave the same result, which is what 4/7 changing no verdict predicts.

Two things worth re-iterating explicitly:

 - 1/7 needs a GCC defining __BPF_FEATURE_CALLX, in bleeding-edge
   but not released yet.

 - 7/7, need a GCC with arena support; that work is coming along
   but not yet ready for public review.

Vineet Gupta (7):
  selftests/bpf: Build callx tests with GCC that defines
    __BPF_FEATURE_CALLX
  selftests/bpf: don't pass clang-only warning flags to GCC
  selftests/bpf: report SKIP for arena tests a compiler cannot build
  selftests/bpf: make arena_base() opaque to GCC's -Warray-bounds
  selftests/bpf: don't report arena tests as passing with an empty body
  selftests/bpf: cast explicitly in the arena subprog and callback
    faults
  selftests/bpf: write the mixed arena/scalar ALU tests in asm

 tools/testing/selftests/bpf/Makefile          |   8 +-
 .../testing/selftests/bpf/Makefile.buildvars  |   6 +-
 .../bpf/libarena/include/bpf_arena_common.h   |  16 +++
 .../bpf/prog_tests/callx_rodata_lskel.c       |   2 +-
 .../selftests/bpf/progs/arena_kfunc_jit.c     |   9 ++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  21 +++
 .../selftests/bpf/progs/callx_rodata.c        |   4 +-
 .../bpf/progs/compute_live_registers.c        |  10 ++
 tools/testing/selftests/bpf/progs/stream.c    |   7 +-
 .../selftests/bpf/progs/verifier_arena.c      | 125 +++++++++---------
 .../bpf/progs/verifier_arena_large.c          |  24 ++--
 .../selftests/bpf/progs/verifier_callx.c      |   5 +-
 .../bpf/progs/verifier_callx_rodata.c         |   5 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |   9 ++
 .../selftests/bpf/progs/verifier_zext.c       |   9 ++
 15 files changed, 163 insertions(+), 97 deletions(-)

-- 
2.53.0-Meta

