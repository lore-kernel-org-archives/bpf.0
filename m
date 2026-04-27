Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20753B38AC;
	Mon, 27 Apr 2026 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287070; cv=none; b=k/2/OBKXhtJz9a2zeWdVqaEQc4vX58KUZIiBOrfw56B7MqUZQ+7ohTlSk8adXhMQvxWB+avtJGpCk5JIGQeXzNkUNQ9Zmbt3NQJsUqAAOCw6CdRT2l8RT8aJTWdxsibc79qkvAUtqDsefYBta7lOMJ3B21Mbznk5sW4FTcU1bdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287070; c=relaxed/simple;
	bh=99XKFLtWM2T4TYzeWHUUeKdHucY+WGC/VJ62r4sznhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OoidNaWoZOR89nUTaA9ZsidvdRD7sqATEkYVGfkhSxLH+5PXCfht7nFPIJsA2TRIFAkQdHfGHRiDA2wqX/l9qcBgXg7Q42cUBQ9ymWKf/ugcDFeAnkFQqJLz93Z4g+aUc5dp4HaDfb1ZEfDr5rJaJQ0U0OYX4UKxT3JvV4Hr5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLOZXxs9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLOZXxs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A8EC2BCB4;
	Mon, 27 Apr 2026 10:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777287070;
	bh=99XKFLtWM2T4TYzeWHUUeKdHucY+WGC/VJ62r4sznhk=;
	h=From:To:Cc:Subject:Date:From;
	b=uLOZXxs9H0y6f0n+RE1EbI2U46Y7ybySYf4q0YHwZDWr7dfFJ5PHk/oAAFySN4Qhd
	 ZA3kpIIPCDHu88Z9einku0iXLT7YQjOu2XtbEwdzE7JEviWe4pkcKzwpyZo4UgHMjM
	 7rIXTsfTodu3xx8eCMBklN2Qdj1HqaHh6I/XQo/bAKKFu9suMtwrMMZXQTxIRz3K0j
	 bhskxz8ask+gnQ7uQIQc6LgPHPbIhOzyThY+Hq/RqOyD4Mf62unx1Ik5rJZ85h/vFv
	 nq+s8NkWCBrTWDLQlE/Sxq5OZJ+UgdaiLoZU/TzX23559xL4ENmjA/Jho4XKK2KkvP
	 /eHTdVTY41axg==
From: Tejun Heo <tj@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/9] bpf/arena: Direct kernel-side access
Date: Mon, 27 Apr 2026 00:51:00 -1000
Message-ID: <20260427105109.2554518-1-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This RFC is for the BPF folks. I don't know BPF code, so please take
patches 1-6 with a big grain of salt - they make sense to me, but I
don't know whether this is the right shape, or whether the whole
direction is wrong.

Motivation
~~~~~~~~~~

sched_ext's ops_cid.set_cmask() hands the BPF scheduler a struct
scx_cmask *. The kernel translates a kernel cpumask to a cmask, but it
had no way to write into the arena, so the cmask lived in kernel memory
and was passed as a trusted pointer. BPF cmask helpers all operate on
arena cmasks though, so the BPF side had to word-by-word probe-read the
kernel cmask into an arena cmask via cmask_copy_from_kernel() before
any helper could touch it. It works, but is clumsy.

The shape isn't unique to set_cmask. Sub-scheduler support is on the
way and more sched_ext callbacks will want to pass structured data to
BPF. Anywhere a kfunc or struct_ops callback wants to hand a struct to
a BPF program, arena residence is the natural answer.

Approach
~~~~~~~~

Add BPF_F_ARENA_MAP_ALWAYS. Arenas created with the flag pre-populate
every kern_vm PTE with a per-arena "garbage" page, so kernel-side
accesses anywhere in the 4G range never fault. arena_alloc_pages()
replaces the garbage PTE with a real page; arena_free_pages() restores
it. User-side fault semantics are unchanged. (The garbage-page mapping
was suggested by Alexei)

