Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0101346E43
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784288503; cv=none; b=UWFaAkuk7GOLWRz/PVBsbADuIZr6wtnWdv3eP64oqDi0p2u9dIKFFl/LeiCtvmHHJkfLFBf45Xqp2VxvDrq6yM7n+aOMnDLFLsDPRn0+vx5ySDokxY8AnV75dbm2dakq2GAXqZTtAXjAWrvPjEqXaYTp04syPXQ77agQSmVlPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784288503; c=relaxed/simple;
	bh=pQLbU4q5XcLB32POztZFQQSFu5aZV8sMgUF21wS775g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MRl9qVxCgzzNc9Ak4RHiZxzGr2B2nMl72ZrtpM4aA2PIxz7sSGjrzhqXK9GdGT9EQ1JtGFK2jq9ozlmi7AfHtGmyd7cq88cEcY4FatU7R+zrSl6r+C9wRVI8StyqwFdSNgObvnmyqssAhu8gg1gAwjJq2acb6xu7v5qUrlXWltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a4Lk8ai3; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a4Lk8ai3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784288499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CPf2mKJIcbXbO5Gzhm7rPQ8E1wgv0pM+yn6CIjtnrfo=;
	b=a4Lk8ai35t5gFiLT6G2CInPLXAH13/b6myFA/QAhmOV6V6alspTEs0P6UlbCbndUj6D23L
	iKRUQYpOj1DigNy0yuYO3ibFN5Ohj37ax6WPkk7IRyeWn3lcnjGybay2SyjoNC9xHlfdVT
	B7Kd2aLx1nYUkgR2nG36/6g6H4CBfe8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
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
	Shuah Khan <shuah@kernel.org>,
	Woojin Ji <random6.xyz@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/4] bpf: Add memory usage for arena and selftest
Date: Fri, 17 Jul 2026 19:37:00 +0800
Message-ID: <20260717114117.350851-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

arena is the only map type whose map_mem_usage() still returns 0, so
bpftool and fdinfo always show 0 memlock for it no matter how many pages
it holds. This series adds the accounting, runs the arena selftests
serially so they don't OOM a small CI VM, and adds a test for it.

v1 -> v2:
- split the scratch_page -> arena refactor into a prep patch (no
  functional change)
- use WRITE_ONCE() for nr_pages to pair with the lockless reader
- reword the "run serially" commit message
- selftest: alloc prog returns 0 so the failure check is reached

v1: https://lore.kernel.org/bpf/20260716142746.8794-1-jiayuan.chen@linux.dev/

Jiayuan Chen (4):
  bpf: Pass arena instead of scratch_page to the pte callbacks
  bpf: Add memory usage for arena
  selftests/bpf: Run arena tests serially
  selftests/bpf: Add tests for memory usage for arena

 kernel/bpf/arena.c                            |  27 ++--
 .../selftests/bpf/prog_tests/arena_atomics.c  |   2 +-
 .../bpf/prog_tests/arena_direct_value.c       |   2 +-
 .../selftests/bpf/prog_tests/arena_htab.c     |   2 +-
 .../selftests/bpf/prog_tests/arena_list.c     |   2 +-
 .../bpf/prog_tests/arena_mem_usage.c          | 122 ++++++++++++++++++
 .../bpf/prog_tests/arena_spin_lock.c          |   2 +-
 .../bpf/prog_tests/arena_strsearch.c          |   2 +-
 .../selftests/bpf/prog_tests/libarena.c       |   2 +-
 .../selftests/bpf/prog_tests/libarena_asan.c  |   2 +-
 .../selftests/bpf/progs/arena_mem_usage.c     |  40 ++++++
 11 files changed, 186 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_mem_usage.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_mem_usage.c

-- 
2.43.0

