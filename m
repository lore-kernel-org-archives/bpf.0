Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760B52EC09B
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862608; cv=none; b=UmwpKsha5agXvo9pZ62Mhn95yDin30x9rK4Ah3oiAzat1ONCDk0hFP5CZSbA4XCTkQX2vczMobnKvQOx5gY/1yaiqVlzDFrz1gGMqe3IY4UO9d3KU3SnoW8HFhMDxbiZqZLQqFTJfQcHBxrJxNdPbeRJ4l+eOStXH4uysNGD1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862608; c=relaxed/simple;
	bh=Puusm8IkaDN3s9SIb+X/OpPy7el/20BL8fchVpP43AA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V1NUFpp29B7NuTlXNKEV9dBdagAqJds74JFFG4w5//z/3SINjyFnV9SJzHpfUhNRTWMAUCQQwzOv3pgIrxiW+14gS2rogs85A4726xMs/EfhC0xhcEjcjkZH6PGUCHQP9JzW09D12PsjtZKGzY8A8fQHTVQ0UP3aBY0YdKdND/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIkGLdJG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIkGLdJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07674C116C6;
	Mon, 23 Feb 2026 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771862608;
	bh=Puusm8IkaDN3s9SIb+X/OpPy7el/20BL8fchVpP43AA=;
	h=From:To:Cc:Subject:Date:From;
	b=VIkGLdJGn2OQczqyeP2ZhrqPtGC2aNg5DAhOrPcmuHGJcRyokl8YlksvShwbzU/kp
	 9CuCYtnUgxy90eiCUoVDU/gK3PDM05wJnPzulOGPNNj0+/aDZd6RhYS3dYdYRiyYRo
	 z8GcLwpNr1+UR3hR+NsCUqDt6zqVNbTh08f4EzlyTPeWkfxKftnSi8VhNjKwg1sv1W
	 b6jx0++VxtH2TLD/oO5d7XJbNcNfYHNbXuetaellDFsHigo8hoosOySqMPVZPg0XU0
	 t5uszd/EdO6ngeBfO9unP/rFqVoWy3x+De5iA8Tft0i2XI8ss+KowkRj+J63pqmYXB
	 2idwJFzJqAxTA==
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
Subject: [PATCH bpf-next v2 0/6] Introduce KF_FORBID_SLEEP modifier for acquire/release kfuncs
Date: Mon, 23 Feb 2026 08:02:48 -0800
Message-ID: <20260223160300.2109907-1-puranjay@kernel.org>
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
           in check_helper_call(), no functional changes

  Patch 3: KF_FORBID_SLEEP flag and forbid_sleep_count machinery.
           Generic, works for any KF_ACQUIRE kfunc - iterator or not.

  Patch 4: Move mmap_lock acquisition from _new to _next in the
           task_vma iterator, preparing for re-acquisition after
           release.

  Patch 5: Wire up task_vma as the first user: annotate _next with
           KF_ACQUIRE | KF_FORBID_SLEEP, add bpf_iter_task_vma_release().

  Patch 6: Selftests covering the runtime path (release + copy_from_user)
           and verifier rejection of invalid patterns (sleeping without
           release, VMA access after release, double release, release
           without acquire, nested iterator interaction).

Puranjay Mohan (6):
  bpf: Add KF_ACQUIRE and KF_RELEASE support for iterators
  bpf: consolidate sleepable context error message printing
  bpf: Add KF_FORBID_SLEEP modifier for KF_ACQUIRE kfuncs
  bpf: Move locking to bpf_iter_task_vma_next()
  bpf: Add split iteration support to task_vma iterator
  selftests/bpf: Add tests for split task_vma iterator

 include/linux/bpf_verifier.h                  |   2 +
 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |   3 +
 kernel/bpf/helpers.c                          |   3 +-
 kernel/bpf/task_iter.c                        |  44 ++++--
 kernel/bpf/verifier.c                         | 147 +++++++++++++-----
 .../testing/selftests/bpf/bpf_experimental.h  |   1 +
 .../testing/selftests/bpf/prog_tests/iters.c  |  13 ++
 .../selftests/bpf/progs/iters_task_vma.c      |  39 +++++
 .../bpf/progs/iters_task_vma_nosleep.c        | 125 +++++++++++++++
 10 files changed, 331 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma_nosleep.c


base-commit: 9cd168a2720bc614647dd20bc5d1c308c56a44ec
-- 
2.47.3

