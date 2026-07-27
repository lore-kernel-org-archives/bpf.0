Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC5346AC2
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785133610; cv=none; b=FpwM3T0uRFInDdGHSliRvUGKRtoJ0ghMLrn2AlCInRBlFZ+L7EqLi8159y4Vl+rxEj/vdsKziyJBDn6LCx3bRdOdtATLJjnzoDRO394ZgCwv6k3grfG/rbpVASo8fzB8Xsy1a4BopvP7a9RYLpGAldB8WLzFKSZ8B7MKTYb6ki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785133610; c=relaxed/simple;
	bh=nKIFAv4kF4KijhFm8sL+SAf6hxE9wioM8+8a8ChOkQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nksW/as/f5ABlSUR/4kgQuyIScvEWQDSE2Txvk2r6zOI0qKUTy94dO9vIqlBtpZlNo/n6JWtWpAVJbPH7dWPWpTP51/A+NQ7f3HrPtLOn/Sd1a9IKg6fcZDXG3alS/i0vbchDzRn7/QX7/fHPNX5ZQcCfxY2YZMYizm4KIyjxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=la/4x8bi; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="la/4x8bi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785133597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PAeOqBD219UGl5uCiw37NAw29YZ5NXNJs983fN0dgDE=;
	b=la/4x8biYn5+Ct4TeIJ0wqWbfL9+RwFfl6onodkpN13do0gYWceTthm9gqCHE6M0Z2SjiO
	BIDI8p9Yc1dEc5fBnNcklWMUpvVNPt5ytdDsDEjsdKgY3CiwuOJpvtqAsqSZNvvIIHrVVK
	gViZKEQXNnQT23nrQLuJltWzoEbXGEI=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next 0/3] bpf: arena: handle memory.max on fault-in with reclaim/OOM
Date: Mon, 27 Jul 2026 14:24:11 +0800
Message-ID: <20260727062521.376231-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since commit e66fe1bc6d25 ("bpf: arena: Reintroduce memcg accounting"),
arena pages are charged to the memcg of the process that created the arena.
That accounting exposes two problems in the arena user page fault path.

1. The fault-in allocation runs under arena->spinlock, so it can only use the
   non-blocking allocator, which never reclaims. Once memory.current is at
   memory.max the allocation simply fails. Reaching memory.max is completely
   normal for a healthy application - e.g. reading a large file fills
   memory.current with page cache - so the process ends up killed for no real
   reason.

2. That failure is turned into VM_FAULT_SIGSEGV, which is misleading: the
   faulting address is a perfectly valid arena address. When we know it is an
   out-of-memory condition we can return VM_FAULT_OOM and let the memcg OOM
   path handle it properly.

Preallocate the page outside the lock (patch 2), the way do_anonymous_page()
does, so the allocation can sleep and go through reclaim and the OOM path.
This needs a sleepable allocator (patch 1), because can_alloc_pages() is a
conservative guess for BPF program context and always forces the non-blocking
allocator under PREEMPT_RT. patch 3 adds a selftest that faults an arena in
under a memory.max limit: without the fix the child gets SIGSEGV on a valid
address, with it the child is killed by the memcg OOM killer.

Jiayuan Chen (3):
  bpf: Add a sleepable page allocator for map memory
  bpf: arena: allocate the fault-in page outside the lock
  selftests/bpf: Add a test for arena fault-in under memory.max

 include/linux/bpf.h                           |   1 +
 kernel/bpf/arena.c                            |  83 ++++++---
 kernel/bpf/syscall.c                          |  21 ++-
 .../selftests/bpf/prog_tests/arena_memcg.c    | 158 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  24 +++
 5 files changed, 263 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

-- 
2.43.0

