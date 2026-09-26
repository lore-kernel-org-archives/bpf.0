Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F62C3757
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790465709; cv=none; b=JcHPNs2w45NBYoZO/a+FFDFJOFQihoFMlBVfBIK2ZTtugGzf1dlhepTt5gueLvFDk+smGNTBbGZFF+wq9IyK6V+n7GeiqCb6CIobH9cgZkWJT35qlb/CWmcJYbg1VQpJY3rY20m8RRx4tFNEicjEIJ648Tn17COE6cUKVtRAJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790465709; c=relaxed/simple;
	bh=M3g6Q2L32w5Jw/1Ub30XWRPtCQxAkBO+RZ1r+3ojuks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBweyWgYj6aKVpxNVVGgccZF5HRlzC5JX5Ry2oylZXLCBAVrktAVJcJliY2vfS8ysJRWJsMR6rBLvjv1PcgZSEVm4Zd1cLp3yyip5RlHQZIVuv02sRlCkluzVdAUmTA2TxI8xy+qUJoDMf+rz08o5bJRoa9g8sNrJI6DoN9KINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rls08zHm; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rls08zHm"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ff96a9784so2776645e9.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790465705; x=1791070505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eQFB663arrUbiCufghojiOkNE+CFTWnXEdeJhsTEPyI=;
        b=Rls08zHm0kDrsvMUFIuu6nheg/CaFFhLnKLrzmB9XFoU4IJv3TZ85d1Mh4N9ovFv1W
         3FKZ3Xm7mlJQy4b7+5eOSfDhor1OWoPTAdcYFbFHZsotyCS3o602F13W+z0y+cmz3Pc7
         TpjxoDNmuEV6Pgd2vVK/pDvwSVvySFeNV+DWF+ZLx8g2iY0euRsTmWuHgCvzxx89FXJf
         ODZCJU1814UHlkAyzrAl04T+4oM2RFyQhFBdjGmQZqQlvQMv7IFLnNq6I4/YQWrxy28G
         vjsHDJhS6L143nchXZ1YxaOb8k07EDmVTESyqooSWkP72x5MYxKhC93XpVC11tW5OXzG
         oMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790465705; x=1791070505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQFB663arrUbiCufghojiOkNE+CFTWnXEdeJhsTEPyI=;
        b=0MfZN5KFDnuUzdFdAGtZKuX869/KGuK06ma2+xqe3uZlCSEkr7MYhQtgkkTQVFXgDi
         M9MLgAWhaKxL2Ym2eqs+VUt9sXIbKUzn+gDMBJo3bY6kbSq7ZbvbYaBfdYw/YMnCdEc6
         YM856nvYAmZugvqTnXHonD28D7bmhznaBM3QAOSXYJ+IlO+oKmGoLZEwg7nu8sBPa3bK
         lUuYyYhW3SstonMtFN/WzaxQscFnSu1LfpWZdLWWsVezEhvcpElwtr4GTY+HilKpZ62V
         kaE8yPCOe7Vg3hMC+p0Kv0wiOZ1Xgt+0aWVvIcYmK4rRmxk7kghBAt95QYsYeG0ITD4u
         GEwQ==
X-Gm-Message-State: AFuF++lw8sE55Kzz6PxKPfhkvblqM++7h2zPybnDQw97/MDy2f1BcQv+
	F+svfaTSN72Ie0LzpMBy+dRponm11aTcGDpKZK5ndNF3hXRttvg+mumvJrTcNJCB
X-Gm-Gg: AYBFou3LnHX5LZkb3P81FgDKgyuaKNL+UKrDC5FIpbyWs4VTszizu3Vy4Q0e1rZIajW
	5t26jsufs/i0498HVkkkAuvsHxEgcr30XqYNxgS56YoKfjtecJtv9SiUxwzj5B1HWQ1sRLAnS0f
	/uSUUmvWNGYbm2CW0OB5KaCPaal4guHgeJFWbzrZ+cwUPwHCta4xvIFjjm8tpJ763teUSU+hY2o
	+YQduxpmbNGS0HSVAgIXasBQ2dYGWEQdRNlWBixj8zID/kqjIisFbkxPRKbaxQvTTKoJ1rbEIvI
	SB2Xk6gaH/Dx0i3X7GUany2Ql9kF6CphApNQ76MIHAVpLeHz3fJpayj5glgjEccw62c2y/GIkWs
	3xlrT0qEojheC3FJIIfy1JqHVKJdCqDREwHIknZ5W73DVDK5VzMzD7iB/pwc5GGRZDpeAEPU5zW
	CKTmSN0QJ3qF5i0w4hyybLW3m7zXJJovehdkjSZ/t+16aRAsgXogVMXdzOClWiiNu9z2rIVzKrw
	Ld1YTwjLwR1J1IPXN1lQjqK6BoIIacvyr3LdYlGzCzrtSYGtTMPkeoYstIKz9YaZStCObelrALn
	kEHgl7dHmoCDK9pXHFRkZhWE/U+Ci1qQAQT2PA==
