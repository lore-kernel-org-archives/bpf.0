Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513165;
	b=rROfdo8tUgOXR9uX46jdsU/SwXLCfTBTN7eoVST6of0Yedbp0/nUmVqk8PhRQpsZEYDQ
	 KMuBpIOfxRnAS8FDA2gRnINBL/+K0IfIBW7BIutp0DwD3tmfPIACxqbYTrhrwHDXIAoq4
	 4bvQgeng7a0iIi1QCijRLinscLN14FaxBXZfwWd8vcvEsSQu/Q9nInf9PAVHyvmZc9/hQ
	 5X5lOUF2rB4w2jPCDmgrTlziwCjjk5pTlCFV1WIZeoAr9j5/MWAJqFYAOkV5yXrMbGf0c
	 zSpa3+BleDEiEbvzR9KQjMvAAen4f0O9NInNJ8eBBLNpc4HnQQSbH2hA5zZtBAG5sPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513165;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=J8AQDqYa093bO5JROgq8wcTCDu2HbaJ3o/zBYJsra74=;
	b=NZ1A9acvQwg/JfBmD8luMglC0NkATeZJwPKlvw7G1apDe1lkALgkI3gWwqS7WZkKhW11
	 6yyL2Np6QiVa9rj7dSdbcLhyDmYe9PxYDWlbYD1ptLS4gqgwMmzYhNKZDjtNXoKnj5FRZ
	 Hh/DAdN/Hn52OmlKAwsHy1PehEWN/ugkL5J8q2z2Y+cQbm32vAVr/d7Hl8sqcAZPn5O0d
	 kEEwJrANiBCx7GznePvMX6smZCh6/440pzkEptp2x5tmH6c3h+lEV0gKMSfUKZ3J/AUt8
	 hpRURWzzblsVI2MtdQwyP6Yvv4MKi1Ac7nbUDWNoUbrXI205k1J2SwAcY524ucSIr3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nBsbaFgz;
	arc=none smtp.remote-ip=91.218.175.155
Received: from mta0.migadu.com (out-155.mta0.migadu.com [91.218.175.155])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C972606A32F
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C972606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nBsbaFgz
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JwWe/dMpnTbNzKs9pgLm3Ba/MnLyPwYkBRb2X2J23ZA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792513162; v=1; x=1793117962;
 b=nBsbaFgz9E1tzkJBxYCnGqv78waQvNTvn2G3sNR9M8bZhBBSbAYVyfXfO/pVYMobxw+OFFFQ
 8uNZVBTVBvrBPMYsQwoBgolkAXPztiawLwyiYlLYJX9+tOmQW5edE4+PLrpJlY+ZrVFDYJEEH8b
 yLWJCCmenDCDyuPO5K0J0Ib8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b965807214146e88;
	Tue, 20 Oct 2026 16:19:22 +0000
X-Mizu-Trace-ID: b965807214146e88
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v3 00/12] bpf: track scalar equality across the low 32 bits
Date: Tue, 20 Oct 2026 09:18:55 -0700
Message-ID: <20261020161907.2115379-1-vineet.gupta@linux.dev>
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

This series was motivated by BPF_GCC tendency to generate sign-extensions
which the verifier effectively doesn't handle at all for the scalar linked
tracking.

This can prevent correct programs from loading such as the test below,

   0: (61) r2 = *(u32 *)(r1 +24)
   1: (bf) r0 = (s32)r2
   2: (56) if w2 != 0x0 goto pc+10       ; R2=0
  12: (95) exit

leads to following load failure:

  At program exit the register R0 has smin=-2147483648 smax=2147483647
  should have been in [0, 1]

The verifier currently tracks the full 64 bits or nothing (the alu32
handling is also full 64-bits with upper bits known to be zeroes).
The sign extension at insn 1 has no way to say "same low 32 bits, high half
from bit 31", so it doesn't link r0 and r2, hence the insn 2 branch can't
narrow r0.

A slightly complex scenario involving sign extension is where the source
is already linked (bpf_sockmap_map_iter_fd/copy):

  31: (85) call bpf_map_delete_elem#3   ; R0=scalar()
  32: (bf) r1 = r0                      ; R0=scalar(id=4) R1=scalar(id=4)
  33: (bf) r0 = (s32)r0                 ; R0=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
  34: (16) if w1 == 0x0 goto pc+6       ; R0 unchanged
  41: (95) exit

