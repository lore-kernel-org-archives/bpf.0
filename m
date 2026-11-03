Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729912;
	b=nEtp15V3U9JOee0woZNK6doJuIyaV4k1gJ2NfoyEvRm9pUZYT3pacX64NMl5o2+ZbHvA
	 yyx3XBQNGTYI+zBNK5EV97Q+NNr5KvQMg6m0yp7ehaY6H9tGskG8oVLkXDJbxfpSdEGzz
	 osyIJDUPn7kzojnGgPZg2aa0ys8S7suT5YMK9BcNL+dVVreJjHTTLAbK72NyV2zh7E3iX
	 InSypLUWVGFI7l/8BQWzcJbHADnusXMZpiC1Vivwrt/AjVOQKNaF9ikZege1pZ7He2s1g
	 DOxsLKnxtSL7IQTOcub27DeUeQllKdn2U/7GSAfRdA05q+EHZXd6aytpkFmPalyhMgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729912;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JOdDlevIHNgLi2iwEh1cVPzFxmgUEr7GY2bhR9cio/A=;
	b=Fjs+8so2puBWZ8n6dBex5JCx+yMPmYMMwaRcQ/5dmcuGGnQhltFIUMKPt+vL+bxuhCnB
	 iK0V5ef21+u9twmnDgO9d3TNYQagc1kKhA5Iyrq0xJ36r5H5olsJw7A2qn6Tpj3Er+Oqa
	 AeKgMMuq+3/fCpEWiw3n6NegdybmgqVTifyGoCX6WOQn7Nkkg8ZKSwb/2GItgp80FpLiu
	 F+6MiMr0AmSC0TGe0MtnOH9yoFXBr1NDf/2lKk+yyDhYAskzJd+nstnEkP4wTX7jEsBt1
	 G3FKKbsN8Sx9RY1wDWNqKWJTxJ4zNy2ZAL1YxOY4wTZxigVDHywBp/R7TkbVzWqV/JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Amh9Kqcq;
	arc=none smtp.remote-ip=91.218.175.145