X-Received: by 2002:a05:600c:83ce:b0:49f:ffa2:1c67 with SMTP id 5b1f17b1804b1-49fffa222demr18540435e9.7.1790465705073;
        Sat, 26 Sep 2026 16:35:05 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00179c729sm19481685e9.15.2026.09.26.16.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 16:35:04 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 00/16] BPF typed arenas
Date: Sun, 27 Sep 2026 01:34:38 +0200
Message-ID: <20260926233503.3114147-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13802; i=memxor@gmail.com; h=from:subject; bh=M3g6Q2L32w5Jw/1Ub30XWRPtCQxAkBO+RZ1r+3ojuks=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtHWExGyot5Sq5zHnc/67w211ab26Lh0ZvXnpPzztnpM a+SuGDfUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkI72P4n2ElvkDqxSan+uxT 6Xxx+0+VHzBX/LhMn2H+y9YHjUVq5YwM8x0uq3V4CnJ8S2W+cPUuc3LHxcKS1NfWBZmd7idb6x5 wAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

NOTE: Patch marked as RFC, since this not ready for proper review. For
now, reviewers are advised to ignore concrete details, but instead focus
on the general approach, design decisions, and tradeoffs made in the
sandboxing approach to support objects that can hold trusted kernel objects.

This set adds typed arenas: kernel-only memory next to an arena map that
holds objects of a program's own struct types with special fields, kptrs
for now, at fixed slots. Programs reach the objects through native
pointers, the verifier trusts the special fields in them, and it does not
track the lifetime of an object, because the memory behind a typed arena
pointer is always valid.

Today, a struct with a kptr cannot be placed in arena memory.
The arena is mapped into user space, and access arbitrarily by the BPF
program with no constraints, which can write anything into it, so the
verifier cannot trust a pointer it loads from arena memory, and a
reference kept in such a field could be overwritten, duplicated or
dropped.

A program that builds its data structures in the arena and wants to
attach a task, a socket or an allocated object to a node keeps the
reference in a separate map and looks it up by key every time.
sched-ext has introduced id based indirection for task structs to work
around similar limitations.

The other way to get typed objects with kptrs, bpf_obj_new(), spills the
lifetime of every object into the static analysis: the pointer is owned
by whoever holds it, it must be dropped or moved into a map, a list or
an rbtree before the program exits, sharing it needs bpf_refcount, and
reading a shared object needs RCU or a lock. Every program that touches
such an object is verified against those rules, and data structures
built from allocated objects are written around them. This has proven
pretty inflexible in practice, and requires kernel changes for each new
data structure.

A typed arena is arena memory that is only mapped in the kernel, so that
only the program writes it and under the verifier's rules, and that is
always valid: every address in it resolves to an object of its struct,
allocated or not. A pointer to a typed arena object therefore does not
dangle, does not have to be released and does not have to be checked for
being alive, so there is no ownership, no reference and no RCU state for
the verifier to track.

The verifier still has to ensure is that a value used as a pointer to
struct T points at the start of an object of T. It does not do that by
tracking where the value came from, but by construction: a new
instruction, typed_arena_cast, masks any 64-bit value into T's slice of
the typed arena and rounds it to an object boundary. The instruction
lowers to a mask with an immediate and an add of the slice's base, four
instructions, with no branch and no bounds check, and the result cannot
point outside the slice or into the middle of an object. Any value goes
through it, a pointer loaded from the raw arena that user space
corrupted, an integer, a pointer of another struct, and comes out as a
trusted pointer to a whole object. Pointers are stored as they are, in
the raw arena, in maps, on the stack or in typed objects; only their use
as an address is sanitized.

The typed arena region is sparsely mapped, and populated on demand at
runtime using new allocation functions mirroring arena allocation
kfuncs. In case of faults, scratch pages are used to supply underlying
memory to allow such objects to be accessed freely from both the BPF
program and the kernel without issues.

Layout
------

