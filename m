Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FF83CE4A2;
	Wed, 20 May 2026 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779321057; cv=none; b=kp2xZhy+Ci/KVLwdUofZrHa2sPc1M/tigX6ul8c7j3Spu6BP8Lf3PZKdHkpy4mbeDh3v4abVTmterktv2IS8Mg9yQ64k1cDt1Q5OhslTs3Kgu/lxTmR4M1fwrKMgUO3ZiKLZ7RSCbrFCObg//pEihboc86B3Q07VbqjooO+YJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779321057; c=relaxed/simple;
	bh=iBc6dJpTypdxERnXklxyWkWOcBA7VoFDNMoZazcKBHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbG0wkLM/S7DQ8DdyrFOntQzZLZTUmTIcgqcx8ChPAVyK3xi02er+5nHKHbNw9xNrjn88b8zRjMMx6gCPW4B43B7hQ7CX7xYRg0NajBex41qzjRlFJ2Ten1GZOEirupe+VMkHmy1pZXteQxBgz+jymAdju0PH8UlsseVdPESScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2R1m7zR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2R1m7zR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8111F000E9;
	Wed, 20 May 2026 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779321053;
	bh=w+8GIsH7FJtbJmH25aCxZ9OJv0REBwu5JFNBuaItB8Q=;
	h=From:To:Cc:Subject:Date;
	b=c2R1m7zRWY9So0PUn+lD7Z1A6RPY6CVB7ZNl3Wuw1NcuHLn++W8wu1UaPMU09kEns
	 2O2LKxHI//fhmECvEaaBs/u1XpUVEccAzTYx6IFN/rd3MZMkNKoDUxOFHRFQRBZIFw
	 1RrJ9JIWmkuQiRqAz0iK6LCgSZ7Aebzr7fGrq8Sx+OqCHcc3vJmva6FNos60gLwy9/
	 d5TvKNly+d5UwCZAcmu+iy5Fd/uxKlHDnNRl/ptS5cBARJWo+5Sy4W38YmDbQ/qwsR
	 b4l3vns3Ee7jeQkEFsJ4eBJG8OM9uXbV6CvJBMDebDVDxCFFfS5AU7LYKqBEeWjejr
	 2EAkqPoyMhssQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v3 sched_ext/for-7.2] bpf/arena: Direct kernel-side access
Date: Wed, 20 May 2026 13:50:44 -1000
Message-ID: <20260520235052.4180316-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This makes BPF arena memory directly dereferenceable from kernel code
(struct_ops callbacks, kfuncs). Each arena gets a per-arena scratch page
that an arch fault hook installs into empty PTEs on kernel-side faults,
after KFENCE. The faulting instruction retries and the violation is reported
through the program's BPF stream.

v3:
- Patch 1: rename ptep_try_install() to ptep_try_set(). Tighten kerneldoc
  for kernel-PTE use. (David Hildenbrand, Alexei)
- Patch 2: apply_range_clear_cb() uses ptep_get_and_clear() so the install
  and clear sides race through atomic accessors. (David)

v2: https://lore.kernel.org/r/20260517211232.1670594-1-tj@kernel.org
v1 (RFC): https://lore.kernel.org/r/20260427105109.2554518-1-tj@kernel.org

Motivation
----------

sched_ext's ops_cid.set_cmask() hands the BPF scheduler a struct scx_cmask
*. The kernel translates a kernel cpumask to a cmask, but it had no way to
write into the arena, so the cmask lived in kernel memory and was passed as
a trusted pointer. BPF cmask helpers all operate on arena cmasks though, so
the BPF side had to word-by-word probe-read the kernel cmask into an arena
cmask via cmask_copy_from_kernel() before any helper could touch it. It
works, but is clumsy.

The shape isn't unique to set_cmask. Sub-scheduler support is on the way and
more sched_ext callbacks will want to pass structured data to BPF. Anywhere
a kfunc or struct_ops callback wants to hand a struct to a BPF program,
arena residence is the natural answer.

Approach
--------