Received: from mta0.migadu.com (out-145.mta0.migadu.com [91.218.175.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A6606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 398A6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Amh9Kqcq
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9H6pGX+rS5AHSpcrFCfzr8bnyddolLBtfUym3kTqrEw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793729908; v=1; x=1794334708;
 b=Amh9Kqcq0wK3tEPwBgJF9ZqDdhzwCOdklWc2r/zczwHAbc0bFOMiEMfBGTXn/471i0kRLz+v
 jkL7S3mPNvzsw0xKjwFsIT/zt83KnYKFtP959Nd9aznJgbQmZk5A9BNdg9VM+B7GKdLrAfoRzcb
 wvTYp4htO/MHB5yAszIf/lKc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8b07ecaecb260597;
	Tue, 03 Nov 2026 18:18:28 +0000
X-Mizu-Trace-ID: 8b07ecaecb260597
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
Subject: [PATCH bpf-next v4 0/8] selftests/bpf: let the arena tests build with GCC
Date: Tue,  3 Nov 2026 10:18:08 -0800
Message-ID: <20261103181816.254686-1-vineet.gupta@linux.dev>
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
Content-Transfer-Encoding: 8bit

The arena selftests cannot be built by GCC today. Three separate
build failures stand in the way, and they are all hidden rather than
avoided by the __BPF_FEATURE_ADDR_SPACE_CAST guards wrapped around
those tests -- the moment a GCC defines that macro, which is what the
in-progress arena support does, the guards stop hiding them and the
build breaks.

Behind the same guards the reporting is also not true. Tests inside a
whole-file guard do not appear at all, so the report is silent about
them. Tests with a guard inside the function keep an empty body that
satisfies __success __retval(0) by doing nothing, and report OK.

So: fix the build failures, then drop the guards entirely and tag the
few tests that genuinely need the feature, which removes the
empty-body failure mode rather than reporting around it.

Numbers are test_progs on bpf-next with a stock bpf-gcc, before and
after:

 1/8: Gate the callx tests on CAN_USE_CALLX, which also accepts a GCC
      defining __BPF_FEATURE_CALLX.
   -> 79 newly visible, 78 OK and one @unpriv SKIP.

 2/8: Keep clang-only warning flags out of GCC builds.

 3/8: Make arena_base() opaque to GCC's -Warray-bounds, as stream.c
      already did for its own copy, and fold that copy back in.
   -> no verdict change.

 4/8: Spell the addr_space_cast address spaces in decimal. gas only
      took hex after 2.47, and the failure is in the assembler.
   -> no functional change.

 5/8: Write the mixed arena/scalar ALU tests in asm, rather than a
      volatile register variable GCC may optimise away.
   -> both now run under a stock bpf-gcc.

 6/8: Drop the arena guards and tag the tests that need the feature.
   -> 27 newly visible, 22 running and passing; four need the tag.

 7/8: Cast explicitly in the four struct_ops arena triggers, which
      test_loader does not drive so the tag cannot reach them.
   -> 2 tests stop reporting a vacuous OK and run for real.

 8/8: Cast explicitly with bpf_addr_space_cast() in the arena subprog
      and callback faults, as the sibling tests already do.
   -> 15 FAIL -> OK, 5 newly visible.

Totals for the series:

  FAIL  472 -> 456        OK -> FAIL regressions:  0
  OK   7061 -> 7167
  SKIP  753 ->  772

v3 -> v4:

Alexei suggested simpler mechanisms for three patches. That exposed
build failures that had to be fixed first, so the series is renumbered.

 - v3 3/8: the #else dummies are gone. Rather than give each guard a
   placeholder that reports SKIP, drop the guards and tag the tests
   that need the feature (Alexei)
 - v3 4/8: arena_base() folds barrier_var() (Alexei)
 - v3 8/8: cast_kern() instead of the flag in .data. (Alexei)

 - New 4/8: addr_space_cast address spaces in decimal. gas has bug
   which is fixed but not released yet
 - 5/8: the asm rewrite of the mixed ALU tests moves ahead of the
   guard removal -- with the guards gone GCC sees the volatile
   register variables and -Werror=volatile-register-var fires. Both
   tests now run under a stock bpf-gcc.
 - verifier_hmul_arena.c converted away from dummy skip for consistency.

v2 -> v3:

 - Rebased on bpf-next.
 - 1/8: the bot asked about data_in_arena.c, whose use_ops() gated an
   indirect call on __clang__ with no arch condition. That file has
   since gone in 3c13b2e5a40e ("selftests/bpf: Remove tests for global
   data in arena"), so nothing is left to convert. The missing word in
   the commit message is fixed. (bot)
 - 7/8: the comment on the r9 load said it was what makes libbpf record
   the arena, which stopped being true with cd7a395838cb ("libbpf: Bind
   the arena of an object to every program in it"). The load is now
   only a fallback for a kernel without fd_array_cnt and for the light
   skeleton; say that instead. (bot)

v1 -> v2:

 - 1/8: the __skip() reason named only x86/arm64 while CAN_USE_CALLX
   also accepts riscv64. Say "arch JIT" instead of listing them, so
   the string cannot go stale the next time an arch is added. (bot)
 - 3/8: jit_insns_arena.c was missed. Both of its programs are inside
   the guard, so without arena support the object has none at all and
   RUN_TESTS(jit_insns_arena) ran zero subtests without saying so.
   (bot)
 - 5/8: commit message only. It cited arena_types to argue the kfunc
   tests need no cast, but the address parameters carry the __ign
   suffix, so get_kfunc_arg_type() returns ARG_IGNORE and
   check_func_arg() returns before any register type check.
   Conclusion unchanged, for a better reason. (bot)
 - 5/8: arena_kfunc.c, verifier_arena_globals1.c and
   verifier_arena_globals2.c had the same empty-body shape and were
   missed; nine more guards go and seven more tags arrive.
   arena_kfunc.c alone had eight subtests reporting a vacuous OK.
 - 8/8: new patch, for the four struct_ops arena progs.

   The three bot findings prompted a sweep of every prog with an
   arena guard, which is where the last two came from.

Link: https://lore.kernel.org/bpf/20261028000411.4010967-1-vineet.gupta@linux.dev/ [v1]
Link: https://lore.kernel.org/bpf/20261028204158.1021284-1-vineet.gupta@linux.dev/ [v2]
Link: https://lore.kernel.org/bpf/20261102220717.4079739-1-vineet.gupta@linux.dev/ [v3]

Vineet Gupta (8):
  selftests/bpf: Build callx tests with GCC that defines
    __BPF_FEATURE_CALLX
  selftests/bpf: don't pass clang-only warning flags to GCC
  selftests/bpf: make arena_base() opaque to GCC's -Warray-bounds
  selftests/bpf: spell the addr_space_cast address spaces in decimal
  selftests/bpf: write the mixed arena/scalar ALU tests in asm
  selftests/bpf: drop the arena guards and tag the tests that need arena
  selftests/bpf: cast explicitly in the struct_ops arena triggers
  selftests/bpf: cast explicitly in the arena subprog and callback
    faults

 tools/testing/selftests/bpf/Makefile          |   8 +-
 .../testing/selftests/bpf/Makefile.buildvars  |   6 +-
 .../bpf/libarena/include/bpf_arena_common.h   |  11 +-
 .../bpf/prog_tests/callx_rodata_lskel.c       |   2 +-
 .../selftests/bpf/progs/arena_atomics.c       |  32 ++--
 .../testing/selftests/bpf/progs/arena_kfunc.c |  18 +--
 .../selftests/bpf/progs/arena_kfunc_jit.c     |   5 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  16 ++
 .../selftests/bpf/progs/callx_rodata.c        |   4 +-
 .../bpf/progs/compute_live_registers.c        |   2 -
 .../selftests/bpf/progs/jit_insns_arena.c     |  10 +-
 tools/testing/selftests/bpf/progs/stream.c    |  62 ++------
 .../selftests/bpf/progs/struct_ops_arena.c    |   3 +-
 .../bpf/progs/struct_ops_arena_autobind.c     |   3 +-
 .../bpf/progs/struct_ops_arena_member.c       |   3 +-
 .../progs/struct_ops_arena_member_render.c    |   3 +-
 .../selftests/bpf/progs/verifier_arena.c      | 138 ++++++++----------
 .../bpf/progs/verifier_arena_globals1.c       |   6 +-
 .../bpf/progs/verifier_arena_globals2.c       |   3 +-
 .../bpf/progs/verifier_arena_large.c          |  21 +--
 .../selftests/bpf/progs/verifier_callx.c      |   5 +-
 .../bpf/progs/verifier_callx_rodata.c         |   5 +-
 .../selftests/bpf/progs/verifier_hmul_arena.c |  19 +--
 .../selftests/bpf/progs/verifier_ldsx.c       |  14 +-
 .../selftests/bpf/progs/verifier_zext.c       |   4 -
 25 files changed, 159 insertions(+), 244 deletions(-)

-- 
2.53.0-Meta

