Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A635957
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634041; cv=none; b=qnbkGLwpYW/zaDfNivYD/sSQD792Oy+r+ZgKWAtW7JwcOS4qqQKpIfnGAGE1zAY+Uv8xkSksaP5W047PbhglrSDkTCbs2rija/twiiXJgtGRj5oFsNBhO4YwXXXWDQY6PJeexvK1QZRJyRmBL3FTMilAG6ctgzCtcOcphZTqJVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634041; c=relaxed/simple;
	bh=txgdI71m1zr+jtQNyfmkKcbHN2VKj2+7O5BZXV6xaEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7cEgimbCWDGLSptDim1sfmmuNqSqEFirTN/Dpi02KiWnb7LKjVGrpA6n04uhwxLkOW3G6fjVZhfHPmbVAi9ctFPoC3lqIdCVpCexHV7D9MqOyndbiHDlOx55avKBebH+h31s3k7cXO4O6amefqsvJClya8/6EGJI1bzzPjkHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izzufPqn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izzufPqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F675C4CEF7;
	Wed,  4 Mar 2026 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772634041;
	bh=txgdI71m1zr+jtQNyfmkKcbHN2VKj2+7O5BZXV6xaEM=;
	h=From:To:Cc:Subject:Date:From;
	b=izzufPqnjP7E64M16AvZv5hqHfqs35DstNTr8ac8RGmg7t1iPDDh51gJHWBI8UWVi
	 CASx/bIkj8noksh7gvxuhCY67I7nQyf9y5bleoAFhhlNdAuZp3uZFob9Td6scvhnyu
	 0dqJL7Ra0hd9EHaaB38hsMNbyVDJGtySuFVKWwbPM5IlAy3P6BcJcTry4qYxWNVmJ+
	 l/vodvOGp0JdpZcxY2FG++3dgeFXskJ74YFjTuHlC1d43/239YJQyJibpnfY+oGc8g
	 wwNS9KzHTnY2eoyDSfIA/TmjnPmFM0T/JK/Na9plEm/0QxLC7QC65pbxcJ76Wz2xc4
	 hfBzMJHY2gtmA==
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
Subject: [PATCH bpf 0/3] bpf: fix and improve open-coded task_vma iterator
Date: Wed,  4 Mar 2026 06:20:13 -0800
Message-ID: <20260304142026.1443666-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the mm lifecycle handling in the open-coded task_vma
BPF iterator and switches it from mmap_lock to per-VMA locking to reduce
contention. It then fixes a deadlock that is caused by holding locks
accross the body of the iterator where faulting is allowed.

Patch 1 fixes a missing mmget() that allows the mm_struct to be freed
before the iterator takes mmap_lock. It adds mmget_not_zero() and
introduces an NMI-safe mmput path using per-CPU irq_work, following the
existing mmap_unlock irq_work pattern.

Patch 2 switches from holding mmap_lock for the entire iteration to
per-VMA locking via lock_vma_under_rcu(). This still doesn't fix the
deadlock problem because holding the per-vma lock for the whole
iteration can still cause lock ordering issues when a faultable helper
is called in the body of the iterator.

Patch 3 resolves the lock ordering problems caused by holding the
per-VMA lock or the mmap_lock (not applicable after patch 2) across BPF
program execution.  It snapshots VMA fields under the lock, then drops
the lock before returning to the BPF program. File references are
managed via get_file()/fput() across iterations.

Puranjay Mohan (3):
  bpf: fix mm lifecycle in open-coded task_vma iterator
  bpf: switch task_vma iterator from mmap_lock to per-VMA locks
  bpf: return VMA snapshot from task_vma iterator

 kernel/bpf/task_iter.c | 136 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 125 insertions(+), 11 deletions(-)


base-commit: 3ebc98c1ae7efda949a015990280a097f4a5453a
-- 
2.47.3

