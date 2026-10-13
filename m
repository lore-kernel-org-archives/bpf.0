Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D99137A831
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879619; cv=none; b=Nogb0PXRhZVOZ+eUXFI0iYAZAjzsUVz0GcMU239Qz02Ch88d+DxRa4oQx20rlHgB/j0fm9HwIr6F2PXc2qtX1srfiTZ19kAEVb6cYeEXhWAXMjuwkloZ1Hy03eidRdzL+DthLyjpwPtLXRGTL5o1cqE1rBgx/ne6yYgFx73yQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879619; c=relaxed/simple;
	bh=YMQriRh1ch4lThe/Mdtv77vz7qgOtreBXaRK79lZTK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtPjVw8F/RtPLLDnXPYA9/eF80th0gWtOO7Ob0ZJUrbx63ROJUGifBqdlNtzXAoUXOB11HwHGZiChfTQRVxQcqLJ5+XxfNuDx+319/pSj9ivfGvbrAF8oAds7+dgBo/ID41ma379qKTvmH8gemP4H3WQkeD8wY/HyaUWUesvMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdvwkAuV; arc=none smtp.client-ip=74.125.231.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdvwkAuV"
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4bfec71901fso962726b6e.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879616; x=1792484416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6QeuCWN3GaTM3W5UEIwyrfGUSKufTptoJx6qvClJS88=;
        b=QdvwkAuV9GehhxaGE3+DrROttaVxD69i3OVwA18oZw1qJ71PQVM+JycEfQlxLhIhaF
         yFDXc3RukyA88lti80ccqRvWMeCHuErrUvntbY1tWDF5gSHP8Sku4/ZK1q9tMl8NGyN8
         NbLDv7NwOvVulT6hKwpuw7cbx59XxCuvL0LS4GugERR4N0g6Y2+vJrzssRwSbDGvztkS
         amzdSp0EpYSX/3Mc6u5MZW1fNG80SDVWv/nL+3LERqWixHgkPjJAwRlENYhI1GD+qAMo
         4NVogpWSGbajs71/qG1Pa4AvyPURuquxtC+hvcT4actgdv+MxyDx62ydlVM7SWvAWFwY
         z0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879616; x=1792484416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6QeuCWN3GaTM3W5UEIwyrfGUSKufTptoJx6qvClJS88=;
        b=le1tN6t6S75BBWTuOcjDvPtknMwOO2xx6FYeqwZKcF8A6GCu6zpypoQTOxyh1R8tM9
         Se2DQW7Cjdgp91n961XOkbKH91r4pOl2rleEEQK5E3Hp96Txv9+Da5l2d9H9Wn1ssx0K
         ScHZ5yM2siU5+Iuhd32K+AJVnLSMLYucqMm55gHp7U1SJftJnT5IeFNR+3LyZH0Mg6Wx
         gLmRqkditgwrQKPcZsVy3Kj603vC0+A5bvL0G5+XC2cVFfqbktrxIAYuzfjMtcXpWwng
         RHZ4LRS7whgCcY5+YGiuiETUZNySGJxVwb86v3z9xfqLDAv/3Pev6bUrCqZuMRg1RLJq
         wUcQ==
X-Gm-Message-State: AFq9FYL3xxCHL/JCUQbxgpD4pxbShe6MKgVkaOWBavgnzQRy2MwBHkjq
	1qBHu/5Oas/YbKtKPIKexICzhPX28UQVK7NPxSCXc+UTrA/YE72hGKSja2mc1Hszpu0=
X-Gm-Gg: AYBFou2Mkz5ioVUqN/A4Qdm7k+5AOPeTqGB1Dcj1Ggz8RjiRpDDeZWx/iMrBkKL85cU
	tu+/MRwt+IsnUPEsztsRevq2W4kGgAhhrOYZnYWu9bZ+cObtm5u2D05O6U2MWznjlQOWc2PRGnX
	fR2cNNd37Hq/oluUy28x9vkRZAXw9s0gFU9HB15hfCOG918bBHXZ0O11KHt+4eFjM5ohZZUT7qm
	SqwnvSEINgo9iDtJubkWnHEqES5sge9LY/o+MbrEGeHpC+nXDIozJjwme7FemLMfmyr3KAb39ct
	CStuBd9Lcd/NIceJOV2wxFt4tU8m6PzDl7dn84SbR/ByYO6NGSZKgSCrQsJ8s9nXA1BqA4XQgqD
	PrWJ7F414dzAEYsq8lQR2hn6rtGZwcQtOFfpD/ZXQWr/OMKxERQQGdvFeR95MPNG1tp65V/2l6z
	sf5j67/NF8Hl0mMxfa0omws85kgIc572hfnSTYKhHRCEJndilZaYkf4Lt83BwjdHGExzBtDyyWH
	rJRXiHn3Z4ekhEpUshgEjPBzGYEWOa92DThfDj7/tnuKGLndSVgz7SWKieBhGk36FCGYbq6glgB
	SIKO7g==
X-Received: by 2002:a05:6808:3384:b0:4c4:79b8:8ad0 with SMTP id 5614622812f47-50c51bb5f4fmr12871550b6e.11.1791879616101;
        Tue, 13 Oct 2026 01:20:16 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5e::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-518a72a6048sm8294455b6e.5.2026.10.13.01.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:20:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 00/13] Fix some arena paper cuts
