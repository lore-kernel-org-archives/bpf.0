Received: from mail-oi2-f5.google.com (mail-oi2-f5.google.com [74.125.231.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A63B2D39
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416131; cv=none; b=QOSBt0gFOwPHqeOL/zgR7k0OvTiZiwMgI4NqpHJ0Izyy5DvtBTm1w3V/whSM6JpzEZlfdeFBGwFKg9OpEr64esaLVHmv6dPQ7NfZ1fPFMuCnYwgwroTmB6mdLSboKldw1kgvcjNtmd5r1x4O96MQklts2swamUTJ4pEOTeuexDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416131; c=relaxed/simple;
	bh=AWWnHt4RHZ2YMJWTs5BbHrF4AxiB3/wu8nRTTopapqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTh7Y7Cgz4UxIuuzNyImSmUAQUVIjrbJINbj/tgkS6d/I6+/oeE4DNKScfEB/v/dGbcMJ83gFbxaou64IWJajOkXLbc/N2joH/zD6luuxkyyXdMT8ueNu0pzFaK1ypXGi/taGKTJHzAfQ8YBWui4V3gJ6aJI7okhzR3aDefe8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbe8MxkU; arc=none smtp.client-ip=74.125.231.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbe8MxkU"
Received: by mail-oi2-f5.google.com with SMTP id 5614622812f47-5413fa881a9so808185b6e.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416128; x=1793020928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XVZ/l3igzXzcqlAaga6uY/QCTtdRDayQ7c+Sp2UR97Q=;
        b=nbe8MxkUUKxLnna6PpAailwppiFRy4S/NgEKwLnrhD3f9/1T1/Be7Afrc3dU6CcOqd
         gHNiSki+KGurs0X0tAtsFLH7kewyu5VDbs+Sbg8KMRGHTG+1u+tAwkWwUo5ULOJX2B9X
         62nkQGyYs2wIIBmb41+MFWVjjmZtB1nInVZOPXx/6uATEoNh6W9e+S0glX8opDGvpimI
         9lREN4fbjkvjN8ub07wOZ+EFFpnLJw+HFVJoppkxXl6b0eTAu2LrCHkhGivwcifmdUfs
         XIIKuIqXyLjZt2VFpyX6V++/Gd0HhdcRwlEAw+c6No3hM7YJFWEYqod8Il2DfbHDb2iw
         P8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416128; x=1793020928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVZ/l3igzXzcqlAaga6uY/QCTtdRDayQ7c+Sp2UR97Q=;
        b=ErLtN+fKy8SP+LrKWnSDgjXRkU34L94S+1aPQ1gA4g+pbqKZEm41Uh65yMTmXIQVcy
         nKYPhZqcH1z8YWOtlYaUcjOHO4hInHBybOjZljtygBsYwTRdmf/Z/EA78vLU8HmDpIQ4
         qvATueswv7zNHmRjToTsIWQt7+Pp1Uh943rfsgJFp23B2FLLXLqmnw4CUeB9RXF+Fs2b
         JNGGyr2MrRfFYNt3N9G/P/nb4X9+3LaY+YMERuElDhnPo2usTfhUETrJjkBNq5EXLUd1
         293/LXaDEY1QPO1Jd4LKTzWQp1INfPGiW8b+ziusp66pjEOmc+i7ZPbS+/Cpsxrh4Hjw
         h4Jg==
X-Gm-Message-State: AFq9FYLti3elgO/mjMOx0crUvzQkRBjtComTiRNqqLmanko9QRSiNhZW
	lNF3pGMPMD4rQBCxiuUrdE8wvidxdNAT0xNaxdtlH4qWTq2TTHEyfYhjOXXw0iLPATk=
X-Gm-Gg: AYBFou1ZlqG/DHPUrkHkaCR9iqgdBHPNWDpkZLL9DOmJlcAs7z5OI9/X5npg9n1Rr0e
	hXRIOcIVNyrfFtth22i63RTKiZGGQKJ427k7I0PxYi1JKH8VqyfcKWOOri1QcIM1nmFVBA9/VRe
	EvH6go2J0T+oGeUoYXMwQ9AYLSm9GUYaIBgwkYznXZPCp1YqWg09aisbowq4mEWXEQDoq0pkSsd
	L2LyvlG1OO6f8S835YaT0it8mrW1lpe1BzO3AWEsiFiIclAqaGR6hloSc1vOMOhDUBVwl9va3sE
	JUqxgcDXzB3CiIqHgdyfxPb9+Gd5hUZoyJu1GCQDu+s0WggZ/oHsYWgiJOjJANOAev0lejd9iAX
	ZUB0hM+YMzCMuTsIuKOgzn7uxVzSL4IqOoSxCrpA+1wLhGtIhP4owxDUVVVdq7xedVWQFiWEgIH
	352331hS99jWIOx5YHJfMK6O3n7emy0okDxFIP+cviayQOGW3+np6032TxmEvtBJftqSQP/8Oas
	mfaI89rzSrPjIcRu75d6cmS0lEMGDDnemAIrdkqGiVomLH9IXtBXjzDKrL+uX0jRcTZmqK3iDOr
	24fYSoU=
X-Received: by 2002:a05:6808:6808:b0:4d6:9335:d535 with SMTP id 5614622812f47-53cd2f36a49mr6324860b6e.66.1792416127820;
        Mon, 19 Oct 2026 06:22:07 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:15::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388289f0bdsm7582440b6e.1.2026.10.19.06.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 00/16] Fix some arena paper cuts
Date: Mon, 19 Oct 2026 15:21:42 +0200
Message-ID: <20261019132203.3034698-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14779; h=from:subject; bh=AWWnHt4RHZ2YMJWTs5BbHrF4AxiB3/wu8nRTTopapqo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxJHkaPWoLpFuP2+Wq76hD2e9+LEv3fdL2fkyVV+hN45B X593lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLHBBgZps22OndoU1JTrJDXhfuaoc KHKk8KZOR4M7S5yXcG9j+TZfhnFWQ9+eLnPeEWQWU9tz8bf/0w75bw5WNzPp2y1Hp2OI+BGwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Kernel code that shares arena memory with BPF programs runs into two
paper cuts, both visible in sched_ext's cid-form schedulers today.

A kernel struct cannot publish an arena pointer: a pointer member reaches
the program typed as a kernel pointer, so sched_ext hands out a plain u64
holding a pre-translated arena address and every program casts it before
use. __arena and __nullable become BTF type tags, defined in a header of
their own, bpf_compiler_types.h, that the code tagging a member includes.
A load through an __arena member of a kernel struct yields PTR_TO_ARENA:
the member holds the kernel address and the fixup pass appends the
conversion to the arena pointer form that the struct_ops trampoline
applies to __arena arguments, with a NULL test for __nullable members.
A __nullable member on its own yields PTR_MAYBE_NULL where NULL would
otherwise be assumed away, on trusted, RCU and per-CPU results, and the
program checks it; through a plain or an untrusted pointer the member is
probed and tolerates NULL, as the BTF_TYPE_SAFE_*_OR_NULL lists never
applied there either. libbpf renders the arena tag with its address
space, so the member arrives in a program built against vmlinux.h ready
to use, without a cast.

A program only has an arena when one of its insns refers to the arena
map, yet the kernel hands programs arena pointers through struct_ops
arguments, tagged members and kfunc return values, and a struct_ops
callback that touches nothing but its arguments fails verification until
it refers to the arena artificially. libbpf binds the arena of an object
to every program loaded from it, through a continuous fd_array. So that
programs which never touch the arena pay nothing for it, the final insns
of a function decide, right before it is JITed, whether it needs the
arena base, and the JITs set it up only then.

Tested with sched_ext for-next as well: a typed cmask member next to the
existing cmask_arena_addr in struct scx_enable_args passes the
enable_cmask selftest read straight from the member, without a cast and
without the asm volatile arena reference.

The series opens with two fixes the reviews led to: the verifier checked
an exclusive map bound through a continuous fd_array against a program
digest it had not computed yet, and bpf_program__clone() passed the
fd_array fill index of the object as fd_array_cnt, which made every
clone from an object with module kfuncs fail.

See commit logs for details.

Changelog:
----------
v4 -> v5
v4: https://lore.kernel.org/bpf/20261019032401.2302823-1-memxor@gmail.com

 * Claim the maps of a program, as their single user and as the owner
   of an insn array, only once every exclusive map has passed the digest
   check, so that a rejected program leaves no trace on a map it had no
   right to. (Sashiko)

v3 -> v4
v3: https://lore.kernel.org/bpf/20261015234125.3152346-1-memxor@gmail.com

 * Drop PTR_MAYBE_NULL on probed results again, plain and untrusted
   pointers and pointers to scalars, where the tag asks for no check, as
   BTF_TYPE_SAFE_*_OR_NULL never did either; keep it on per-CPU results,
   and test both. (Alexei)
 * Check the skeleton pointer in the exclusive map fd_array test.
   (Sashiko)
 * Accept an acquire load of an __arena member, rewritten like a plain
   load, and test it.
 * Check the exclusive maps against the digest once it is final, at the
   end of check_and_resolve_insns(), instead of computing the digest
   before the fd_array is resolved, which would have let relocations the
   kernel applies change a program after the check. (BPF CI)
 * Declare has_tag inside the arch guard of the arena struct_ops test,
   it was unused on s390x and failed the build there. (BPF CI)
 * Say in the autobind test log which programs never refer to the arena.
   (BPF CI)
 * Move the two no-arena tests to an object without an arena map in a
   patch of their own, ahead of the libbpf binding, so that they pass at
   every step of the series. (BPF CI)
 * Move __arena and __nullable out of compiler_types.h into a new
   bpf_compiler_types.h that the code tagging a member includes, so the
   rest of the kernel never sees them. (Alexei)
 * Decide whether a function needs the arena base on its final insns,
   right before the JIT, instead of recording uses during verification:
   a constant NULL passed to a nullable __arena kfunc argument took the
   verifier's early exit and was never recorded, so the x86 JIT rejected
   the program; test that case. (Alexei)
 * Hide the open-coded type tag attributes of the render mirror test
   behind macros. (Alexei)
 * Bind an arena exclusive to the program itself only where the kernel
   checks exclusive maps against the final digest, found by a second
   probe, so that such a program keeps loading on kernels without the
   first patch; test the binding.
 * Correct two libbpf logs: the JIT prologue cost of the binding goes
   away later in the series, and GCC ignores the address space attribute
   with a warning.
 * Report a missing member as an error from the type tag probe of the
   tests instead of a skip, and check the arena of every clone in the
   autobind test.
 * Spell out in the test logs the store case a struct_ops program cannot
   reach the member check with, the memory pointer mismatch case and
   the NULL constant passed to a nullable __arena kfunc argument.
 * Drop the early digest of a signed program along with the early
   comparison it served; the signature check hashes the insns itself.

v2 -> v3
v2: https://lore.kernel.org/bpf/20261013082012.1107446-1-memxor@gmail.com

 * Keep NULL on a probed load of an __arena member as well, so that a
   fault reads as NULL rather than as an arena pointer, and test it.
   (Sashiko)
 * Drop the stripping of PTR_MAYBE_NULL: a __nullable member yields it
   whatever the pointer it is read through, per-CPU, plain and scalar
   pointees included, and the program checks; test each. (Sashiko)
 * Report the arena member tests as skipped on a kernel whose module BTF
   carries no type tags. (BPF CI)
 * Update the fd_array_used comment for the arena in slot 0. (BPF CI)
 * Compute the program digest before the fd_array is resolved, as a fix
   patch with a selftest: an exclusive map bound through a continuous
   fd_array was checked against a digest the kernel had not computed
   yet for an unsigned program, which failed the binding of an exclusive
   arena to its own program.
 * Skip an arena whose fd is gone after a failed load; keep the count a
   caller passes to bpf_program__clone().
 * Load the autobind object through bpf_object__prepare() and
   bpf_program__clone() in the test as well.
 * Look for the type tag on the member in the module BTF itself, guard
   the test kfuncs against a missing ops3 map, and define __arena for a
   program that includes the module header before bpf_arena_common.h.
 * Note in the libbpf commit log that the kernel resolves every module
   BTF slot for every program once the arena is bound.

v1 -> v2
v1: https://lore.kernel.org/bpf/20261012133711.4030594-1-memxor@gmail.com

 * Leave the flags of members walked from a map pointer alone: the
   review found that an __rcu member comes out of that path as MEM_RCU,
   neither nullable nor probed, which is an older problem of the path
   and of the bare PTR_TO_BTF_ID results it accepts, left to a separate
   series after a wider audit. (Sashiko)
 * Record the non-arena side of a shared load insn for every load, not
   only for loads through a kernel struct pointer, since a load insn may
   also serve a memory pointer on another path; test that case. (Sashiko)
 * Return early in assert_prog_map() when the program lists no map, so a
   failing check does not read uninitialized memory. (Sashiko)
 * Mark the __arena argument of a kfunc call where the call is verified,
   the kfunc pre-pass marked subprogram 0 whatever subprogram held the
   call, and test a subprogram whose only arena use is such a call.
   (BPF CI)
 * Bind the arena only when libbpf creates it, so a program whose arena
   has autocreate off still loads; leave out an arena exclusive to
   another program and offloaded programs; reset fd_array_cnt after the
   load; bind it from bpf_program__clone() as well, so veristat loads
   what bpf_object__load() loads. (BPF CI)
 * Stop bpf_program__clone() from passing the fd_array fill index of the
   object as fd_array_cnt, and rename the index so that it no longer
   reads like the uapi field, as a fix patch with a selftest: slot 0
   holds no fd, so every clone from an object with module kfuncs failed.
 * Skip the __arena and __nullable member tests when the module BTF
   carries no type tags, as with a GCC build. (BPF CI)
 * Initialize map_ids in the autobind test for GCC's
   -Wmaybe-uninitialized. (BPF CI)
 * Note in the libbpf commit log that every program of an object with an
   arena now needs the JIT and CAP_PERFMON.
 * Fix the description of the store failure test. (BPF CI)


Kumar Kartikeya Dwivedi (16):
  bpf: Check exclusive maps once the program digest is final
  selftests/bpf: Bind an exclusive map through a continuous fd_array
  libbpf: Keep the fd_array fill index out of bpf_program__clone()
  selftests/bpf: Clone a program that calls a module kfunc
  bpf: Add the __arena and __nullable BTF type tags
  bpf: Recognize __nullable on pointer members of kernel structs
  bpf: Turn loads of __arena pointer members into arena pointers
  selftests/bpf: Test __nullable pointer members
  selftests/bpf: Test __arena pointer members
  selftests/bpf: Move the no-arena tests out of objects with an arena
    map
  libbpf: Bind the arena of an object to every program in it
  selftests/bpf: Test arena binding by libbpf
  bpf: Set up the arena base only in functions that use it
  libbpf: Render the arena type tag with its address space
  selftests/bpf: Test the address space rendering of the arena type tag
  selftests/bpf: Test an arena kfunc argument passed from a subprogram

 arch/arm64/net/bpf_jit_comp.c                 |   6 +-
 arch/loongarch/net/bpf_jit.c                  |   6 +-
 arch/powerpc/net/bpf_jit_comp.c               |   6 +-
 arch/riscv/net/bpf_jit_core.c                 |   6 +-
 arch/s390/net/bpf_jit_comp.c                  |   7 +-
 arch/x86/net/bpf_jit_comp.c                   |  14 +-
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_compiler_types.h            |  21 ++
 include/linux/bpf_verifier.h                  |   8 +
 include/linux/filter.h                        |  13 ++
 kernel/bpf/btf.c                              |  48 ++++-
 kernel/bpf/core.c                             |  57 +++++
 kernel/bpf/fixups.c                           |  67 +++++-
 kernel/bpf/verifier.c                         | 148 ++++++++++---
 tools/lib/bpf/btf_dump.c                      |   3 +
 tools/lib/bpf/features.c                      |  82 ++++++++
 tools/lib/bpf/libbpf.c                        |  85 +++++++-
 tools/lib/bpf/libbpf_internal.h               |   4 +
 .../selftests/bpf/prog_tests/btf_dump.c       |  16 +-
 .../bpf/prog_tests/clone_module_kfunc.c       |  30 +++
 .../selftests/bpf/prog_tests/map_excl.c       |  37 ++++
 .../bpf/prog_tests/test_struct_ops_arena.c    | 195 ++++++++++++++++++
 .../bpf/prog_tests/test_struct_ops_nullable.c |  62 ++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../testing/selftests/bpf/progs/arena_kfunc.c |  47 ++++-
 .../selftests/bpf/progs/arena_noarena.c       |  39 ++++
 tools/testing/selftests/bpf/progs/map_excl.c  |   3 +-
 .../bpf/progs/struct_ops_arena_autobind.c     |  64 ++++++
 .../bpf/progs/struct_ops_arena_member.c       | 109 ++++++++++
 .../struct_ops_arena_member_fail__mismatch.c  |  45 ++++
 ...ruct_ops_arena_member_fail__mismatch_mem.c |  54 +++++
 .../struct_ops_arena_member_fail__no_arena.c  |  24 +++
 .../struct_ops_arena_member_fail__union.c     |  34 +++
 .../struct_ops_arena_member_fail__write.c     |  36 ++++
 .../struct_ops_arena_member_fail__xchg.c      |  40 ++++
 .../progs/struct_ops_arena_member_render.c    |  85 ++++++++
 .../selftests/bpf/progs/struct_ops_nullable.c |  82 ++++++++
 .../bpf/progs/struct_ops_nullable_fail.c      |  28 +++
 .../progs/struct_ops_nullable_fail__percpu.c  |  28 +++
 .../progs/struct_ops_nullable_probed__plain.c |  26 +++
 .../struct_ops_nullable_probed__scalar.c      |  26 +++
 .../struct_ops_nullable_probed__untrusted.c   |  45 ++++
 .../bpf/progs/verifier_arena_scalar.c         |  13 --
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  67 ++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  74 +++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   2 +
 tools/testing/selftests/bpf/testing_helpers.c |  45 ++++
 tools/testing/selftests/bpf/testing_helpers.h |   7 +
 48 files changed, 1870 insertions(+), 78 deletions(-)
 create mode 100644 include/linux/bpf_compiler_types.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_noarena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__no_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__union.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__write.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__xchg.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__percpu.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__plain.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_probed__untrusted.c


base-commit: 25bb03f0a47b622b9025a1558bf2095ec1f55d26
-- 
2.53.0-Meta

