Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76E3A1A54
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208598; cv=none; b=anzApCXviSU70Hh841ttipvkG4mLRllA4ovt5pcJt9Xm3Hl1FnLmXm6Yb+FlhWiNFCxpOB307gzVhE8qaaEUXdYYE8GlGIonQzwEvu78juopiOnLigF10lS3a796NnB3/PZv9npRu6cAT3QNHYS0eCQ3kl/iaaZkDQgGFa7cUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208598; c=relaxed/simple;
	bh=9ZybhAGJu8XUb42f5UVwPOJYCaRuubOq2Vziq3+xuAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KW9dtZRI1jPvktAiPxC99BJPoAlxicUVwjD1X561y087PwQMV9LXU/xFFrOWGyAIsA+kSA9Jsw/osRRRkdXPMdetUR2fv3i7PyE2KCJkE7cq4IZyxuvFKNvRdFgiSLer7EX+/ytoH2DjMOmjgKaXfXCLBcNtIQivmrKhjMQHTMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUsXMolz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUsXMolz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3963CC2BCB3;
	Tue, 19 May 2026 16:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779208598;
	bh=9ZybhAGJu8XUb42f5UVwPOJYCaRuubOq2Vziq3+xuAU=;
	h=From:To:Cc:Subject:Date:From;
	b=XUsXMolzR772tYT9oWdTt/KwiIE6Jen3ovVobkyx9FKVBFoI2EWuGLtCLyM1YWOG1
	 1NqgK7Qp48dTC6RhVqxJ7joFZO1+WgXMkFYW+c/C3EaOYS4SZZfU/jFkUczRGehjDl
	 qnPtqSALBBPGAtfU99e69yKT/pVN+P25hr65YlXlFjLHytPt6mBQtlgpGEtLU8VdIg
	 mVG+9kG/aJe6VvmVaccxU87S54c147TC+hvZ4e/vwAOLHcp+pIQa293YZxe1WLYIKk
	 erYa66glgJ9G9Zv5U+HuJQ8DI6zy3xzl0guGjBHfXrPKvjd2JBsJcpEiFdITY7cJss
	 gcC+SDNZ8lKYQ==
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
Subject: [PATCH bpf-next 0/4] selftests/bpf: XDP LB benchmark fixes
Date: Tue, 19 May 2026 09:36:28 -0700
Message-ID: <20260519163632.2220753-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three bug fixes and one improvement for the XDP LB and batch-timing
benchmarks.

The cold_lru validation was failing a lot because batch_hash could
compute to zero when batch_gen matched the CPU id. Similarly,
pre-populated UDP LRU entries had atime=0 so they'd expire immediately
on any CPU that calibration didn't warm. Both are fixed in patches 1-2.

Patch 3 lowers CALIBRATE_MAX_BATCH to stay under BPF_MAX_LOOPS.

Patch 4 adds IQR outlier filtering to the timing stats to stabilize
scenarios with high stddev.

Puranjay Mohan (4):
  selftests/bpf: Fix cold_lru producing zero batch_hash in XDP LB
    benchmark
  selftests/bpf: Fix expired UDP LRU entries in XDP LB benchmark
  selftests/bpf: Cap batch-timing calibration at BPF may_goto loop limit
  selftests/bpf: Filter timing outliers with IQR in batch-timing library

 .../selftests/bpf/benchs/bench_bpf_timing.c   | 28 ++++++++++++++++++-
 .../selftests/bpf/benchs/bench_xdp_lb.c       | 11 ++++++++
 .../selftests/bpf/progs/xdp_lb_bench.c        |  2 +-
 3 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.53.0-Meta

