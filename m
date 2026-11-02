Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657254;
	b=unEBpKyVvmX1XsCIN3f71ajNi88wY1WhkUuKnUsGnyAxG7/5KVSvnbe9QioQILM5tBHK
	 1ZnElz6mr8ux20LS1xp8U7PlR/QSHgQf8QIx++9Sfovo7393ZDngDnvtDiJgK5EDoCR3k
	 +AxiRwPQcyxvRTkJT6ar440u0ect6A2QO+ThjEE3QYCc8pgfXjdWXUiJoXASpi7U2stl+
	 y58J0Qkchm0myR10Q8TsivHIh9N/bGL7eHcom8Y6LMfOHatvVi9TDIvJllfLfJ8iv/C2J
	 uEm3Gr/2y1ptmBhGCwEn6zueiBnixVLamUG5MkIBfimDF0fj70Q0CvVY3+9YvDX6WjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657254;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SK35Qq0pP7U3ITxQEzMwjyV70Jp5lJ0aak8ieWZ3W1M=;
	b=fqy2rWw/ZgRXJQh6HRtEKSSMlrYsmDt+vxeUjUCzEGqkHx5fsSXzn3/yMZ9Myf+eSUL+
	 WSLJ1iVhFMx9gKn6yCwTLApxpxc2LlciWlcoiFeK2couGPEjlBEsaLdCkCcrFHzKQb2Nr
	 Jw/5BXyc+NKSwvo12bzQJSWM3tP13Bs7qYMMl5JZj/NsqJ7yCz8q+QbBnk+k1Zsdhx7x9
	 RzuUibExWV9sc+A4p3VORu/wnXZ5GmyBkKolTvmt9qrE26OJ8o7z363ppeiXKXJEfrOQD
	 Qnq8k8XLO22a9RUQsjLiQOdwAxcVxAqjuw9PWxY6skjZB/AHuCntmV8YIxzcZEjW82Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i8U5w5mo;
	arc=none smtp.remote-ip=91.218.175.156
Received: from mta0.migadu.com (out-156.mta0.migadu.com [91.218.175.156])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24B606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB24B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=i8U5w5mo
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nEYHTijhG3y2jMigu8DXS+u3k3k5VFqb7Kpwqv8LdG8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793657250; v=1; x=1794262050;
 b=i8U5w5moEYiilcF5tWYTLIxEpxQC6lRRaVnyP+69WE+lae3zUR4VaQCoufPMsv6GyGwYySHU
 GTfa3Siog0bA/I+CJhr+wo/XpjSsnyZ+XuLMowxfK22Ds/BaBpRAPUR3lu2sgNqsTBikw/ZdpWL
 L0od0Kqfp6cnZAdE90YA7Ez0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 366f3409fd7c6eee;
	Mon, 02 Nov 2026 22:07:30 +0000
X-Mizu-Trace-ID: 366f3409fd7c6eee
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
Subject: [PATCH bpf-next v3 0/8] selftests/bpf: cleanup bpf-gcc runs
Date: Mon,  2 Nov 2026 14:07:09 -0800
Message-ID: <20261102220717.4079739-1-vineet.gupta@linux.dev>
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
   -> 79 subtests newly visible, 78 OK and one @unpriv SKIP; the two
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

  FAIL  472 -> 456        OK -> FAIL regressions:  0
  OK   7061 -> 7141
  SKIP  753 ->  779

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

v2 -> v3:

 - Rebased on bpf-next.
 - 1/8: the bot asked about data_in_arena.c, whose use_ops() gated an
   indirect call on __clang__ with no arch condition.  That file has
   since gone in 3c13b2e5a40e ("selftests/bpf: Remove tests for global
   data in arena"), so nothing is left to convert.  The missing word in
   the commit message is fixed.  (bot)
 - 7/8: the comment on the r9 load said it was what makes libbpf record
   the arena, which stopped being true with cd7a395838cb ("libbpf: Bind
   the arena of an object to every program in it").  The load is now
   only a fallback for a kernel without fd_array_cnt and for the light
   skeleton; say that instead.  (bot)

Link: https://lore.kernel.org/bpf/20261028000411.4010967-1-vineet.gupta@linux.dev/ [v1]
Link: https://lore.kernel.org/bpf/20261028204158.1021284-1-vineet.gupta@linux.dev/ [v2]

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
 .../selftests/bpf/progs/verifier_arena.c      | 131 +++++++++---------
 .../bpf/progs/verifier_arena_globals1.c       |   6 +-
 .../bpf/progs/verifier_arena_globals2.c       |   3 +-
 .../bpf/progs/verifier_arena_large.c          |  24 ++--
 .../selftests/bpf/progs/verifier_callx.c      |   5 +-
 .../bpf/progs/verifier_callx_rodata.c         |   5 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |   9 ++
 .../selftests/bpf/progs/verifier_zext.c       |   9 ++
 24 files changed, 253 insertions(+), 117 deletions(-)

-- 
2.53.0-Meta

