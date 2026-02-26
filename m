Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC0425CF6
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122518; cv=none; b=Ot6itIhUxL3Xec2/L+9SuVL8v0lkO0AVQhG6i3pGnTHnesPUoX9FuV3CKDRX2KMooD6Ba4do82Vyn74KMyzOg0iWVXYRlEMTdDGoEU9W5g8v3lJSqrgwl2PeOg5MMOmRIhKpzfSZkQXwFYKKMMPxA/2CEQmZ9rwScZvRIxbDBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122518; c=relaxed/simple;
	bh=IovFZdTYC8smIR/H4PbFotiNk5oZLARg7ZpApKX8TDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QLxQLEhHcKzhu8CmHK915OB55cRTTn0OrKk+u9f/3YLwpxYMnP4tCtU23xpTPdb83aq10QAPnalXL6FZaPYtwMcD0H+dVUEkdkr3UbJWKGjhIJnpTktI+moycx47EE/LLdg0rGI78IVCjytoaHL3EDDHpbIUJCZlxms0nMBsEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V57fCGDL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V57fCGDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0FDC116C6;
	Thu, 26 Feb 2026 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772122518;
	bh=IovFZdTYC8smIR/H4PbFotiNk5oZLARg7ZpApKX8TDQ=;
	h=From:To:Cc:Subject:Date:From;
	b=V57fCGDLM8paDmJAUWDbNFkfuOOEvnv5eRLjx7T1hgStPBBBsD8IWtWsX4HForCef
	 c1sboGjTUthvqwbgZXizU8GxA9r/00BHosDD0bDFSM0epOw3GGnQwb15cyfq+ydY7r
	 5ogr7WBVuSi4qw0qbV1OZFc78jZpoZzLBu7IY36SWO3pOZllpuWCHMr67+eyNquvzd
	 ryYyW1a5y2VaeTRRf1shEK1t3zP+IkNxiX4Jk8/+3nMJDNtJ/bFE3LRTqXlG/DMjZ6
	 jlsRm7qCmVzgpCsFc8O0YtEVuoOY2Uj8CS0TjifMX5hGouXG+DpoTLMWExG1AWQ6Gr
	 3gsV3JK1MCaeQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf v5 0/8] Introduce KF_FORBID_FAULT modifier for acquire/release kfuncs
Date: Thu, 26 Feb 2026 08:14:49 -0800
Message-ID: <20260226161500.775715-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changelog:

v4: https://lore.kernel.org/all/20260224212535.1165151-1-puranjay@kernel.org/
Changes in v4 -> v5:
- Base the commits over bpf/master and not bpf-next/master
- Rename KF_FORBID_SLEEP to KF_FORBID_FAULT: mmap_lock is a sleeping
  lock (rw_semaphore), so the actual constraint is about faulting (which
  would deadlock on mmap_lock re-acquisition), not sleeping (Alexei)
- Rename forbid_sleep/forbid_sleep_count to forbid_fault/forbid_fault_count
  throughout verifier and headers
- Change verifier error description from "nosleep region" to
  "nofault region"
- Add new preparatory patch (patch 4) to consolidate the open-coded
  sleepable check in check_func_call() into in_sleepable_context() +
  non_sleepable_context_description(), consistent with
  check_helper_call() and check_kfunc_call()
- Update selftest error messages to match: "nofault region" and use
  #{{[0-9]+}} regex for helper IDs

v3: https://lore.kernel.org/all/20260223174659.2749964-1-puranjay@kernel.org/
Changes in v3 -> v4:
- In iter_release_acquired_ref(), drop the if (!err) guard before
  zeroing iter_st->id, the verifier stops on error anyway (Eduard)
- In process_iter_next_call() DRAINED branch, guard iter_release_acquired_ref()
  with is_kfunc_acquire() check for future-proofing (Eduard)
- In check_kfunc_call() KF_RELEASE path, validate that the stack slot is
  actually STACK_ITER before operating on it (Mykyta)
- In check_kfunc_call() KF_RELEASE path, use iter_release_acquired_ref()
  helper instead of open-coding release_reference() + id zeroing (Eduard)
- In check_kfunc_call() KF_ACQUIRE path, move is_iter_next_kfunc() check
  inside the is_kfunc_acquire() block so there is only one place checking
  is_kfunc_acquire() (Mykyta)
- Add new patch to consolidate scattered sleepable checks in
  check_kfunc_call() into a single in_sleepable_context() check (Eduard)
- Drop separate forbid_sleep_count check in check_kfunc_call(), now
  covered by the consolidated in_sleepable_context() check (Eduard)
- Use in_sleepable_context() for global subprog sleep check in
  check_func_call() instead of open-coding (Eduard)
- Add runtime test for nested task_vma iterators on the same task to
  verify mmap_read_trylock() handles concurrent readers (Alexei)

v2: https://lore.kernel.org/all/20260223160300.2109907-1-puranjay@kernel.org/
Changes in v2 -> v3:
- Rebased on bpf-next/master

v1: https://lore.kernel.org/all/20260218182555.1501495-1-puranjay@kernel.org/
Changes in v1 -> v2:
- Add a patch to consolidate sleepable context error message printing in
  check_helper_call(), has no functional changes (Eduard)
- In check_kfunc_call() for KF_RELEASE and __iter arg, use release_regno
  like dynptr rather than custom handling (Mykyta)
- Fix some comments to follow correct style (Mykyta)
- Move state->forbid_sleep_count-- to release_reference_state() (Eduard)
- Remove error message in check_resource_leak() for forbid_sleep_count
  because it is redundant and will never trigger (Eduard)
