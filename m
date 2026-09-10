Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CACD3B5820
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058819; cv=none; b=o4IyQuZQ//78FQN5GyjpACqor2V4gEiOZ+7ShGpTp+gZtEYnlcWnNje5G8EfQxjJ5YLhmBrWSRHbx+Z+AJS+qVVOKtdG83D0qqNmrIjO/lzR5Ygc0VlDdbf6xnE8oQvUn8rBqWzqzb6j2zDaHomTBkZf+FqZ99g6IR/pOMwxe1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058819; c=relaxed/simple;
	bh=OoC+vcUQUSkDdm7I8MGBn5ON6kHyud+ofa/Jzk3F8AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktAOQn4UPkQDO0vgxCvC6/sQXoWKoosNAH+G6GeMb87XGE7z90JD6+6SMOuLk/3yE2LUR8aQf6+jc0CcnHx9OIcOKeHxxdV1rPEcA/F/Ysnvsw/TlT1/WzQRlGqjSAqsCS3toPXXwtGUxpJEWi2IDZ/V8K6N5avMdAexcVuPuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OPUsJf9m; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OPUsJf9m"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OoC+vcUQUSkDdm7I8MGBn5ON6kHyud+ofa/Jzk3F8AY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058810; v=1; x=1789663610;
 b=OPUsJf9mnQwC8VB70jM7i5OOQAv5J1r4B1qP6ceUdFXdWg83wXNbnnECEO06u2FrKXiTO8fm
 xw5ScN2bMAnE4/LU9yhyN/FmhEvtLCL6LHuX0h0xzzNDSqlc10l2wEt0yz45DaPj0Ojtso9MLzE
 lTqecWsikxRmxoC/ZbxWU1Xw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5d7114d02b135b4c;
	Thu, 10 Sep 2026 16:46:50 +0000
X-Mizu-Trace-ID: 5d7114d02b135b4c
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
Subject: [PATCH bpf-next v2 00/13] bpf: track scalar equality across the low 32 bits
Date: Thu, 10 Sep 2026 22:16:22 +0530
Message-ID: <20260910164635.459558-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier's linked-scalar machinery tracks register equality only for
the full 64 bits, optionally with a constant delta. There is no way to
record "these two registers share just their low 32 bits", so a 32-bit
operation on a source with unknown high bits has to drop the relationship,
and a later narrowing of the source never reaches the destination:

The verifier's linked-scalar machinery tracks register equality only for
the full 64 bits, optionally with a constant delta. There is no way to
record "these two registers share just their low 32 bits", so a 32-bit
operation on a source with unknown high bits has to drop the relationship,
and a later narrowing of the source never reaches the destination:

  r6 = ...              /* full 64-bit unknown */
  w7 = w6               /* 32-bit zero-extending mov */
  if w6 != 0 goto ...   /* not taken: r6's low 32 bits are 0 */
  if w7 == 0 goto ...   /* not deduced today */

The same gap exists for the 32-bit sign extension, which is what prompted
this, and -- as pointed out on the RFC -- for loads, which can zero- or
sign-extend the same way. This series covers all four, plus the spill that
feeds a narrowing fill.

Record a low-32 link instead of dropping the relation. On a later
narrowing, sync_linked_regs() rebuilds such a register from the base by
re-applying the extension the original operation used, rather than copying
it. The reverse direction is skipped: a low-32 register knows nothing about
a full register's high half.

There is an upstream test that documents the missing capability directly.
verifier_reg_equal's "w reg not equal if r reg upper32 bits not 0" asserts
that w3 = w2 does not let a later w2 < 9 bound r3, and that the program is
therefore rejected. That bound is sound, so the test becomes __success
here.

Layout
======
The kinds live in bitfields rather than in the top bits of ->id, as
suggested on 1/6:

	enum bpf_add_const	add_const:2;
	enum bpf_subreg		subreg:2;

bpf_reg_state stays 80 bytes; 20 bits of padding remain.

Patches
=======
 1     move the kinds out of ->id [NFC]
 2     restore the kind comparison in regs_exact() that 1 drops
 3-4   zero-extending mov
 5-6   keep the range across a sign extension that cannot change it
 7-8   sign-extending mov
 9-10  narrowing fill
 11    record what a narrowing spill actually stores
 12-13 narrowing spill

5 and 11 are precision fixes that stand on their own; they are ordered
ahead of the linking patches that build on them.

Testing
=======
clang and bpf-gcc 20260721, x86_64:

  clang    129/2594 PASSED, 6 SKIPPED, 0/0 FAILED  (-t verifier)
  bpf-gcc  no new failures against the base

A full test_progs run on both the base and the series gives the same 28
distinct failures, with identical per-test failure counts.

Every patch builds individually.

Changes since the RFC [1]
=========================
6 patches became 13. In aggregate:

- The kinds are bitfields rather than a byte of flags, so RFC 1/6 is gone
  and RFC 2/6 shrank to patch 1.
- Two precision fixes were split out and ordered ahead of the linking
  patches that build on them: coerce_reg_to_size_sx() no longer widens a
  range it cannot change (5), and a narrowing spill records what it stored
  rather than the wider source (11). Both stand alone.
