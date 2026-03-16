Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6666D3E9F75
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687470; cv=none; b=lHpq2nX8tor5f6E0ziiXQufMel5rRT1tmvNRW6Hl/Y8DJ/Lf4yRWWxkMZVaHMa6hI1DMCNs+gpvOwSeN6Nj+SnCOopZxkn7g2wEe6Sy+flcjwtoY364NPA96KB/mT/P1E/DyaBLtBRG4OuFd9kOepxkxmXAa68K1+BKA6eACMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687470; c=relaxed/simple;
	bh=qLLI0+TXe0U0ttKh09Q1qrFMf2TVGhuOrTkluKdUl5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCaYnLG3FgigF3QrnAO72DGx5ZHcOP2TWKVzn4MbldR6ehNrXqBCx6YykVo2h6NJWAPAwDmFHA/TZ/TBoo7nn/iInLzq6qY+ftdyKAHplaq8V1LFdPpNJAfZfMMYd/kSsPKmUvXEbg+0rHcRX+ixvMQu1A/6D3e4uRf6h9VOYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsx12y8f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsx12y8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CE2C19421;
	Mon, 16 Mar 2026 18:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773687469;
	bh=qLLI0+TXe0U0ttKh09Q1qrFMf2TVGhuOrTkluKdUl5U=;
	h=From:To:Cc:Subject:Date:From;
	b=hsx12y8ftQ10PoJmrq/ewTHhfufbD1N9GUACHv5kTZGa30OnK+qub12n1c41iVKFX
	 1I1aPS4hYiaiioDERtnK9euPb0X6HkPuRVHosry+8vMY0r+guAv6xR/CdyO337x+Ft
	 pxFM8FP8TqC7FU4ew/kIlCum+ik6tAZKPlotUOlWvb8KV5/vLlnyvzpjuYHDVsG/X7
	 N1X7OKzswVbelPJQ1/oA9ur+t4cez45lYl9WkL9hUA0OUuM3b4ci4/gWmzDPDzhh1Y
	 CVUiu6u8qHTuTuIq2TtAmb5yjkC39a0mSCqPS8Osomc3cf9DXcyD55jLTkKoeTO4cf
	 E4PyD3GTXPOnA==
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
Subject: [PATCH bpf v4 0/3] bpf: fix and improve open-coded task_vma iterator
Date: Mon, 16 Mar 2026 11:57:30 -0700
Message-ID: <20260316185736.649940-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
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

Patch 1 fixes a missing mmget() that allows the mm_struct to be freed
before the iterator takes mmap_lock. It adds mmget_not_zero() and
disables task_vma iterator in irq_disabled() contexts by returning
-EBUSY from the _new() kfunc. This allow using mmput_async() safely.

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

 include/linux/sched/mm.h |   2 +-
 kernel/bpf/task_iter.c   | 123 +++++++++++++++++++++++++++++++++++----
 kernel/fork.c            |   2 +-
 3 files changed, 113 insertions(+), 14 deletions(-)


base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
-- 
2.52.0

