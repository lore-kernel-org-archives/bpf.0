Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7650923394B
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284033; cv=none; b=OikHkeYO0b05ZnmEmNpDImXrrIfGITID7KhmPIyLjl2pyp5p1+LfgHIax+2hyfi4qbM27iUxPCreMvUaLFRPjhKEhqVHVJXXxae1G5kf94E4okPAZ2J9UeJ16scK79m3kOZ0ZktC+d3CtQUgGYQYGUiW4T1gV68EWr3mTPjyTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284033; c=relaxed/simple;
	bh=2zbR2osNZMaJ5U8H1j/0OkSTHXyGsoMgNaduLFhcd58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Br1lrzhWR69YsTeZ/M/Mpsj+kKDEiowTB73RxLgzCDLMGqgsmr39sw+3WDv7j8hGejkSk/gCxs/8qErm8Um9AznOEgYcZpumAly2LevrCRj1cB6fx+c7Wcq1bPRHYbJsmg4dcwBmqe0VOmG/7MBm3d/f/J0IzaM9HL3/vc2P8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lojT43nS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lojT43nS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18461F000E9;
	Wed, 20 May 2026 13:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779284032;
	bh=bGmfwa3emc5UuDihZKikSA88k4DNmQRTPNBk5d0PCUg=;
	h=From:To:Cc:Subject:Date;
	b=lojT43nSSv/08njkyUOJuRb+DfPDbDLZarmgD/IL+5Vs6ZVZRQgAvBPForPH1lQZ9
	 B5iNHjBAewgNXkKv+dnORxbw9qsSABdJG6BQUEIbBkKpt1arXzu4oqLm+ead8As6Uu
	 X2gZiZ3112OLM10f06HuVJbVuwCbc8UDH9xFuGoCKjdCsFOvQ07hO4GV9dad5J3zbI
	 a3B06rmp7lL9CbgW4acEZ71c4uUCy5hcr/ctnyE3XZf4ja3XkE4Xmbt7HVJb1cZdNk
	 /fPtrssXOdcPRepO+UzIgkfjxlOk5EhEuLvMUP0pYglb/QOQ2JCnZt48Jzp3wdTe8G
	 Ll6L1Wb9NCmjw==
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
	Fei Chen <feichen@meta.com>,
	Taruna Agrawal <taragrawal@meta.com>,
	Nikhil Dixit Limaye <ndixit@meta.com>,
	"Nikita V. Shirokov" <tehnerd@tehnerd.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/3] selftests/bpf: XDP LB benchmark fixes
Date: Wed, 20 May 2026 06:33:29 -0700
Message-ID: <20260520133338.3392667-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1: https://lore.kernel.org/all/20260519163632.2220753-1-puranjay@kernel.org/
Changes in v2:
- Drop patch 3 as it was fixing a situation that can never happen in practice.
- Replace | 1 logic in patch 1 with replacing ^ operator with +

Three bug fixes and one improvement for the XDP LB and batch-timing
benchmarks.

The cold_lru validation was failing a lot because batch_hash could
compute to zero when batch_gen matched the CPU id. Similarly,
pre-populated UDP LRU entries had atime=0 so they'd expire immediately
on any CPU that calibration didn't warm. Both are fixed in patches 1-2.

Patch 3 adds IQR outlier filtering to the timing stats to stabilize
scenarios with high stddev.

Puranjay Mohan (3):
  selftests/bpf: Fix cold_lru producing zero batch_hash in XDP LB
    benchmark
  selftests/bpf: Fix expired UDP LRU entries in XDP LB benchmark
  selftests/bpf: Filter timing outliers with IQR in batch-timing library

 .../selftests/bpf/benchs/bench_bpf_timing.c   | 26 +++++++++++++++++++
 .../selftests/bpf/benchs/bench_xdp_lb.c       | 11 ++++++++
 .../selftests/bpf/progs/xdp_lb_bench.c        |  2 +-
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.53.0-Meta