Date: Tue, 13 Oct 2026 10:19:55 +0200
Message-ID: <20261013082012.1107446-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8659; h=from:subject; bh=YMQriRh1ch4lThe/Mdtv77vz7qgOtreBXaRK79lZTK0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevsy3kpf+88rLzNoLja0en9+jiF8pXKa8yCLEWmpbbrb3mt Ynmgo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOZGcXwT3fKNq/CnRPPc5wJXlk9J0 bztQjPwlunz1re9ty+fuo+OS2G/w4leSbBqlaLXx7bWqFgdEX86uTlNyZmsMVt41/Amztbnx8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Kernel code that shares arena memory with BPF programs runs into two
paper cuts, both visible in sched_ext's cid-form schedulers today.

A kernel struct cannot publish an arena pointer: a pointer member reaches
the program typed as a kernel pointer, so sched_ext hands out a plain u64
holding a pre-translated arena address and every program casts it before
use. __arena and __nullable become BTF type tags like __user and __rcu.
A load through an __arena member of a kernel struct yields PTR_TO_ARENA:
the member holds the kernel address and the fixup pass appends the
conversion to the arena pointer form that the struct_ops trampoline
applies to __arena arguments, with a NULL test for __nullable members.
A __nullable member on its own keeps PTR_MAYBE_NULL on trusted and RCU
pointers, where NULL would otherwise be assumed away. libbpf renders the
arena tag with its address space, so the member arrives in a program
built against vmlinux.h ready to use, without a cast.

A program only has an arena when one of its insns refers to the arena
map, yet the kernel hands programs arena pointers through struct_ops
arguments, tagged members and kfunc return values, and a struct_ops
callback that touches nothing but its arguments fails verification until
it refers to the arena artificially. libbpf binds the arena of an object
to every program loaded from it, through a continuous fd_array. So that
programs which never touch the arena pay nothing for it, the verifier
records which functions have insns that work with the arena base and the
JITs set it up only for those.

Tested with sched_ext for-next as well: a typed cmask member next to the
existing cmask_arena_addr in struct scx_enable_args passes the
enable_cmask selftest read straight from the member, without a cast and
without the asm volatile arena reference.

The series opens with a fix the review of v1 led to: bpf_program__clone()
passed the fd_array fill index of the object as fd_array_cnt, which made
every clone from an object with module kfuncs fail.

See commit logs for details.

Changelog:
----------
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

Kumar Kartikeya Dwivedi (13):
  libbpf: Keep the fd_array fill index out of bpf_program__clone()
  selftests/bpf: Clone a program that calls a module kfunc
  compiler_types: Add __arena and __nullable BTF type tag qualifiers
  bpf: Recognize __nullable on pointer members of kernel structs
  bpf: Turn loads of __arena pointer members into arena pointers
  selftests/bpf: Test __nullable pointer members
  selftests/bpf: Test __arena pointer members
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
 include/linux/bpf_verifier.h                  |  10 ++
 include/linux/compiler_types.h                |  10 ++
 include/linux/filter.h                        |  11 ++
 kernel/bpf/btf.c                              |  48 +++++-
 kernel/bpf/fixups.c                           |  51 ++++++-
 kernel/bpf/verifier.c                         |  75 ++++++++++
 tools/lib/bpf/btf_dump.c                      |   3 +
 tools/lib/bpf/features.c                      |  40 +++++
 tools/lib/bpf/libbpf.c                        |  76 ++++++++--
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/prog_tests/btf_dump.c       |  16 +-
 .../bpf/prog_tests/clone_module_kfunc.c       |  30 ++++
 .../bpf/prog_tests/test_struct_ops_arena.c    | 139 ++++++++++++++++++
 .../bpf/prog_tests/test_struct_ops_nullable.c |  68 +++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../testing/selftests/bpf/progs/arena_kfunc.c |  33 ++++-
 .../selftests/bpf/progs/arena_noarena.c       |  39 +++++
 .../bpf/progs/struct_ops_arena_autobind.c     |  64 ++++++++
 .../bpf/progs/struct_ops_arena_member.c       |  92 ++++++++++++
 .../struct_ops_arena_member_fail__load_acq.c  |  38 +++++
 .../struct_ops_arena_member_fail__mismatch.c  |  45 ++++++
 ...ruct_ops_arena_member_fail__mismatch_mem.c |  54 +++++++
 .../struct_ops_arena_member_fail__no_arena.c  |  23 +++
 .../struct_ops_arena_member_fail__union.c     |  34 +++++
 .../struct_ops_arena_member_fail__write.c     |  32 ++++
 .../progs/struct_ops_arena_member_render.c    |  82 +++++++++++
 .../selftests/bpf/progs/struct_ops_nullable.c |  45 ++++++
 .../bpf/progs/struct_ops_nullable_fail.c      |  28 ++++
 .../bpf/progs/verifier_arena_scalar.c         |  13 --
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  53 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  46 ++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   2 +
 39 files changed, 1300 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_noarena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__load_acq.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch_mem.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__no_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__union.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__write.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c


base-commit: 0d5e3fc78a6f2522e6339743b8e5ecc02351a9dd
-- 
2.53.0-Meta

