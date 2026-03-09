Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00103612ED
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071720; cv=none; b=ijyt/rtKAg4j6BIAJBSNMkvHHIn5D1KPp5mwRx9Fi2aMMT55b+RbeSYZUaNtrNoif1WSSGdq9jt5BHdqVEBT/VxyN97PGY5gVm9pUWq0MdbwVUSJymlfQtlYUYTYeTBNNUA6hbUFmf8VuK9PbK8klcxahoJ3sEaJK/w5hr0Org4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071720; c=relaxed/simple;
	bh=/mc2BoMcDypwvF7gm6lx7PnGvxRKbNpQa5g5wLxMtKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lwpQxwulgdZX5I2q/YjUY1oC9+TQcwV7xgWMw1fE2p8YNa9WZFssh52LSv37pX7C8nnlLuNghoT92Fgmx5myiWfP4hyZsWlX65UPRHNOj6IoBYkG19J4fsLVTT9q980tdkgOMH58xn/fZlRi+sm4x7qpBxDPKdQFn1Zft0UcQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7zGZiTj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7zGZiTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687EBC4CEF7;
	Mon,  9 Mar 2026 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773071720;
	bh=/mc2BoMcDypwvF7gm6lx7PnGvxRKbNpQa5g5wLxMtKM=;
	h=From:To:Cc:Subject:Date:From;
	b=h7zGZiTj+yugcAqDea/ZBdQPqHjkpHrvWUs8mM73909j5DexT05fPhy3EKgoUE8VD
	 Z7htm7bExvg+Njt3Is4bxY0qCSK4CLvJVEhsbs2/WOKAv58bwlaUJA5UN9OsxsNEEe
	 F6mzDi/ZCRnYEKDuTJMAsg3d/7bJi29/P+v1MfTcxkqKkVExQN9mZ36Y/N4JcU1Cp4
	 2X3ZjkgppuFO1absclbtnCraSruD+K85nZTMGcNdVTXwxEJtQPjZ79+kcoMW7F1yLh
	 feWYbtJ3nHkC6yWymUiNsTot+b565MrGjUafyYuF4Fq8jlmgPOrmA2g9V0c9g9MLOA
	 pjNdE9RXgiYkg==
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
Subject: [PATCH bpf v2 0/4] bpf: fix and improve open-coded task_vma iterator
Date: Mon,  9 Mar 2026 08:54:54 -0700
Message-ID: <20260309155506.23490-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
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

Patch 1 renames mmap_unlock_irq_work to bpf_iter_mm_irq_work so it is
generic enough to be used by Patch 2 for mmput_async().

Patch 2 fixes a missing mmget() that allows the mm_struct to be freed
before the iterator takes mmap_lock. It adds mmget_not_zero() and
introduces an NMI/IRQ-safe mmput path using per-CPU irq_work, following the
existing mmap_unlock irq_work pattern.

Patch 3 switches from holding mmap_lock for the entire iteration to
per-VMA locking via lock_vma_under_rcu(). This still doesn't fix the
deadlock problem because holding the per-vma lock for the whole
iteration can still cause lock ordering issues when a faultable helper
is called in the body of the iterator.

Patch 4 resolves the lock ordering problems caused by holding the
per-VMA lock or the mmap_lock (not applicable after patch 2) across BPF
program execution. It snapshots VMA fields under the lock, then drops
the lock before returning to the BPF program. File references are
managed via get_file()/fput() across iterations.

Puranjay Mohan (4):
  bpf: rename mmap_unlock_irq_work to bpf_iter_mm_irq_work
  bpf: fix mm lifecycle in open-coded task_vma iterator
  bpf: switch task_vma iterator from mmap_lock to per-VMA locks
  bpf: return VMA snapshot from task_vma iterator

 include/linux/sched/mm.h      |   2 +-
 kernel/bpf/mmap_unlock_work.h |  12 +--
 kernel/bpf/stackmap.c         |   2 +-
 kernel/bpf/task_iter.c        | 152 ++++++++++++++++++++++++++++++----
 kernel/fork.c                 |   2 +-
 5 files changed, 145 insertions(+), 25 deletions(-)


base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
-- 
2.47.3

