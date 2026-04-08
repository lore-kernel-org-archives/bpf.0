Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F32D77E5
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663145; cv=none; b=MSMmoiE3HCovB2shhDP+uYqxc6cIrZavfGWupmERR1CQVQ+AGK2QJEnv1IkWCmiYwcUDzpuWvqZO+3LMMJbFHzuCNkwnS/snspXPLoAfJEYZx01rB0vvLa0YQpF+cnHAcw/Uw4zU36KoMP2e3v5GMcP3w4lMPQOkM5worNadxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663145; c=relaxed/simple;
	bh=ThmizSExdxAeMM00v9BZsGU8mn4Bg6GpFrF82z+c3ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UrGLC5cnpyORtnykWkefhOwqstxPIXr4QXY5fr029aLCXwU1skJVdoG0nf2leaI+wjJDP7/kLgUvGJPUjnf7622jEee9BHOKhGTf1pPHaDvV+GNi1VySLXBSS8uXFKF16EGhSdsMFyoi2hHJihniesMouUTq3LDJF5PaVgJm4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZKyo97m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZKyo97m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3036BC19421;
	Wed,  8 Apr 2026 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775663145;
	bh=ThmizSExdxAeMM00v9BZsGU8mn4Bg6GpFrF82z+c3ZM=;
	h=From:To:Cc:Subject:Date:From;
	b=aZKyo97m8fjWUP7snyjOfIbaYrRQxU1OTicHErFa1EG8gZi1GyrkEZYcbGzrmDoNm
	 /v2bEXbAVHf6NQseJ39cx1otyZSm53+EMsn41IHniAnXHMYFKzYvO8zBnch1W2fje7
	 rsihscSXPwh+CF/dUGsHDPRkPJYdemkFXsfBDCSsf/g6CAB5SD7zq0BhZs+OE/WmAD
	 08bDDpkF+kU/qLEqUS/8/lxKDNVMjCOv7O+tjVw1HvAMlcFrrzlbphf3O7cotUNeWl
	 VTTTR7KltNSLfj39bdMd2H7hu9CDsBpLFhQsjIAu/wDWnX8YR3JDvwG6Y7axbQNDaE
	 AC7d1RDCFvfFA==
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
Subject: [PATCH bpf v6 0/3] bpf: fix and improve open-coded task_vma iterator
Date: Wed,  8 Apr 2026 08:45:34 -0700
Message-ID: <20260408154539.3832150-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changelog:
v5: https://lore.kernel.org/all/20260326151111.4002475-1-puranjay@kernel.org/
Changes in v6:
- Replace local_irq_disable() + get_task_mm() with spin_trylock() on
  alloc_lock to avoid a softirq deadlock: if the target task holds its
  alloc_lock and gets interrupted, a softirq BPF program iterating
  that task would deadlock on task_lock() (Gemini)
- Gate on CONFIG_MMU in patch 1 so that the mmput() fallback in
  bpf_iter_mmput_async() cannot sleep in non-sleepable BPF context
  on NOMMU; patch 2 tightens this to CONFIG_PER_VMA_LOCK (Gemini)
- Merge the split if (irq_work_busy) / if (!mmap_read_trylock())
  back into a single if statement in patch 1 (Andrii)
- Flip comparison direction in bpf_iter_task_vma_find_next() so both
  the locked and unlocked VMA failure cases read consistently:
  end <= next_addr → PAGE_SIZE, else - use end (Andrii)
- Add Acked-by from Andrii on patch 3

v4: https://lore.kernel.org/all/20260316185736.649940-1-puranjay@kernel.org/
Changes in v5:
- Use get_task_mm() instead of a lockless task->mm read followed by
  mmget_not_zero() to fix a use-after-free: mm_struct is not
  SLAB_TYPESAFE_BY_RCU, so the lockless pointer can go stale (AI)
- Add a local bpf_iter_mmput_async() wrapper with #ifdef CONFIG_MMU
  to avoid modifying fork.c and sched/mm.h outside the BPF tree
- Drop the fork.c and sched/mm.h changes that widened the
  mmput_async() #if guard
- Disable IRQs around get_task_mm() to prevent raw tracepoint
  re-entrancy from deadlocking on task_lock()

v3: https://lore.kernel.org/all/20260311225726.808332-1-puranjay@kernel.org/
Changes in v4:
- Disable task_vma iterator in irq_disabled() contexts to mitigate deadlocks (Alexei)
- Use a helper function to reset the snapshot (Andrii)
- Remove the redundant snap->vm_mm = kit->data->mm; (Andrii)
- Remove all irq_work deferral as the iterator will not work in
  irq_disabled() sections anymore and _new() will return -EBUSY early.

v2: https://lore.kernel.org/all/20260309155506.23490-1-puranjay@kernel.org/
Changes in v3:
- Remove the rename patch 1 (Andrii)
- Put the irq_work in the iter data, per-cpu slot is not needed (Andrii)
- Remove the unnecessary !in_hardirq() in the deferral path (Alexei)
- Use PAGE_SIZE advancement in case vma shrinks back to maintain the
  forward progress guarantee (AI)

v1: https://lore.kernel.org/all/20260304142026.1443666-1-puranjay@kernel.org/
Changes in v2:
- Add a preparatory patch to rename mmap_unlock_irq_work to
  bpf_iter_mm_irq_work (Mykyta)
- Fix bpf_iter_mmput() to also defer for IRQ disabled regions (Alexei)
- Fix a build issue where mmpu_async() is not available without
  CONFIG_MMU (kernel test robot)
- Reuse mmap_unlock_irq_work (after rename) for mmput (Mykyta)
- Move vma lookup (retry block) to a separate function (Mykyta)

This series fixes the mm lifecycle handling in the open-coded task_vma
BPF iterator and switches it from mmap_lock to per-VMA locking to reduce
contention. It then fixes a deadlock that is caused by holding locks
accross the body of the iterator where faulting is allowed.

Patch 1 fixes a use-after-free where task->mm was read locklessly and
could be freed before the iterator used it. It uses a trylock on
alloc_lock to safely read task->mm and acquire an mm reference, and
disables the iterator in irq_disabled() contexts by returning -EBUSY
from _new().

Patch 2 switches from holding mmap_lock for the entire iteration to
per-VMA locking via lock_vma_under_rcu(). This still doesn't fix the
deadlock problem because holding the per-vma lock for the whole
iteration can still cause lock ordering issues when a faultable helper
is called in the body of the iterator.

Patch 3 resolves the lock ordering problems caused by holding the
per-VMA lock or the mmap_lock (not applicable after patch 2) across BPF
program execution. It snapshots VMA fields under the lock, then drops
the lock before returning to the BPF program. File references are
managed via get_file()/fput() across iterations.

Puranjay Mohan (3):
  bpf: fix mm lifecycle in open-coded task_vma iterator
  bpf: switch task_vma iterator from mmap_lock to per-VMA locks
  bpf: return VMA snapshot from task_vma iterator

 kernel/bpf/task_iter.c | 151 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 136 insertions(+), 15 deletions(-)


base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
-- 
2.52.0