- Consolidated some checks and prints (Eduard)


Some BPF kfuncs acquire resources that prevent faulting - a lock, a
reference to an object under a lock, a preempt-disable section. Today there
is no way for the verifier to know that holding a particular acquired
reference means faulting is forbidden. Programs either run entirely in
sleepable or non-sleepable context, with no way to express "faulting is
forbidden right now, but will be allowed once I release this reference."

This series adds KF_FORBID_FAULT, a new kfunc flag that can be combined
with KF_ACQUIRE. When a kfunc annotated with KF_ACQUIRE | KF_FORBID_FAULT
is called, the verifier tags the acquired reference with forbid_fault and
increments a per-state forbid_fault_count counter. When the reference is
released (through corresponding KF_RELEASE kfunc), the counter is
decremented. The verifier checks this counter everywhere it decides
whether sleeping is allowed — the implementation conservatively blocks
all sleepable operations while faulting is forbidden.

This is fully generic. Any pair of KF_ACQUIRE/KF_RELEASE kfuncs can opt
into fault prohibition by adding KF_FORBID_FAULT to the acquire side.

To make this useful for iterators specifically, the series first extends
the verifier's iterator support to allow KF_ACQUIRE on _next and KF_RELEASE
on a separate kfunc taking an __iter argument. The verifier tracks the
acquired reference on the iterator's stack slot (st->id) and auto-releases
it on the next _next call and on the DRAINED (NULL) path, so the
acquire/release is transparent to programs that don't need mid-loop
release.

Iterator KF_ACQUIRE support is not useful on its own right now, but it
becomes the foundation for KF_FORBID_FAULT: an iterator whose _next is
annotated with KF_ACQUIRE | KF_FORBID_FAULT can now express "holding this
pointer forbids faulting; calling _release invalidates the pointer and
re-enables sleeping."

The task_vma iterator is the first user. It holds mmap_lock during
iteration, preventing sleepable helpers like bpf_copy_from_user().
Since mmap_lock is a sleeping lock (rw_semaphore), sleeping itself is
fine while holding it. The actual danger is faulting, which would try
to re-acquire mmap_lock and deadlock.

With this series, a BPF program can release the lock mid-iteration:

    bpf_for_each(task_vma, vma, task, 0) {
        u64 start = vma->vm_start;

        /* faulting forbidden, but vma pointer access allowed */
        bpf_iter_task_vma_release(&___it);
        /* mmap_lock released, vma pointer invalidated */
        /* faulting (and sleeping) is fine here */

        bpf_copy_from_user(&buf, sizeof(buf), (void *)start);
    }

The series is organized as:

  Patch 1: KF_ACQUIRE/KF_RELEASE plumbing for iterators in the
           verifier. Pure infrastructure, no behavioral change to
           existing iterators.

  Patch 2: Consolidate sleepable context error message printing
           in check_helper_call(), no functional changes.

  Patch 3: Consolidate scattered sleepable checks in check_kfunc_call()
           into a single in_sleepable_context() check.

  Patch 4: Consolidate the open-coded sleepable check in
           check_func_call() into in_sleepable_context(), consistent
           with patches 2 and 3.

  Patch 5: KF_FORBID_FAULT flag and forbid_fault_count machinery.
           Generic, works for any KF_ACQUIRE kfunc - iterator or not.

  Patch 6: Move mmap_lock acquisition from _new to _next in the
           task_vma iterator, preparing for re-acquisition after
           release.

  Patch 7: Wire up task_vma as the first user: annotate _next with
           KF_ACQUIRE | KF_FORBID_FAULT, add bpf_iter_task_vma_release().

  Patch 8: Selftests covering the runtime path (release + copy_from_user,
           nested iterators on same mm) and verifier rejection of
           invalid patterns (sleeping without release, VMA access after
           release, double release, release without acquire, nested
           iterator interaction).

Puranjay Mohan (8):
  bpf: Add KF_ACQUIRE and KF_RELEASE support for iterators
  bpf: consolidate sleepable checks in check_helper_call()
  bpf: consolidate sleepable checks in check_kfunc_call()
  bpf: consolidate sleepable checks in check_func_call()
  bpf: Add KF_FORBID_FAULT modifier for KF_ACQUIRE kfuncs
  bpf: Move locking to bpf_iter_task_vma_next()
  bpf: Add split iteration support to task_vma iterator
  selftests/bpf: Add tests for split task_vma iterator

 include/linux/bpf_verifier.h                  |   2 +
 include/linux/btf.h                           |   1 +
 kernel/bpf/helpers.c                          |   3 +-
 kernel/bpf/task_iter.c                        |  44 +++-
 kernel/bpf/verifier.c                         | 196 ++++++++++++------
 .../testing/selftests/bpf/bpf_experimental.h  |   1 +
 .../testing/selftests/bpf/prog_tests/iters.c  |  24 +++
 .../selftests/bpf/prog_tests/summarization.c  |   2 +-
 tools/testing/selftests/bpf/progs/irq.c       |   4 +-
 .../selftests/bpf/progs/iters_task_vma.c      |  71 +++++++
 .../bpf/progs/iters_task_vma_nosleep.c        | 125 +++++++++++
 .../selftests/bpf/progs/preempt_lock.c        |   6 +-
 .../bpf/progs/verifier_async_cb_context.c     |   4 +-
 13 files changed, 399 insertions(+), 84 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma_nosleep.c


base-commit: 8feedae96f872f1b74ad40c72b5cd6a47c44d9dd
-- 
2.47.3