- Loads are covered, as asked for on the cover letter: the narrowing fill
  (9-10) and the narrowing spill that feeds it (12-13).
- regs_exact() regained a comparison the RFC lost when the kind left ->id
  (2).

Four of those differ from what was reviewed and are worth describing in
some detail:

- The wide-source mov no longer excludes an ADD_CONST source. This was
  suggested on 3/6 and it is the right call, but it has a cost:
  forming the link clears the source's base+delta relationship, so
  tracking that used to survive is lost. The two cannot both be kept -- a
  link the sync path skips would be inert -- and the delta shape is common
  in the codegen this targets. Patch 3 spells this out, and
  zext_mov_breaks_add_const_src pins it.

- reconstruct_sext32() does NOT reuse coerce_reg_to_size_sx(), despite that
  being the explicit ask on 5/6. The RFC's call-then-overwrite is gone --
  coerce_reg_to_size_sx() is fixed in patch 5 and the mov site now has a
  single sign-extension path. But the sync path cannot use it: it reads
  smin/smax, which straddle after a 32-bit compare and collapse to the full
  field range, so the link propagates nothing. It needs the base's 32-bit
  range instead, exactly as zext_32_to_64() does for the zero-extending
  side. Three tests failed on this before it was understood.

- The sign-extending self-mov is narrower than in the RFC. There,
  r0 = (s32)r0 was never excluded, because reconstruct_sext32() ran at the
  mov site to keep the range. Patch 5 now does that job, so the link is
  formed only when r0 already carries an id -- otherwise there is nothing
  to link to and minting one would leave the register describing itself.

- Patch 11 tightens the state recorded for every narrowing spill, including
  programs with no links at all. It is separated out for that reason.

[1] 20260814231945.3884596-1-vineet.gupta@linux.dev

Two notes on the tests:

- The two sign-extension range tests live in verifier_movsx.c rather than
  verifier_linked_scalars.c, contrary to the request on 4/6. They exercise
  the range a sign-extending mov produces, not the ->id machinery, and that
  file already gates on the cpuv4 support they need.

- Three tests that were named *_link_mismatch_blocks_pruning are now named
  for what they actually check. Disabling the ->subreg comparison in
  regsafe() does not make them fail: the states they compare differ in ids,
  contents or ranges, so regsafe() keeps them apart for reasons of its own.
  They verify an outcome, not that specific guard.

Still open
==========
- The kind comparison in regsafe() has no test that isolates it, like the
  pre-existing add_const comparison. The shape it guards is old being a
  superset of cur -- old SUBREG_ZEXT over [0, U32_MAX] against cur
  SUBREG_SEXT over [0, 100] passes range_within(), and without the
  comparison a later sync_linked_regs() would rebuild cur by the wrong
  rule. Whenever the kinds differ in a way a program can construct directly
  the ranges differ too, so the range checks reject first. Suggestions
  welcome.

- The fill arm mints an id when spill_size == 4, but the clearing test does
  not mention spill_size. A narrow value spilled at 8 bytes and filled at 4
  therefore inherits a full 64-bit link without the minting gate running.
  This predates the series; patch 9 builds on that arm without changing it.
  Is it deliberate?

- regs_exact() loses the kind comparison for exactly one patch, between 1
  and 2. They can be folded if the [NFC] label matters more than the bisect
  step.

Vineet Gupta (13):
  bpf: move linked-scalar flags out of bpf_reg_state->id [NFC]
  bpf: compare linked-scalar kinds in regs_exact()
  bpf: track low-32 scalar equality across zero-extending movs
  selftests/bpf: cover the low-32 link for zero-extending movs
  bpf: keep the range across a sign extension that cannot change it
  selftests/bpf: cover sign extensions that cannot change the range
  bpf: track low-32 scalar equality across sign-extending movs
  selftests/bpf: cover the low-32 link for sign-extending movs
  bpf: track low-32 scalar equality across narrowing stack fills
  selftests/bpf: cover the low-32 link for narrowing stack fills
  bpf: record what a narrowing spill actually stores
  bpf: track low-32 scalar equality across narrowing stack spills
  selftests/bpf: cover the low-32 link for narrowing stack spills

 include/linux/bpf_verifier.h                  |  36 +-
 include/linux/tnum.h                          |   3 +
 kernel/bpf/log.c                              |   8 +-
 kernel/bpf/states.c                           |  38 +-
 kernel/bpf/tnum.c                             |  15 +
 kernel/bpf/verifier.c                         | 282 ++++++--
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   8 +
 .../selftests/bpf/progs/verifier_bounds.c     |   2 +-
 .../bpf/progs/verifier_linked_scalars.c       | 653 +++++++++++++++++-
 .../selftests/bpf/progs/verifier_movsx.c      |  51 ++
 .../selftests/bpf/progs/verifier_reg_equal.c  |  14 +-
 .../selftests/bpf/progs/verifier_spill_fill.c |  10 +-
 12 files changed, 995 insertions(+), 125 deletions(-)

-- 
2.53.0-Meta