And a zero extension has the same gap, but usually it only costs precision.
This is captured in existing verifier_reg_equal.c:subreg_equality_2 (since
2023):

  call %[bpf_ktime_get_ns]
  r2 = r0 		<-- unknown high bits
  w3 = w2 		<-- only low half shared, not recorded
  if w2 < 9 goto l0_%=  <-- narrows w2
  exit 
l0_%=:
  if r3 < 9 goto l1_%=  <-- this doesn't deduce
  r0 -= r1    		<-- illegal read reachable
l1_%=:
  exit 

This series, among others, also removes this restriction, making the test
pass now.

  -__description("check w reg not equal if r reg upper32 bits not 0")
  -__failure __msg("R1 !read_ok")
  +__description("check w reg equal if r reg upper32 bits not 0")
  +__success

And finally this series also handles narrowing stack fills: a 4-byte read
of a value spilled wider. Its mirror image, the narrowing stack spill,
is implemented here too (patch 11-12) but is not proposed, see
Testing: veristat sub-section below for reasoning.

Improvements
============

This series completely eliminates two class of verifier failures in
selftests built with BPF_GCC: 

 - all 19 instances of "should have been in [0, 1]"
 - all 6 instances of "The sequence of 8193 jumps is too complex"

It unblocks existing subreg_equality_2.

How it is modelled
==================

Upstream currently relates two scalars using ->id which additionally
encodes add_const with a optional delta. Sign-extension requires a different
relationship which is low32 same only. This series generalizes the
existing mechanisms:

For an abstract scalar X, a register can be:

	X + delta        zext(X + delta)        sext(X + delta)

The first is the existing add_const and other two are the new
functionality and also support the optional delta. The relationship now
looks like:

	enum bpf_reg_link_kind {
		BPF_REG_LINK_NONE = 0,
		BPF_REG_LINK_FULL,	/* all 64 bits shared */
		BPF_REG_LINK_ZEXT,	/* low 32 shared, high half zero */
		BPF_REG_LINK_SEXT,	/* low 32 shared, high half = bit 31 */
	};

Four values fit the two bits add_const already had, so the encoding
costs no space: bpf_reg_state stays 80 bytes and bpf_func_state stays in
the 1K allocator bucket that commit a2052333e6f9 ("bpf: Bpf_func_state
size optimization") put it in.

Other details to be aware of
============================

 - Sext with delta is supported.

 - Semantics of BPF_ADD_CONST32 change: It used to be:

	reg == base + delta, base known to fit u32

   Now it is modelled as:

	BPF_REG_LINK_ZEXT:  reg == (u32)(base + delta), for ANY base width.

 - Delta composing/stacking: is allowed now, albeit only once:

	"w3 = w0; w3 -= 1" is now able to keep the regs linked

   Composing further is deliberately not done, as it interferes with
   state pruning in loops.  On arena_strsearch, allowing any second delta
   costs 1176 -> 1751 insns and 102 -> 133 states; allowing it onto a zero
   delta produced by an add rather than by the mov still costs 1176 -> 1196.

 - Propagating a delta backwards: patches 4 and 6 already do that for
   base that fits 32-bits, for wide base, patch 8 does that for
   completeness. It does fix the directed test zext_reverse_pins_low_half,
   and the instrumented arm fires 78 times under bpf-gcc, 40 times under
   clang, but no visible improvements.

Testing
=======

 - kernel off bpf-next baseline of 26/10/16, commit d2141481a764 "(bpf: Free
   the subprog jump tables once the CFG passes are done)"
 - bpf-gcc (20261010, ga02e2004cb70).

Only patch 1-10 are used for testing as the last 2 are just for demonstration
(as asked for in v2), but not really production.