Each arena gets a per-arena scratch page. Arenas stay sparsely mapped as
today - PTEs are populated only for allocated pages. A new arch fault hook
(bpf_arena_handle_page_fault) is wired into x86 page_fault_oops() and arm64
__do_kernel_fault(), after KFENCE. When a kernel-side access faults inside
an arena's kern_vm range, the helper walks the stack to find the BPF program
responsible, range-checks the fault address against prog->aux->arena, and
atomically installs the scratch page into the empty PTE via the new
ptep_try_set() wrapper. The kernel instruction retries and reads/writes the
scratch page. Free paths and map destruction treat scratch as non-owned.
Real allocation refuses to overwrite scratch (apply_range_set_cb returns
-EBUSY). A scratched address stays dead until map destroy, since its
presence means the BPF program has already malfunctioned.

The mechanism is default behavior - no UAPI flag.

What this preserves
-------------------

All the debugging properties of today's sparse-PTE design are preserved:

* BPF programs still fault on unmapped arena accesses. The fault semantics
  (instruction retry with rdst = 0) and the violation report through
  bpf_streams are unchanged for prog-side accesses.

* The first kernel-side touch of an unmapped address is reported via
  bpf_streams the same way as a prog-side fault, with the stack walk
  attributing it to the originating prog.

* User-side fault on a never-scratched address still lazy-allocates a real
  page (or returns SIGSEGV under BPF_F_SEGV_ON_FAULT). User-side fault on a
  scratched address SIGSEGVs.

What changes for the kernel-side caller is just that an unmapped deref no
longer oopses - it retries through the scratch page and emits a violation
report. The same shape today's BPF instruction faults have.

Patches 1-2 (atomic PTE install + arena scratch-page recovery)
--------------------------------------------------------------

  mm: Add ptep_try_set() for lockless empty-slot installs
  bpf: Recover arena kernel faults with scratch page

Patches 3-5 (helpers used by struct_ops registration)
-----------------------------------------------------

  bpf: Add sleepable variant of bpf_arena_alloc_pages for kernel callers
  bpf: Add bpf_struct_ops_for_each_prog()
  bpf/arena: Add bpf_arena_map_kern_vm_start() and bpf_prog_arena()

Patches 6-8 (sched_ext: arena auto-discovery, allocator, set_cmask)
-------------------------------------------------------------------

  sched_ext: Require an arena for cid-form schedulers
  sched_ext: Sub-allocator over kernel-claimed BPF arena pages
  sched_ext: Convert ops.set_cmask() to arena-resident cmask

Patch 6 reads each member prog's prog->aux->arena via bpf_prog_arena() and
requires the cid-form struct_ops to reference exactly one arena. Patch 7
builds a gen_pool sub-allocator inside that arena. Patch 8 converts
set_cmask() to write into arena memory; BPF dereferences via __arena like
any other arena struct, no probe-reads.

Base
----

sched_ext/for-7.2 (1136fb1213d1) with cmask-prep-v2.3 applied:
  https://lore.kernel.org/r/20260519075838.2706712-1-tj@kernel.org

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git arena-direct-v3

 Documentation/bpf/kfuncs.rst          |  14 +++
 arch/arm64/include/asm/pgtable.h      |   8 ++
 arch/arm64/mm/fault.c                 |  10 +-
 arch/x86/include/asm/pgtable.h        |   8 ++
 arch/x86/mm/fault.c                   |  12 +-
 include/linux/bpf.h                   |  14 +++
 include/linux/bpf_defs.h              |  11 ++
 include/linux/pgtable.h               |  26 ++++
 kernel/bpf/arena.c                    | 216 +++++++++++++++++++++++++++-------
 kernel/bpf/bpf_struct_ops.c           |  36 ++++++
 kernel/bpf/core.c                     |   5 +
 kernel/sched/build_policy.c           |   4 +
 kernel/sched/ext.c                    | 135 ++++++++++++++++++++-
 kernel/sched/ext_arena.c              | 127 ++++++++++++++++++++
 kernel/sched/ext_arena.h              |  18 +++
 kernel/sched/ext_cid.c                |  20 +---
 kernel/sched/ext_internal.h           |  23 +++-
 tools/sched_ext/include/scx/cid.bpf.h |  52 --------
 tools/sched_ext/scx_qmap.bpf.c        |   5 +-
 19 files changed, 616 insertions(+), 128 deletions(-)

Thanks.

--
tejun
