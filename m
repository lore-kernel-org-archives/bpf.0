Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF1F411F94
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647857; cv=none; b=T2M6YBHAR9RXwjME7XVuTh9HT2XgSzbimmqk5FLdSC7NjdMxKtBWBiTdQHmjBrOt9Hp4A2ZW+NaK2EB+T6G4lZgT2pCgMaFHh4qOC4LA/cZiU+vx4Ke3/6bFvS3o3sIKVxjU3PNh/THp2QvdW4uvtBseGef9okqlo+SqHh+Vwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647857; c=relaxed/simple;
	bh=75rat4DZTbi/AtCH6CKBQvkAvbMJm8BchY554+SdpEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nU305myiprBn9P1LWb0tSUj88qB4l9ibstfeN7Lh5C1QKk3UrCQF8ggDK/VkXE//OtfIRcC8bMX03aWdBwlfSGlz2ue7JBYqpwS+cUN19cqWf3lblVE/Yqw9GSQE09QmdivZoS0u31puVZB+PpdQVR5PqZKOQ/UzUfihRZIbXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6V2qP41; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6V2qP41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8241F000E9;
	Thu, 13 Aug 2026 19:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647855;
	bh=CX5ME1roxXjEjjYi0syuy06YCrMato1yud/FPq8W/R0=;
	h=From:To:Cc:Subject:Date;
	b=Z6V2qP41zCVs6NXEcsUm4MmXT5bzEAPrhwcixORA6kPiRf1sN1tBfSNGALEcDxFE1
	 lazyK8KaFx7Iu9kI+Dc3wnB+oVyUGNPiLPwqrfnTd3Gscu2eybC9HM+KtrA+fdG6nA
	 O7TBiuDCzirjPzsBX2YeAR41DJa2hE9QfpRoPG5IGLrvhL8PlBPZog0Fv0e1JSR1wD
	 V4IDuzh+fAS2gW0O390+hzMRmieGXg45ZIqQRs5CWrU9HXS1Ehly2yZxsU8jq+v9XW
	 lyk8687ITllu5/p3T7DeLdmbBZwfb6VrD97LdNvgnN12DafYhjQJb+IvLuaxpxiZFT
	 xtBo3AnMyvPZw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH bpf-next v2 0/7] bpf, arm64: __arena kfunc and struct_ops arguments
Date: Thu, 13 Aug 2026 12:03:47 -0700
Message-ID: <20260813190356.335181-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86-64 JIT recently gained support for the __arena and
__arena__nullable argument suffixes on kfuncs and struct_ops stubs. This
adds the arm64 side and flips bpf_jit_supports_arena_args() on, so the
verifier stops rejecting these programs on arm64.

Patch 1 is an independent fix. save_args() reads stack-passed arguments
at FP + 32, which only holds when the trampoline is entered through the
fentry call and two frame records are pushed. A struct_ops trampoline is
entered via blr and pushes one frame fewer, so its stack arguments start
at FP + 16 and every one of them was read two slots off. No struct_ops
member passed arguments on the stack until the test added by commit
2d4de9a493a0, which is why this went unnoticed. It carries a Fixes tag
and can be taken separately; note that the test covering it only runs on
arm64 once the rest of this series lands.

Patch 2 adds an ADD/SUB (extended register) encoder to the insn library,
so the JIT can zero-extend and add in one instruction.

Patches 3 and 4 are the JIT work. A kfunc argument is rebased onto the
arena base at the call site:

        add     xN, x28, wN, uxtw

and a nullable one skips the add so NULL stays NULL:

        mov     wN, wN
        cbz     wN, 1f
        add     xN, x28, wN, uxtw
1:

A struct_ops callback converts in the other direction, in the trampoline
while saving arguments into the BPF ctx, with the low half of the arena
base kept in x11:

        sub     w10, wsrc, w11
        str     x10, [sp, #slot]

Patches 5 and 6 add arm64 JIT-sequence assertions and drop the x86-64
gating from the existing arena argument tests. Patch 7 is arch-neutral:
it adds a struct_ops member whose first argument is a 16-byte struct
passed by value, so the arena pointer does not land at the ctx slot its
argument index suggests. Nothing covered that before, and it is the case
patch 4 has to get right.

Changelog:
V1: https://lore.kernel.org/bpf/20260810190922.3408757-1-puranjay@kernel.org/
Changes in v2:
- patch 2: fix the decode masks for the new extended-register predicates,
  0x7F200000 -> 0x7FE00000. opt in bits 23:22 is part of the opcode here
  rather than a shift type, and any value other than 00 is unallocated
  (Xu Kuohai). Also noted in the commit message. No functional change: the
  masks only feed aarch64_insn_is_*_ext(), which has no in-tree callers,
  while the encoder uses aarch64_insn_get_*_ext_value().
- patch 4: comment why the conversion in the stack-argument loop is not
  guarded by for_call_origin (Xu Kuohai).
- collect Reviewed-by/Acked-by from Xu Kuohai.
- rebase onto current bpf-next.

Puranjay Mohan (6):
  bpf, arm64: Fix stack-passed arguments for indirect trampolines
  bpf, arm64: JIT __arena kfunc argument rebasing
  bpf, arm64: Convert struct_ops arena arguments in the trampoline
  selftests/bpf: Add arm64 JIT-sequence tests for __arena kfunc
    arguments
  selftests/bpf: Enable __arena argument tests on arm64
  selftests/bpf: Test a multi-slot argument before a struct_ops arena
    argument

Tejun Heo (1):
  arm64: insn: Add encoder for ADD/SUB (extended register)

 Documentation/bpf/kfuncs.rst                  |   6 +-
 arch/arm64/include/asm/insn.h                 |  23 +++
 arch/arm64/lib/insn.c                         |  60 +++++++
 arch/arm64/net/bpf_jit.h                      |  11 ++
 arch/arm64/net/bpf_jit_comp.c                 | 147 +++++++++++++++---
 .../bpf/prog_tests/test_struct_ops_arena.c    |  10 +-
 .../testing/selftests/bpf/progs/arena_kfunc.c |   9 ++
 .../selftests/bpf/progs/arena_kfunc_jit.c     |  20 +++
 .../selftests/bpf/progs/struct_ops_arena.c    |  24 +++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  15 ++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   8 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
 12 files changed, 308 insertions(+), 26 deletions(-)


base-commit: 806c1a185215382fab5a7fafc74e30070b2fb043
-- 
2.53.0-Meta