Each arena map reserves a 4 GiB kernel-only region ahead of its
user-mappable window, which user space cannot map. A new mm helper
aligns the vm area to the region, so that every power-of-two slice in it
is aligned to its own size and the cast needs only a mask. A struct with
special fields gets one slice per program BTF and type in the program's
arena map, registered at program load when the verifier first meets the
type in a cast, in a load from a typed pointer field or in an
allocation.  The slice's size comes from a "typed_arena_size:<size>"
declaration tag on the struct, 128 MiB by default, a power of two of at
least a page and at most 2 GiB. Objects sit at slots of the struct's
size rounded up to a power of two. The unit of backing is a chunk, the
larger of a slot and a page: an object larger than a page is one
contiguous block, and an object never spans two allocations. The page
tables of a slice are populated at registration and charged to the map,
together with two bitmaps, because a fault on an unbacked typed page is
recovered in atomic context.

A chunk nobody allocated reads as zeroed dummy objects: a fault on it
maps in the slice's scratch chunk, one per slice, at the same position,
so that a scalar field of one dummy object does not alias another. Two
kfuncs back a range with real objects and release it, in page counts
like the raw arena kfuncs, rounded up to whole chunks, with the granted
count written back:

  void *bpf_typed_arena_alloc_pages(void *map, __u64 type_id, void *addr,
                                    __u32 *page_cnt, int node_id);
  void bpf_typed_arena_free_pages(void *map, __u64 type_id, void *ptr,
                                  __u32 page_cnt);

A release is deferred behind an RCU and an RCU-tasks-trace grace period,
so that every invocation that started before it keeps valid objects, and
a range is released once, since a second release queued behind the first
would take the range away from its next owner. The kptrs of released
objects are dropped once the chunk is unmapped. A pointer to a released
object that a program kept still names a whole object of the type, of
whoever claims the chunk next; that is program logic, like a stale index
into an array, not a safety problem.

Access
------

A pointer member of a typed struct whose pointee is itself a typed struct
is a typed pointer field, found from BTF alone, without annotation. The
verifier lets nothing but a trusted pointer to the pointee at offset
zero, or the constant 0, be stored into it, the memory is kernel-only,
and a reused chunk comes back zeroed, so a load from the field is
trusted to be an object or 0 without a cast. The loaded pointer is
canonicalized in place only where it is used as an address; a
comparison, a copy or a store of it as a value sees the raw value, so a
list is walked with plain loads and ends on the usual test against NULL.
A program that uses the value without checking for 0 lands on object 0
of the slice, as a cast of 0 would. Whether to check is left to the
program, since nothing it can do with the value reaches outside the
slice; a maybe-NULL type that must be checked before every use would
cost a check on every hop that the sanitization makes unnecessary.

Scalar fields are loaded and stored natively, atomics included, with no
probe mode and no exception table entry. kptr fields go through
bpf_kptr_xchg(), as in map values.

Compiler Changes
----------------

Programs do not write the cast. Behind the typed-arena target feature,
Clang inserts it where a pointer to a struct with special fields is used
as an address, and where a value of another type is converted to such a
pointer, which is where a value loaded from the raw arena or returned by
the allocator becomes a typed pointer. The same struct also lives in
allocated objects, map values and on the stack, and the compiler cannot
tell which, so the verifier decides per path what a cast costs: a value
it does not trust is sanitized, a pointer it already trusts is copied,
and a program that only uses bpf_obj_new() objects of the struct loads
as before. The builtin, __builtin_bpf_typed_arena_cast(), remains for
turning a scalar or a raw arena pointer into a typed pointer on purpose.
The feature defines __BPF_FEATURE_TYPED_ARENA_CAST; libbpf relocates the
instruction and provides bpf_typed_arena_cast(); the selftests probe for
the feature and are skipped without it.

The compiler changes are on the typed-arena branch of
https://github.com/kkdwvd/llvm-project, two commits on top of main:

  4f5f6b0db95c BPF: Add the typed_arena_cast builtin and instruction
  cb29a13b73bd BPF: Insert typed_arena_cast at uses of typed record pointers

