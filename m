Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC5340293
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774524171; cv=none; b=JJ3WDhc32pX0LhbIK5/wm52e7fdXRmt65JWvvlCajv3Pg4fcw6ML3mr5r8QMFScNLVgD7yTfK/dtLED5Y1JIZ0cRpxukFLoAnYnBTjripxCTb3zZgNw7NvFqSd/j2tR9G3se9KQK2IImvhoqWP+RaXmKOm3NU/d1LzHEpFBiLmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774524171; c=relaxed/simple;
	bh=J694CBVV7rz8d7WT7BQSesrpAUX9vArQKayZzDb8HQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RuKplJ+XtmAPXui+Wb+QPy4A3wCdg38/jk9zSft+R4ooMo0vUWx/pNKOLTlcjlqo+eOLaNaq/b6G+AcVu9UVsrBwmMrGIg5hSTtLqq3lsML4Wqj1nbuA6NrL5dVyS2nDcp/i6kPKluN4FxGWRJ093rG69e4ZUd1ywG1txYhFXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCm/ncyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCm/ncyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31950C116C6;
	Thu, 26 Mar 2026 11:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774524171;
	bh=J694CBVV7rz8d7WT7BQSesrpAUX9vArQKayZzDb8HQg=;
	h=From:To:Cc:Subject:Date:From;
	b=iCm/ncyYKdYzFAIkro5hxZkBQiLrhfEhTc+u542HT8d0fFe4oDn12fdy+u2L0uBtb
	 JDwvF1UNd+ZRuEXGqosVSrMcAqZgNDl2tbCcBcVVuMIW3W2CNy1HONllQp4V+phlDM
	 CeLlejMlqBq4KJoensvjGlfHRddn/96lHydliAvA5uz9eTreZ5beYeGBQUPrUgaXik
	 MKVZQRJBewIS9cuSwUU3/e5c9CWwkyTy7Q1c2uPQ4WNXLtpD3t8QpGxItptrQgLFWA
	 AfJR3Z+hTB0/I7TOz7Fx09aX5wj7+vS3O4G8WU+6XiQ/GQqI+Qa+43Un2ZQ904YsG+
	 2RcJBDjc5ZZxw==
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
Subject: [PATCH bpf v5 0/3] bpf: fix and improve open-coded task_vma iterator
Date: Thu, 26 Mar 2026 04:22:37 -0700
Message-ID: <20260326112242.2260320-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
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
could be freed before the iterator used it. It uses get_task_mm() to
safely acquire the mm reference under task_lock() and disables the
iterator in irq_disabled() contexts by returning -EBUSY from _new().

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

 kernel/bpf/task_iter.c | 141 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 125 insertions(+), 16 deletions(-)


base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.52.0

