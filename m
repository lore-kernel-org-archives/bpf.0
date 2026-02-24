Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB09A3EBF1F
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968358; cv=none; b=LH81le1Vft4XqBbsaZBiuuA4Su4mkEl3SzMGWJC9t0VYViY9v3zjcuKuRw5qbE4Ertm434zq97fwxeGjCS9OPx5SMcaiPai4itlSVNQOgBvftSeybzc2ndnfaWPh1TG/789CDpAQnjjeSXcjt2UFpePO18RvzFazwrEZaKYaNac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968358; c=relaxed/simple;
	bh=jj2BgQZnyHCmnihGKKjmzKN+VqY9DaTcGkdaqglPwJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F6rup0wWBKspnmAwf6b8EbyxwsG8kL08AYp3j6SdEMLGZ3E8ACs/N86kWOY1JieKZhMxwpxLgyQ2ygRQ+TYxUGLXTG5twjtl8U4mMnt69hD4iFNeNLcQ1Dd3IgrajBhYYULATLMS/EJOdeKTB2rpx97K8mIMHpjIuSpdQsgwtNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ2RXvGP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ2RXvGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328BDC116D0;
	Tue, 24 Feb 2026 21:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771968358;
	bh=jj2BgQZnyHCmnihGKKjmzKN+VqY9DaTcGkdaqglPwJk=;
	h=From:To:Cc:Subject:Date:From;
	b=GQ2RXvGPZZo6b8/7cWlmTjK1+pL6nQ7Z+2BL0QvwIUNafch1NtYLgDky8Zn+YGJ18
	 9FrQKS7UCVTit5KhUwdRGx16a1S/SiI4+UUWyapd0pDiK6Qo1fq0xA85Qcc9WPlAij
	 /UvzNm9s6/TeAqZWCkrJVwHBOM9L+O1CZQ10cHP7edr05nOkR5GvjWXeCHVKsMD5MU
	 9cwFtvB5+GEf9SPM9cyqXYIUPmnZtchaVAntWYCs5jzQs9Uq9Ciy3ruFlOn5xGZYtv
	 W+VnlZxGik0rpnqu9xbiWi/UzS16WAXB/ym47fiSYhhimys2otlNVmvmyPPtLOMurD
	 ei8Rh0xkH2MrA==
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
Subject: [PATCH bpf-next v4 0/7] Introduce KF_FORBID_SLEEP modifier for acquire/release kfuncs
Date: Tue, 24 Feb 2026 13:25:22 -0800
Message-ID: <20260224212535.1165151-1-puranjay@kernel.org>
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


Some BPF kfuncs acquire resources that prevent sleeping - a lock, a
reference to an object under a lock, a preempt-disable section. Today there
is no way for the verifier to know that holding a particular acquired
reference means sleeping is forbidden. Programs either run entirely in
sleepable or non-sleepable context, with no way to express "sleeping is
forbidden right now, but will be allowed once I release this reference."

This series adds KF_FORBID_SLEEP, a new kfunc flag that can be combined
with KF_ACQUIRE. When a kfunc annotated with KF_ACQUIRE | KF_FORBID_SLEEP
is called, the verifier tags the acquired reference with forbid_sleep and
increments a per-state forbid_sleep_count counter. When the reference is
released (through corresponding KF_RELEASE kfunc), the counter is
decremented.  The verifier checks this counter everywhere it decides
whether sleeping is allowed — sleepable helpers, sleepable kfuncs, global
function calls, and resource leak checks.

This is fully generic. Any pair of KF_ACQUIRE/KF_RELEASE kfuncs can opt
into sleep prohibition by adding KF_FORBID_SLEEP to the acquire side.

To make this useful for iterators specifically, the series first extends
the verifier's iterator support to allow KF_ACQUIRE on _next and KF_RELEASE
on a separate kfunc taking an __iter argument. The verifier tracks the
acquired reference on the iterator's stack slot (st->id) and auto-releases
it on the next _next call and on the DRAINED (NULL) path, so the
acquire/release is transparent to programs that don't need mid-loop
release.

Iterator KF_ACQUIRE support is not useful on its own right now, but it
becomes the foundation for KF_FORBID_SLEEP: an iterator whose _next is
annotated with KF_ACQUIRE | KF_FORBID_SLEEP can now express "holding this
pointer forbids sleeping; calling _release invalidates the pointer and
re-enables sleeping."

The task_vma iterator is the first user. It holds mmap_lock during
iteration, preventing sleepable helpers like bpf_copy_from_user().
Currently, this can lead to a deadlock as the fault path also takes
mmap_lock.

With this series, a BPF program can release the lock mid-iteration:

    bpf_for_each(task_vma, vma, task, 0) {
        u64 start = vma->vm_start;

        /* sleeping forbidden, but vma pointer access allowed */
        bpf_iter_task_vma_release(&___it);
        /* mmap_lock released, vma pointer invalidated */
        /* sleeping is fine here */

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

  Patch 4: KF_FORBID_SLEEP flag and forbid_sleep_count machinery.
           Generic, works for any KF_ACQUIRE kfunc - iterator or not.

  Patch 5: Move mmap_lock acquisition from _new to _next in the
           task_vma iterator, preparing for re-acquisition after
           release.

  Patch 6: Wire up task_vma as the first user: annotate _next with
           KF_ACQUIRE | KF_FORBID_SLEEP, add bpf_iter_task_vma_release().

  Patch 7: Selftests covering the runtime path (release + copy_from_user,
           nested iterators on same mm) and verifier rejection of
           invalid patterns (sleeping without release, VMA access after
           release, double release, release without acquire, nested
           iterator interaction).

Puranjay Mohan (7):
  bpf: Add KF_ACQUIRE and KF_RELEASE support for iterators
  bpf: consolidate sleepable checks in check_helper_call()
  bpf: consolidate sleepable checks in check_kfunc_call()
  bpf: Add KF_FORBID_SLEEP modifier for KF_ACQUIRE kfuncs
  bpf: Move locking to bpf_iter_task_vma_next()
  bpf: Add split iteration support to task_vma iterator
  selftests/bpf: Add tests for split task_vma iterator

 include/linux/bpf_verifier.h                  |   2 +
 include/linux/btf.h                           |   1 +
 kernel/bpf/helpers.c                          |   3 +-
 kernel/bpf/task_iter.c                        |  44 +++--
 kernel/bpf/verifier.c                         | 184 ++++++++++++------
 .../testing/selftests/bpf/bpf_experimental.h  |   1 +
 .../testing/selftests/bpf/prog_tests/iters.c  |  24 +++
 .../selftests/bpf/progs/iters_task_vma.c      |  71 +++++++
 .../bpf/progs/iters_task_vma_nosleep.c        | 125 ++++++++++++
 9 files changed, 387 insertions(+), 68 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma_nosleep.c


base-commit: e4094d56c5592dd90aa619f9480265b0689ed3d9
-- 
2.47.3

