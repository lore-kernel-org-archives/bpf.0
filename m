Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98559412270;
	Wed,  2 Sep 2026 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341919; cv=none; b=Uh6160Fgr65AYJud0SBao+fP7OBP4FcM7U4LZqY98meQY10juo2OmoSmTCIEA1kiwUvOQcni02m2dNjpSEFrczOCf8du2LXHC34xBBH8S4AZsC7F+7FZ3GCzLOFiKTXSdytOPmqk667oj/a7BY+mI+eoOoFdL3hQKqp9JFx/VpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341919; c=relaxed/simple;
	bh=OmckPcNn2d43Jt4qbFjjAGMFSJuOEDinrWkQBqBea8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSEYgsUzLOnjku/ybsQcbIdjXSfdyITBvctAq/k779aYi7lgZOXvw7kWCDA05ZjuRa7SGM/0xVbx4W2TpLT1mG1Hj1NzzdbTgv15/ot2IfM7vSK4TJhuQlfQAM6PIZD4Enl1019pWM6d0G9v3L9JEHteDwdP2GFAt9XxA+19PzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e6mfzPeq; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e6mfzPeq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=cPtOUVSgreGRfeCgKA1l8rilUJWEmMP8VYiOnBVHhxY=;
	b=e6mfzPeqTRNLnEt7BY0s5h+kxNH0qVHOa+6qniTC0qrlOCw4fcpehMTn8RiTB5
	NNL8BF6WUl+V2ZHF0aaw3oT2Mbe1EGt53I9GyAoIHwZricWbEwai4+vnAeQy0aZ4
	aetKNg3Hsm3R2DbQ+XxdMK3wUtNh4nrhtHW+QQpWa4/9c=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3F7Vu7pdqogtpAA--.21222S2;
	Wed, 02 Sep 2026 17:37:51 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v5 0/3] bpf, arena: fix range_tree consistency on allocation failure
Date: Wed,  2 Sep 2026 17:37:37 +0800
Message-ID: <20260902093740.2338724-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAADnVQKPSWBzaEc7QBT39C_N_32Gu5_P5Cob9G0rxcDgiSQg6g@mail.gmail.com>
References: <CAADnVQKPSWBzaEc7QBT39C_N_32Gu5_P5Cob9G0rxcDgiSQg6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F7Vu7pdqogtpAA--.21222S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF47tryDtF48ur47Gr18uFg_yoW5XFy7pr
	W5Kws8J3ykG3yxuFs3uF1xXFn5Ca1rXw4UGryagr1kZry5Gr1xtr40k3WUWr1UCFn5Xw4U
	KF4Yq34Igr1UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnb18UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAg9XFWqX7m8OjwAA3y

From: Yuan Chen <chenyuan@kylinos.cn>

The arena range tree can be left inconsistent when kmalloc_nolock()
fails mid-operation. Patch 1 fixes range_tree_clear(), patch 2 fixes
range_tree_set(), patch 3 makes the arena free paths handle
range_tree_set() failures, checks the return value in
arena_alloc_pages()'s partial-allocation error path, and makes
arena_map_free() drain the deferred-free machinery safely now that the
worker can requeue failed spans and queue irq_work on retry.

Changes in v5:
  - arena_map_free(): set a dying flag and steal orphaned spans before
    draining, and drain with flush_work() + irq_work_sync() +
    flush_work().  The worker retry queues arena->free_irq, which the
    old irq_work_sync() + flush_work() order could miss: the irq_work
    fired after the arena was freed and its callback scheduled
    free_work on freed memory.
  - arena_map_free(): retry the spinlock acquisition a bounded number
    of times (-EDEADLK is not retried) and WARN with the error code,
    instead of a bare WARN_ON_ONCE(1) and an immediate leak of the
    arena.
  - range_tree_set(): reword the comment describing the two lookups,
    as suggested by Alexei Starovoitov.  The pre-clear probe only
    decides whether a fresh node must be allocated, so that -ENOMEM
    leaves the tree unmodified; the post-clear lookup fetches the
    merge handles without depending on how range_tree_clear()
    truncates overlapping nodes.

Changes in v4:
  - arena_free_worker(): keep a span whose range_tree_set() failed on
    arena->free_spans and retry it on a later worker run, instead of
    leaving it in the drained list where the second loop would still
    zap user VMAs and free the span (dropping the free request), as
    pointed out by Emil Tsalapatis.

Changes in v3:
  - Check range_tree_set() return value in arena_alloc_pages()'s error
    path, which restores the unpopulated tail of a partially allocated
    range (previously ignored), as pointed out in review.

Changes in v2:
  - Fix multi-line comment style in patches 1 and 3 (opening /* on its
    own line), as pointed out in review.

Note: arena_vm_fault()'s two recovery paths (restoring the range to the
free tree after allocation/mapping failure) also call range_tree_set()
without checking the return value; that is addressed in a separate
series.

Yuan Chen (3):
  bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock
    failure
  bpf, arena: fix range_tree_set inconsistency on kmalloc_nolock failure
  bpf, arena: handle range_tree_set failures in alloc/free paths

 kernel/bpf/arena.c      | 95 ++++++++++++++++++++++++++++++++++----
 kernel/bpf/range_tree.c | 61 +++++++++++++++++-------
 2 files changed, 132 insertions(+), 24 deletions(-)

-- 
2.54.0

