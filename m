Received: from mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D7142EEA3
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230467; cv=none; b=LXa1YTcqGiN0jVQm6HdsyHAE2bNQ6f4wM4XMTuSquyDrwB+lwbDr+IGiPIg2NvdSFYSWJLYxah3GQzAiVd+wn7jFn2Sqtajmg+NcEWN3vV5YiZ0yisjxC+D6AvKnQFobPXT76v/oi5fPwK/xOoh7JVSqV40GiFOd4WlIvbItU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230467; c=relaxed/simple;
	bh=uaa47HjIg5FFqjOeEzANpXLJA0/CX5ySz08yr8qyvWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NbV9bICOowa+9SQKBhI5a+oGtK+s6MdG2A0VUBSmhtjlaWSklT1Tqamut2w+tnZHd9mRdMOiDIaMbXSl7l7adHbdDP4/uQ7qTFgI2xXextZTGEt13gQXgmbVFFMx6rE3Oze12lKlQzmXSYAG9aECt237f+Nd0g+JUssNhdYvZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZtwA/0Dj; arc=none smtp.client-ip=91.218.175.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZtwA/0Dj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uaa47HjIg5FFqjOeEzANpXLJA0/CX5ySz08yr8qyvWs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788230451; v=1; x=1788835251;
 b=ZtwA/0Dj0d8b6rrHyEJlG/mPCGJwCT2zkC64X/HJ2n/PgKdEBZe5WSxMkaKws9dKjPv0yahs
 nQnukOI5MDA3p7hugu4bgzr+uWoZW5OUiGQsrncaG6bxdgG/cptiD/TtQhYGx/mns1bfETa0lJv
 sTa/4IA0r0NzfPHFa0k5RaCA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b6cebc90bc5a86e6;
	Tue, 01 Sep 2026 02:40:50 +0000
X-Mizu-Trace-ID: b6cebc90bc5a86e6
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	void@manifault.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	michalblk@google.com,
	liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/2] sched_ext: fix wraparound-unsafe vtime orderings
Date: Tue,  1 Sep 2026 10:40:36 +0800
Message-ID: <20260901024038.730424-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Two spots order tasks by 64-bit virtual time with comparisons that
break when the values are far apart: the kernel's vtime DSQ priority
queue and scx_flatcg's cgroup tree. They need opposite fixes, which
is the point of this series.

The kernel's scx_dsq_priq_less() compares with time_before64(), i.e.
(s64)(a - b) < 0. That is only a valid ordering when all values in
the queue are less than 2^63 apart. CFS upholds that invariant with
min_vruntime clamping; sched_ext cannot, because dsq_vtime comes
straight from the BPF scheduler. A scheduler that inserts vtimes
wider than 2^63 apart into one DSQ gets the inverted order -- the
tasks it placed last run first while the rest starve. Patch 1
switches to a plain u64 comparison, which is a total order and always
honors the requested order; it reproduces the inversion with a probe
scheduler and verifies the fix.

scx_flatcg's cgv_node_less() has the inverse problem: it compares
with a plain <, which misorders once cvtime wraps. There the cyclic
(s64)(a - b) < 0 comparison from patch 1's bug is the correct fix,
because flatcg does uphold the spread invariant --
cgrp_cap_budget() clamps every node to within max_budget behind
cvtime_now -- and the cyclic comparison also carries the ordering
correctly across the natural 2^64 wrap, which a plain comparison
would not.

So: same bug family, opposite fixes, each justified by whether the
spread invariant exists. This is also why the naive "use
time_before64 everywhere" suggestion doesn't hold -- without the
invariant it is exactly the inversion patch 1 fixes.

Tao Cui (2):
  sched_ext: fix vtime priority queue inversion on wide vtime spread
  sched_ext/scx_flatcg: make cgv_node_less() wraparound-safe

 kernel/sched/ext/ext.c           | 3 ++-
 tools/sched_ext/scx_flatcg.bpf.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.43.0