Notes
-----

 * BPF kptrs are the only special fields a typed arena object may have. Timers,
   workqueues, task work and RCU heads keep kernel state that a release or
   a fault could pull from under a kfunc, so they are refused inline for now,
   this will be made to work in subsequent revisions.

   Pages can be unmapped while a kernel is operating on an object
   embedded inline a typed arena object sitting in a page that was
   requested to be freed. Some protocol to signal when operating on such
   objects from the kernel side will be necessary to ensure that new
   operations cannot begin on such fields, and whether existing
   operations are finished.

   Spin locks, lists, rbtrees, etc. are unnecessary to support as
   special fields, since they have their own analogues in arenas.

 * A slot is a power of two, so an object is padded by up to half its slot.
   This is the trade the slab allocator makes for its size classes, and it
   is what keeps the cast at a mask and an add. Denser packing can be added
   behind the same interface, since programs never see the slot, but it
   is likely not worth it.
 * Slices are fixed at registration, neither grown nor moved, and a
   map's slices share its 4 GiB region. Objects larger than 4 MiB are
   refused.
 * The scratch chunk is shared by every unallocated chunk of a slice, so
   a store through a stray pointer is visible through every unallocated
   chunk, and a kptr stored there is dropped with the map.
 * The sanitizing sequence runs on every value that enters from
   untrusted memory and, for now, before every use of a loaded typed
   pointer as an address.
 * The page tables of a slice cost 8 bytes per page, 256 KiB for the
   default size, charged to the map.
 * Nothing in the set is UAPI: the kfuncs, the declaration tag and the
   instruction encoding may change.
 * Only x86-64 has been tested. No JIT changes are needed: the cast is
   lowered by the verifier, accesses are native loads and stores, and
   the fault path lives in the arena map.

Follow-ups
----------

 * Elide the sanitization on loads through a typed pointer that nothing
   writes to, with a probed load, so that a chain of reads costs nothing
   beyond the loads.

Patch 1 adds an mm helper for an aligned sparse vm area. Patches 2 and 3
add the region, the registry and the scratch backing. Patches 4 to 8 add
the cast instruction, object access, special fields, typed pointer fields
and their canonicalization at use. Patch 9 adds the kfuncs and patch 10
the free cast on trusted pointers. Patch 11 adds the libbpf support, patch
12 the selftests' compiler probe, and patches 13 to 16 the selftests.

Kumar Kartikeya Dwivedi (16):
  mm/vmalloc: Add get_vm_area_align()
  bpf: Introduce BPF typed arenas
  bpf: Back typed arena chunks with scratch on demand
  bpf: Add the typed_arena_cast instruction
  bpf: Allow scalar and atomic access to typed arena objects
  bpf: Support special fields in typed arena objects
  bpf: Trust typed pointer fields of typed arena objects
  bpf: Canonicalize loaded typed arena pointers where they are used
  bpf: Add typed arena page allocation and release kfuncs
  bpf: Let typed_arena_cast copy pointers the verifier already trusts
  libbpf: Support the typed_arena_cast instruction
  selftests/bpf: Build BPF objects with compiler-inserted typed arena
    casts
  selftests/bpf: Test typed arena casts and registration
  selftests/bpf: Test typed arena object access, kptrs and typed pointer
    fields
  selftests/bpf: Test typed arena page allocation and release
  selftests/bpf: Exercise typed arenas at run time

 include/linux/bpf.h                           |   91 ++
 include/linux/bpf_verifier.h                  |   35 +
 include/linux/vmalloc.h                       |    2 +
 include/uapi/linux/bpf.h                      |    6 +
 kernel/bpf/arena.c                            |  772 +++++++++-
 kernel/bpf/backtrack.c                        |    8 +-
 kernel/bpf/btf.c                              |  140 +-
 kernel/bpf/core.c                             |    2 +
 kernel/bpf/disasm.c                           |    9 +
 kernel/bpf/fixups.c                           |   64 +
 kernel/bpf/log.c                              |    6 +-
 kernel/bpf/syscall.c                          |    3 +
 kernel/bpf/verifier.c                         |  498 ++++++-
 mm/vmalloc.c                                  |   19 +
 tools/include/uapi/linux/bpf.h                |    6 +
 tools/lib/bpf/bpf_helpers.h                   |   13 +
 tools/lib/bpf/relo_core.c                     |   19 +-
 tools/testing/selftests/bpf/Makefile          |   13 +-
 .../testing/selftests/bpf/bpf_experimental.h  |   18 +
 .../selftests/bpf/prog_tests/typed_arena.c    |  489 +++++++
 .../selftests/bpf/prog_tests/verifier.c       |   22 +
 .../testing/selftests/bpf/progs/typed_arena.c |  354 +++++
 .../bpf/progs/verifier_typed_arena.c          | 1304 +++++++++++++++++
 23 files changed, 3852 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/typed_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/typed_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_typed_arena.c


base-commit: ea9358e1270ab2c3ba6f36bd9bdda68617665516
-- 
2.53.0