What MAP_ALWAYS gives up is the sparse-PTE fault protection. That
protection is already shallow: it only catches accesses outside the
allocated set. Within the allocated set, a buggy BPF program can still
corrupt arena memory in countless ways, and that much larger class of
bugs goes undetected with or without sparse PTEs. The general answer
to catching arena memory bugs is arena ASAN, which addresses both
classes uniformly. Given that, trading the narrow sparse-PTE
protection for clean direct kernel-side access seems like a fair deal
as long as it stays opt-in. Arenas without the flag behave exactly as
before.

Patches 1-3 (BPF: direct-access mode)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  bpf/arena: Plumb struct bpf_arena * through PTE callbacks
  bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for direct kernel access
  bpf: Add sleepable variant of bpf_arena_alloc_pages for kernel callers

Patches 4-7 (arena auto-discovery in struct_ops registration)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  bpf: Add bpf_struct_ops_for_each_prog()
  bpf: Add bpf_prog_for_each_used_map()
  bpf/arena: Add bpf_arena_map_kern_vm_start()
  sched_ext: Require MAP_ALWAYS arena for cid-form schedulers

4-6 are helpers; 7 is the first user. From the cid-form struct_ops
.reg() callback, sched_ext walks all member progs' aux->used_maps[]
and requires exactly one BPF_MAP_TYPE_ARENA, with MAP_ALWAYS set, to be
referenced across the whole struct_ops. Reaching into prog->aux from
.reg() and expressing the requirement entirely in code (not in the
struct_ops type) is the part I'm least sure about - see the open
questions.

Patches 8-9 (sched_ext: arena allocator and set_cmask conversion)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  sched_ext: Sub-allocator over kernel-claimed BPF arena pages
  sched_ext: Convert ops.set_cmask() to arena-resident cmask

The kernel sub-allocates inside the arena via gen_pool over claimed
pages and uses that storage to back the per-CPU set_cmask cmask. BPF
dereferences via __arena like any other arena struct - no helpers, no
probe-reads, no error paths.

Open questions
~~~~~~~~~~~~~~

I'd appreciate input on any of these, including "this is the wrong
direction":

* Does the overall shape - BPF_F_ARENA_MAP_ALWAYS, the struct_ops /
  used_maps walk helpers, the kern_vm_start lookup - look reasonable?
  Or would you structure something fundamentally differently?

* Patch 7's enforcement - "this struct_ops registration must reference
  exactly one MAP_ALWAYS arena, walked out of prog->aux->used_maps[]
  from inside .reg()" - is purely runtime code in sched_ext. Is there
  a cleaner mechanism?

* In patch 9 the BPF side receives an arena pointer dressed as a
  regular kernel pointer and casts it back:

    void BPF_STRUCT_OPS(qmap_set_cmask, struct task_struct *p,
                        const struct scx_cmask *cmask_in)
    {
            struct scx_cmask __arena *cmask =
                    (struct scx_cmask __arena *)(long)cmask_in;
            ...
    }

  I'd much rather declare the struct_ops callback so the BPF side
  receives a `struct scx_cmask __arena *` directly and the cast goes
  away.

This stack is based on sched_ext/cid-cmask (064d11edd78b) - for-7.2 +
the already-posted ext_*.c include reorg [1] + 17 cid/cmask patches.

[1] https://lore.kernel.org/r/b7ce63c1c16b6a21106b4fde986c3778@kernel.org

Git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git cid-arena-rfc

 include/linux/bpf.h                   |  15 ++++
 include/uapi/linux/bpf.h              |   7 ++
 kernel/bpf/arena.c                    | 127 +++++++++++++++++++++++++++----
 kernel/bpf/bpf_struct_ops.c           |  36 +++++++++
 kernel/bpf/core.c                     |  29 +++++++
 kernel/sched/build_policy.c           |   4 +
 kernel/sched/ext.c                    | 137 ++++++++++++++++++++++++++++++++--
 kernel/sched/ext_arena.c              | 128 +++++++++++++++++++++++++++++++
 kernel/sched/ext_arena.h              |  18 +++++
 kernel/sched/ext_cid.c                |  16 +---
 kernel/sched/ext_internal.h           |  25 ++++++-
 kernel/sched/ext_types.h              |  10 +++
 tools/sched_ext/include/scx/cid.bpf.h |  44 -----------
 tools/sched_ext/scx_qmap.bpf.c        |   8 +-
 14 files changed, 520 insertions(+), 84 deletions(-)

Thanks.

--
tejun