1. BPF_GCC built selftest changes:

  before:        476 FAIL    6912 OK     749 SKIP
  after:         450 FAIL    6985 OK     751 SKIP

  bpf_ip_check_defrag                                              FAIL -> OK
  bpf_ip_check_defrag/v4                                           FAIL -> OK
  bpf_ip_check_defrag/v6                                           FAIL -> OK
  bpf_iter                                                         FAIL -> OK
  bpf_iter/bpf_sockmap_map_iter_fd                                 FAIL -> OK
  bpf_iter/task_pid                                                FAIL -> OK
  bpf_iter/task_pidfd                                              FAIL -> OK
  bpf_iter/task_sleepable                                          FAIL -> OK
  bpf_iter/task_tid                                                FAIL -> OK
  bpf_sockmap_map_iter_fd                                          FAIL -> OK
  setget_sockopt                                                   FAIL -> OK
  sock_addr/connect_unix: attach prog with wrong attach type       FAIL -> OK
  sock_addr/connect_unix: connect (stream)                         FAIL -> OK
  sock_addr/connect_unix: connect deny (stream)                    FAIL -> OK
  sock_addr/connect_unix: kernel_connect (dgram)                   FAIL -> OK
  sock_addr/connect_unix: kernel_connect deny (dgram)              FAIL -> OK
  sock_addr/sendmsg_unix: attach prog with wrong attach type       FAIL -> OK
  sock_addr/sendmsg_unix: kernel_sendmsg deny (dgram)              FAIL -> OK
  sock_addr/sendmsg_unix: sendmsg (dgram)                          FAIL -> OK
  sock_addr/sendmsg_unix: sendmsg deny (dgram)                     FAIL -> OK
  sock_addr/sendmsg_unix: sock_sendmsg (dgram)                     FAIL -> OK (runs twice)
  sock_addr/sendmsg_unix: sock_sendmsg deny (dgram)                FAIL -> OK
  sockmap_basic                                                    FAIL -> OK
  sockmap_basic/sockhash copy                                      FAIL -> OK
  sockmap_basic/sockmap copy                                       FAIL -> OK


2. veristat on selftests built off bpf-gcc, clang and a corpora of prebuilt
   bpf objects.

bpf-gcc, 3314 programs verifying on both sides:

  verdicts      12 pre-existing failure -> success
  total_insns   4 changed, 2 worse, -16 overall: cond_break3 36 -> 48,
                ksock_wq_start 207 -> 213, estab 2849 -> 2817, and the
                series' own zext_contradiction_keeps_range_sane 11 -> 9
  total_states  1 changed, 1 worse:  cond_break3 4 -> 6

clang, 3520 programs verifying on both sides:

  verdicts      1 pre-existing: subreg_equality_2
  total_insns   3 changed, 1 worse, +126 overall: big_alloc2
                2956 -> 3095, cond_break2 90 -> 79, and the series' own
                zext_contradiction_keeps_range_sane 11 -> 9
  total_states  2 changed, 1 worse:  big_alloc2 157 -> 165,
                cond_break2 10 -> 9

and an external corpus -- 441 objects from cilium, katran, fb and
sched_ext, 1467 programs verifying on both sides (increase test coverage
from selftest 5.4M insns and 15 progs above 50k insns to 25.2M insns and
131 progs over 50k insns).

  verdicts      no change
  total_insns   12 changed, 10 worse, +7087 (+0.028%); two improve.
                Worst is +1812 on test_file_open, 2470 -> 4282, in
                bpfjailer .../lib-tests-bpf-open-open.bpf.o
  total_states  9 changed, 7 worse, +242 (+0.026%); worst +155 on the
                same program

3. Applying 11-12 on top of 1-10:

  bpf-gcc       nothing at all -- no program changes
  clang         one program changes, and it improves
  external      102 changed, 63 worse, +84450 insns (+0.335%) and
                +6257 states (+0.661%). Not a broad slowdown: the three
                below carry 97% of it. Of the remaining 60, two are
                +26.6% and +7.7%; the other 58 are under 1% each.

                  +89.7%  +19784   rusty_enqueue    22053 ->  41837
                                     scx_rusty.bpf.o
                  +57.2%  +59616   test_file_open  104160 -> 163776
                                     bpfjailer .../match-tests-...-file.bpf.o
                  +40.6%   +2688   layered_enqueue   6626 ->   9314
                                     scx_layered 1.0.11.1

Two notes for anyone re-running the above.

