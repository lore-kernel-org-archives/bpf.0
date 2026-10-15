Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEB73EC82D
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107693; cv=none; b=vA1jVIX0DnzuOo9+2rZzbMi0E4R+tRq0eLgsLp4Z+asvAHlr84vqQfPCuT3Pg74mLGoRQYCD4V8aFZc0lFWQLPvT3SC+G2HRvaLD3FeHmkdrANyqsb5m//VBAw8lD4h2w7NZG5fg4yPvTcI9cj9nrMwhJG9voDWbYJtb2q+BKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107693; c=relaxed/simple;
	bh=mSUyXB5lb8soBxQE6lfplHMrPIjg84xn3xArOGQFrNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TF8jJvkRtOJW8edmHKGt0Zsh2dA9jAj2GIfn23+GemM6MPFYLL+8gIYQoXYzQsM9g8dAszW8NyZMTjBaXNqZLUdeU3SC8mVOVS27CMQY4NOHBPQbDXaZhintj52pZqmxd6/LU3EggA42WQxWQYELFerpeMhyN8OvIIcZSP26v38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdwifnC7; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdwifnC7"
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-49e545b61f6so624346fac.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107691; x=1792712491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wsPe87aj90B4dHojYMKxo9F6IkLZW262QszAsV8Dso8=;
        b=YdwifnC7/rdnWp6KrghT949cvX9haEU0rhTBgDFwg1sgIJlDPHN1R7UYr8bI8ekK7X
         pq91Xmu9rQQuARDiYZ3JCD/4xxCxYiup5l3ueEO5vJG8LxPyXPEjTnk/O0nNfyUT5RGa
         Dd3/J4qgZalGacELRBUE7yPDybqzjW498oiz8pCDuIlwIMYSFSI+lOQGPRovK1wiz5qE
         hJXMThd/NfgrmEI5sSiJfKo2w/bMWX6FKF61/rFqJ1BvYaNBvXGz0kPv7z9NDtJwebna
         fzBMUgsaK11xg2b2SwR4fY/H3gLC2XNq3hyFAIZy9fKJG3d4puA53IEYFFH56Bgl8KW6
         kjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107691; x=1792712491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wsPe87aj90B4dHojYMKxo9F6IkLZW262QszAsV8Dso8=;
        b=eL3lQsU+nn0o/qtaWkiorpRxUktX25E8vkf9KgF1vmyUXfJ0EVgSQYBTM55+vgE3+w
         evQhNnKGRvOT55SGeSeywqQMIXAXiUnNlyHLsUU9xFM56VeK7DmsVRdI9EHggEH9qNhi
         ZoBboeUeS/462t/604R/TV8VxfIXCECV0fRtyIQALGjw2AKaH/RsKl2VG7PRB/w2RTFJ
         wYykBYGAtjIPi35r/UikygyCwhCTzc+2s4PVvwVH7j4lj+uw/0VDJ3xjbQYHvFSXgrq2
         QzzjHeJLyE5GjDqj0SqZ+trum8q7b4lM+L2qHok5bKVj+YbGW/xM0LcPoZCjrfDSTwEL
         /pVw==
X-Gm-Message-State: AFq9FYK2YUyDAKeUS8ON3P4ZgwetugJc5gmQmrPhjesywnhs7Vh8+AOc
	KGXF77U99GqeJZF6YMkyEMPLHe9+BujZCyBbVi/cEXhmPzUXfNQqFTACnfZMECMo5gQ=
X-Gm-Gg: AYBFou1n0oyZlfhF+SJAVnvw+GK88RCZffeV0s/o104EdRehQP/d6QeQkVxrJOENJ7n
	mQvinYa1zrraAKVMNlo+trHdyCY52vA8NnUEnXY3IFJwBYWXggCE+ThzmZEciYIvJSutPIxKF1t
	FsPXDc2QW4MVfz4vAdq9suVtAlUrHiDskEMjmCW7XL/Vugphit40ppYGHrYafeYahJ4CWUqY3dl
	11nQoCOKjfWDwqulSfWiPypTinmkCfw5O9ishXBFZaS9sGzItZBLPBdaTB0V8TiaIDo7OfwdovZ
	hZywT2KUo8I75FXjV50yqpaa/1ps9/CEF4UZknPIwxjpIGEia+UWNrzJesbImmXYy89gSXDynqZ
	zfL8B5gfsgRGuPlxWoMoGz0OUhOOB4/7MsPQ4urllQKFjSNU8Fb8J3ZON0BR25jC3XKRjd/vcu8
	3ZM4fipikbz5Vzz/tZaR+NrAXdCAtWsBEG8pEgKeF0liIuUGDQDVwvDu1T5tkDFcv6QEDH4GU1k
	0+25ZvKwnc/Hkc3XGUW1zQ8w7Iow1rr7UqKNmi+25fdhX+v5hLcxB2tWsMNT2Do7cC7jvTWUc5f
	6aZfmg==
