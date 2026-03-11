Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176E399025
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269869; cv=none; b=rr2F03+0qw4PSySb9VjKKscPImAZ+UuE7q4qgBB8Js08l+Zq6jrOz/UI1JmZZjsKfsWPOjgwGhekhRkVNzNlRXpEjkeplWRs8tG9GjOIP0vlbFVJpqxPLL6lsOjvCuoKlMMaK0HanBKin6x0soWfHqNHo/BkmcoBxHXWKaIUYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269869; c=relaxed/simple;
	bh=wqKw58kM8mMohRpIfu3NGIikxrVRJmD7e4n92nHWJy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=unthIR/C8QEf7lEwtEPF18UmMoN2uFP3vpP4u3zmGGs9yIq0wIaxrNqBpKkkbvfBMVrAdll+Ysml6Z6kbGSt+5cVm0SNEfFHn2J63ZbZR8kGjbF5p06FPDz1JRoBYqWsB/qPK6rcCv27ouap7/AOS2PKVSiWuExwKnkkKCKSzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv9nolyl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv9nolyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA58C4CEF7;
	Wed, 11 Mar 2026 22:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773269869;
	bh=wqKw58kM8mMohRpIfu3NGIikxrVRJmD7e4n92nHWJy8=;
	h=From:To:Cc:Subject:Date:From;
	b=hv9nolyl2FQa/Jo/SvFi7dwLQMRfmVIcuoMcdAC9JYeD39zl26WJCG+i4eJfveqEH
	 xEyEpoTVSffV5mU8zOyXUBgqMgAVWiexwN8lqBQteNhQsLqbuicyQrFKPFDum1JKwP
	 MzizphBX5Z8IsH3lR31MwCgJAzod5I6788A0/xT53q520pEvf220OnJG1aQXJ+P+Vo
	 rFqgUNgh31OetM9PuB4hmN1GmilEcOJ4j/uFeIob2nBdnjSP2U96TvZ8WeJsmKTBZD
	 9dLPeESZ6NArPjDaKOaIbxXxbOo9Ye2CgtSyAN4hwhrAZHBxf8dnyztQTXW7LtKVno
	 5p8zxhYd4xDHQ==
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
Subject: [PATCH bpf v3 0/3] bpf: fix and improve open-coded task_vma iterator
Date: Wed, 11 Mar 2026 15:57:20 -0700
Message-ID: <20260311225726.808332-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
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
introduces an safe mmput path using per-CPU irq_work, following the
existing mmap_unlock irq_work pattern.

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
 kernel/bpf/task_iter.c   | 134 +++++++++++++++++++++++++++++++++++----
 kernel/fork.c            |   2 +-
 3 files changed, 123 insertions(+), 15 deletions(-)


base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
-- 
2.52.0