Four programs in the external corpus are named test_file_open. The one
at +57.2% here is in .../match-tests-...-file.bpf.o; the +1812 in
section 2 is a different and much smaller program in
.../lib-tests-...-open.bpf.o, which these two patches take the other
way, 4282 -> 2476.

And veristat's raw verdict-change counts are larger than the twelve in
section 2 -- 28 on bpf-gcc, 17 on clang -- because the corpus is built
from the series tree, so the series' own new tests read as
failure -> success too. zext_mov_breaks_linked_src goes the other way,
success -> failure: it is an intentional __failure test, and veristat
records "failure" for a program that does not load.

Patches
=======

  1-2   fix a sign extension that cannot change the range but widens it
        anyway, which is unrelated to the rest and was asked to go first
  3     move the linked-scalar flags out of bpf_reg_state->id
  4-5   zero-extending movs
  6-7   sign-extending movs, including the inherited delta
  8     the reverse direction, for a base wider than 32 bits
  9-10  narrowing stack fills
  11-12 [do not merge] narrowing stack spills

Patches 1-10 are what is proposed. 11-12 are posted because the relation
is the one asked for and implementing it was the only way to find out
what it costs; the answer is in 11's message and it is not worth it.

Changes since v2
================

  - the kind moves out of bpf_reg_state->id into an enum of its own
    (Eduard), replacing v2's add_const plus a separate subreg_sext
    bool. bpf_reg_state stays 80 bytes. v2's 2/13 is squashed into the
    patch that needs it (Alexei).
  - the zero-extending link is ADD_CONST32 with a zero delta rather
    than a kind of its own (Alexei), which drops the
    dst_umax > U32_MAX guard -- the one pre-existing semantic this
    series changes, described above.
  - sign-extending movs carry a delta, which v2 did not support.
  - 4/12 fixes a reachable WARNING found while preparing this revision:
    the intersect step could leave an empty range behind. v2 never
    showed it because its 8/13 happened to mask it.
  - 9/12 reports its cost, which v2 did not: +6598 insns over six
    external programs, with no verdict change.
  - v2's 11/13 is dropped; the two spill patches are now [do not
    merge], with the measurement behind that call in 11/12.

The per-patch changelogs under each --- have the rest.

v2:
https://lore.kernel.org/bpf/20260910164635.459558-1-vineet.gupta@linux.dev/

RFC:
https://lore.kernel.org/bpf/20260814231945.3884596-1-vineet.gupta@linux.dev/

Vineet Gupta (12):
  bpf: Keep the 32-bit range across a sign extension that cannot change
    it
  selftests/bpf: Cover sign extensions that cannot change the range
  bpf: Prepare linked scalars for relations narrower than 64 bits
  bpf: Track low-32 scalar equality across zero-extending movs
  selftests/bpf: Cover the low-32 link for zero-extending movs
  bpf: Track low-32 scalar equality across sign-extending movs
  selftests/bpf: Cover the low-32 link for sign-extending movs
  bpf: Recover the low 32 bits on the reverse link direction
  bpf: Track low-32 scalar equality across narrowing stack fills
  selftests/bpf: Cover the low-32 link for narrowing stack fills
  [do not merge] bpf: Track low-32 scalar equality across narrowing
    stack spills
  [do not merge] selftests/bpf: Cover the low-32 link for narrowing
    stack spills

 include/linux/bpf_verifier.h                  |   52 +-
 include/linux/tnum.h                          |    7 +
 kernel/bpf/log.c                              |    6 +-
 kernel/bpf/scev.c                             |    2 +-
 kernel/bpf/states.c                           |   38 +-
 kernel/bpf/tnum.c                             |   15 +
 kernel/bpf/verifier.c                         |  387 ++++-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   16 +
 .../selftests/bpf/progs/verifier_bounds.c     |    2 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |    8 +-
 .../bpf/progs/verifier_linked_scalars.c       | 1323 ++++++++++++++++-
 .../selftests/bpf/progs/verifier_movsx.c      |   63 +-
 .../selftests/bpf/progs/verifier_reg_equal.c  |   14 +-
 .../selftests/bpf/progs/verifier_spill_fill.c |    6 +-
 14 files changed, 1787 insertions(+), 152 deletions(-)

-- 
2.53.0-Meta