X-Received: by 2002:a05:6871:c643:20b0:4a6:f610:87eb with SMTP id 586e51a60fabf-4a6f610af7amr3333529fac.3.1792107690571;
        Thu, 15 Oct 2026 16:41:30 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b5b4278sm331012fac.6.2026.10.15.16.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:41:29 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 00/15] Fix some arena paper cuts
Date: Fri, 16 Oct 2026 01:41:06 +0200
Message-ID: <20261015234125.3152346-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11116; h=from:subject; bh=mSUyXB5lb8soBxQE6lfplHMrPIjg84xn3xArOGQFrNw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3KvyX2/XirfObZlrJaux04db2pjDwDXXZMuFMxUTmCW4 95Z2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIXrjEy9Acuv67e+Gqp2N1tl9wflT pd57+8wHtJ4/dtm6oqgru6XRgZ7sewyi30SSvdra6uO0Nunm6QoevT+6pzrtfv/Osl55nPBQA=
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
A __nullable member on its own yields PTR_MAYBE_NULL, whatever the
pointer it is read through, and the program checks it. libbpf renders the
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

The series opens with two fixes the reviews led to: the verifier checked
an exclusive map bound through a continuous fd_array against a program
digest it had not computed yet, and bpf_program__clone() passed the
fd_array fill index of the object as fd_array_cnt, which made every
clone from an object with module kfuncs fail.

See commit logs for details.

Changelog:
----------
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

Kumar Kartikeya Dwivedi (15):
  bpf: Compute the program digest before resolving the fd_array
  selftests/bpf: Bind an exclusive map through a continuous fd_array
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
 kernel/bpf/btf.c                              |  51 +++++-
 kernel/bpf/fixups.c                           |  52 +++++-
 kernel/bpf/verifier.c                         |  92 +++++++++--
 tools/lib/bpf/btf_dump.c                      |   3 +
 tools/lib/bpf/features.c                      |  40 +++++
 tools/lib/bpf/libbpf.c                        |  76 +++++++--
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/prog_tests/btf_dump.c       |  16 +-
 .../bpf/prog_tests/clone_module_kfunc.c       |  30 ++++
 .../selftests/bpf/prog_tests/map_excl.c       |  35 ++++
 .../bpf/prog_tests/test_struct_ops_arena.c    | 152 ++++++++++++++++++
 .../bpf/prog_tests/test_struct_ops_nullable.c |  60 +++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../testing/selftests/bpf/progs/arena_kfunc.c |  33 +++-
 .../selftests/bpf/progs/arena_noarena.c       |  39 +++++
 tools/testing/selftests/bpf/progs/map_excl.c  |   3 +-
 .../bpf/progs/struct_ops_arena_autobind.c     |  64 ++++++++
 .../bpf/progs/struct_ops_arena_member.c       |  99 ++++++++++++
 .../struct_ops_arena_member_fail__load_acq.c  |  39 +++++
 .../struct_ops_arena_member_fail__mismatch.c  |  45 ++++++
 ...ruct_ops_arena_member_fail__mismatch_mem.c |  54 +++++++
 .../struct_ops_arena_member_fail__no_arena.c  |  24 +++
 .../struct_ops_arena_member_fail__union.c     |  34 ++++
 .../struct_ops_arena_member_fail__write.c     |  32 ++++
 .../progs/struct_ops_arena_member_render.c    |  82 ++++++++++
 .../selftests/bpf/progs/struct_ops_nullable.c |  60 +++++++
 .../bpf/progs/struct_ops_nullable_fail.c      |  28 ++++
 .../progs/struct_ops_nullable_fail__percpu.c  |  28 ++++
 .../progs/struct_ops_nullable_fail__plain.c   |  26 +++
 .../progs/struct_ops_nullable_fail__scalar.c  |  26 +++
 .../bpf/progs/verifier_arena_scalar.c         |  13 --
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  67 ++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  70 ++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   2 +
 tools/testing/selftests/bpf/testing_helpers.c |  43 +++++
 tools/testing/selftests/bpf/testing_helpers.h |   6 +
 46 files changed, 1542 insertions(+), 64 deletions(-)
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
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__percpu.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__plain.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail__scalar.c


base-commit: 653b8f14fdda385bd7c5b786f8dfdcc3e5599e27
-- 
2.53.0-Meta

