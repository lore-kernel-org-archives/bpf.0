Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F51E0B86
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439162; cv=none; b=bhxgubaR87daz6gTDduPhPfCdHyVTxdvPkX9UX0Y2Tp6MQPnCqFlNsHMezPahr2OlegvdI6n0CruiPMcchRsgn69MdtR1oImoD/lsAWY7l7zf4+mGBloUZNoX9XrF/N/rFECsTdbqCgmyt1S5NeWNlFK443OBE5eplEojkI/xfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439162; c=relaxed/simple;
	bh=5MkopGrDsD+Heeim8rpzhCDiUk9eKTBocluoUIeU5aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VYKPdVVvSxIlF2eKQvxlBcuHWIeSY07DapPgh8Ea6ZpTz5yco6ChAZtQ7MuxgRMkjZqN2fYdGD7qTm1RvIDUa38EZzXQqcKY5fVh+aaJkq4sOgwqHZSjLBiwXB2sjZcu01mjudBRe6ch+85cbWauVNAbTehH+HO6yUYl9iE7mQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LabdwKuf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LabdwKuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5959C116D0;
	Wed, 18 Feb 2026 18:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771439162;
	bh=5MkopGrDsD+Heeim8rpzhCDiUk9eKTBocluoUIeU5aA=;
	h=From:To:Cc:Subject:Date:From;
	b=LabdwKufbpO3ayBPv0L4I78W/aKq0Hilka6udIxI439KzmcTLu/CgMH8AdeCJscVK
	 MYdVplDcMRZ6T3IG/dSD6PVNPQ7Byypo57oqX+aJIc1lHJkElJ2V8BPAxNbLpu10mn
	 bjAkO2vopkSaQjNGLUUA31ObpVw2f6nV4QRFKHWlewY6mefYkIQGucTSamCTnPoFXN
	 yeOcpLc+iYVDnw56UGDwWgGGrn3yq9OWiaOurfHA++2ezo0/kqZOctS1qFregycPFQ
	 MYZy90dfCQKmXLV3lk5XFo2Tcd9uRPkknVzFvnVxYfzUkY0g8mgIRZvpYWO/QToz0u
	 OQQHIZ5WOpiSQ==
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
Subject: [PATCH bpf-next 0/5] Introduce KF_FORBID_SLEEP modifier for acquire/release kfuncs
Date: Wed, 18 Feb 2026 10:25:45 -0800
Message-ID: <20260218182555.1501495-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

  Patch 2: KF_FORBID_SLEEP flag and forbid_sleep_count machinery.
           Generic, works for any KF_ACQUIRE kfunc - iterator or not.

  Patch 3: Move mmap_lock acquisition from _new to _next in the
           task_vma iterator, preparing for re-acquisition after
           release.

  Patch 4: Wire up task_vma as the first user: annotate _next with
           KF_ACQUIRE | KF_FORBID_SLEEP, add bpf_iter_task_vma_release().

  Patch 5: Selftests covering the runtime path (release + copy_from_user)
           and verifier rejection of invalid patterns (sleeping without
           release, VMA access after release, double release, release
           without acquire, nested iterator interaction).

Puranjay Mohan (5):
  bpf: Add KF_ACQUIRE and KF_RELEASE support for iterators
  bpf: Add KF_FORBID_SLEEP modifier for KF_ACQUIRE kfuncs
  bpf: Move locking to bpf_iter_task_vma_next()
  bpf: Add split iteration support to task_vma iterator
  selftests/bpf: Add tests for split task_vma iterator

 include/linux/bpf_verifier.h                  |   2 +
 include/linux/btf.h                           |   1 +
 kernel/bpf/helpers.c                          |   3 +-
 kernel/bpf/task_iter.c                        |  44 ++++--
 kernel/bpf/verifier.c                         | 121 +++++++++++++++--
 .../testing/selftests/bpf/bpf_experimental.h  |   1 +
 .../testing/selftests/bpf/prog_tests/iters.c  |  13 ++
 .../selftests/bpf/progs/iters_task_vma.c      |  39 ++++++
 .../bpf/progs/iters_task_vma_nosleep.c        | 125 ++++++++++++++++++
 9 files changed, 325 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/iters_task_vma_nosleep.c


base-commit: 4c51f90d45dca71e7974ed5a7c40b9c04a6c6762
-- 
2.47.3

